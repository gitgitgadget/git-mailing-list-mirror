From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: git-filter-branch may leave tree in a nasty state
Date: Sun, 2 Mar 2008 22:02:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803022159130.27717@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0803022029540.27717@fbirervta.pbzchgretzou.qr>
 <alpine.LSU.1.00.0803022039360.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 22:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvLG-0001CX-B1
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbYCBVCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755811AbYCBVCb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:02:31 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:47839 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbYCBVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:02:30 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id A9E2C1804FBB4; Sun,  2 Mar 2008 22:02:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id A18AA1C057151;
	Sun,  2 Mar 2008 22:02:29 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0803022039360.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75838>


On Mar 2 2008 20:40, Johannes Schindelin wrote:
>On Sun, 2 Mar 2008, Jan Engelhardt wrote:
>
>> $ git-filter-branch --env-filter 'export GIT_AUTHOR_NAME="";' b4caa441..HEAD
>> Rewrite cf1d02ac074041f7e570ff206d87fb47ef2b2c34 (1/1)fatal: empty ident  
>> <user@corp.com> not allowed
>
>Well, I kinda expected people savvy enough to run filter-branch to have 
>set up the proper ident ;-)

Nah, this is just the test case. The real scripts I use write
author, email and log message to a file in the env-filter hook,
call an editor where they can be arbitrarily changed, and then
the rest of the env-filter and msg-filter hooks parse the text
file back into the shell variables.

So I am changing the ident of existing commits (postprocessing
a non-git tree conversion).

The problem is that some editors clear the terminal window
(in other words, they are "full-screen"), so I did not get to
see the filter-branch error message at all because the next
editor invocation just popped in.

Most importantly, git-filter-branch should STOP when it detects
a problem, not try rewriting the next commit.
