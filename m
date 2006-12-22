From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 19:09:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net> <86k60jsvh8.fsf@blue.stonehenge.com>
 <86fyb7sv9f.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 19:09:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxoq6-0003j9-33
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 19:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWLVSJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWLVSJo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 13:09:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751684AbWLVSJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 13:09:43 -0500
Received: (qmail invoked by alias); 22 Dec 2006 18:09:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 22 Dec 2006 19:09:41 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86fyb7sv9f.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35192>

Hi,

On Fri, 22 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
> 
> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> Junio> git-pull: refuse default merge without branch.*.merge
> 
> Randal> Argh.  How do I get back the old behavior?
> Randal> "git-pull origin" doesn't seem to be enough.

Maybe "git-pull origin master"?

> Randal> You just broke a bunch of automated scripts for me.
> 
> Ahh, it's "git-pull . origin".

This is just a merge, not a real pull (it leaves out the fetch part).

> Maybe a bit more warning for non-upward-compatible changes though, 
> please.

It is unfortunate that this change broke your scripts. But I really think 
that the new behaviour is much saner: If you have different branches, you 
probably do not want to pull the _same_ remote branch into _all_ of them.

So, for each branch (e.g. "xyz") for which you have a preferred upstream 
(e.g. remote "linus" with branch "master"), say

	$ git repo-config branch.xyz.remote linus
	$ git repo-config branch.xyz.merge refs/heads/master

Then,

	$ git pull

pulls your preferred upstream. But when you pull from another remote, or 
into another branch, without specifying which remote branch you want to 
pull, git now refuses to blindly pull branch "master". This should prevent 
quite some pilot errors.

Ciao,
Dscho
