Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F61C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D86136F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJTN1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhJTN05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD1C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso10234844wms.4
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUyDmkY2NIWpWT1V9EbM24O3P3os68Hb+UNSNCHOBXo=;
        b=bP69nHBiLyn7Bs4D/FkfJBsY9cEQtnkz0biSsMc3PTJDKWs13iSlJHh/TYSxxsTTLv
         lO6xZhxyC8KGVxaXnmxg7hmTjujtriM58+M1pFF4maKIGb28BfmY6aHHW+831LefQI8z
         AYd2ZjVxABzjVY8N3+rdScJlOoOtnG32e1qB5dB2ULR1m1VcpDdPMM8vdoSqCLbGBlFk
         xHdkL7z3pP5cYr89bseFpfv0LIT90Y1IMMgFjvy7/QRlY9bAV/B15AeWNX25NjX3FZrV
         S7ZWSagSsEM3uA4GVOt4TScbltaLq+WvOOWtoKSoFx9yGqcTCXox+ycHsL5/Ftgcq2Se
         H6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUyDmkY2NIWpWT1V9EbM24O3P3os68Hb+UNSNCHOBXo=;
        b=4raCYlaif84DX+zX1wgzMnZjJbvl7lnHGzCzTG4bdmzBbHrp3knpyTJKARhwfM5870
         Zr7GgnHFrCMXH3Ms1tSVvGau8Sqm7ChC3kIHODAUt18cdkeVT2GwFVvj8jX1N/DDYJlx
         WPX67ZMpBuMUaaobMvZ7ifvV27WV5+uS3ij8xm4Z2u2d3We+2EQpfFhBcBxI/QGwNN8x
         LtF63M8XKs9BKcT/i3D7am4r1a5Q87nvRmQUypwe6rVyUxoJIzapSYpZc8jOftFJDwNZ
         30VqmaGMhSysL7onvkpJmsGlkc/xxVPy3T8cWfs5Nyn+itTrH06a5xKeM1T0dgIkm0ir
         nosA==
X-Gm-Message-State: AOAM5317WTVQBhqRpfF1dYnfKLqFa1Q64c1dreSh7CZW43GiShYZAAuv
        76TcFlhQBHw76WS4Wg8gYtLJAZIHdwEf4Q==
X-Google-Smtp-Source: ABdhPJxKlek0zYuRBON8AClgyabN54V/ZUI0NQVPrb+fvE5xW6NcMwx19K3J/KBzWDxqslo37OXMgA==
X-Received: by 2002:a1c:4d15:: with SMTP id o21mr13772960wmh.167.1634736280687;
        Wed, 20 Oct 2021 06:24:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm5933351wmj.0.2021.10.20.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 1/4] tag: use a "goto cleanup" pattern, leak less memory
Date:   Wed, 20 Oct 2021 15:24:33 +0200
Message-Id: <RFC-patch-v2-1.4-fc776c3f1cd-20211020T131627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com> <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change cmd_tag() to free its "struct string_list"'s instead of using
an UNLEAK() pattern. This changes code added in 886e1084d78 (builtin/:
add UNLEAKs, 2017-10-01).

As shown in the context of the deceleration of the "struct
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

