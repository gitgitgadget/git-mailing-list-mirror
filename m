Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37CC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C9960FF2
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhJTS3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhJTS3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:29:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1715C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i12so47778wrb.7
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNbYrr8CmPMd96TaIzIjXGWpXvlhU+deDilQmXDMAiU=;
        b=pAw8wZh37dzIiuiLRVypGheaHyKjXe4FiPSX/qn4/yAG9uzIn2NSMtxp9rlVGC9m4w
         zPCWIWMRqn5imouqBNreCiq+R0zn92TDAtKiQ8epPcGhI87XjQgx4x/hzBH0r0WMaK3F
         4pS1lp0b+/l9OjItC4tVZKJDKi4RlD+t86awznUO0OqKG4kXy0PAlQOxCjGSohcubwHa
         qOzfb6gR4RKv9wlKb07ZssiUudq9younfEcrEy/htiUZ7kBJ8wcRntGXmwUOfzuEcLtD
         f8wzHL4JTKFB1iWxZTFkObtxKalj1CtxY5Y0izPo1YaXMWCUnTwykUVrH/yF9Ikk8nS+
         Me6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNbYrr8CmPMd96TaIzIjXGWpXvlhU+deDilQmXDMAiU=;
        b=sPwJEGG94RKhP3NgFP5y9Vb1rvT1FKYKxoF8OJc+spSYRXGzdpE8MhmD9SIZjkdePg
         ibxQwObvh49s8t8Gf6jS7/R2ybYzlZOUQomG+HksQSILrblx3Rp6KLP4SfRUOemraQqN
         xr8/C8g7xaLqYdoX9agp5DBn+UubF76CFuBGub9QKm24DmOiAnt2cqhLUYTTzwld5CMf
         O4B1t3HfQBjCr0j5FCWSwmgZZDV3rJ2UjCjk5AEQgsFUFILT6AkthQP5ne8AqOxX8ITs
         xRcOEf+rbTyAiHpXs+bQyFD2Or0MpVWNr9ZNQjZNas05nkX+DvcSjvAtj7ogDF47dvLZ
         0LcA==
X-Gm-Message-State: AOAM533FXdgaNOkYtHd2L7x3W2HpSbUq/DVhN+P51hONytCFPnoqIuNp
        gKS1MogJ+8WfG7LRiiql+CSpkyuTgfrLcg==
X-Google-Smtp-Source: ABdhPJwPLu4NeqazdpPlab9PlNdtyaiYAHzD7TbsfAd49Po4/ckeQ3ijWDyBIhPidxc3aLvdWFCwbw==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr1049150wra.432.1634754448108;
        Wed, 20 Oct 2021 11:27:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm3091093wmq.41.2021.10.20.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:27:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] tag: use a "goto cleanup" pattern, leak less memory
Date:   Wed, 20 Oct 2021 20:27:19 +0200
Message-Id: <patch-1.3-8ccd07abf86-20211020T182516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
References: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com> <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change cmd_tag() to free its "struct strbuf"'s instead of using an
UNLEAK() pattern. This changes code added in 886e1084d78 (builtin/:
add UNLEAKs, 2017-10-01).

As shown in the context of the declaration of the "struct
msg_arg" (which I'm changing to use a designated initializer while at
it, and to show the context in this change), that struct is just a
thin wrapper around an int and "struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/tag.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 6535ed27ee9..ad6c9855914 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -432,7 +432,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	int annotate = 0, force = 0;
 	int cmdmode = 0, create_tag_object = 0;
 	const char *msgfile = NULL, *keyid = NULL;
-	struct msg_arg msg = { 0, STRBUF_INIT };
+	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
@@ -482,6 +482,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END()
 	};
+	int ret = 0;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -529,7 +530,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
-		int ret;
 		if (column_active(colopts)) {
 			struct column_options copts;
 			memset(&copts, 0, sizeof(copts));
@@ -540,7 +540,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		ret = list_tags(&filter, sorting, &format);
 		if (column_active(colopts))
 			stop_column_filter();
-		return ret;
+		goto cleanup;
 	}
 	if (filter.lines != -1)
 		die(_("-n option is only allowed in list mode"));
@@ -552,12 +552,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--points-at option is only allowed in list mode"));
 	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
-	if (cmdmode == 'd')
-		return delete_tags(argv);
+	if (cmdmode == 'd') {
+		ret = delete_tags(argv);
+		goto cleanup;
+	}
 	if (cmdmode == 'v') {
 		if (format.format && verify_ref_format(&format))
 			usage_with_options(git_tag_usage, options);
-		return for_each_tag_name(argv, verify_tag, &format);
+		ret = for_each_tag_name(argv, verify_tag, &format);
+		goto cleanup;
 	}
 
 	if (msg.given || msgfile) {
@@ -626,10 +629,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		printf(_("Updated tag '%s' (was %s)\n"), tag,
 		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
 
-	UNLEAK(buf);
-	UNLEAK(ref);
-	UNLEAK(reflog_msg);
-	UNLEAK(msg);
-	UNLEAK(err);
-	return 0;
+cleanup:
+	strbuf_release(&buf);
+	strbuf_release(&ref);
+	strbuf_release(&reflog_msg);
+	strbuf_release(&msg.buf);
+	strbuf_release(&err);
+	return ret;
 }
-- 
2.33.1.1338.g20da966911a

