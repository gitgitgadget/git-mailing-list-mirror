From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rev-list docs: clarify --topo-order description
Date: Mon, 13 Aug 2012 15:21:09 -0700
Message-ID: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 00:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1317-00079h-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 00:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab2HMWVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 18:21:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927Ab2HMWVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 18:21:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C13949AB1;
	Mon, 13 Aug 2012 18:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	WiPTxeuBms1q8WMuljwR//ja58=; b=dQh4ObpJ+Pi/yM4NNoB2BrLdiWJWt3xOw
	Vt1x5tvDG98Q+UU7Vxw6Gvj2kWsbL8XtXYZElnFykmTbdX4CsoQeOi9t3ZbW8prB
	g+7g4L5Ybij+i6EIFFU7dRfSBysEQz8FUzkgugy6YQiBdy71auxfpwLZ+EFk+U6L
	o+bVbkVX5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=PikvLwyjFSUeEN6B1ljBWJ8OTcGzunIY/6L+i2mCT/VsOB2kY/XkPeCo
	zDrzV+n+mWW2cAGPuq9J4fN4o3DKyt9sAfByvdMU2S4GFkvN1q8E5MIA48Z0mEpK
	0wVVFNIIG2q9ktwS4BcOSRgA9BivWStsQIry93OvSpkkyBYZkF8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADAE89AB0;
	Mon, 13 Aug 2012 18:21:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F70A9AAD; Mon, 13 Aug 2012
 18:21:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FAEF3A2-E595-11E1-B792-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203372>

We said "--date-order" still does not violate the topology, but it
was still not clear enough.

Reword the description for both "--date-order" and "--topo-order",
and add an illustration to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Let's do this before I forget...; came up in discussion $gmane/203370

 Documentation/rev-list-options.txt | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6a4b635..dc501ee 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -579,15 +579,32 @@ Commit Ordering
 By default, the commits are shown in reverse chronological order.
 
 --topo-order::
-
-	This option makes them appear in topological order (i.e.
-	descendant commits are shown before their parents).
+	This option makes them appear in topological order.  Even
+	without this option, descendant commits are shown before
+	their parents, but this tries to avoid showing commits on
+	multiple lines of history intermixed.
 
 --date-order::
 
-	This option is similar to '--topo-order' in the sense that no
-	parent comes before all of its children, but otherwise things
-	are still ordered in the commit timestamp order.
+	Show no parents before all of its children, but otherwise
+	show commits in the commit timestamp order.
++
+For example, in a commit history like this:
++
+----------------------------------------------------------------
+
+    ---1----2----4----7
+	\	       \
+	 3----5----6----8---
+
+----------------------------------------------------------------
++
+where the numbers denote the order of commit timestamps, `git
+rev-list` and friends with `--date-order` show the commits in the
+timestamp order: 8 7 6 5 4 3 2 1.
++
+With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
+3 1), to avoid commits from two branches mixed together.
 
 --reverse::
 
-- 
1.7.12.rc2.85.g1de7134
