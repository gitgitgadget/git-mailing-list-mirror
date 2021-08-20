Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D22C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336E161130
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhHTJQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbhHTJQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 05:16:08 -0400
X-Greylist: delayed 1849 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Aug 2021 02:15:30 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB8C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 02:15:30 -0700 (PDT)
Received: from [2400:4160:1877:2b00:d89b:5a80:e3c2:b06] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1mH08h-0007sF-Bj; Fri, 20 Aug 2021 08:44:35 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1mH08a-006JBe-Pj; Fri, 20 Aug 2021 17:44:28 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix leak in credential_apply_config
Date:   Fri, 20 Aug 2021 17:44:13 +0900
Message-Id: <20210820084413.1503711-1-mh@glandium.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 credential.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/credential.c b/credential.c
index 3c05c7c669..000ac7a8d4 100644
--- a/credential.c
+++ b/credential.c
@@ -128,6 +128,7 @@ static void credential_apply_config(struct credential *c)
 	normalized_url = url_normalize(url.buf, &config.url);
 
 	git_config(urlmatch_config_entry, &config);
+	string_list_clear(&config.vars, 1);
 	free(normalized_url);
 	strbuf_release(&url);
 
-- 
2.33.0

