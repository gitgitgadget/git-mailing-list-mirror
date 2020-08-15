Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831CEC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8442074D
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHOAZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 20:25:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:29193 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgHOAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 20:25:31 -0400
IronPort-SDR: Pdf/d4hloKvp7xhj8+MaIfNZM4nQ7EnIZR+ArImO+buRZbcCXCp1eEeoQzIX4qw0mTGK8GP/fy
 mCmtm1SKoCsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="172554200"
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="172554200"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 17:25:31 -0700
IronPort-SDR: qrl4PT2HNcO/ix8JgbBPEOuopt7JfoiJtdNYZVk01HVLBx6h3PBbVqK80WxsGzQly8cGwfH8zL
 p5/ng78Ebjfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="325861564"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 17:25:30 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC 1/3] refspec: fix documentation referring to refspec_item
Date:   Fri, 14 Aug 2020 17:25:07 -0700
Message-Id: <20200815002509.2467645-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b60
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

In commit d27eb356bf25 ("remote: move doc to remote.h and refspec.h")
the documentation for the refspec structure was moved into refspec.h

This documentation refers to elements of the refspec_item, not the
struct refspec. Move the documentation slightly in order to align it
with the structure it is actually referring to.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 refspec.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/refspec.h b/refspec.h
index 23e1555b88ac..8d654e3a3ac4 100644
--- a/refspec.h
+++ b/refspec.h
@@ -4,6 +4,19 @@
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
 extern const struct refspec_item *tag_refspec;
 
+/**
+ * A struct refspec_item holds the parsed interpretation of a refspec.  If it will
+ * force updates (starts with a '+'), force is true.  If it is a pattern
+ * (sides end with '*') pattern is true.  src and dest are the two sides
+ * (including '*' characters if present); if there is only one side, it is src,
+ * and dst is NULL; if sides exist but are empty (i.e., the refspec either
+ * starts or ends with ':'), the corresponding side is "".
+ *
+ * remote_find_tracking(), given a remote and a struct refspec_item with either src
+ * or dst filled out, will fill out the other such that the result is in the
+ * "fetch" specification for the remote (note that this evaluates patterns and
+ * returns a single result).
+ */
 struct refspec_item {
 	unsigned force : 1;
 	unsigned pattern : 1;
@@ -21,20 +34,8 @@ struct refspec_item {
 #define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
 
 /**
- * A struct refspec holds the parsed interpretation of a refspec.  If it will
- * force updates (starts with a '+'), force is true.  If it is a pattern
- * (sides end with '*') pattern is true.  src and dest are the two sides
- * (including '*' characters if present); if there is only one side, it is src,
- * and dst is NULL; if sides exist but are empty (i.e., the refspec either
- * starts or ends with ':'), the corresponding side is "".
- *
- * An array of strings can be parsed into an array of struct refspecs using
+ * An array of strings can be parsed into a struct refspec using
  * parse_fetch_refspec() or parse_push_refspec().
- *
- * remote_find_tracking(), given a remote and a struct refspec with either src
- * or dst filled out, will fill out the other such that the result is in the
- * "fetch" specification for the remote (note that this evaluates patterns and
- * returns a single result).
  */
 struct refspec {
 	struct refspec_item *items;

base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
-- 
2.28.0.163.g6104cc2f0b60

