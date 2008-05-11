From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Sun, 11 May 2008 19:03:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805111901390.30431@racer>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 11 20:04:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFuV-00077L-P5
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634AbYEKSDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbYEKSDp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:03:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54002 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755175AbYEKSDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:03:45 -0400
Received: (qmail invoked by alias); 11 May 2008 18:03:43 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 11 May 2008 20:03:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qwhRxKuQq1ig4ieQOI9T5jKiNyodI96GijbxmEg
	08Hfc/9pakLr5N
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81805>

Hi,

On Mon, 28 Apr 2008, Johannes Schindelin wrote:

> With rotating logs, there is a problem when the syslog is opened only 
> once (in the beginning).  So open the log everytime we write something, 
> and close it directly after writing.

Actually, the culprit were _not_ rotating logs.  At least not really.  
syslog() is not supposed to be called from a signal handler.  In 
git-daemon, it is, from child_handler(), but only when called with 
--verbose (and --syslog, or --detach).  Bummer.

Sorry for my wrong analysis,
Dscho
