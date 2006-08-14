From: Shawn Pearce <spearce@spearce.org>
Subject: Validation of a commit object?
Date: Mon, 14 Aug 2006 02:28:30 -0400
Message-ID: <20060814062830.GF18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 14 08:28:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCVwG-0004Vz-Pg
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 08:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWHNG2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 02:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWHNG2i
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 02:28:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33428 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751885AbWHNG2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 02:28:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GCVwA-0006fh-4X
	for git@vger.kernel.org; Mon, 14 Aug 2006 02:28:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 413A620FB77; Mon, 14 Aug 2006 02:28:30 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25323>

In looking at fsck-objects.c the only thing it tries to validate
about a commit is:

 - the commit has a tree ("tree NNNNNN\n");
 - the commit maybe has parent(s) ("parent NNNNN\n");
 - the commit has "author ".

That's it.

Its OK for an author line to be completely corrupt and have no
timestamp, no name, no timezone.  Or to have a timestamp such as
"bobthetalkingdog".

Its OK for a committer line to just plain not exist or to be
equally corrupt.


I'm thinking that can't be right.  Shouldn't fsck-objects be doing
better checking on commits?

The reason I ask is I'm working on my (bastard) fast-import program
for Jon's Mozilla CVS -> GIT conversion effort and I'm taking the
author and committer lines blind from the Python code.  If the
Python code gives me a bad line its going to go into the pack that
way, with that possibly resulting in a totally corrupt repository.
I hoped to apply the same verification that fsck-objects applies
but apparently it doesn't do anything.  :-)

I'm willing to write some better validation in fsck-objects.c
and submit the patch if folks think we should do stronger checks
in there.

-- 
Shawn.
