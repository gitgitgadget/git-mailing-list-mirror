Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5014F1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJJWcW (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:32:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:29841 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeJJWcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:32:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 08:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,364,1534834800"; 
   d="scan'208";a="96323519"
Received: from vjcarmax-mobl2.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.254.118.37])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2018 08:09:34 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, lucas.de.marchi@gmail.com
Subject: [PATCH] range-diff: allow to diff files regardless submodule
Date:   Wed, 10 Oct 2018 08:09:16 -0700
Message-Id: <20181010150916.4295-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.19.1.1.g8c3cf03f71
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do like it's done in grep so mode doesn't end up as
0160000, which means range-diff doesn't work if one has
"submodule.diff = log" in the configuration. Without this
while using range-diff I only get a

    Submodule a 0000000...0000000 (new submodule)

instead of the diff between the revisions.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 60edb2f518..bd8083f2d1 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, &null_oid, 0, 0644);
+	fill_filespec(spec, &null_oid, 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
-- 
2.19.1.1.g8c3cf03f71

