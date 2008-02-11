From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Add compat/fopen.c which returns NULL on attempt to
 open directory
Date: Mon, 11 Feb 2008 10:29:50 +0100
Message-ID: <20080211102950.122ba93d@pc09.procura.nl>
References: <47ACFFD9.2030705@nrlssc.navy.mil>
	<47AD10CF.1040207@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOV0B-0008Fk-RG
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbYBKJaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 04:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbYBKJaO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:30:14 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1430 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYBKJaM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:30:12 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1B9TqL4054879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 10:29:53 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <47AD10CF.1040207@nrlssc.navy.mil>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73492>

On Fri, 08 Feb 2008 20:32:47 -0600, Brandon Casey <casey@nrlssc.navy.mil>
wrote:

> Some systems do not fail as expected when fread et al. are called on
> a directory stream. Replace fopen on such systems which will fail
> when the supplied path is a directory.

I applied this patch instead of mine, and added the Makefile define
Harder to trace, as it is not issuing error messages, but could this
success^Wfailure be related?

/pro/3gl/LINUX/git-1.5.4.rc5 103 > cat t/t5701-clone-local.sh.err
*   ok 1: preparing origin repository
*   ok 2: local clone without .git suffix
*   ok 3: local clone with .git suffix
*   ok 4: local clone from x
* FAIL 5: local clone from x.git that does not exist

                cd "$D" &&
                if git clone -l -s x.git z
                then
                        echo "Oops, should have failed"
                        false
                else
                        echo happy
                fi

*   ok 6: With -no-hardlinks, local will make a copy
*   ok 7: Even without -l, local will make a hardlink
* failed 1 among 7 test(s)

Any hints in where to start digging?

> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  Makefile          |    7 +++++++
>  compat/fopen.c    |   26 ++++++++++++++++++++++++++
>  git-compat-util.h |    5 +++++
>  3 files changed, 38 insertions(+), 0 deletions(-)
>  create mode 100644 compat/fopen.c
> 
> diff --git a/Makefile b/Makefile
> index 92341c4..debfc23 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3,6 +3,9 @@ all::
>  
>  # Define V=1 to have a more verbose compile.
>  #
> +# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
> +# when attempting to read from an fopen'ed directory.
> +#
>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
>  # This also implies MOZILLA_SHA1.
>  #
> @@ -618,6 +621,10 @@ endif
>  ifdef NO_C99_FORMAT
>  	BASIC_CFLAGS += -DNO_C99_FORMAT
>  endif
> +ifdef FREAD_READS_DIRECTORIES
> +	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
> +	COMPAT_OBJS += compat/fopen.o
> +endif
>  ifdef NO_SYMLINK_HEAD
>  	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
>  endif
> diff --git a/compat/fopen.c b/compat/fopen.c
> new file mode 100644
> index 0000000..ccb9e89
> --- /dev/null
> +++ b/compat/fopen.c
> @@ -0,0 +1,26 @@
> +#include "../git-compat-util.h"
> +#undef fopen
> +FILE *git_fopen(const char *path, const char *mode)
> +{
> +	FILE *fp;
> +	struct stat st;
> +
> +	if (mode[0] == 'w' || mode[0] == 'a')
> +		return fopen(path, mode);
> +
> +	if (!(fp = fopen(path, mode)))
> +		return NULL;
> +
> +	if (fstat(fileno(fp), &st)) {
> +		fclose(fp);
> +		return NULL;
> +	}
> +
> +	if (S_ISDIR(st.st_mode)) {
> +		fclose(fp);
> +		errno = EISDIR;
> +		return NULL;
> +	}
> +
> +	return fp;
> +}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4df90cb..46d5e93 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -204,6 +204,11 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
>                  const void *needle, size_t needlelen);
>  #endif
>  
> +#ifdef FREAD_READS_DIRECTORIES
> +#define fopen(a,b) git_fopen(a,b)
> +extern FILE *git_fopen(const char*, const char*);
> +#endif
> +
>  #ifdef __GLIBC_PREREQ
>  #if __GLIBC_PREREQ(2, 1)
>  #define HAVE_STRCHRNUL


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
