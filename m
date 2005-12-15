From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: new file leaked onto release branch
Date: Thu, 15 Dec 2005 02:29:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512150208190.9568@wbgn013.biozentrum.uni-wuerzburg.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B8748@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.63.0512150034120.8992@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7ja7ures.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 02:31:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emhvx-0001R7-1s
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVLOB3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVLOB3W
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:29:22 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:55189 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932517AbVLOB3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 20:29:22 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 13397E254B; Thu, 15 Dec 2005 02:29:21 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F00179DDE0; Thu, 15 Dec 2005 02:29:20 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DAE9C9DDDC; Thu, 15 Dec 2005 02:29:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C6397E254B; Thu, 15 Dec 2005 02:29:20 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7ja7ures.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13669>

Hi,

On Wed, 14 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So, it could have been
> >
> > 	git pull . 5165
> >
> > which mistakes 5165 for a short SHA1?
> 
> I do not think git-pull would work on arbitrary SHA1
> expressions, so you should be safe.

D'oh. I wanted to write it short, but I guess that made it only more 
confusing. In reality, Len used "git merge", and that works quite well 
with short SHA1s.

However, I just verified (as you did also), that they do not take 
precedence over branch names (the relevant piece of code is in get_sha1_1: 
get_short_sha1() is called only if get_sha1_basic() fails).

> Interestingly...
> 
>         $ git rev-parse 5165
>         error: short SHA1 5165 is ambiguous.
>         5165
> 
> that short SHA1 is ambiguous.

I don't want to be a PITA, but it could be ambiguous only since short time 
ago.

> But a branch name immediately under .git/refs/heads takes precedence:
>
>         $ git branch 5165 master
>         $ git rev-parse 5165 master
>         acd9b7b4e08a3f0f48afa922d8e371414cf2d3b2
>         acd9b7b4e08a3f0f48afa922d8e371414cf2d3b2

There is an interesting side effect: If 5165 as a short SHA1 would be 
unique, and there is a tag *and* a branch named 5165, git-rev-parse would 
expand the short SHA1...

However, it still does not solve the original riddle.

Ciao,
Dscho
