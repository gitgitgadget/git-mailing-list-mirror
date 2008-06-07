From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
 unknown command
Date: Sat, 7 Jun 2008 16:04:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806071603470.1783@racer>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080607072721.GA3347@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 17:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4zzt-0004hu-3I
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 17:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbYFGPFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 11:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbYFGPFc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 11:05:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:50613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754730AbYFGPFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 11:05:31 -0400
Received: (qmail invoked by alias); 07 Jun 2008 15:05:29 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp040) with SMTP; 07 Jun 2008 17:05:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aIQh8rMVaBbm7T9BlZHIkDBlywjbfXVrUf4txE3
	TdPAM6sAxMTakl
X-X-Sender: gene099@racer
In-Reply-To: <20080607072721.GA3347@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84203>

Hi,

On Sat, 7 Jun 2008, Alex Riesen wrote:


> diff --git a/help.c b/help.c
> index ac29225..765eed8 100644
> --- a/help.c
> +++ b/help.c
> @@ -640,7 +640,7 @@ static int levenshtein_compare(const void *p1, const void *p2)
>  
>  void help_unknown_cmd(const char *cmd)
>  {
> -	int i, header_shown = 0;
> +	int i, header_shown = 0, listed = 0;
>  
>  	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
>  
> @@ -667,6 +667,8 @@ void help_unknown_cmd(const char *cmd)
>  			header_shown = 1;
>  		}
>  		fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
> +		if (++listed >= 5)
> +			break;
>  	}
>  
>  	exit(1);

How about this instead?

-- snipsnap --

 help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index bd51852..173e502 100644
--- a/help.c
+++ b/help.c
@@ -655,7 +655,7 @@ void help_unknown_cmd(const char *cmd)
 	qsort(main_cmds.names, main_cmds.cnt,
 	      sizeof(*main_cmds.names), levenshtein_compare);
 
-	for (i = 0; i < main_cmds.cnt; i++) {
+	for (i = 0; i < main_cmds.cnt && i < 5; i++) {
 		int s = similarity(main_cmds.names[i]->name);
 		if (s > 6)
 			break;
