From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Wed, 1 Feb 2012 22:25:31 +0100
Message-ID: <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
 <20120201184020.GA29374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 01 22:26:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rshgw-0007R8-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 22:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab2BAVZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 16:25:54 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38311 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932457Ab2BAVZw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 16:25:52 -0500
Received: by lagu2 with SMTP id u2so911917lag.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OSkLSPcrKTjLWE//nW6bSvK+D8kNRpYZ4Nl+wbzZwos=;
        b=CNpv5fOpWs5aZsxYBsLJQxdP0rcL5S7KHR677jwpQMyE06/Kxm00WkPgdHF5jbj1Z3
         kyKUsZKkIK5m/FIYQvcxGHV5aL9d/eGF8J0zwDyhpiaVvacRm10TONoaTj14wtixuHW3
         qyS23a4+AJPMg3xAVduSQ9S50UmcEfyKQgvRI=
Received: by 10.152.129.69 with SMTP id nu5mr154824lab.9.1328131551213; Wed,
 01 Feb 2012 13:25:51 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Wed, 1 Feb 2012 13:25:31 -0800 (PST)
In-Reply-To: <20120201184020.GA29374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189537>

On Wed, Feb 1, 2012 at 19:40, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 01, 2012 at 06:33:47PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> For a program I'm working on (git-deploy) I'd like to have this as a
>> general facility, i.e. users can specify either:
>>
>> =C2=A0 =C2=A0 foo.bar =3D value
>>
>> Or:
>>
>> =C2=A0 =C2=A0 foo.bar =3D !cat /some/path
>>
>> I'm wondering why git-config doesn't do this already, if there's no
>> reason in particular I can just patch it in, either as a new option:
>>
>> =C2=A0 =C2=A0 git config --with-exec --get foo.bar
>
> I'm not clear on what you want --with-exec to do. By default, config
> values are strings. I would expect the "!" to be a special marker tha=
t
> the caller would recognize in the string, and then act appropriately.
>
> So if I were implementing git aliases in the shell, the code would lo=
ok
> like:
>
> =C2=A0v=3D$(git config alias.$alias)
> =C2=A0case "$v" in
> =C2=A0"")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die "no such alias: $alias" ;;
> =C2=A0"!*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd=3D"${v#!}" ;;
> =C2=A0*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd=3D"git $v" ;;
> =C2=A0esac
> =C2=A0eval "$cmd"
>
> I.e., everything pertaining to "!" happens after we get the config
> string. So what is it that you want "git config --with-exec" to do?

I agree that that's how it should work, I just suggested --with-exec
in case anyone complained about the backwards compatibility issue of
changing the meaning of "!" for existing configs.
