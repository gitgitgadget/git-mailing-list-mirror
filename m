From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] gettext: use libcharset when available
Date: Tue, 28 Sep 2010 17:07:51 +0000
Message-ID: <AANLkTin_fu02QN0cUX15+02iO7xJ+tii5aVBqR2V_AVc@mail.gmail.com>
References: <1285689926-5048-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 19:08:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0des-0007Pk-47
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab0I1RHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 13:07:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58615 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947Ab0I1RHw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 13:07:52 -0400
Received: by iwn5 with SMTP id 5so6200474iwn.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3QVjxOcPHVWUguzADuM7jzgkgjEqhE64lDCwXBzXYzc=;
        b=svnL/zYlnQtWpSJaguLGLHYquoX9GkYHaqEXNLPa8+a35p2gRWgJGUCcz8cGEDpX3W
         h45UJvUtjSujOwWLLmCTe/3dHs7Cyb1YCI7/KLRDzV4P0sX5n2Mfa+IILHQPY9nCRHKt
         B/PgAHXe6BXsu1faxbpjfYCLcKXnjs9PH8Rpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ktwyQBbOsBpF2TFztgT4qYqN1eJjiiGF4LEJztTrtUEb2DQ37Av3synWpK7MUbCehG
         g7B/vx/WykdOgbHuW876u9iMlwNECuK6iBHM4rJjwi4eNhcgwJh7rqoHYqr4Vc+Ye8Wr
         kH5j9PAgSLVoeG+uC4/XsrW0FWr7vmpUf9OFM=
Received: by 10.231.146.136 with SMTP id h8mr274062ibv.0.1285693671863; Tue,
 28 Sep 2010 10:07:51 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 10:07:51 -0700 (PDT)
In-Reply-To: <1285689926-5048-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157445>

On Tue, Sep 28, 2010 at 16:05, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> libcharset provides an even more portable way of quering the charset
> of the current locale.
>
> Use that instead of nl_langinfo unless NO_LIBCHARSET is set.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> Windows doesn't have langinfo.h and nl_langinfo(), but libcharset was
> invented for this very purpose. With this patch on top, ab/i18n
> compiles without errors in msysGit.
>
> There's still a bunch of lower-level issues on Windows, like gettext
> ending up overloading our winansi-wrappings for printf and friends,
> but let's take thinks one step at the time :)
>
> =C2=A0configure.ac | =C2=A0 =C2=A06 ++++++
> =C2=A0gettext.c =C2=A0 =C2=A0| =C2=A0 10 +++++++++-
> =C2=A02 files changed, 15 insertions(+), 1 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 1821d89..d3139cd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -810,6 +810,12 @@ AC_CHECK_HEADER([libintl.h],
> =C2=A0[NO_GETTEXT=3DYesPlease])
> =C2=A0AC_SUBST(NO_GETTEXT)
> =C2=A0#
> +# Define NO_LIBCHARSET if you don't have libcharset.h
> +AC_CHECK_HEADER([libcharset.h],
> +[NO_LIBCHARSET=3D],
> +[NO_LIBCHARSET=3DYesPlease])
> +AC_SUBST(NO_LIBCHARSET)
> +#
> =C2=A0# Define NO_STRCASESTR if you don't have strcasestr.
> =C2=A0GIT_CHECK_FUNC(strcasestr,
> =C2=A0[NO_STRCASESTR=3D],
> diff --git a/gettext.c b/gettext.c
> index 8644098..902268c 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -1,13 +1,17 @@
> =C2=A0#include "exec_cmd.h"
> =C2=A0#include <locale.h>
> =C2=A0#include <libintl.h>
> +#ifndef NO_LIBCHARSET
> +#include <libcharset.h>
> +#else
> =C2=A0#include <langinfo.h>
> +#endif
> =C2=A0#include <stdlib.h>
>
> =C2=A0extern void git_setup_gettext(void) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *podir;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *envdir =3D getenv("GIT_TEXTDOMAINDIR=
");
> - =C2=A0 =C2=A0 =C2=A0 char *charset;
> + =C2=A0 =C2=A0 =C2=A0 const char *charset;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (envdir) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)bindtext=
domain("git", envdir);
> @@ -20,7 +24,11 @@ extern void git_setup_gettext(void) {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)setlocale(LC_MESSAGES, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)setlocale(LC_CTYPE, "");
> +#ifndef NO_LIBCHARSET
> + =C2=A0 =C2=A0 =C2=A0 charset =3D locale_charset();
> +#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0charset =3D nl_langinfo(CODESET);
> +#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)bind_textdomain_codeset("git", chars=
et);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)setlocale(LC_CTYPE, "C");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)textdomain("git");

Thanks for porting it to Windows. Some points:

 * Nit: Should be NEEDS_LIBCHARSET instead of NO_LIBCHARSET, all the
   variables that set library inclusions in the Makefile use the
   NEED_* names.

 * GHC had a patch like this, it seems it affects NetBSD and OpenBSD
   too, can anyone with these systems confirm:
   http://hackage.haskell.org/trac/ghc/ticket/4080

 * Their patch compiles a program that includes libcharset.h and
   compiles "const char* charset =3D locale_charset();". I don't know i=
f
   this is needed, or whether just checking the header name like
   you've done will do.

 * They also have a HAVE_LANGINFO_H define and fall back on just
   returning "", which works on GNU iconv. Maybe we should do this
   too?

I'm not sure about any of this, since I've just been testing on
Solaris, Linux and FreeBSD.
