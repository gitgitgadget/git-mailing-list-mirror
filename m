From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 2 Aug 2007 22:49:09 +0200
Message-ID: <20070802204909.GA2829@steel.home>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com> <Pine.LNX.4.64.0708021636470.14781@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhc6-0000vx-1M
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602AbXHBUtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757639AbXHBUtO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:49:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:64556 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbXHBUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:49:12 -0400
Received: from tigra.home (Fac1b.f.strato-dslnet.de [195.4.172.27])
	by post.webmailer.de (fruni mo6) (RZmta 10.3)
	with ESMTP id z01c13j72HQqX7 ; Thu, 2 Aug 2007 22:49:10 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 85EBC277BD;
	Thu,  2 Aug 2007 22:49:09 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9D601C21D; Thu,  2 Aug 2007 22:49:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708021636470.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9thg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54606>

Johannes Schindelin, Thu, Aug 02, 2007 17:38:37 +0200:
> Hi,
> 
> On Thu, 2 Aug 2007, Alex Riesen wrote:
> 
> >@@ -209,7 +209,8 @@ const char *set_work_tree(const char *dir)
> >        len = strlen(dir);
> >        if (len > postfix_len && !strcmp(dir + len - postfix_len,
> >                                "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
> >-                       strncpy(dir_buffer, dir, len - postfix_len);
> >+               strncpy(dir_buffer, dir, len - postfix_len);
> >+               dir_buffer[len - postfix_len] = '\0';
> >
> >                /* are we inside the default work tree? */
> >                rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
> 
> Darn, darn, darn.  strncpy does _not_ NUL terminate.  I keep forgetting 
> that.
> 
> Better use strlcpy()?

Of course, but it just should not be needed at all: static supposed to
be zeroed.
