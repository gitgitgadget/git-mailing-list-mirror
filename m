From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/14] revert: Separate cmdline parsing from functional code
Date: Wed, 6 Jul 2011 15:04:03 +0530
Message-ID: <CALkWK0=eMfMYvysKpixUWt_nCmK3x8EUgKxnstJrAReN8Xi=FA@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-9-git-send-email-artagnon@gmail.com> <20110706091334.GE15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOV2-0005HQ-4K
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab1GFJeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 05:34:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52403 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660Ab1GFJeY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 05:34:24 -0400
Received: by wyg8 with SMTP id 8so4534037wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aBBA7r8q5Wx3QEYsY5ypg+STb5Oq6jwy5qxtr+qd6OI=;
        b=tS8MWLv6MA8ryBJ0TE1yJDR1tSzmqDDmOfNFkSPw0UUxDyb1enVSL9YUn0DfgN5fua
         W3wOwPGdLYcmmNMq5go68EHShQCybhRAQdUuBdsSYPV0o3M2Aa3yJuRpwdHJYHriLaCo
         7goIr7fK8vsfoHY3Wdq7ZkM07WDkIaGpzHGIo=
Received: by 10.216.60.72 with SMTP id t50mr1786648wec.92.1309944863128; Wed,
 06 Jul 2011 02:34:23 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 02:34:03 -0700 (PDT)
In-Reply-To: <20110706091334.GE15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176672>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
> [...]
>> @@ -612,7 +610,10 @@ int cmd_cherry_pick(int argc, const char **argv=
, const char *prefix)
>>
>> =C2=A0 =C2=A0 =C2=A0 memset(&opts, 0, sizeof(struct replay_opts));
>> =C2=A0 =C2=A0 =C2=A0 opts.action =3D CHERRY_PICK;
>> - =C2=A0 =C2=A0 res =3D revert_or_cherry_pick(argc, argv, &opts);
>> + =C2=A0 =C2=A0 git_config(git_default_config, NULL);
>> + =C2=A0 =C2=A0 me =3D "cherry-pick";
>> + =C2=A0 =C2=A0 parse_args(argc, argv, &opts);
>> + =C2=A0 =C2=A0 res =3D pick_commits(&opts);
>> =C2=A0 =C2=A0 =C2=A0 if (res < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("%s failed"),=
 me);
>> =C2=A0 =C2=A0 =C2=A0 return res;
>
> I'd put the "me =3D" line right after "opts.action =3D" if doing it t=
his
> way. =C2=A0This means callers to pick_commits() are responsible for s=
etting
> the "me" variable and in particular it will not make sense to export
> that function to callers outside of this file any more, right?

Exactly.  Good point.

-- Ram
