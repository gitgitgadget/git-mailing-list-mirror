From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 05/11] winansi: fix compile warnings
Date: Sun, 31 May 2009 20:03:32 +0200
Message-ID: <4A22C674.603@kdbg.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 31 20:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MApNq-00058D-1T
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 20:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZEaSDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 14:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZEaSDe
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 14:03:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:37317 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbZEaSDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 14:03:34 -0400
Received: from [192.168.1.201] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 67DF5A7EB3;
	Sun, 31 May 2009 20:03:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1243786525-4493-6-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120424>

Steffen Prohaska schrieb:
> diff --git a/compat/win32.h b/compat/win32.h
> index c26384e..d531130 100644
> --- a/compat/win32.h
> +++ b/compat/win32.h
> @@ -1,5 +1,6 @@
>  /* common Win32 functions for MinGW and Cygwin */
>  #include <windows.h>
> +#include <conio.h>
>  
>  static inline int file_attr_to_st_mode (DWORD attr)
>  {

I assume this is to remove the warning about missing declaration of 
_getch(). Can we have this patch instead? I don't have conio.h in my 
oldish MinGW environment.

diff --git a/compat/mingw.c b/compat/mingw.c
index 52961ee..53053ad 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1211,6 +1211,9 @@ int link(const char *oldpath, const char *newpath)
  	return 0;
  }

+/* from conio.h */
+int _getch(void);  // FIXME: really look this up in conio.h!!!!
+
  char *getpass(const char *prompt)
  {
  	struct strbuf buf = STRBUF_INIT;

> diff --git a/compat/winansi.c b/compat/winansi.c
> index 4bee335..9217c24 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -80,7 +80,7 @@ static void set_console_attr(void)
>  static void erase_in_line(void)
>  {
>  	CONSOLE_SCREEN_BUFFER_INFO sbi;
> -	long dummy; /* Needed for Windows 7 (or Vista) regression */
> +	DWORD dummy; /* Needed for Windows 7 (or Vista) regression */
>  
>  	if (!console)
>  		return;

This should really be squashed into 03/11, where the line is introduced.

-- Hannes
