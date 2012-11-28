From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH] push: cleanup push rules comment
Date: Tue, 27 Nov 2012 23:18:53 -0600
Message-ID: <1354079933-2488-1-git-send-email-chris@rorvick.com>
References: <7v7gp7nf5e.fsf@alter.siamese.dyndns.org>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 06:20:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tda4R-0000zY-TP
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 06:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab2K1FUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 00:20:10 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53730 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab2K1FUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 00:20:09 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so9591228iay.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 21:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+npk5v4WHlXaQYd59YDbENbr/bDEjRx73ReEN4XCfo8=;
        b=JCt+YdyrgGbnObOI87BE/v6ri5vbVLKK0nMe1qu/AvMdT7UCNHVd6jBoqrareyIHWP
         f0Anki7JxJ093t7kUnMMMlxIa3zV2X5m8Dj9w39kWDQ8N9mYrBCiPjivUyI25Tnys8iB
         Xp6PksMrEx2XBPF40Dd6oqlJPHLgEt0J3PyYjvgtNs1/eZf2o+8Knpl4y433jEgm9rCu
         6izFhnz4X+dO+fLyrAFSQab+t3D5bNFA07+yswNDzcQ5XcIyDL064ApJfL+JakoYPDEo
         RXYSraWErZ3Yg8ZbAIID7+v1vNWIvS0QSBDsOLY0tspQntN6ddt6ogS20VtuCKAKOQjf
         VKVQ==
Received: by 10.50.179.103 with SMTP id df7mr18180410igc.4.1354080008553;
        Tue, 27 Nov 2012 21:20:08 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id s3sm3757268igb.14.2012.11.27.21.20.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 21:20:07 -0800 (PST)
X-Mailer: git-send-email 1.8.0.209.gf3828dc
In-Reply-To: <7v7gp7nf5e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210704>

---

I ended up rewriting most of the comment.  The new version removes
inter-rule dependencies (e.g., rule 5 overrides rule 3) which I think
makes it more readable.

This patch applies on top of the latest patch series regarding
pushing tags.  If will include this in a re-roll of that series if
these changes are deemed a good idea.

Also, I hand-edited the patch so that the changes were not interleaved
to make it much easier to read.  Can this be done automatically?
Something like a minimum # of matching lines required between
differences?

Chris

 remote.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/remote.c b/remote.c
index ee0c1e5..3fb1068 100644
--- a/remote.c
+++ b/remote.c
@@ -1319,27 +1319,29 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			continue;
 		}
 
-		/* This part determines what can overwrite what.
-		 * The rules are:
-		 *
-		 * (0) you can always use --force or +A:B notation to
-		 *     selectively force individual ref pairs.
-		 *
-		 * (1) if the old thing does not exist, it is OK.
-		 *
-		 * (2) if the destination is under refs/tags/ you are
-		 *     not allowed to overwrite it; tags are expected
-		 *     to be static once created
-		 *
-		 * (3) if you do not have the old thing, you are not allowed
-		 *     to overwrite it; you would not know what you are losing
-		 *     otherwise.
-		 *
-		 * (4) if old is a commit and new is a descendant of old
-		 *     (implying new is commit-ish), it is OK.
-		 *
-		 * (5) regardless of all of the above, removing :B is
-		 *     always allowed.
+		/*
+		 * The below logic determines whether an individual
+		 * refspec A:B can be pushed.  The push will succeed
+		 * if any of the following are true:
+		 *
+		 * (1) the remote reference B does not exist
+		 *
+		 * (2) the remote reference B is being removed (i.e.
+		 *     pushing :B where no source is specified)
+		 *
+		 * (3) the update meets all fast-forwarding criteria:
+		 *
+		 *     (a) the destination is not under refs/tags/
+		 *     (b) the old is a commit
+		 *     (c) the new is a descendant of the old
+		 *
+		 *     NOTE: We must actually have the old object in
+		 *     order to overwrite it in the remote reference,
+		 *     and that the new object must be commit-ish.
+		 *     These are implied by (b) and (c) respectively.
+		 *
+		 * (4) it is forced using the +A:B notation, or by
+		 *     passing the --force argument
 		 */
 
 		ref->not_forwardable = !is_forwardable(ref);
-- 
1.8.0.209.gf3828dc
