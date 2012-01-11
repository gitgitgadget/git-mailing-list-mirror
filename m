From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 09:32:18 +0530
Message-ID: <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkpOg-0002OC-9S
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab2AKECk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:02:40 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51287 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab2AKECj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 23:02:39 -0500
Received: by wgbds12 with SMTP id ds12so86126wgb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vwaZ/hAzzUDPgEV7w0OACN8tzbI2rMgwUM3RCoP2ESQ=;
        b=AkFW1Pz34KipaA65hDgLZfgwDf1qJ7+5q95WSsXRG5Q5BNEa3m2NXcJ+l4hfJyPEIp
         cCzq17q2mTBP1SUQu3yboVw/aC2TPPjNJ5+Gh4TLa/0EyVIhPX7BRbgCO5rQAnPio9p+
         MjGHueieEbfrdII2o/cSbi1+FWueYkorKVvg0=
Received: by 10.180.77.200 with SMTP id u8mr16616974wiw.18.1326254558302; Tue,
 10 Jan 2012 20:02:38 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 20:02:18 -0800 (PST)
In-Reply-To: <20120110183857.GC22184@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188322>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> [...]
>> -static const char *action_name(const struct replay_opts *opts)
>> +static const char *command_name(struct replay_opts *opts)
>
> This part does a similar renaming, and drops a const while at it for
> no intelligible reason.

Carried over from the previous iteration- sorry I forgot to fix this.

> [...]
>> @@ -142,7 +147,7 @@ static void verify_opt_mutually_compatible(const=
 char *me, ...)
>> =C2=A0static void parse_args(int argc, const char **argv, struct rep=
lay_opts *opts)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 const char * const * usage_str =3D revert_or_ch=
erry_pick_usage(opts);
>> - =C2=A0 =C2=A0 const char *me =3D action_name(opts);
>> + =C2=A0 =C2=A0 const char *me =3D command_name(opts);
>
> The rest is stuff like this, which follows from the first part.
>
> Stepping back, I think the idea is that "enum replay_action" is not a
> good way to identify the command name in error messages like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: cherry-pick: --abort cannot be used=
 with --continue
>
> So you introduce a _new_ enum to represent the command name. =C2=A0Wh=
y not
> just use a string, so commands using the nice and generic sequencer
> library do not have to register themselves in a global callers list t=
o
> use it?

=46ine;  I'm sold on the string idea.  Also, I figured it would be
easier to explain the changes if I change this enum to a string -- I
should probably use "ease of explaining changes" as a stronger
criterion in the future when I have two competing implementations in
mind.

Thanks.

-- Ram
