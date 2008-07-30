From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Glean libexec path from argv[0] for git-upload-pack and
 git-receive-pack.
Date: Wed, 30 Jul 2008 16:56:49 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807301650060.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1217417238-26731-1-git-send-email-shaslam@lastminute.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:58:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOD7g-0007lW-B4
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758AbYG3O4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbYG3O4x
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:56:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:50894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756055AbYG3O4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:56:52 -0400
Received: (qmail invoked by alias); 30 Jul 2008 14:56:50 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 30 Jul 2008 16:56:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1969Qk5OTh6KfTyG/L0ghHhyuiCjNmjv7SeLKM6A3
	IU1RwimCkLa7E4
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1217417238-26731-1-git-send-email-shaslam@lastminute.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90799>

Hi,

> diff --git a/upload-pack.c b/upload-pack.c
> index c911e70..086eff6 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -616,6 +616,9 @@ int main(int argc, char **argv)
>  	int i;
>  	int strict = 0;
>  
> +	if (argv[0] && *argv[0])
> +		git_extract_argv0_path(argv[0]);
> +

This is ugly.  The called function should already do it itself.

Further, why not go the full nine yards and avoid the calculation 
altogether, until it is necessary?  Then the change to add 
lookup_program_in_path() would be nice and non-intrusive.

IOW why not leave the function name as-is, and just enhance system_path() 
to have a static variable "initialized", which does the whole calculation? 
I.e. move the calculation from git.c to exec_cmd.c, but at the same time 
do it only when needed.

And your change to set argv0_path from receive-pack and upload-pack would 
be a second patch.

And then the patch to add support to "glean" (did not know that word) the 
path from the PATH (lookup_program_in_path()) could come as a third patch.

Ciao,
Dscho
