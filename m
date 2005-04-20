From: Matt Mackall <mpm@selenic.com>
Subject: distributed merge prototype
Date: Wed, 20 Apr 2005 10:50:42 -0700
Message-ID: <20050420175042.GH21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 20 19:47:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOJHf-0008PV-Jz
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDTRu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVDTRu4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:50:56 -0400
Received: from waste.org ([216.27.176.166]:55982 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261773AbVDTRup (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:50:45 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3KHogtV014060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 12:50:42 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3KHogPp014057
	for git@vger.kernel.org; Wed, 20 Apr 2005 12:50:42 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've hacked together a prototype SCM that I think you folks might be
interested in. The announcement is here:

 http://selenic.com/mercurial/announce.txt

It's at a very early stage right now and is likely to break if you
look at it wrong, but I have sucessfully managed to check in kernel
trees, do a local clone/branch, make changes in both trees, and then
do a pull/sync which called up tkdiff where appropriate.

I mention it here because I've got a fairly simple implementation of
distributed merge ala Monotone or BK with the necessary graph smarts.
It also should perform decently - I've paid a lot of attention to the
scalability of the core algorithms. The core of the merge code is less
than 100 lines so even people who aren't familiar with Python may be
able to wrap their head around it and leverage it for git.

I'd also like to encourage more attention to back-end storage.
Mercurial can check in all 495 versions of linux/Makefile from bkcvs
to compressed delta store in about 5 seconds on my laptop and the
result is about 80K (bkcvs takes 254K). Adding and retrieving
revisions is O(1).

The same directory individually compressed by gzip (ie what git does)
takes a comparable amount of time and 5.1M of disk space. This is
admittedly a worst case for git as most of the deltas are small, but I
needed a test file with lots of revisions.

Now back to our regularly scheduled programming..

-- 
Mathematics is the supreme nostalgia of our time.
