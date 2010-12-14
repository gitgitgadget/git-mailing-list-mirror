From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
Date: Tue, 14 Dec 2010 21:38:37 +0100
Message-ID: <201012142138.37679.j6t@kdbg.org>
References: <4D07B786.2060602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"GIT Mailing-list" <git@vger.kernel.org>, jrnieder@gmail.com,
	vmiklos@frugalware.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 21:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSbeJ-0003nW-Ji
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 21:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760073Ab0LNUil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 15:38:41 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:57512 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759983Ab0LNUik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 15:38:40 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E29D6CDF83;
	Tue, 14 Dec 2010 21:38:37 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BE4BC19F5F9;
	Tue, 14 Dec 2010 21:38:37 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D07B786.2060602@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163686>

On Dienstag, 14. Dezember 2010, Ramsay Jones wrote:
> @@ -126,7 +126,10 @@ static int is_executable(const char *name)
>  	    !S_ISREG(st.st_mode))
>  		return 0;
>
> -#ifdef WIN32
> +#if defined(WIN32) || defined(__CYGWIN__)
> +#if defined(__CYGWIN__)
> +if ((st.st_mode & S_IXUSR) == 0)
> +#endif
>  {	/* cannot trust the executable bit, peek into the file instead */
>  	char buf[3] = { 0 };
>  	int n;

Do you gain a lot by this extra condition? Wouldn't

-#ifdef WIN32
+#if defined(WIN32) || defined(__CYGWIN__)

be sufficient?

-- Hannes
