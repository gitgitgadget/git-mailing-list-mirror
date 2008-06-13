From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well
Date: Fri, 13 Jun 2008 21:32:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806132131180.6439@racer>
References: <1213376131-20967-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7G09-0000lk-3V
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 22:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbYFMUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYFMUel
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 16:34:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:36713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752302AbYFMUek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 16:34:40 -0400
Received: (qmail invoked by alias); 13 Jun 2008 20:34:37 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 13 Jun 2008 22:34:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/AmN5IH1/gtDYCTGgvGYfnyvn6DTXLLjlKB/FKc
	Lk0bdmcnnE//vQ
X-X-Sender: gene099@racer
In-Reply-To: <1213376131-20967-1-git-send-email-dzickus@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84938>

Hi,

On Fri, 13 Jun 2008, Don Zickus wrote:

> When working with a lot of people who backport patches all day long, 
> every once in a while I get a patch that modifies the same file more 
> than once inside the same patch.  git-apply either fails if the second 
> change relies on the first change or silently drops the first change if 
> the second change is independent.
> 
> The silent part is the scary scenario for us.  Also this behaviour is 
> different from the patch-utils.
> 
> I have modified git-apply to cache the filenames of files it modifies 
> such that if a later patch chunk modifies a file in the cache it will 
> buffer the previously changed file instead of reading the original file 
> from disk.
> 
> Logic has been put in to handle creations/deletions/renames/copies.  All the
> relevant tests of git-apply succeed.
> 
> A new test has been added to cover the two cases I addressed.
> 
> The fix is relatively straight-forward.  But I'm not sure if this new
> behaviour is something the git community wants.

The scary part is about adding a linked list for file names you want to 
look up.

Not that performance matters here, I guess, but we _already_ have 
something much more efficient in Git, namely path-lists.

You could use that, and end up with a substantially smaller patch.

Ciao,
Dscho
