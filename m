From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 4 Dec 2014 16:49:36 +0100
Message-ID: <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <54801B50.4080500@web.de> <20141204095557.GE27455@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 16:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwYfK-0002NX-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 16:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbaLDPt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 10:49:58 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:47395 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbaLDPt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 10:49:58 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so2973974obc.39
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ccxw4ofjXU0xkRJHeDse7YRsxRYB2Gf+jO/sPcLZHZ0=;
        b=CxDhwWxvFkoR05+z+nKbUYa19Or+JvEnA0p7MenOSR7nPp1mjPWV7waxDIYxWB929T
         Mb1EMWM97vP8Wf5/xOg0GZE0G8FV8qFGJEa44jwL/z8ohvEIoLB6V9diap1SrX172Lue
         NL3qduOl852bGbaM5Y+LZKSzeA1T66cgou+LWVe/jQlNK/yQH8Mkqeyq6N1JpX1fVlST
         Gt7kSCL2dyBwJOBKyh+m0txk3KQ7C+84WdgJyBUIl8zWwysEdVlJV1ILrJJKfcIlgH1y
         i4LzsG4DFMH4Mf76ldx17J/O8fOTeyLo5Se/XlGktIUZ5/C7NPJPsa2MwWQ+Vu3/bZ0u
         fn9Q==
X-Received: by 10.202.190.3 with SMTP id o3mr6891258oif.120.1417708196286;
 Thu, 04 Dec 2014 07:49:56 -0800 (PST)
Received: by 10.76.141.44 with HTTP; Thu, 4 Dec 2014 07:49:36 -0800 (PST)
In-Reply-To: <20141204095557.GE27455@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260761>

On Thu, Dec 4, 2014 at 10:55 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 04, 2014 at 09:29:04AM +0100, Torsten B=C3=B6gershausen w=
rote:
>
>> How about
>> alias git=3D'LANGUAGE=3Dde_DE.UTF-8 git'
>> in your ~/.profile ?
>> (Of course you need to change de to the language you want )
>
> Besides being awkward in scripts (which will not respect the alias an=
d
> use a different language!), that variable will also be inherited by
> programs git spawns. So the editor, for example, may end up in the wr=
ong
> language.
>
> I think respecting core.locale would make sense (probably the change
> would go into git_setup_gettext(), but you may have to fight with the
> setup code over looking at config so early in the process).

I think we should just stick to the standard *nix way of doing this:
Tell people to set their locale in their environment.

If someone's having this issue it's also happening for all the
binutils, and any other command-line and GUI program they use, unless
they override using the standard way of doing so, by setting the
relevant LC_* environment variables.

If you want Git in English then create an alias to override its locale
to be C, if you want the editor it spawns to be in some other language
alias that to something that explicitly sets LC_* for that editor.

Maybe I'm being overzealous about this (especially with the "I
implemented this" blinders on), but let's not have Git set the
precedent for other *nix programs that they all should come up with
some custom way to override locales, that's something to be done at
the OS locale library level, which we use.

> However, I think the original question is not one of localizing git, =
but
> rather of having it _not_ localized (avoiding the German translations=
).
> There is a hack you can do that for that, which is to set
> GIT_TEXTDOMAINDIR to something nonsensical (like "/"), which will mea=
n
> git cannot find the .po files, and just uses the builtin messages.

You can, but the fact that that works is an internal implementation
detail we shouldn't document or support.
