Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8481F597
	for <e@80x24.org>; Fri, 27 Jul 2018 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbeG0WO6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 18:14:58 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:45935 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389266AbeG0WO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 18:14:58 -0400
Received: by mail-qk0-f201.google.com with SMTP id d194-v6so5239900qkb.12
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jhdts0c2cZnvHPkDc2iuyG2zJ1+UuKZnDwQAGEkrFsw=;
        b=a2rydu4BCGlq0DvQ10fZPLQOeL+HSh5NuGIbewB5lykBrmZJx3bi5HmwfVFfgNRIfq
         MP+EOlLh66lkTkdlEactcxGl3iS6dlSMEGIaFyh7Kkny/YPkwz4yXeZoBDkobaneMMQ1
         pFGq4/b773LUeW74A7XpK7pdrGSKCiZOblvSGUyu2NPqEOWcAxVL0Zqr3+AOi/xYTo9+
         JC7kA2pWXC8ux/uMVTG5yva8Wawh8UYJVI3pEKWb6DhJwHlNDlu1YM4H9JPF9mjU/iNl
         UPBvPa33CFkNbT4eMeNs197lqLDQsrmzn1OLMhFGZhNHND9ZkvVwcY8SbOhln3b+oAk7
         rGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jhdts0c2cZnvHPkDc2iuyG2zJ1+UuKZnDwQAGEkrFsw=;
        b=ij0hoosKI4ClZMlg7/XZagebSjk/AHxeWu/SVVMPYeIq1zxgpxylktVVCHAm8Sgcin
         n5IqFDSoCyPS27DAa/DWhsKoxZkudOEOmF39MqPj1eZRfJIGEL3hIr9Ok/0UW5AUtLv/
         8WE8pFOIuWg0RRhQNbgm9sPXT8ATCdwvsQAnqXsUW9UfSDmRQW3iS/eV1nLB3btSVAdE
         rNBX5XmtevFSf+QiD93yeDPPlcDDvnG95KMAB6cU84+9awCgLz5wM3yfQkgYGlmxWgEm
         VOtJsssu2m/5mSLuUCQzCTCbNUVaT42ynO70XDMWC+dPJe3LXw75yczgmGm3EIaVJUcw
         BaWg==
X-Gm-Message-State: AOUpUlFCPj1dk4FdNZyLeC65bPJplyblNgFM/xNXc4830oq26/aQRT/r
        Nk+F025Gu1USBQvpEOrYyK3s8+jLPUKWFgOGuHRXpambaP8SY6kuo/f3emj2f1rQL3zr3rRWqoq
        dgAXMKY99NBrLlod0A6CMBdU6XzskpN394C/poFZ91+SXACZBsmhSZyaLKA6a
X-Google-Smtp-Source: AAOMgpct7wSD/U0XhjYBfHHd9UIY7wmNcf1Ny3tWftUXVd9ihbctOtSFXTkCKbT2+ZxZ8bquAR8l1M1NRHAW
X-Received: by 2002:ae9:f403:: with SMTP id y3-v6mr4435675qkl.55.1532724681127;
 Fri, 27 Jul 2018 13:51:21 -0700 (PDT)
Date:   Fri, 27 Jul 2018 13:51:17 -0700
Message-Id: <20180727205117.243770-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A use reported a submodule issue regarding strange case indentation
issues, but it could be boiled down to the following test case:

  $ git init test  && cd test
  $ git config foo."Bar".key test
  $ git config foo."bar".key test
  $ tail -n 3 .git/config
  [foo "Bar"]
        key = test
        key = test

Sub sections are case sensitive and we have a test for correctly reading
them. However we do not have a test for writing out config correctly with
case sensitive subsection names, which is why this went unnoticed in
6ae996f2acf (git_config_set: make use of the config parser's event
stream, 2018-04-09)

Make the subsection case sensitive and provide a test for both reading
and writing.

Reported-by: JP Sugarbroad <jpsugar@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 config.c          |  2 +-
 t/t1300-config.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3aacddfec4b..3ded92b678b 100644
--- a/config.c
+++ b/config.c
@@ -2374,7 +2374,7 @@ static int store_aux_event(enum config_event_t type,
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
-			!strncasecmp(cf->var.buf, store->key, store->baselen);
+			!strncmp(cf->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 03c223708eb..8325d4495f4 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1218,6 +1218,24 @@ test_expect_success 'last one wins: three level vars' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setting different case subsections ' '
+	test_when_finished "rm -f caseSens caseSens_actual caseSens_expect" &&
+
+	# v.a.r and v.A.r are not the same variable, as the middle
+	# level of a three-level configuration variable name is
+	# case sensitive.
+	git config -f caseSens v."A".r VAL &&
+	git config -f caseSens v."a".r val &&
+
+	echo VAL >caseSens_expect &&
+	git config -f caseSens v."A".r >caseSens_actual &&
+	test_cmp caseSens_expect caseSens_actual &&
+
+	echo val >caseSens_expect &&
+	git config -f caseSens v."a".r >caseSens_actual &&
+	test_cmp caseSens_expect caseSens_actual
+'
+
 for VAR in a .a a. a.0b a."b c". a."b c".0d
 do
 	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
-- 
2.18.0.345.g5c9ce644c3-goog

