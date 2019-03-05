Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E2B20248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCEEqk (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:46:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:38832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEEqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:46:40 -0500
Received: (qmail 786 invoked by uid 109); 5 Mar 2019 04:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28687 invoked by uid 111); 5 Mar 2019 04:46:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:46:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:46:38 -0500
Date:   Mon, 4 Mar 2019 23:46:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 1/2] doc/fsck: clarify --connectivity-only behavior
Message-ID: <20190305044637.GA32325@sigill.intra.peff.net>
References: <20190305044530.GG19800@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305044530.GG19800@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On reading this again, there are two things that were not immediately
clear to me:

  - we do still check links to blobs, even though we don't open the
    blobs themselves

  - we do not do the normal fsck checks, even for non-blob objects we do
    open

Let's reword it to make these points a little more clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fsck.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 55950d9eea..b7c7ac0866 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -62,9 +62,13 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	with --no-full.
 
 --connectivity-only::
-	Check only the connectivity of tags, commits and tree objects. By
-	avoiding to unpack blobs, this speeds up the operation, at the
-	expense of missing corrupt objects or other problematic issues.
+	Check only the connectivity of reachable objects, making sure
+	that any objects referenced by a reachable tag, commit, or tree
+	is present. This speeds up the operation by avoiding reading
+	blobs entirely (though it does still check that referenced blobs
+	exist). This will detect corruption in commits and trees, but
+	not do any semantic checks (e.g., for format errors). Corruption
+	in blob objects will not be detected at all.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
-- 
2.21.0.684.gc9dc8b89c9

