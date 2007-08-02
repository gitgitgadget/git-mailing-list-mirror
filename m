From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 2 Aug 2007 16:38:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021636470.14781@racer.site>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcla-0000eg-DJ
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbXHBPjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbXHBPjG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:39:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:44809 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751589AbXHBPjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:39:05 -0400
Received: (qmail invoked by alias); 02 Aug 2007 15:39:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 02 Aug 2007 17:39:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+corQ+ojicMvA61FEzIbMvyRhlngYQubKLTy/GA7
	eQE0zpxZV2qjzP
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54565>

Hi,

On Thu, 2 Aug 2007, Alex Riesen wrote:

>@@ -209,7 +209,8 @@ const char *set_work_tree(const char *dir)
>        len = strlen(dir);
>        if (len > postfix_len && !strcmp(dir + len - postfix_len,
>                                "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
>-                       strncpy(dir_buffer, dir, len - postfix_len);
>+               strncpy(dir_buffer, dir, len - postfix_len);
>+               dir_buffer[len - postfix_len] = '\0';
>
>                /* are we inside the default work tree? */
>                rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);

Darn, darn, darn.  strncpy does _not_ NUL terminate.  I keep forgetting 
that.

Better use strlcpy()?

Ciao,
Dscho
