From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Sat, 19 Mar 2011 19:20:38 +0100
Message-ID: <AANLkTimfk8bb-V8Br+KKpoLbA3G3y9HxyfjA=NrsgR0v@mail.gmail.com>
References: <201103191528.34646.tboegi@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 19:21:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q10lt-0005Ii-Pr
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 19:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210Ab1CSSVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 14:21:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55428 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134Ab1CSSU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 14:20:59 -0400
Received: by fxm17 with SMTP id 17so4535611fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3s3tUmAaBfJxRVmLHGfIZahWxiSuj9CPsvNYaj1KiZo=;
        b=iHxOsCIKNAHjPfILMwe+oc9I3z5DisuzEdpgOElCEJ8boU+sUIel6jnindRX6y1MUW
         MRddA6yYG15ssm5a8Qeis2E5p36T0PZgy3xQhMlfdiwUbElJG1aJQHk2eN46pEZJzP/J
         Cebm+dwLiHbA1z8Ys5K5ircIeqNxpetdPwA9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=qP1wzVmZiuCHc0gZ6fLWFlhHJtqAD0zlc+yija1O3CtehNxI+dkf2XyqAq/jo0lqLO
         kqyiK0V9hR2Bd0Ch8N0Nxnk/T2gLaCv3d+0nPzycoc/iUF2lr9DtRZJr654QdPkQQ1oO
         rqremrG7JYjISU1a8R0B9K4cGjajzIdhl9hB8=
Received: by 10.223.77.16 with SMTP id e16mr2799049fak.87.1300558858161; Sat,
 19 Mar 2011 11:20:58 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Sat, 19 Mar 2011 11:20:38 -0700 (PDT)
In-Reply-To: <201103191528.34646.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169454>

2011/3/19 Torsten B=F6gershausen <tboegi@web.de>:
> diff --git a/compat/win32/same-file.c b/compat/win32/same-file.c
> new file mode 100644
> index 0000000..bb1a791
> --- /dev/null
> +++ b/compat/win32/same-file.c
> @@ -0,0 +1,26 @@
> +#include "../../git-compat-util.h"
> +#include "../win32.h"
> +
> +int win_is_same_file(const char *a, const char *b)

The compat/win32-folder is usually used to provide implementations of
POSIX APIs lacking on Windows. I don't think this is appropriate
functionality to be put there...

> +{
> + =A0 =A0 =A0 BY_HANDLE_FILE_INFORMATION hia, hib;
> + =A0 =A0 =A0 HANDLE h;
> +
> + =A0 =A0 =A0 h =3D CreateFile(a, GENERIC_READ, FILE_SHARE_READ, NULL=
, OPEN_EXISTING, 0, NULL);
> + =A0 =A0 =A0 if (INVALID_HANDLE_VALUE =3D=3D h)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!(GetFileInformationByHandle(h,&hia)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0CloseHandle(h);

Indentation-slip?

> +
> + =A0 =A0 =A0 h =3D CreateFile(b, GENERIC_READ, FILE_SHARE_READ, NULL=
, OPEN_EXISTING, 0, NULL);
> + =A0 =A0 =A0 if (INVALID_HANDLE_VALUE =3D=3D h)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!(GetFileInformationByHandle(h,&hib)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0CloseHandle(h);
> +

Same as above...?

> +#if defined (WIN32) || defined(__CYGWIN__)
> +/* MinGW or MSVC or cygwin */
> +int win_is_same_file(const char *a, const char *b);
> +#define is_same_file(a,b) win_is_same_file((a),(b))
> +#else
> +static inline int is_same_file(const char *a, const char *b)
> +{
> + =A0 =A0 =A0 struct stat sta, stb;
> + =A0 =A0 =A0 if (lstat(a, &sta) ||
> + =A0 =A0 =A0 =A0 =A0 lstat(b, &stb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return sta.st_ino && sta.st_dev =3D=3D stb.st_dev && st=
a.st_ino =3D=3D stb.st_ino;
> +}
> +#endif

This isn't how we usually do things like this. We usually define stuff
in compat/mingw.h (which should really be called compat/win32.h
instead, since it's used by our MSVC builds as well. But that's a
different discussion), and check if it's defined near the bottom of
git-compat-util.h.
