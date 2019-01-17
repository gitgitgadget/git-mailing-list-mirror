Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A431F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfAQNHX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41609 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQNHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so4807384pfi.8
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/ClL1LeB7jaArLOYbh5ig81qmDQRCWvqttxv7b65PU=;
        b=iU9dysSxLSk8p6cpPHGB+0YQCEMkXkJ9zUlIM7DYvxVE3pMqq8cnrMUhy/yNO53QDW
         TGQyGIV9Fw/PpZwqgobtr6swN0QLnIVWsShrV5/y13R/218bLkOemgPvd35dYwlF77C5
         0s2HuC0YMAkUnVQ22tI7LS7Xbvfcc96YAcTlojOm9yYMWyrXWL/eq6VmDKTp+lw9Lj4e
         wupfb0QTzxC0DcSy12WaovQbvWUBpjJ1dURdwmZN+7BNuoZA561+CHr5l5MwrKAfN+8x
         ECTUJMKC5oNY+P+z7E5DO5CnwPzrRdXQfKlBwpMiUrB/5K7TbC0XcPa7+w8qrr8zDo6O
         VTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/ClL1LeB7jaArLOYbh5ig81qmDQRCWvqttxv7b65PU=;
        b=S9juaih4uY5+T2m+7FJ5lJzBdywh/+AzXBw/hpGKgGxvYL1l8C8Czs56t+n7mes0Qx
         mkM7itB8vFKuVLbL+/cSDj1ccAszNHAr6++/Z6el1mMRZ20HeJhyBrJzaICx08RlcUP0
         ZoLCUD23u1VLAHnrcuCUSM5GtU7VGR5tYn73PNvQIFZxND8h6imERqT+224hFvCMRP2f
         +mhNeUKpmStsnEpIs1C0jlKwwnhSQ3H12mPKFi21luKA1583EoUUelOZsuC8ktLeUngO
         n5yepy1TH8QNTA6Fw1ICHNtL4EzmHA7le98f+p7k4D1XrS4xgdtqDjcKMOyy8UG67P+t
         qr+w==
X-Gm-Message-State: AJcUukdmeTqWeTzsb2helcXQzFoQ5f8Fx3flQrEjUI323+33wqRHK+/N
        qkK8i0BX5Z0thlsc+RAviIzzfWzC
X-Google-Smtp-Source: ALg8bN4lCjM2YHWtLN0RBEL+bGsxTRuLcU9+CJv4mgL+6RycCa1IoBkKx63WHPx9isW40Cf7e1bkHg==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr14702021pfg.235.1547730442356;
        Thu, 17 Jan 2019 05:07:22 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k14sm1722035pgs.52.2019.01.17.05.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/76] diff.h: avoid bit fields in struct diff_flags
Date:   Thu, 17 Jan 2019 20:05:09 +0700
Message-Id: <20190117130615.18732-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bitfield addresses cannot be passed around in a pointer. This makes it
hard to use parse-options to set/unset them. Turn this struct to
normal integers. This of course increases the size of this struct
multiple times, but since we only have a handful of diff_options
variables around, memory consumption is not at all a concern.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h | 66 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/diff.h b/diff.h
index c872a41344..8abe1649d0 100644
--- a/diff.h
+++ b/diff.h
@@ -64,39 +64,39 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
-	unsigned recursive:1;
-	unsigned tree_in_recursive:1;
-	unsigned binary:1;
-	unsigned text:1;
-	unsigned full_index:1;
-	unsigned silent_on_remove:1;
-	unsigned find_copies_harder:1;
-	unsigned follow_renames:1;
-	unsigned rename_empty:1;
-	unsigned has_changes:1;
-	unsigned quick:1;
-	unsigned no_index:1;
-	unsigned allow_external:1;
-	unsigned exit_with_status:1;
-	unsigned reverse_diff:1;
-	unsigned check_failed:1;
-	unsigned relative_name:1;
-	unsigned ignore_submodules:1;
-	unsigned dirstat_cumulative:1;
-	unsigned dirstat_by_file:1;
-	unsigned allow_textconv:1;
-	unsigned textconv_set_via_cmdline:1;
-	unsigned diff_from_contents:1;
-	unsigned dirty_submodules:1;
-	unsigned ignore_untracked_in_submodules:1;
-	unsigned ignore_dirty_submodules:1;
-	unsigned override_submodule_config:1;
-	unsigned dirstat_by_line:1;
-	unsigned funccontext:1;
-	unsigned default_follow_renames:1;
-	unsigned stat_with_summary:1;
-	unsigned suppress_diff_headers:1;
-	unsigned dual_color_diffed_diffs:1;
+	unsigned recursive;
+	unsigned tree_in_recursive;
+	unsigned binary;
+	unsigned text;
+	unsigned full_index;
+	unsigned silent_on_remove;
+	unsigned find_copies_harder;
+	unsigned follow_renames;
+	unsigned rename_empty;
+	unsigned has_changes;
+	unsigned quick;
+	unsigned no_index;
+	unsigned allow_external;
+	unsigned exit_with_status;
+	unsigned reverse_diff;
+	unsigned check_failed;
+	unsigned relative_name;
+	unsigned ignore_submodules;
+	unsigned dirstat_cumulative;
+	unsigned dirstat_by_file;
+	unsigned allow_textconv;
+	unsigned textconv_set_via_cmdline;
+	unsigned diff_from_contents;
+	unsigned dirty_submodules;
+	unsigned ignore_untracked_in_submodules;
+	unsigned ignore_dirty_submodules;
+	unsigned override_submodule_config;
+	unsigned dirstat_by_line;
+	unsigned funccontext;
+	unsigned default_follow_renames;
+	unsigned stat_with_summary;
+	unsigned suppress_diff_headers;
+	unsigned dual_color_diffed_diffs;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
-- 
2.20.0.482.g66447595a7

