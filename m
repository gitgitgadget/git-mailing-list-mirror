From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: [PATCH v3 1/2] compat: add a mkstemps() compatibility function
Date: Tue, 2 Jun 2009 18:05:39 +0530
Message-ID: <e6cd6cf90906020535m24d588eau40b800555c9e906f@mail.gmail.com>
References: <1243503831-17993-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, j.sixt@viscovery.net,
	markus.heidelberg@web.de, jnareb@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 14:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBTJd-0001bM-5X
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 14:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZFBMlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2009 08:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbZFBMlx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 08:41:53 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:47728 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZFBMlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 08:41:52 -0400
Received: by qw-out-2122.google.com with SMTP id 5so5546256qwd.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y6avmzOblHpbpEWuVh9BGRnGYJXNYUSPTUtj/BY6a0w=;
        b=PgsYqN2EcsbGV57gEmu1uo2UzQjYiz7LYND5lYbH6PGULnx5elHEnEbmhhPxi1kxrE
         05lzn8/GDad9ekG8lLn/rQzVR7bwyJH1SWA+gzq8+OmQVBBerQdOUcOFZYQLTXMEdj+K
         h4RDvKjdwuEIuEMioHqnmA8jqDZIMnSbQCJ8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OdcsVpVnrfRWYPYzGRHnel0DKSpfLVp7m5RVfURyNkeaYbgp6fTB4HO0N/dTlpeWVC
         TYpeG8RwLcAhi8wjWDvHIi5XPq+5FzrscHLGCJpLyDFEsGBYzbq23cyEAmHYqyaver0m
         k8Wqrnag7IsCD3ihKys1q8iA7F9PDtDMgNXnI=
Received: by 10.229.86.145 with SMTP id s17mr2026446qcl.10.1243946139255; Tue, 
	02 Jun 2009 05:35:39 -0700 (PDT)
In-Reply-To: <1243503831-17993-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120505>

Hi David

I think I see a few minor issues with the code dealing with random six
letters generation. Please correct me if I am wrong.

On Thu, May 28, 2009 at 3:13 PM, David Aguilar <davvid@gmail.com> wrote=
:
> mkstemps() is a BSD extension so provide an implementation
> for cross-platform use.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)
> ---
> =A0Makefile =A0 =A0 =A0 =A0 =A0| =A0 19 +++++++++++++++
> =A0compat/mkstemps.c | =A0 67 +++++++++++++++++++++++++++++++++++++++=
++++++++++++++
> =A0config.mak.in =A0 =A0 | =A0 =A01 +
> =A0configure.ac =A0 =A0 =A0| =A0 =A06 ++++
> =A0git-compat-util.h | =A0 =A05 ++++
> =A05 files changed, 98 insertions(+), 0 deletions(-)
> =A0create mode 100644 compat/mkstemps.c
>
> diff --git a/Makefile b/Makefile
> index eaae45d..a70b5f0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -52,6 +52,8 @@ all::
> =A0#
> =A0# Define NO_MKDTEMP if you don't have mkdtemp in the C library.
> =A0#
> +# Define NO_MKSTEMPS if you don't have mkstemps in the C library.
> +#
> =A0# Define NO_SYS_SELECT_H if you don't have sys/select.h.
> =A0#
> =A0# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbo=
lic link.
> @@ -636,10 +638,12 @@ EXTLIBS =3D
>
> =A0ifeq ($(uname_S),Linux)
> =A0 =A0 =A0 =A0NO_STRLCPY =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0THREADED_DELTA_SEARCH =3D YesPlease
> =A0endif
> =A0ifeq ($(uname_S),GNU/kFreeBSD)
> =A0 =A0 =A0 =A0NO_STRLCPY =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0THREADED_DELTA_SEARCH =3D YesPlease
> =A0endif
> =A0ifeq ($(uname_S),UnixWare)
> @@ -651,6 +655,7 @@ ifeq ($(uname_S),UnixWare)
> =A0 =A0 =A0 =A0SHELL_PATH =3D /usr/local/bin/bash
> =A0 =A0 =A0 =A0NO_IPV6 =3D YesPlease
> =A0 =A0 =A0 =A0NO_HSTRERROR =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0BASIC_CFLAGS +=3D -Kthread
> =A0 =A0 =A0 =A0BASIC_CFLAGS +=3D -I/usr/local/include
> =A0 =A0 =A0 =A0BASIC_LDFLAGS +=3D -L/usr/local/lib
> @@ -674,6 +679,7 @@ ifeq ($(uname_S),SCO_SV)
> =A0 =A0 =A0 =A0SHELL_PATH =3D /usr/bin/bash
> =A0 =A0 =A0 =A0NO_IPV6 =3D YesPlease
> =A0 =A0 =A0 =A0NO_HSTRERROR =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0BASIC_CFLAGS +=3D -I/usr/local/include
> =A0 =A0 =A0 =A0BASIC_LDFLAGS +=3D -L/usr/local/lib
> =A0 =A0 =A0 =A0NO_STRCASESTR =3D YesPlease
> @@ -702,6 +708,7 @@ ifeq ($(uname_S),SunOS)
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> =A0 =A0 =A0 =A0NO_HSTRERROR =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0OLD_ICONV =3D UnfortunatelyYes
> =A0 =A0 =A0 =A0ifeq ($(uname_R),5.8)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NO_UNSETENV =3D YesPlease
> @@ -724,6 +731,7 @@ ifeq ($(uname_O),Cygwin)
> =A0 =A0 =A0 =A0NO_D_INO_IN_DIRENT =3D YesPlease
> =A0 =A0 =A0 =A0NO_STRCASESTR =3D YesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0NO_SYMLINK_HEAD =3D YesPlease
> =A0 =A0 =A0 =A0NEEDS_LIBICONV =3D YesPlease
> =A0 =A0 =A0 =A0NO_FAST_WORKING_DIRECTORY =3D UnfortunatelyYes
> @@ -767,11 +775,13 @@ ifeq ($(uname_S),NetBSD)
> =A0 =A0 =A0 =A0BASIC_LDFLAGS +=3D -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr=
/pkg/lib
> =A0 =A0 =A0 =A0THREADED_DELTA_SEARCH =3D YesPlease
> =A0 =A0 =A0 =A0USE_ST_TIMESPEC =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0endif
> =A0ifeq ($(uname_S),AIX)
> =A0 =A0 =A0 =A0NO_STRCASESTR=3DYesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0NO_STRLCPY =3D YesPlease
> =A0 =A0 =A0 =A0NO_NSEC =3D YesPlease
> =A0 =A0 =A0 =A0FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
> @@ -787,12 +797,14 @@ endif
> =A0ifeq ($(uname_S),GNU)
> =A0 =A0 =A0 =A0# GNU/Hurd
> =A0 =A0 =A0 =A0NO_STRLCPY=3DYesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0endif
> =A0ifeq ($(uname_S),IRIX64)
> =A0 =A0 =A0 =A0NO_IPV6=3DYesPlease
> =A0 =A0 =A0 =A0NO_SETENV=3DYesPlease
> =A0 =A0 =A0 =A0NO_STRCASESTR=3DYesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0NO_STRLCPY =3D YesPlease
> =A0 =A0 =A0 =A0NO_SOCKADDR_STORAGE=3DYesPlease
> =A0 =A0 =A0 =A0SHELL_PATH=3D/usr/gnu/bin/bash
> @@ -805,6 +817,7 @@ ifeq ($(uname_S),HP-UX)
> =A0 =A0 =A0 =A0NO_SETENV=3DYesPlease
> =A0 =A0 =A0 =A0NO_STRCASESTR=3DYesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0NO_STRLCPY =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease
> =A0 =A0 =A0 =A0NO_UNSETENV =3D YesPlease
> @@ -834,6 +847,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> =A0 =A0 =A0 =A0NO_C99_FORMAT =3D YesPlease
> =A0 =A0 =A0 =A0NO_STRTOUMAX =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0SNPRINTF_RETURNS_BOGUS =3D YesPlease
> =A0 =A0 =A0 =A0NO_SVN_TESTS =3D YesPlease
> =A0 =A0 =A0 =A0NO_PERL_MAKEMAKER =3D YesPlease
> @@ -853,6 +867,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> =A0endif
> =A0ifneq (,$(findstring arm,$(uname_M)))
> =A0 =A0 =A0 =A0ARM_SHA1 =3D YesPlease
> + =A0 =A0 =A0 NO_MKSTEMPS =3D YesPlease
> =A0endif
>
> =A0-include config.mak.autogen
> @@ -1011,6 +1026,10 @@ ifdef NO_MKDTEMP
> =A0 =A0 =A0 =A0COMPAT_CFLAGS +=3D -DNO_MKDTEMP
> =A0 =A0 =A0 =A0COMPAT_OBJS +=3D compat/mkdtemp.o
> =A0endif
> +ifdef NO_MKSTEMPS
> + =A0 =A0 =A0 COMPAT_CFLAGS +=3D -DNO_MKSTEMPS
> + =A0 =A0 =A0 COMPAT_OBJS +=3D compat/mkstemps.o
> +endif
> =A0ifdef NO_UNSETENV
> =A0 =A0 =A0 =A0COMPAT_CFLAGS +=3D -DNO_UNSETENV
> =A0 =A0 =A0 =A0COMPAT_OBJS +=3D compat/unsetenv.o
> diff --git a/compat/mkstemps.c b/compat/mkstemps.c
> new file mode 100644
> index 0000000..87ebc2a
> --- /dev/null
> +++ b/compat/mkstemps.c
> @@ -0,0 +1,67 @@
> +#include "../git-compat-util.h"
> +
> +#ifndef TMP_MAX
> +#define TMP_MAX 16384
> +#endif
> +
> +/* Adapted from libiberty's mkstemp.c. */
> +int gitmkstemps(char *pattern, int suffix_len)
> +{
> + =A0 =A0 =A0 static const char letters[] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "abcdefghijklmnopqrstuvwxyz"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0123456789";
> + =A0 =A0 =A0 static const int num_letters =3D 62;
> + =A0 =A0 =A0 uint64_t value;
> + =A0 =A0 =A0 struct timeval tv;
> + =A0 =A0 =A0 char *template;
> + =A0 =A0 =A0 size_t len;
> + =A0 =A0 =A0 int fd, count;
> +
> + =A0 =A0 =A0 len =3D strlen(pattern);
> +
> + =A0 =A0 =A0 if (len < 6 + suffix_len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =3D EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =3D EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Replace pattern's XXXXXX characters with randomness.
> + =A0 =A0 =A0 =A0* Try TMP_MAX different filenames.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 gettimeofday(&tv, NULL);
> + =A0 =A0 =A0 value =3D ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ ge=
tpid();
> + =A0 =A0 =A0 template =3D &pattern[len - 6 - suffix_len];
> + =A0 =A0 =A0 for (count =3D 0; count < TMP_MAX; ++count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t v =3D value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fill in the random bits. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 template[0] =3D letters[v % num_letters=
]; v/=3D num_letters;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 template[1] =3D letters[v % num_letters=
]; v/=3D num_letters;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 template[2] =3D letters[v % num_letters=
]; v/=3D num_letters;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 template[3] =3D letters[v % num_letters=
]; v/=3D num_letters;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 template[4] =3D letters[v % num_letters=
]; v/=3D num_letters;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 template[5] =3D letters[v % num_letters=
]; v/=3D num_letters;

v is divided 6 times by 62, and a decent amount of randomness shall be
ensured only if 'value' is usually greater than 62^6.

If it is assumed to be ok for 'v' to become zero in the last one odd
steps sometimes (in fact, _frequently_), then you may ignore what I am
pointing out here.

1. On a couple of systems that I checked on, all variables/types on
the right hand side of
      value =3D ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
are 4 bytes long. So 'value' is ultimately going to be assigned a
number that fits in 4 bytes, ie value < 2^32 (at least on a few
systems).
The systems that I checked on have these `uname -a` outputs:
-   Linux host 2.6.9-55.ELsmp #1 SMP Fri Apr 20 17:03:35 EDT 2007 i686
i686 i386 GNU/Linux
-   Linux host 2.4.21-50.ELsmp #1 SMP Tue May 8 17:18:29 EDT 2007 i686
i686 i386 GNU/Linux

Also, even if size_t were 64 bits, typecasting _after_ the shift does
not help much. And given the uncertainty about sizeof (size_t), we
could use:
  ((uint64_t) tv.tv_usec) << 16)


2. tv_usec has a decimal value range of 0-999999  (10^6 usec make 1
sec). Which means that tv_usec fits completely in 20 bits (or less).
(tv_usec << 16) yields a number that fits completely in 36 bits (or
less). Max value of this number is 999999 * 2^16, or for convenience,
about M =3D 10^6 * 2^16. This number (in the range of 0 to M) goes on t=
o
be divided by D=3D62^6. Also, M > D. Thus, there is about a  D / M * 10=
0
~ 87 % probability of the division M / D working out to be zero. i.e,
in 87% cases, the last division (v/=3D num_letters) will cause 'v' to
become 0.
Therefore, I think an additional shift of 7 or more bits will help in
improving randomness of template[5]. I would suggest left shifting by
24 bits. This seemed ok in some tests I did.


Combining #1 and #2, I guess we could have the computation of 'value' a=
s:
      value =3D (((uint64_t)tv.tv_usec) << 24) ^ tv.tv_sec ^ getpid();


- Antriksh
