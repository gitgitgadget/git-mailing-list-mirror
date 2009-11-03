From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] Makefile: keep MSVC and Cygwin configuration separate
Date: Tue, 03 Nov 2009 08:27:39 +0100
Message-ID: <4AEFDB6B.8010209@viscovery.net>
References: <4AE74659.6020503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Dnt-0006Y2-WD
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbZKCH1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbZKCH1e
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:27:34 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:6443 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755628AbZKCH1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:27:34 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5Dnm-0006TU-I2; Tue, 03 Nov 2009 08:27:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 55DA36D9; Tue,  3 Nov 2009 08:27:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE74659.6020503@ramsay1.demon.co.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131949>

Ramsay Jones schrieb:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  Makefile |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 8e1cfc5..12c8249 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -658,6 +658,14 @@ EXTLIBS =
>  # Platform specific tweaks
>  #
>  
> +ifdef MSVC
> +	# When building with msvc, on MinGW or Cygwin, we
> +	# override the uname settings to make it easier to
> +	# keep the configuration sections separate
> +	uname_S = Windows
> +	uname_O = Windows
> +endif
> +
>  # We choose to avoid "if .. else if .. else .. endif endif"
>  # because maintaining the nesting to match is a pain.  If
>  # we had "elif" things would have been much nicer...
> @@ -893,7 +901,7 @@ ifeq ($(uname_S),HP-UX)
>  	NO_SYS_SELECT_H = YesPlease
>  	SNPRINTF_RETURNS_BOGUS = YesPlease
>  endif
> -ifdef MSVC
> +ifeq ($(uname_S),Windows)
>  	GIT_VERSION := $(GIT_VERSION).MSVC
>  	pathsep = ;
>  	NO_PREAD = YesPlease
> @@ -945,7 +953,7 @@ else
>  	BASIC_CFLAGS += -Zi -MTd
>  endif
>  	X = .exe
> -else
> +endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
>  	pathsep = ;
>  	NO_PREAD = YesPlease
> @@ -994,7 +1002,6 @@ else
>  	NO_PTHREADS = YesPlease
>  endif
>  endif
> -endif
>  
>  -include config.mak.autogen
>  -include config.mak

I like the direction of this change, but I think that you must use ':='
assignment, and I would put this right after the uname_* assignments at
the beginning of the Makefile:

 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
+ifdef MSVC
+	uname_S := Windows
+	uname_O := Windows	# avoid cygwin configuration
+endif

-- Hannes
