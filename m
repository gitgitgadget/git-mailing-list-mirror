From: James Ketrenos <jketreno@linux.intel.com>
Subject: Getting list of changed objects...
Date: Thu, 14 Jul 2005 13:20:32 -0500
Message-ID: <42D6ACF0.30303@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 14 19:24:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt7QW-0007aJ-UM
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 19:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVGNRWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVGNRWy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 13:22:54 -0400
Received: from fmr17.intel.com ([134.134.136.16]:42674 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261564AbVGNRUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 13:20:12 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j6EHK1Pw028586
	for <git@vger.kernel.org>; Thu, 14 Jul 2005 17:20:01 GMT
Received: from [127.0.0.1] (logicsbox.jf.intel.com [134.134.16.142])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j6EHJwVU029971
	for <git@vger.kernel.org>; Thu, 14 Jul 2005 17:20:00 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050626
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I have the following tree path:

  A   C   B
  |   |
  | 3.|<--.   
  |   |   |
2.|-->'   |
  |       |
1.|------>'
  |

Where A is the root repository for my overlays.  B was created by 
cloning A (1)

B is where development has been progressing.  Finding the set of 
objects to move from A to B is easily obtained via:

  git-rev-list --objects B ^A 

The problem is now when I want to re-sync B with the latest version 
of A.  What I currently do is:

Create a new C tree based on latest A (2) and then merge B back into 
it (3):

  git-merge-tree -m $(git-merge-base C B) C B

That works great.  I now have a tree with all of the latest A code
and the B changes applied.  The problem is now in getting the list
of objects to create the overlay repository.

  cg-log -f -r C:B

Will correctly show only those files that have actually changed 
between C and B in the first log entry.  However, cg-log does 
not show me the list of tree objects that have changed between 
C and B.  

The problem is that if I run:

  git-rev-list --objects B ^C

It shows me all of the tree and commit objects but also gives a 
list of all of the files that changed between A and C as if they 
are needed to move C to B.

Am I overlooking something, misusing things, or ?

Thanks,
James
