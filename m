From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 02/14] msvc: git-daemon.exe: Fix linker "unresolved
 externals" error
Date: Sat, 4 Dec 2010 22:15:40 +0100
Message-ID: <AANLkTi=cVTcaQTQqNeQoNHhUrEBZvE5B=aFDy=r+k0uQ@mail.gmail.com>
References: <4CFA8EB7.9070000@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzSm-0006oq-7L
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab0LDVQD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Dec 2010 16:16:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46648 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0LDVQB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:16:01 -0500
Received: by fxm20 with SMTP id 20so3216496fxm.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=XkLffRLeZdeQqH7ahnHHT7cIv0UKLCgjmLBhWzAiRPs=;
        b=B1scminm80kMZ2J5MtHtYMpb7XSA/U/fIrTOpZWicR7UeialXhla5hoEC0+fntsXcL
         +pRX+XgzrpVdnFiV1q+OtWBA+b8/QBud7Xggo28AIGHRKXDeRgipMGE6SgGZp9+hUXAX
         x8RLNxB8cBb3rFfa96gkC9maJH+7z0M72bfRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=uXOCdgSdsyYpcN7XjZqBYrLNOL9sqF/QlMGqJZdXDpaIkKHMWdiCLAL8Fl1TXB2lq7
         HwnggGw9driHhVDrxpSnO3xWSyPCgBNMGP7gRs2arHL1frexpdnrS5nwNf9DER2hnPJM
         9eBlar7jr/9k+hUk20D5rDXjszG1lCURe7Nbc=
Received: by 10.223.83.13 with SMTP id d13mr3488936fal.56.1291497360398; Sat,
 04 Dec 2010 13:16:00 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Sat, 4 Dec 2010 13:15:40 -0800 (PST)
In-Reply-To: <4CFA8EB7.9070000@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162918>

On Sat, Dec 4, 2010 at 7:55 PM, Ramsay Jones <ramsay@ramsay1.demon.co.u=
k> wrote:
>
> The msvc linker complains about external symbols referenced by
> the new poll() emulation code. In particular, it complains about
> the DispatchMessage(), PeekMessage(), TranslateMessage() and
> MsgWaitForMultipleObjects() functions.
>
> In order to satisfy the external references, we link against the
> user32.lib library.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> =A0Makefile | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1d42413..bda9fa6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1087,7 +1087,7 @@ ifeq ($(uname_S),Windows)
> =A0 =A0 =A0 =A0COMPAT_OBJS =3D compat/msvc.o compat/fnmatch/fnmatch.o=
 compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o compat/w=
in32/sys/poll.o
> =A0 =A0 =A0 =A0COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_=
STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icom=
pat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=3D\".exe\"
> =A0 =A0 =A0 =A0BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO -S=
UBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
> - =A0 =A0 =A0 EXTLIBS =3D advapi32.lib shell32.lib wininet.lib ws2_32=
=2Elib
> + =A0 =A0 =A0 EXTLIBS =3D user32.lib advapi32.lib shell32.lib wininet=
=2Elib ws2_32.lib
> =A0 =A0 =A0 =A0PTHREAD_LIBS =3D
> =A0 =A0 =A0 =A0lib =3D
> =A0ifndef DEBUG

Looks sane. But it's a bit odd - it currently builds fine without this
patch from the IDE, but not from the makefile. Is the linker-libs
different between these?
