From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Link against libiconv on IRIX
Date: Mon, 05 Apr 2010 11:45:32 -0500
Message-ID: <1UypQMCHLT57SnjSQIM66RTkLalsvavG8xXoQJv4rEQ@cipher.nrlssc.navy.mil>
References: <20100329105748.GD14869@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: holger@zedat.fu-berlin.de
X-From: git-owner@vger.kernel.org Mon Apr 05 18:45:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NypQp-0007WB-0R
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 18:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab0DEQpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 12:45:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37950 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab0DEQpl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 12:45:41 -0400
Received: by mail.nrlssc.navy.mil id o35GjW57013682; Mon, 5 Apr 2010 11:45:33 -0500
In-Reply-To: <20100329105748.GD14869@CIS.FU-Berlin.DE>
X-OriginalArrivalTime: 05 Apr 2010 16:45:32.0780 (UTC) FILETIME=[686622C0:01CAD4DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143993>

On 03/29/2010 05:57 AM, Holger Wei=C3=9F wrote:
> On IRIX, "-liconv" must be added to the linker command line in order =
to
> get iconv(3) support; set the according Makefile variable appropriate=
ly.

This breaks compilation on IRIX 6.5.29m for me since there
is no separate libiconv.so.

What version of IRIX are you using?

On my system, even the iconv utility doesn't link against
a libiconv shared object.  It seems the iconv functionality is in libc.

   # ldd /usr/bin/iconv
           libc.so.1  =3D>    /usr/lib32/libc.so.1

Could it be that you are using a third party iconv library?
I've experienced this on another system and the problem was related
to curl.  In that case, curl was linked against an external iconv and
not the native library, so if I tried to build with curl support, I had
to also build against the external iconv library.

-brandon


> Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
> ---
>  Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 3a6c6ea..8a0f5c4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -919,6 +919,7 @@ ifeq ($(uname_S),IRIX)
>  	SNPRINTF_RETURNS_BOGUS =3D YesPlease
>  	SHELL_PATH =3D /usr/gnu/bin/bash
>  	NEEDS_LIBGEN =3D YesPlease
> +	NEEDS_LIBICONV =3D YesPlease
>  endif
>  ifeq ($(uname_S),IRIX64)
>  	NO_SETENV=3DYesPlease
> @@ -937,6 +938,7 @@ ifeq ($(uname_S),IRIX64)
>  	SNPRINTF_RETURNS_BOGUS =3D YesPlease
>  	SHELL_PATH=3D/usr/gnu/bin/bash
>  	NEEDS_LIBGEN =3D YesPlease
> +	NEEDS_LIBICONV =3D YesPlease
>  endif
>  ifeq ($(uname_S),HP-UX)
>  	NO_IPV6=3DYesPlease
