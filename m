From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 13:57:35 +0200
Message-ID: <4821992F.4060201@viscovery.net>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mike.ralphson@gmail.com
To: Mike Ralphson <mike@abacus.co.uk>
X-From: git-owner@vger.kernel.org Wed May 07 13:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtiIF-0004ZJ-L4
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 13:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbYEGL5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 07:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbYEGL5p
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 07:57:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57838 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbYEGL5j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 07:57:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtiH8-0003q6-W6; Wed, 07 May 2008 13:57:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AC31E69F; Wed,  7 May 2008 13:57:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1210149355875-git-send-email-mike@abacus.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81428>

Mike Ralphson schrieb:
> NO_MKDTEMP is required to build, FREAD_READS_DIRECTORIES and the definition
> of _LARGE_FILES fix test suite failures and INTERNAL_QSORT is required for
> adequate performance.
> 
> Tested on AIX v5.3 Maintenance Level 06
> 
> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
> ---
>  Makefile |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7c70b00..4296656 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -632,8 +632,12 @@ endif
>  ifeq ($(uname_S),AIX)
>  	NO_STRCASESTR=YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_MKDTEMP = YesPlease
>  	NO_STRLCPY = YesPlease
> +	FREAD_READS_DIRECTORIES = UnfortunatelyYes
> +	INTERNAL_QSORT = UnfortunatelyYes
>  	NEEDS_LIBICONV=YesPlease
> +	BASIC_CFLAGS += -D_LARGE_FILES
>  endif
>  ifeq ($(uname_S),GNU)
>  	# GNU/Hurd

I'm trying this patch on AIX 4.3.3 (sigh!) with gcc3. I get this:

git-compat-util.h:209:1: warning: "fopen" redefined
In file included from git-compat-util.h:51,
                 from builtin.h:4,
                 from git.c:1:
/usr/local/lib/gcc-lib/powerpc-ibm-aix4.3.2.0/3.2.1/include/stdio.h:110:1:
warning: this is the location of the previous definition

Line 110 in ...include/stdio.h is inside a #ifdef _LARGE_FILES section and
says:

#define fopen fopen64

Did you also get this warning? Is _LARGE_FILES support solved in a
different way on 5.3?

-- Hannes
