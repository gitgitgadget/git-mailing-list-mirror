From: Eric Wong <normalperson@yhbt.net>
Subject: Re: minor git-svn bug
Date: Thu, 2 Jul 2009 23:24:16 -0700
Message-ID: <20090703062416.GA23128@dcvr.yhbt.net>
References: <4A4CEB81.4080309@doki-pen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: doki_pen <doki_pen@doki-pen.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 08:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMcC7-0003ff-DN
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 08:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbZGCGYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 02:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZGCGYN
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 02:24:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59933 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbZGCGYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 02:24:13 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D38751F84D;
	Fri,  3 Jul 2009 06:24:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A4CEB81.4080309@doki-pen.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122684>

doki_pen <doki_pen@doki-pen.org> wrote:
> Is this the right place to bring up bugs?  Or only patches?  Anyway, I  
> found a small bug.

Yes to both.  Also, feel free to Cc: me on git svn questions since
it halves the chance of me losing track of it.

> Due to some strange structure on the svn host, I have manually added the  
> fetch lines to the [svn-remote] section of config.  There are hundreds  
> of branches and tags, so I only have lines for what I need.  I removed  
> one that I thought I didn't need anymore, and also removed the remote  
> tracking branch.  When I discovered that I needed the branch again, I  
> added it back to svn-remotes and did a git svn fetch.  There were no new  
> commits on the branch, so the remote tracking branch was not recreated.   
> The work around was to do a commit on the branch via svn, then git svn  
> fetch.  This caused the remote tracking branch to reappear. --

If you have reflogs (on by default), then it would've been possible to
recreate the ref without hitting the network at all by creating the
ref based on the reflog.

git svn not detecting that a remote ref was manually removed was
probably caused by lingering metadata in .git/svn/$remote_branch/.
Clobbering that directory alone should've been sufficient for
"git svn fetch" to work...

-- 
Eric Wong
