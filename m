Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5F6C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbhKYW5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhKYWzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:55:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C8C061746
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so5617135wms.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvQflBWFBqNZAJoD0HXbPiWOLNkmUz45gIFX8uTeCFo=;
        b=TXBiwo5o8I7e+Q1vR0Ycrjg8nuCrTDi6btulp8XyO4U2I8Bz7s1D/cOwJcBzhoON6P
         3kdLFRenILc2kJG8KTHoILC5sEu3ccc0e9e6brKjZsLSdlf0rBFyfUeIzh672EzKR+7+
         N4qcPr5loeHHmsQQ7DGhsYsp5q2mLup9AO8aNVZhYH3tOQoo4gRCW+qu/tJfo0AMAm6j
         bt7jKGEAQ6erX5tgbLIy5YL8bcM3qnSxT0+wR82Ba3MmKw0U1tgiXdyiB2VmxD87758Z
         vVJd0Vw6CWpQR3CzP269StVa+V/fRYm4lC2wh9W28ljvR6wdxgVQyTEpisSEZ3WhOMAT
         0fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvQflBWFBqNZAJoD0HXbPiWOLNkmUz45gIFX8uTeCFo=;
        b=ViyXsSc/SKJ4XDJi8TDlcZrCZmvodWqgKLzMaX2cCAEHb49k+r5Qbyvi29RNAlw0Jv
         ecsRjmWSq/iPlWM2xKK4WCnQVLxxlIVnoEdAJeiUY4eYAUsRkSZUWjw2baB7FKXXxpid
         3BhqCVCHWS2WrNsQIvI2hMrqVndOdunNrrhy2o0rkik9F19FU4LFZv+86jaQiL3E1Eeh
         rdb6Tx3gNcDJxEIJBwVVjz3svQU5JcV/ftANLeDj9i7s4VhHH4IS0z07+ETNHe7cRUxu
         XGs7OrMAf6pG1SPGh5AtWR+yuc2e4Sw5gEJYMQs5SHTZ878u5VCkfJkhE888yNHtG4DN
         q9Og==
X-Gm-Message-State: AOAM5305l7ekMuTu4zIZcpabwQO0zTf71vEkhi8RZXXUq+3XDd8BGgNO
        V5fnGPtFHEBBN2rEIjo0T6NdLLDrGBY+Pw==
X-Google-Smtp-Source: ABdhPJzP3sQDOvFRsDNyylmQbYkwA+gioQ9Jc9avgf7Th7RtAZEdS+VPi2cI7p0P4D/Xeb872TODVA==
X-Received: by 2002:a1c:7f43:: with SMTP id a64mr11616707wmd.133.1637880749613;
        Thu, 25 Nov 2021 14:52:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] upload-archive: use regular "struct child_process" pattern
Date:   Thu, 25 Nov 2021 23:52:17 +0100
Message-Id: <patch-v3-2.9-d3a418b3809-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This pattern added [1] in seems to have been intentional, but since
[2] and [3] we've wanted do initialization of what's now the "struct
strvec" "args" and "env_array" members. Let's not trample on that
initialization here.

1. 1bc01efed17 (upload-archive: use start_command instead of fork,
   2011-11-19)
2. c460c0ecdca (run-command: store an optional argv_array, 2014-05-15)
3. 9a583dc39e (run-command: add env_array, an optional argv_array for
   env, 2014-10-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/upload-archive.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 24654b4c9bf..98d028dae67 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -77,7 +77,7 @@ static ssize_t process_input(int child_fd, int band)
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	struct child_process writer = { argv };
+	struct child_process writer = CHILD_PROCESS_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
@@ -89,9 +89,10 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	 * multiplexed out to our fd#1.  If the child dies, we tell the other
 	 * end over channel #3.
 	 */
-	argv[0] = "upload-archive--writer";
 	writer.out = writer.err = -1;
 	writer.git_cmd = 1;
+	strvec_push(&writer.args, "upload-archive--writer");
+	strvec_pushv(&writer.args, argv + 1);
 	if (start_command(&writer)) {
 		int err = errno;
 		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
-- 
2.34.1.838.g779e9098efb

