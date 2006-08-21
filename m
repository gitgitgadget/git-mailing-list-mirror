From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: use case
Date: Mon, 21 Aug 2006 22:47:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608212231430.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060821182338.GA21395@daga.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 22:48:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGgc-0004Hk-Oe
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 22:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWHUUrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 16:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWHUUrw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 16:47:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:11990 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751038AbWHUUrv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 16:47:51 -0400
Received: (qmail invoked by alias); 21 Aug 2006 20:47:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 21 Aug 2006 22:47:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Blu Corater <blu@daga.cl>
In-Reply-To: <20060821182338.GA21395@daga.cl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25819>

Hi,

On Mon, 21 Aug 2006, Blu Corater wrote:

> The main problem I am facing now is that I have been unable to make an
> octopus merge from all the branches to consolidate them. When I do a
> "git-pull . branch1 branch2..." git tells me "Unable to find common commit
> with 5f83..." where 5f83... is the sha1 of the head commit of the first
> branch on the command line.

Ideally, you really would have a common revision to start from. Since you 
do not have that yet, you have to go low-level for the first octopus.

Suppose you have the last common version as tip of branch "ancestor", you 
could do

	git merge-octopus ancestor -- HEAD branch1 branch2 ...

After this -- if everything went well -- you should have a committable 
state in the index. Before you commit, you should do

	git rev-parse branch1 > .git/MERGE_HEAD
	git rev-parse branch2 >> .git/MERGE_HEAD
	git rev-parse branch3 >> .git/MERGE_HEAD
	...

to tell git that you want to commit an octopus merge. This will tell 
git-commit what the parents of the merge are.

The next time you do an octopus, you _will_ have a common ancestor, so no 
need to jump through hoops after the first octopus.

Hth,
Dscho
