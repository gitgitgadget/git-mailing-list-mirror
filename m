Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571B41F461
	for <e@80x24.org>; Wed, 28 Aug 2019 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfH1V5m (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 17:57:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37831 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfH1V5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 17:57:41 -0400
Received: from localhost.localdomain (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1131D200003;
        Wed, 28 Aug 2019 21:57:38 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3 3/4] git-gui: return early when patch fails to apply
Date:   Thu, 29 Aug 2019 03:27:24 +0530
Message-Id: <20190828215725.13376-4-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828215725.13376-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the procedure apply_or_revert_range_or_line, if the patch does not
apply successfully, a dialog is shown, but execution proceeds after
that. Instead, return early on error so the parts that come after this
don't work on top of an error state.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 lib/diff.tcl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index ffca788..0659029 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -848,6 +848,8 @@ proc apply_or_revert_range_or_line {x y revert} {
 		puts -nonewline $p $wholepatch
 		close $p} err]} {
 		error_popup "$failed_msg\n\n$err"
+		unlock_index
+		return
 	}
 
 	unlock_index
-- 
2.21.0

