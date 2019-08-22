Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517101F461
	for <e@80x24.org>; Thu, 22 Aug 2019 20:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393229AbfHVUbT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 16:31:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:57637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbfHVUbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 16:31:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 13:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; 
   d="scan'208";a="178970483"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.244.172])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2019 13:31:19 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] git-submodule: fix expansion of depth for cmd_update
Date:   Thu, 22 Aug 2019 13:31:14 -0700
Message-Id: <20190822203114.18805-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.23.0.245.gf157bbb9169d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

The depth variable already contains "--depth=", so expanding it with an
additional --depth when invoking the update-clone git submodule--helper
is incorrect.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I'm *reasonably* sure this is correct, but I am not sure how to test it.
It's possible that it expands to "--depth --depth=N" and somehow this gets
handled properly?

 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c7f58c5756f7..4e7fc8bf3652 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -547,7 +547,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
-		${depth:+--depth "$depth"} \
+		${depth:+"$depth"} \
 		$recommend_shallow \
 		$jobs \
 		-- \
-- 
2.23.0.245.gf157bbb9169d

