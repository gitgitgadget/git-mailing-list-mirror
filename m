Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC86C43460
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62145613C6
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhEDRVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhEDRVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:21:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9444C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:20:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m12so7839336pgr.9
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U6yob82ZacqZ5I9wFnc9LzrJLAklat0vI4YNZ7LcIB4=;
        b=PCtPRc+AHRGFFFnpvERUlTmZPqX6PaWxhB7Yp9sScsI1NQy1YThoLY4opucd2I5RfT
         dy34GH9QCPreZCOlrOuzJVTo/45KRYkEZjdDx9aex66m8Mi3V1IIoZQoZMLWcXU3B+/q
         Im8Vo3X+OKiVXf3a8M25/mxcb7Tqfn3b9vdvYFpTntViQl2iMx7MhoV1xaBmFtquwXqd
         vw9H8pGhwk0xrOY+EgbqvTa2lISxzrsP54uDzmYPG5ePHG8xSNDCZgyIOdpZDm1ABfyL
         wpB0UX7DhJt3ApZ8kg9Y0tctmfvjXyz+rT/SDzVRuMgZcZ0/SMPbsqAItX7PuX297mFE
         L4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6yob82ZacqZ5I9wFnc9LzrJLAklat0vI4YNZ7LcIB4=;
        b=jXvsrdrIbyZoHSjBTjQNz9/Bxc0Ex4FcTNHs/Vmls9UNv+RHrU3tMhIvnX/m7HmCFw
         4QHVJD9LFqoEDola3k9rTlJ0LfouneD+tE7/2NSCxyQil50+PE5fZw7F3aPFepFCOpPz
         7/rCRyEFOjJZ31FTTga3rtySwYNtHa4u9FLnegKRzHpiV9jAACpISGM855C5RuOFXLVc
         MimXwnvR6GfBSyzOPaQhd9RGmaTCOjCQpSQQwGE7QCIHbxWme/bG9RQqTM8xRFCcwDyP
         nokKJPZqJaEcgfJbkH9kp71r0twiiGn3sfRDsVFumzRwD//hpXag0y9mnVfEiUW+XvGE
         TfeA==
X-Gm-Message-State: AOAM531CeKxVXC3XpMgoaRh++D6ahJuJGYAzCuGeoqoxR7sInSfQrHw+
        X1YKwKZ+JpP2hTqeiGSk8KYMfedyKAytlQ==
X-Google-Smtp-Source: ABdhPJx8zHSU4dBCk9PL0+eQShanUvGH0XmIJUzWQNr/BQQ5qGT584XaV2qcOgkuModn8HfFjAEKTw==
X-Received: by 2002:aa7:900c:0:b029:27d:7e15:11b2 with SMTP id m12-20020aa7900c0000b029027d7e1511b2mr23710750pfo.45.1620148820214;
        Tue, 04 May 2021 10:20:20 -0700 (PDT)
Received: from athena.localdomain ([27.75.102.31])
        by smtp.gmail.com with ESMTPSA id a18sm4019267pgg.51.2021.05.04.10.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:20:19 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 4/5] mailinfo: strip quoted CR on users' wish
Date:   Wed,  5 May 2021 00:20:01 +0700
Message-Id: <01d4a4853b8a0b6911a2d7773f836620566b4293.1620148732.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.500.gbc6bbdd36b
In-Reply-To: <cover.1620148732.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620148732.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous changes, we've turned on warning for quoted CR in base64 or
quoted-printable email messages. Some projects sees those quoted CR a lot
and they know that it happens most of the time.

Those projects in question usually fall back to use other tools to handle
patches when receiving such patches.

Let's help those projects handle those patches by stripping those
excessive CR-s.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-mailinfo.txt | 1 +
 mailinfo.c                     | 7 +++++++
 mailinfo.h                     | 1 +
 t/t5100-mailinfo.sh            | 4 ++++
 4 files changed, 13 insertions(+)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index c776b27515..d700929a46 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -100,6 +100,7 @@ The valid actions are:
 *	`nowarn`: Git will do nothing with this action.
 *	`warn`: Git will issue a warning for each message if such CR-LF is
 	found.
+*	`strip`: Git will convert those CR-LF to LF.
 --
 +
 The default action could be set by configuration option `mailinfo.quotedCR`.
diff --git a/mailinfo.c b/mailinfo.c
index fe7ffd01d0..68f4eba72a 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -998,6 +998,11 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 		    line->buf[len - 2] == '\r' &&
 		    line->buf[len - 1] == '\n') {
 			*have_quoted_cr = 1;
+			if (mi->quoted_cr == quoted_cr_strip) {
+				strbuf_setlen(line, len - 2);
+				strbuf_addch(line, '\n');
+				len--;
+			}
 		}
 		handle_filter(mi, line);
 		return;
@@ -1228,6 +1233,8 @@ enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *action)
 		return quoted_cr_nowarn;
 	else if (!strcmp(action, "warn"))
 		return quoted_cr_warn;
+	else if (!strcmp(action, "strip"))
+		return quoted_cr_strip;
 	return quoted_cr_invalid_action;
 }
 
diff --git a/mailinfo.h b/mailinfo.h
index 1bcef5a6f3..e0e094c311 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -8,6 +8,7 @@
 enum quoted_cr_action {
 	quoted_cr_nowarn,
 	quoted_cr_warn,
+	quoted_cr_strip,
 	quoted_cr_invalid_action
 };
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 57b8fc8104..7559c922c6 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -242,6 +242,10 @@ test_expect_success 'mailinfo handle CR in base64 encoded email' '
 	check_quoted_cr_mail &&
 	grep "quoted CR detected" quoted-cr-err &&
 	check_quoted_cr_mail --quoted-cr=nowarn &&
+	test_must_be_empty quoted-cr-err &&
+	sed "s/%%//" "$DATA/quoted-cr-msg" >expect-cr-msg &&
+	sed "s/%%//" "$DATA/quoted-cr-patch" >expect-cr-patch &&
+	check_quoted_cr_mail --quoted-cr=strip &&
 	test_must_be_empty quoted-cr-err
 '
 
-- 
2.31.1.500.gbc6bbdd36b

