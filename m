From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Fri, 20 Jan 2012 11:40:38 +0100
Message-ID: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <7vfwfclf4v.fsf@alter.siamese.dyndns.org> <4F17C294.6010004@viscovery.net>
 <7vhazrk0jx.fsf@alter.siamese.dyndns.org> <CACBZZX7iiF2um11FvD+MBz=rZb7RrHtCJp3PqexLnSp3-Cbqug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 11:41:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoBuL-0005Rh-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 11:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab2ATKlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 05:41:00 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:57100 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab2ATKk7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 05:40:59 -0500
Received: by obcva7 with SMTP id va7so529274obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kSszv5MCP9xmn0F9vgNnHZs+HlQYYrsh5fqXp5JSXfE=;
        b=Wsm4OjM9VO6VTa0l8c3nLZgtcmto7APVMYmpAflTNY9T9yT2H4Gmgq6xuomQhy7Bz+
         XsuD1KWnoBbyjcK7CHVPzO2ISd5LTWsDCfE98v21aS7oJaeBmWJrNYDM7YcQgC5XKDav
         lea96zC+jTXzXVXupZg1qR6UGXALYE+z9AN98=
Received: by 10.182.38.70 with SMTP id e6mr7242889obk.13.1327056059184; Fri,
 20 Jan 2012 02:40:59 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Fri, 20 Jan 2012 02:40:38 -0800 (PST)
In-Reply-To: <CACBZZX7iiF2um11FvD+MBz=rZb7RrHtCJp3PqexLnSp3-Cbqug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188873>

On Fri, Jan 20, 2012 at 10:50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> However with the shell code we can:
>
> =C2=A01. Be using the system gettext & eval_gettext to get translatio=
ns.
>
> =C2=A02. Be using the system gettext & eval_gettext as pass-through, =
either
> =C2=A0 =C2=A0because we don't have translations since we've installed=
 with
> =C2=A0 =C2=A0NO_GETTEXT=3DYesPlease, or because we're in the C locale=
=2E
>
> =C2=A03. Haven't detected that gettext.sh etc. exists, so we have to =
provide
> =C2=A0 =C2=A0our own fallbacks.
>
> The proposed patch would move all users of NO_GETTEXT=3DYesPlease to =
#3,
> even though on most platforms we don't need to define our own dummy
> fallbacks since the system already provides them.
>
> I don't particularly like it because I'd rather use the OS vendor's
> implementation if possible, even for fallback.

Well, I dunno. I wouldn't trust anything to this particular "OS vendoer=
".

> However it being broken is also unacceptable, but I think the way
> forward is to detect the breakage either at compile time or at
> runtime, ...

Better at runtime, unless the packager explicitly stated they don't wan=
t
any of this.

> ... to that end Alex could you provide us with the output from
> the following commands on the offending system where this is broken:
>
> =C2=A0 =C2=A0$ type gettext.sh

gettext.sh is /usr/bin/gettext.sh

> =C2=A0 =C2=A0$ gettext.sh --version

/usr/bin/gettext.sh (GNU gettext-runtime) 0.18.1
Copyright (C) 2003-2007 Free Software Foundation, Inc.
License GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl=
=2Ehtml>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Written by Bruno Haible

> =C2=A0 =C2=A0$ gettext -h

Nothing. Exit code 127.

> =C2=A0 =C2=A0$ gettext "some test text"

Nothing. Exit code 127.

> =C2=A0 =C2=A0$ . gettext.sh

Nothing. Exit code 0.

> =C2=A0 =C2=A0eval_gettext

Nothing. Exit code 127.

> =C2=A0 =C2=A0$ variable=3Dvalue eval_gettext "some \$variable"

Nothing. Exit code 127.

> Then how the eval_gettext function is defined:
>
> =C2=A0 =C2=A0$ type eval_gettext

eval_gettext is a function
eval_gettext ()
{
    gettext "$1" | ( export PATH `envsubst --variables "$1"`;
    envsubst "$1" )
}

> And then a --version for whatever programs that function uses,
> e.g. here:
>
> =C2=A0 =C2=A0$ envsubst --version

Nothing. Exit code 127.

> Once we know how it breaks we can e.g. add configure tests for
> checking whether we can use the system's gettext library for the
> fallbacks.

The exit code seems to be a good enough test here, but testing some
output (or even translation) would be safer.

I believe gettext (the binary) just doesn't start at all here. Maybe
some Cygwin library wrong or missing library. Happens all the time
here, as we have different Cygwin installations depending on the
currently used toolchain. QNX Momentics, in particular. Different
versions of them, and it is too cumbersome to keep them apart.

> Could you also run the git test suite as described in t/README? I'd
> expect a lot of the i18n tests to fail, but it would be curious to se=
e
> which ones exactly.

Yes, they do. Can't run them on this problematic system, because they
tend to crash it, if run for an undetermined while. On the other system=
,
which can run them, gettext works (it is an older Cygwin installation),
so almost all tests pass (some still don't, but for reasons unrelated).
Strangely enough, the problematic system can build. So I don't copy
the git binaries, they are actually built on that system.
