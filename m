From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 21/40] Windows: Disambiguate DOS style paths from SSH
 URLs.
Date: Thu, 28 Feb 2008 15:22:53 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281522190.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-22-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:24:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkc6-0006jr-T4
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbYB1PX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756480AbYB1PX0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:23:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:56207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753862AbYB1PXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:23:25 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:23:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 28 Feb 2008 16:23:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7IFhCu+P76LxPJnBzMmxhH9W/uAlWROSW79yR75
	9YAUX6nslOzDj2
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-22-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75408>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> diff --git a/connect.c b/connect.c
> index 5ac3572..7e18ac8 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -529,7 +529,13 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>  		end = host;
>  
>  	path = strchr(end, c);
> -	if (path) {
> +#ifdef __MINGW32__
> +	/* host must have at least 2 chars to catch DOS C:/path */
> +	if (path && path - end > 1)
> +#else
> +	if (path)
> +#endif
> +	{

This could be un-#ifdef'ed by using the has_dos_drive_prefix() function I 
suggested earlier.

Ciao,
Dscho

