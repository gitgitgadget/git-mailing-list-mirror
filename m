From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-merge documentation: describe how conflict is
 presented
Date: Sun, 31 Aug 2008 23:28:00 -0700
Message-ID: <7vwshwz8gf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 08:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka2ud-0007B9-P5
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 08:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbYIAG2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 02:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYIAG2N
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 02:28:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYIAG2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 02:28:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67B626974E;
	Mon,  1 Sep 2008 02:28:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 12FDA6974D; Mon,  1 Sep 2008 02:28:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 263C98A0-77EF-11DD-BC0A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94534>

We took it granted that everybody knows how to read the RCS merge style
conflicts, and did not give illustrations in the documentation.  Now we
are introducing an alternative output style, it is time to document this.

The lack of illustration has been bugging me for a long time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It always bothered me that we say "conflicts are shown the same way as
   you would see with CVS or SVN" or "resolve it the same way as you would
   in other SCMs", without explicitly saying how they look like or how you
   would actually resolve them.  Recent update to this manual page by Dan
   Hensgen made the situation better for the latter issue, and this one
   addresses the former one.

 Documentation/git-merge.txt |   65 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 17a15ac..8065d17 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -119,6 +119,71 @@ When there are conflicts, these things happen:
    same and the index entries for them stay as they were,
    i.e. matching `HEAD`.
 
+HOW CONFLICTS ARE PRESENTED
+---------------------------
+
+During a merge, the working tree files are updated to reflect the result
+of the merge.  Among the changes made to the common ancestor's version,
+non-overlapping ones (that is, you changed an area of the file while the
+other side left that area intact, or vice versa) are incorporated in the
+final result verbatim.  When both sides made changes to the same area,
+however, git cannot randomly pick one side over the other, and asks you to
+resolve it by leaving what both sides did to that area.
+
+By default, git uses the same style as that is used by "merge" program
+from the RCS suite to present such a conflicted hunk, like this:
+
+------------
+Here are lines that are either unchanged from the common
+ancestor, or cleanly resolved because only one side changed.
+<<<<<<< yours:sample.txt
+Conflict resolution is hard;
+let's go shopping.
+=======
+Git makes conflict resolution easy.
+>>>>>>> theirs:sample.txt
+And here is another line that is cleanly resolved or unmodified.
+------------
+
+The area a pair of conflicting changes happened is marked with markers
+"<<<<<<", "=======", and ">>>>>>>".  The part before the "=======" is
+typically your side, and the part after it is typically their side.
+
+The default format does not show what the original said in the conflicted
+area.  You cannot tell how many lines are deleted and replaced with the
+Barbie's remark by your side.  The only thing you can tell is that your
+side wants to say it is hard and you'd prefer to go shopping, while the
+other side wants to claim it is easy.
+
+An alternative style can be used by setting the "merge.conflictstyle"
+configuration variable to "diff3".  In "diff3" style, the above conflict
+may look like this:
+
+------------
+Here are lines that are either unchanged from the common
+ancestor, or cleanly resolved because only one side changed.
+<<<<<<< yours:sample.txt
+Conflict resolution is hard;
+let's go shopping.
+|||||||
+Conflict resolution is hard.
+=======
+Git makes conflict resolution easy.
+>>>>>>> theirs:sample.txt
+And here is another line that is cleanly resolved or unmodified.
+------------
+
+In addition to the "<<<<<<", "=======", and ">>>>>>>" markers, it uses
+another "|||||||" marker that is followed by the original text.  You can
+tell that the original just stated a fact, and your side simply gave in to
+that statement and gave up, while the other side tried to have a more
+positive attitude.  You can sometimes come up with a better resolution by
+viewing the original.
+
+
+HOW TO RESOLVE CONFLICTS
+------------------------
+
 After seeing a conflict, you can do two things:
 
  * Decide not to merge.  The only clean-up you need are to reset
-- 
1.6.0.1.260.g7aa8
