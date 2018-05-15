Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17A51F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeEOXnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34724 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeEOXmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:51 -0400
Received: by mail-pl0-f65.google.com with SMTP id ay10-v6so975933plb.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OYV/28X4vpkCoMcursP7HYCVeLnYUzFehYoRFpHtASg=;
        b=FMFAuQTzqm8fT3CchEAeQ1MVq3fRrc8WLhW5aw1Vvai5cwOunEaK1pMf8pYeGMwzEP
         Fl3VCiKpa4yOid/8hc2ta7BxvNTnA8gl0IhaIKdvJJOeQA7vyDWTkWeH9J/HSw2MrtnQ
         qAPuukpDlOPCB3e4XEtlDO2qoIwzDGYGftkG+vZ3FEw8396SXfOaL0ZPcBqeRsB8cP1H
         0We5cZnyMSvCGPklTnM3DgK1B37PGyrx7BoC7uLuQ2b+FyDFzYT1I8zkeeOtmPFKp1Gh
         NZ5vheTjXJbPosOefcFSfH7TpEgYfxxiBdSz/GIwGNcuqtuWrAf6632npUuACkE153b/
         nOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OYV/28X4vpkCoMcursP7HYCVeLnYUzFehYoRFpHtASg=;
        b=CEesvevaMgy4M3hSfiHbrBaWz7q0IhGyx2OUQqiZueANlosMwjR/CqanHfoZE7ntvm
         jdh17bxqP08PoywoAin68nlczbEmb5uWNpaCXgwtOyTAhBA5FX1q6GruX76BhC7mDMiq
         hd6rMfzuXjeItJocPuO71LcFu1xSaQkTaZHdB9j91eQoJUVkWGL7+qKWzvTac1Qv74+1
         KsAfceY1IedZ/EvqSEuy+mCRThjqKDBVgdcUGDvmia83Xmej1+3peJ8uKI6IGND3y3n5
         urEX4ob7iYPirT4FQkEc+XG5k/qKQjmdXJ2VT/q/n18Ryh0ADJusPKdmzk3itQ7LhTkN
         VeiA==
X-Gm-Message-State: ALKqPwf76cRZ7k54i5uf8FV7QcPjJEZm5x/2W52Qf0MpOrcT60JpRa2z
        U3ZuRILotjWuT6eBfpYHqy92sIxmGro=
X-Google-Smtp-Source: AB8JxZo+cbulCLPoWJCvAv4CIFUTVRVYDXQnfDkrZPegCf4Fo6CJ23h4ZiZNPIyyo9bu6C19SJwhGw==
X-Received: by 2002:a17:902:1023:: with SMTP id b32-v6mr16429817pla.145.1526427770660;
        Tue, 15 May 2018 16:42:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m72-v6sm1622605pfk.110.2018.05.15.16.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/19] shallow: add repository argument to check_shallow_file_for_update
Date:   Tue, 15 May 2018 16:42:24 -0700
Message-Id: <20180515234233.143708-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 shallow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index 0fadd5330d2..0028e4ea776 100644
--- a/shallow.c
+++ b/shallow.c
@@ -217,7 +217,8 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	return result;
 }
 
-static void check_shallow_file_for_update(void)
+#define check_shallow_file_for_update(r) check_shallow_file_for_update_##r()
+static void check_shallow_file_for_update_the_repository(void)
 {
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
@@ -319,7 +320,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 
 	fd = hold_lock_file_for_update(shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
-	check_shallow_file_for_update();
+	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
@@ -366,7 +367,7 @@ void prune_shallow(int show_only)
 	}
 	fd = hold_lock_file_for_update(&shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
-	check_shallow_file_for_update();
+	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-- 
2.17.0.582.gccdcbd54c44.dirty

