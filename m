From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well
Date: Fri, 13 Jun 2008 16:42:19 -0400
Message-ID: <20080613204219.GE7703@redhat.com>
References: <1213376131-20967-1-git-send-email-dzickus@redhat.com> <alpine.DEB.1.00.0806132131180.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7G7O-0003p4-FL
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 22:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbYFMUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 16:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYFMUm1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 16:42:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42787 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbYFMUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 16:42:27 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5DKgKiR032052;
	Fri, 13 Jun 2008 16:42:24 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5DKgK6o024423;
	Fri, 13 Jun 2008 16:42:20 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5DKgKji020414;
	Fri, 13 Jun 2008 16:42:20 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5DKgKu7026443;
	Fri, 13 Jun 2008 16:42:20 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5DKgJih026442;
	Fri, 13 Jun 2008 16:42:19 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806132131180.6439@racer>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84939>

On Fri, Jun 13, 2008 at 09:32:52PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 13 Jun 2008, Don Zickus wrote:
> 
> > When working with a lot of people who backport patches all day long, 
> > every once in a while I get a patch that modifies the same file more 
> > than once inside the same patch.  git-apply either fails if the second 
> > change relies on the first change or silently drops the first change if 
> > the second change is independent.
> > 
> > The silent part is the scary scenario for us.  Also this behaviour is 
> > different from the patch-utils.
> > 
> > I have modified git-apply to cache the filenames of files it modifies 
> > such that if a later patch chunk modifies a file in the cache it will 
> > buffer the previously changed file instead of reading the original file 
> > from disk.
> > 
> > Logic has been put in to handle creations/deletions/renames/copies.  All the
> > relevant tests of git-apply succeed.
> > 
> > A new test has been added to cover the two cases I addressed.
> > 
> > The fix is relatively straight-forward.  But I'm not sure if this new
> > behaviour is something the git community wants.
> 
> The scary part is about adding a linked list for file names you want to 
> look up.
> 
> Not that performance matters here, I guess, but we _already_ have 
> something much more efficient in Git, namely path-lists.
> 
> You could use that, and end up with a substantially smaller patch.

Thanks for the feedback.  I was unaware of path-lists.  I'll try to find
an example and implement it if it works.

Cheers,
Don
