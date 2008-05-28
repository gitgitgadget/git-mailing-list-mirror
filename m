From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui clone differs from command line
Date: Wed, 28 May 2008 19:23:24 -0400
Message-ID: <20080528232324.GM30245@spearce.org>
References: <483D7884.2050407@robertsr.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Barry Roberts <blr@robertsr.us>
X-From: git-owner@vger.kernel.org Thu May 29 01:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1V0s-00013b-8A
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbYE1XXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972AbYE1XXn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:23:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38355 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbYE1XX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:23:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K1UzD-0000vZ-SV; Wed, 28 May 2008 19:23:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C5EF20FBAE; Wed, 28 May 2008 19:23:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <483D7884.2050407@robertsr.us>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83145>

Barry Roberts <blr@robertsr.us> wrote:
> After much mis-directed research, I finally figured out that cloning a 
> repo (ssh://) with git-gui doesn't work exactly like 'git clone' from 
> the command line.  The main difference is that 'git pull' doesn't work 
> on master.  I get the error below.  Is that intentional, or are we doing 
> something wrong?

Bug in git-gui.

git-gui's clone feature isn't implemented in terms of git-clone.
Its implemented in terms of more primitive actions:

	git init
	git remote add origin
	git fetch
	git fetch --tags
	git update-ref refs/heads/master origin/master
	git checkout

however it forgets to setup the branch configuration:
 
> If you often merge with the same branch, you may want to
> configure the following variables in your configuration
> file:
> 
>    branch.master.remote = <nickname>
>    branch.master.merge = <remote-ref>
>    remote.<nickname>.url = <url>
>    remote.<nickname>.fetch = <refspec>
> 
> See git-config(1) for details.

Yea.  That author of git-gui should really check git-config(1)
for detais.  *ducks and hides*

I'll try to fix it tonight or tomorrow.

-- 
Shawn.
