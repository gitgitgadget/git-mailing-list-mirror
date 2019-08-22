Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016571F4B7
	for <e@80x24.org>; Thu, 22 Aug 2019 22:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbfHVWdY (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 18:33:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33549 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfHVWdY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:33:24 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost.localdomain (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8745BC0002;
        Thu, 22 Aug 2019 22:33:21 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-gui: Update in-memory config when changing config options
Date:   Fri, 23 Aug 2019 04:03:16 +0530
Message-Id: <20190822223316.11153-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user updates any config variable from the options menu, the new
config gets saved, but the in-memory state of the config variables is
not updated. This results in the old settings being used until the user
either opens the options menu again (which triggers a call to
load_config), or re-starts git-gui.

This change fixes that problem by re-loading the config variables when
the Save button is pressed in the options menu.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---

The commit can be found in the topic branch 'py/reload-config' at
https://github.com/prati0100/git-gui/tree/py/reload-config

Once reviewed, pull the commit 92582527b91750e47c2c3e4d1e2188998e9330ce
or just munge the patch and apply it locally, whichever you prefer.

 lib/option.tcl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/option.tcl b/lib/option.tcl
index e43971b..139cf44 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -344,6 +344,7 @@ proc do_save_config {w} {
 	if {[catch {save_config} err]} {
 		error_popup [strcat [mc "Failed to completely save options:"] "\n\n$err"]
 	}
+	load_config 1
 	reshow_diff
 	destroy $w
 }
--
2.21.0

