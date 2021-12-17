Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461D8C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhLQNae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhLQNab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2B7C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q16so4062004wrg.7
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YcsuS7NVRIZMLKijujb7NUE+39Rb8p2SuUW9RECoMA=;
        b=RhqfHHVZYzMwuUA4okW6rCq6tpsGPW0AMGZzm2/Jpgkj7eiSIiMMvEz53n4om6VHTv
         PZlPCmUUESVNBVCu4UQADSQf+uSmNPuRXCTM8V42+VuPP1Hfl/dMU8ahrrHmeTRLRINB
         JGeHceKVVPANk4RxedBBJK7DT+RVRTXXlmjDE+t+aPU2RYLScISgDUzUu9A0JrgeQAjA
         T8yIp4AqmMfUAHsuEiebF07XTkJdFx4G2jswDgXbdCVEQ9SeUumZ/X3K/gdXZPqWbCa1
         zXtTMBpEO5s1kA8ZIBhJIrPFUcrha+B2celWCUbFbqjlHk6g3iIAJE2dng4vJqFAF6Dm
         Ss8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YcsuS7NVRIZMLKijujb7NUE+39Rb8p2SuUW9RECoMA=;
        b=ImtjJgNYeaF2hwcz43r5/VaRflLgFwYSu1BfNI3LAewkzOyliAPg8cTTio96sFyrLJ
         qlMCkd/h4YllBFPuV8EVeomEeibBg/yCQcLw68X27KSKEx88X6zuE1H4HYvHxE7zbydY
         7ljC6yu964Mh09pp57YPGrBIaFuzZiOtvkzVeOUcihY9IWvt4TALaLy5aQVwXPeyYhjS
         /iRZfSmMmA085PHjyee2C1gLb1HNsjpMCYP4mFmJjqQMB5KAz0WMQIRcsOeyCBMUuUyQ
         DjJXE5ZzPdzTH/gF/9StrI63xdboQH3EshzmOHIK0mr/9owix985kZqJsVgeCj9eEvBv
         b4VQ==
X-Gm-Message-State: AOAM531ub9zWA6Ty7Vg+h7KguKRrVUaxkUkyEBL58Ir/5hLjbvVZwO6Y
        5yjYYv7FUbW3GR05SHopxjw7UXUQdLG2Fg==
X-Google-Smtp-Source: ABdhPJzTJfcnoKR/ZqADrNhJ3s1+GA7CafQzTHzzX9mv3yUAwyB7N9d79PxUB+hS2mwtA6Veo+ZEiw==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr2608934wrs.25.1639747828972;
        Fri, 17 Dec 2021 05:30:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/7] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Fri, 17 Dec 2021 14:30:19 +0100
Message-Id: <RFC-patch-3.7-6219756cdd0-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ls-tree.c code to use type_name() on the enum instead of
using the string constants. This doesn't matter either way for
performance, but makes this a bit easier to read as we'll no longer
need a strcmp() here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0a28f32ccb9..3f0225b097f 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,17 +66,17 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int retval = 0;
 	int baselen;
-	const char *type = blob_type;
+	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-		type = commit_type;
+		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
 			retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
 		}
-		type = tree_type;
+		type = OBJ_TREE;
 	}
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
@@ -84,7 +84,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (type == OBJ_BLOB) {
 				unsigned long size;
 				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
@@ -95,11 +95,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
 			}
-			printf("%06o %s %s %7s\t", mode, type,
+			printf("%06o %s %s %7s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
 		} else {
-			printf("%06o %s %s\t", mode, type,
+			printf("%06o %s %s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev));
 		}
 	}
-- 
2.34.1.1119.g7a3fc8778ee

