From: Paul Mackerras <paulus@samba.org>
Subject: Re: New features in gitk
Date: Thu, 1 Nov 2007 22:37:36 +1100
Message-ID: <18217.47744.621850.100789@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 12:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYNB-0001mH-DP
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 12:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbXKALhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 07:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbXKALhw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 07:37:52 -0400
Received: from ozlabs.org ([203.10.76.45]:45691 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756339AbXKALhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 07:37:51 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id ECE28DDDF6; Thu,  1 Nov 2007 22:37:49 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62939>

Linus Torvalds writes:

> The cost is not generally in outputting the commits. The real cost is in 
> traversing them in the first place. 

Actually, the biggest cost is still gitk reading in the commits from
git log and doing the processing that gitk needs to do on each commit
(which I have tried to minimize, and is way smaller than it used to
be, but is still significant).

In fact that would go significantly faster if git log could output the
data for each commit in a slightly different format.  What would be
good is to get one header line for each commit in the form:

id flag {parent parent parent...} length

where:

id is the 40-char SHA1 for the commit
flag is normally 1, but is 0 for "boundary" commits, 2 for "left-side"
    commits (with --merge), or 3 for "right-side" commits
length is the number of characters of commit data that follow
    (which may differ from the number of bytes, so there would need
     to be agreement on the encoding)

followed by the body of the commit (with no null or other separator
character between commits).

That would be easier to parse in Tcl, and looks like it would knock
another 1.5 seconds off the gitk startup time (for the kernel
repository on my G5).

Paul.
