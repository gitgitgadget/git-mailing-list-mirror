Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60070C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450DD207DA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUVsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:48:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:19358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgHUVsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:48:40 -0400
IronPort-SDR: MIo1j3Q8zUlsNk8V6DLySb0olH9IAjWcDODjPLHaxiz/zCDp204+FDyQRdjz0UOgFEyAO5BRfy
 9IkkoVwHWX9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135171195"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135171195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:48:39 -0700
IronPort-SDR: jipGPlSIKa+ETAnKcp7ZU4u0ioIc+MJHkeCusLdX0S9JyPIYvxtFkMM45UPmFhJqh6nFZz88Ck
 i7OPi7FUDXFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="498106700"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2020 14:48:39 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 1/2] refspec: fix documentation referring to refspec_item
Date:   Fri, 21 Aug 2020 14:48:19 -0700
Message-Id: <20200821214820.757222-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.218.ge27853923b9d.dirty
In-Reply-To: <20200821214820.757222-1-jacob.e.keller@intel.com>
References: <20200821214820.757222-1-jacob.e.keller@intel.com>
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
-- 
2.28.0.218.ge27853923b9d.dirty

