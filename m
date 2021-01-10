Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9FAC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5E2227BF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbhAJTFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 14:05:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50310 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbhAJTFj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 14:05:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C170F60781;
        Sun, 10 Jan 2021 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610305498;
        bh=XwGRsHRAN4aCp6pVSqY+JJ+Bhu/6qUhg3/OlcM+6XPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kSKZg5rqrpM3j8vnbRPiC7m/axBRhITMEWO+hU38+FglN23bBOZw7Pr0rH3+RmF9t
         JV78s3Dnd/rrWHwLnhJa3LJszE7qvB+jRp5d35TB9wUUXPFcw4h7bcDq4BWZynQ7Iu
         iNRHojEDkLMgtWnHXZrLrjFNW1ej4Pmc8kYfYmbbBkdCTbs17BgJp7YYuEJkywEwR3
         vQxwufkacM8H/l4H0LJcB0EExVtMr+5xizSUIi3hqXAw+JkvcVHvlVyCGllLjV9/C4
         Tx3CSf3CHAk3dJGf+fazYYgUw2AUZrSITuZEnClpurL/zkSCpaC+IE2Ow4Z7yrBftC
         m7JDOwXKgPbp40d/9PepGRcl6YbaI14CuNpwYjsdQU7V3SkEpQv/VB/+ExoIjyLQJR
         sFc33stRzAxgeLBuyY8FBGhHB6ckI5Exyp0Gi/RffZOp6SM78L8cNdcGUGZWdPkzfJ
         H8AZrPwydJX6bBigEPQMcdMEiCPMF/bgpdOHw+M795o7nOMhcjr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Alan Mackenzie <acm@muc.de>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] docs: rephrase and clarify the git status --short format
Date:   Sun, 10 Jan 2021 19:04:48 +0000
Message-Id: <20210110190448.779754-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <X/oAhdZlLwcFRCrR@ACM>
References: <X/oAhdZlLwcFRCrR@ACM>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The table describing the porcelain format in git-status(1) is helpful,
but it's not completely clear what the three sections mean, even to
some contributors.  As a result, users are unable to find how to detect
common cases like merge conflicts programmatically.

Let's improve this situation by rephrasing to be more explicit about
what each of the sections in the table means, to tell users in plain
language which cases are occurring, and to describe what "unmerged"
means.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This uses text from Junio's email, so his sign-off will be required
here.  I assume that won't be a problem, but I can send a v3 if it is.

 Documentation/git-status.txt | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7731b45f07..c0764e850a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -184,11 +184,26 @@ characters, that field will be quoted in the manner of a C string
 literal: surrounded by ASCII double quote (34) characters, and with
 interior special characters backslash-escaped.
 
-For paths with merge conflicts, `X` and `Y` show the modification
-states of each side of the merge. For paths that do not have merge
-conflicts, `X` shows the status of the index, and `Y` shows the status
-of the work tree.  For untracked paths, `XY` are `??`.  Other status
-codes can be interpreted as follows:
+There are three different types of states that are shown using this format, and
+each one uses the `XY` syntax differently:
+
+* When a merge is occurring and the merge was successful, or outside of a merge
+	situation, `X` shows the status of the index and `Y` shows the status of the
+	working tree.
+* When a merge conflict has occurred and has not yet been resolved, `X` and `Y`
+	show the state introduced by each head of the merge, relative to the common
+	ancestor. These paths are said to be _unmerged_.
+* When a path is untracked, `X` and `Y` are always the same, since they are
+	unknown to the index. `??` is used for untracked paths. Ignored files are
+	not listed unless `--ignored` is used; if it is, ignored files are indicated
+	by `!!`.
+
+Note that the term _merge_ here also includes rebases using the default
+`--merge` strategy, cherry-picks, and anything else using the merge machinery.
+
+In the following table, these three classes are shown in separate sections, and
+these characters are used for `X` and `Y` fields for the first two sections that
+show tracked paths:
 
 * ' ' = unmodified
 * 'M' = modified
@@ -198,9 +213,6 @@ codes can be interpreted as follows:
 * 'C' = copied
 * 'U' = updated but unmerged
 
-Ignored files are not listed, unless `--ignored` option is in effect,
-in which case `XY` are `!!`.
-
 ....
 X          Y     Meaning
 -------------------------------------------------
