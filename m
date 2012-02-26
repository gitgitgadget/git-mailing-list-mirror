From: "Neal Kreitzinger" <neal@rsss.com>
Subject: 4-way diff (base,ours,theirs,merged) to review merge results
Date: Sat, 25 Feb 2012 21:55:37 -0600
Message-ID: <jicafn$gnj$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 04:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1VDm-0003dC-2j
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 04:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab2BZDzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 22:55:51 -0500
Received: from plane.gmane.org ([80.91.229.3]:53088 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab2BZDzu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 22:55:50 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S1VD8-0003I0-45
	for git@vger.kernel.org; Sun, 26 Feb 2012 04:55:46 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 04:55:46 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 04:55:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191553>

Combined diff only tells you what the merge result auto-resolved (with 
rerere turned off and no merge-conflicts) in comparison to "ours" and 
"theirs".  That only tells you what "ours" and "theirs" *had*, not what they 
*did* (or were trying to do).  You need the merge-base version to see what 
"ours" and "theirs" did.  Seeing what "ours" and "theirs" did will 
much-better tell you if "merged" did-the-right-thing or not.  What is the 
best way to display a 4-way diff of merge-base, "ours", "theirs", and 
"merged" after a merge completes so you can review the "merged" results for 
correctness?

Before I try writing a script to dump the object-contents of the merge-base, 
"ours", "theirs", and "merged" versions of the-file-in-question to 
work-files and then feed them to a 4-way diff for review, I would like to 
see if someone already has a script or better-idea for this, or if git has 
something more straight-forward that already does-this-for-you.

Reason for this:
If "ours" has line-x and "theirs" does not have line-x, and "merged" does 
have line-x you still have a mystery on your hands:

(Combined diff)
ours:  has line-x
theirs (master):  does not have line-x
merged:  has line-x
merge-base (older master):  *may-or-may-not* have line-x
conclusion:  I'm not very sure if "merged" should have line-x or not...

Based on the combined-diff only, I don't know if "merged" should have line-x 
or not because I don't know if "ours" *added* line-x to the merge-base or if 
"theirs" *removed* line-x from the merge-base.  IOW, if "theirs" is master 
and "ours" is way-behind master then I pretty-much know I probably need to 
take "theirs" because it has the latest-stuff.  However, I don't know if 
"theirs" took line-x out of master (and "ours" just has line-x because its 
old), or if line-x was never in master and "ours" really-needed to add it. 
Having merge-base context allows for more accurate conclusions like this:

ours:  has line-x
theirs (master):  does not have line-x
merged:  has line-x
merge-base (older master):  has line-x
conclusion:  I should probably take line-x out of "merged"

ours:  has line-x
theirs (master):  does not have line-x
merged:  has line-x
merge-base:  does not have line-x
conclusion:  I should probably keep line-x in "merged"

Thanks in advance for you feedback.

v/r,
neal 
