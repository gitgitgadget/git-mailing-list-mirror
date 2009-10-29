From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH I18N filenames v2 3/3] Provide compatibility with MinGW
Date: Thu, 29 Oct 2009 10:01:01 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0910290955530.8995@ds9.cixit.se>
References: <1256752900-2615-1-git-send-email-timur@iris-comp.ru> <1256752900-2615-2-git-send-email-timur@iris-comp.ru> <1256752900-2615-3-git-send-email-timur@iris-comp.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Timur Sufiev <timur@iris-comp.ru>
X-From: git-owner@vger.kernel.org Thu Oct 29 10:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3QsZ-0003as-VE
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 10:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZJ2JBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 05:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZJ2JBA
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 05:01:00 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:51741 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751956AbZJ2JA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 05:00:59 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n9T9112v011174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 29 Oct 2009 10:01:01 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n9T911XB011171;
	Thu, 29 Oct 2009 10:01:01 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1256752900-2615-3-git-send-email-timur@iris-comp.ru>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131575>

Hi!

Timur Sufiev:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 6b5b5b2..2a2ebcb 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2,7 +2,7 @@
> #include "win32.h"
> #include <conio.h>
> #include "../strbuf.h"
> -
> +#include "../io-i18n.h"
> #include <shellapi.h>
>
> static int err_win_to_posix(DWORD winerr)
> @@ -132,7 +132,7 @@ int mingw_open (const char *filename, int oflags, ...)
> 	if (!strcmp(filename, "/dev/null"))
> 		filename = "nul";
>
> -	fd = open(filename, oflags, mode);
> +	fd = open_i18n(filename, oflags, mode);
>
> 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
> 		DWORD attrs = GetFileAttributes(filename);

Instead of calling the open_i18n() which converts from UTF-8 to a local 
8-bit character set, this should probably call a version that converts from 
UTF-8 to UTF-16 and uses _wopen().

Same thing for fopen_i18n() and _wfopen().

I created a small RFC patch for that that changed parts of the system 
earlier this year - http://kerneltrap.org/mailarchive/git/2009/3/2/5350814

I did not address readdir() and friends, I'm not sure if they are available 
in UTF-16 form or if they need to be rewritten using findfirst()/findnext().

-- 
\\// Peter - http://www.softwolves.pp.se/
