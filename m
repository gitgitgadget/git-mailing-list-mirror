Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDEF20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbdFLWOx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:53 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36288 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdFLWOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:50 -0400
Received: by mail-pg0-f42.google.com with SMTP id a70so50760843pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dIItHQEXEAwqimVToRmDR7BdG69Hlmthspe5YGiwRko=;
        b=TBFALsiCHJvrdSGtJb+6EfXcMfUwF7QlJJJbpLmIpRA/rIE2NwLc+O9598XZvN1tgW
         VFmo6OYse01eIJ0b76M83VpfLrekP/yKWBnqmZgkK8KwbvGqlfWRs8f+6SLiVdtjPR07
         lhnzxDhXxxvHuR497oNrSJbJ1S8CW123zr9zyTemSBc7XZuyyCKGKU9MAY77hn4jQ5vo
         fJeY3Ifmu6HKUGAyk0BeFcfJ2VUTL70eKYiJV0/lPwfZ8Q2PIE+wyedxpN7bbTVzurex
         xUoHXdxL2NEwVErFQe4SEqCw0gyNTGQ3hOJbuDe/nbemWUcSWIZuIm/PUQ2OmvnSAclv
         827w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dIItHQEXEAwqimVToRmDR7BdG69Hlmthspe5YGiwRko=;
        b=inu3C5hVqevAdEOtNuUlz8rgDmocS+m9d/+smAUsy/rX6ceOT2zWMoTo4us3fP5w7H
         +fwQZ0o84oBblip1yWxx5d+GE3RssAtyKqiC1AiM7h5RKprM1sZLY+oEVcmR6hN8v5mD
         Lnh6wqS8Gcp/2XgdRL0GrwxQyog48CLVQ6R1xLjEn5RyJAqAi73QxVxtX4NfmbKvMRta
         xQ1o6xxiZuFDF1vBHEHhe/rkllee5U3RBKl5s9lsKbRTZ8uGTdXmgtZ8Us2EPA3w2R50
         Kot6D9Ul0e/cDRFG4pe/xZuB4lCOiEqIZH8V5O8f/ab2Ds6Xom3JhcvQQNXW/yGJ5OCU
         a7Pw==
X-Gm-Message-State: AKS2vOySwkak8+BBpeAft0SKlCdO5Nfznj3CE3f++FNTC1o4/M49Kkof
        hgIPkYichhgGBFXIkQ+hew==
X-Received: by 10.98.7.11 with SMTP id b11mr1911622pfd.188.1497305684082;
        Mon, 12 Jun 2017 15:14:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 16/17] ls-files: factor out debug info into a function
Date:   Mon, 12 Jun 2017 15:14:07 -0700
Message-Id: <20170612221408.173876-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 55d6f54fd..c9307f9ef 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -93,6 +93,19 @@ static void write_name(const char *name)
 	strbuf_release(&full_name);
 }
 
+static void print_debug(const struct cache_entry *ce)
+{
+	if (debug_mode) {
+		const struct stat_data *sd = &ce->ce_stat_data;
+
+		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
+	}
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len = max_prefix_len;
@@ -279,15 +292,7 @@ static void show_ce_entry(const struct index_state *istate,
 		}
 		write_eolinfo(istate, ce, ce->name);
 		write_name(ce->name);
-		if (debug_mode) {
-			const struct stat_data *sd = &ce->ce_stat_data;
-
-			printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-			printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-			printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-			printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-			printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
-		}
+		print_debug(ce);
 	}
 
 	strbuf_release(&name);
-- 
2.13.1.518.g3df882009-goog

