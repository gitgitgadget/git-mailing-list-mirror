From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 07:52:15 +0200
Message-ID: <20070418055215.GA32634@xp.machine.xx>
References: <20070417161720.GA3930@xp.machine.xx> <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 07:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He35n-00050K-5m
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 07:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbXDRFwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 01:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbXDRFwR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 01:52:17 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54153 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1753810AbXDRFwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 01:52:16 -0400
Received: (qmail 5744 invoked by uid 0); 18 Apr 2007 05:52:13 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 05:52:13 -0000
Mail-Followup-To: Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44863>

On Tue, Apr 17, 2007 at 10:55:17PM +0100, Julian Phillips wrote:
>  On Tue, 17 Apr 2007, Peter Baumann wrote:
> 
> > running git-gc or git-gc --prune isn't save because e.g. all the tags
> > are packed and .git/packed-refs isn't shared on the several workdirs.
> 
>  Do you mean that the link wasn't created?  Or that the link was removed and
>  replaced with a file when you ran gc from a workdir?
> 

The problem is, when I created the new workdir, I don't have a file
.git/packed-refs, so a new workdir was created with a dangling symlink,
e.g.  workdir/.git/packed-refs -> repo/.git/packed-refs (but the last one
doesn't exist). As it seems, git gc removes the dangling symlink and
replaces it with a file.

Steps to reproduce (written in this mail; after /usr/bin/script gave me an
output whith color coded text *GRR* in ASCII squences):

	mkdir a && cd a && git init
	echo 1 > file.txt
	git add file.txt
	git commit -m "file added"
	git tag v0
	cd ..

	git-new-workdir a b
	cd b && git-gc


Oh. Wait. Just forget that theorie about dangling symlink. git-gc replaces
the symlink in a new workdir with a file. Just confirmed that.

So it isn't save to run git-gc in a workdir.

-Peter
