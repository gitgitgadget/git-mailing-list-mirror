Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4EDC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209476139F
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbhDFCfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhDFCfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 22:35:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27B2C06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 19:35:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o6so3615405wmq.3
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CevzPVpIPSsBfzAbC6IpwlCMAq97Vs62hnL9Jq4c+Hc=;
        b=fm41cpmdzQMXTaSWPPb7jtX7n3I9+jKLz9X+hEXc4u5Bb+ZuqtnKsw2+3p4dBk3Xc0
         uCaOQ1sB5fUMkDMRYMOUVtlCYwtjQnWVuXLhOSwi9ATvi/vjNUCJshR0Sy0eZNs211NJ
         dZdzfJMvdiEzAxCUZO8msbJAqWi4e/xOKyoOIL0J3CabzYf5DFnOTU+9rccIK90wjXtF
         uEFtsOUs/fsu92fwZiGBQJ9N4ohc/5OBWVdniNfn6CdXtoFiWAxuLNfFj6qWQ1yojroW
         0H6jASdXRf/ieyAG0AjcPTOf5YYcPFm/yqUpRUvuleX8qwAtlLJ5ZZaCFI+REJMt8BIn
         HaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CevzPVpIPSsBfzAbC6IpwlCMAq97Vs62hnL9Jq4c+Hc=;
        b=AFHhM4lY5b7qSq47vD4c7XUR+En/GtFaRnrFkr/bgP7KnGlTbaa1fz3SsXS2piozl/
         ezDEmPqYOw6HSPldQeb40EwaZxIMmC56FCg+ZSIXRLoVVzINgRdxcntRoxKJnxcjDegU
         kKSwdD2FE1yuTHFx4fyytvn6XnvEaUX5+FMd5NaxMZKuV6AOK9lgjppWH1B2DIOIXxqC
         0quT4q8tDDTttaRvX9oA48jf9lc2eFLx/y5aOnHNfTkAHEe9PnggDGjY3ti3LYi2KWQL
         Wl0Yzt5K7mnrQ6YbRd/OLovRjfmRJKF4RTzd4pdmWCOpqEWhbtHLIwIF3QK+k/9c10Ip
         mEAg==
X-Gm-Message-State: AOAM532FiK82ykYkbR/xP3QiJgv36Om+gp1T/Mz58CLgZ5emCxU2YxuJ
        xwMN4QFGmcsQbH7GmSrr8lQbxdtWUN9NJQ==
X-Google-Smtp-Source: ABdhPJy0SLTSllzIr1UpuI5+GqWruuYCNG9Pxxxl4z0ZLTXDv/OWH0FL1e5FRfWxbLsWfWQwG1v5Ow==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr1731000wml.113.1617676537241;
        Mon, 05 Apr 2021 19:35:37 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.55])
        by smtp.gmail.com with ESMTPSA id l1sm31454044wrv.87.2021.04.05.19.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:35:36 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] test-bloom: fix missing 'bloom' from usage string
Date:   Tue,  6 Apr 2021 04:35:14 +0200
Message-Id: <20210406023514.27060-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like 'get_murmur3' and 'generate_filter', 'get_filter_for_commit' is a
subcommand of `test-tool bloom` not of `test-tool` itself.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-bloom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 2a1ae3dae6..ad3ef1cd77 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -48,7 +48,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 static const char *bloom_usage = "\n"
 "  test-tool bloom get_murmur3 <string>\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
-"  test-tool get_filter_for_commit <commit-hex>\n";
+"  test-tool bloom get_filter_for_commit <commit-hex>\n";
 
 int cmd__bloom(int argc, const char **argv)
 {
-- 
2.31.1.189.g2e36527f23

