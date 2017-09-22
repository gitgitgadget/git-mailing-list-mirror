Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72CD202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdIVUbe (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:31924 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdIVUbd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:33 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 061818470B;
        Fri, 22 Sep 2017 16:31:33 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7FC378470A;
        Fri, 22 Sep 2017 16:31:32 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 10/13] rev-list: add filtering help text
Date:   Fri, 22 Sep 2017 20:30:14 +0000
Message-Id: <20170922203017.53986-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-rev-list.txt     |  9 ++++++++-
 Documentation/rev-list-options.txt | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ef22f17..b2e8255 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -47,7 +47,14 @@ SYNOPSIS
 	     [ --fixed-strings | -F ]
 	     [ --date=<format>]
 	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
-	       [ --unpacked ] ]
+	       [ --unpacked ]
+	       [ [ --filter-omit-all-blobs |
+		   --filter-omit-large-blobs=<n>[kmg] |
+		   --filter-use-blob=<blob-ish> |
+		   --filter-use-path=<path> ]
+		 [ --filter-print-missing ]
+		 [ --filter-print-omitted ] ] ]
+	     [ --filter-relax ]
 	     [ --pretty | --header ]
 	     [ --bisect ]
 	     [ --bisect-vars ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a6cf9eb..5c7d53c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -698,6 +698,38 @@ ifdef::git-rev-list[]
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
+
+--filter-omit-all-blobs::
+	Only useful with one of the `--objects*`; omits all blobs from
+	the printed list of objects.
+
+--filter-omit-large-blobs=<n>[kmg]::
+	Only useful with one of the `--objects*`; omits blobs larger than
+	n bytes from the printed list of objects.  May optionally be
+	followed by 'k', 'm', or 'g' units.  Value may be zero.  Special
+	files (matching ".git*") are always included, regardless of size.
+
+--filter-use-blob=<blob-ish>::
+--filter-use-path=<path>::
+	Only useful with one of the `--objects*`; uses a sparse-checkout
+	specification contained in the given object or file to filter the
+	result to only contain blobs referenced by such a sparse-checkout.
+
+--filter-print-missing::
+	Prints a list of the missing objects for the requested traversal.
+	Object IDs are prefixed with a ``?'' character.  The object type
+	is printed after the ID.  This may be used with or without any of
+	the above filtering options.
+
+--filter-print-omitted::
+	Only useful with one of the above `--filter*`; prints a list
+	of the omitted objects.  Object IDs are prefixed with a ``~''
+	character.  The object size is printed after the ID.
+
+--filter-relax::
+	Relax consistency checking for missing blobs.  Do not warn of
+	missing blobs during normal (non-filtering) object traversal
+	following an earlier partial/narrow clone or fetch.
 endif::git-rev-list[]
 
 --no-walk[=(sorted|unsorted)]::
-- 
2.9.3

