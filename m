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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC904C43461
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD236140A
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEIRNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhEIRNg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 13:13:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A98C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 10:12:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i190so11950018pfc.12
        for <git@vger.kernel.org>; Sun, 09 May 2021 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OD5x47wzfa369B76+0GFXgQg2DoKl8DjcZ/KoBNdB1w=;
        b=cY1r40EN3ip5ZYkRnRAWHc3VZxd06VZ4fzcH12tdgzmFjcqYr1hmJ7M6dt7doeiO4q
         PjRxbhKIVvbSPVLuEFEMKnkFukT8UiBu2ZayJ5tKxhun6Jm0LsaNXGUbZW1SXdpf78GV
         0QrVuuYJd2waodWWAPMxrXcCPOFkf3eXUh3MaIQHuwf8Tychu1OYwIxDd3SU8yxrX0MU
         kQlWe+nUUKXLfCik31R62Gqu4zYRg9Kq52vi/4PmvVnumu49QkxShiCpAsrUlbe4J0t4
         nLzbwe2PLCBGjq50QjpWIK6N3NsVAmQuLwwHri1gaI8zuTyyGN3bBEpavuVtHeS+4x1c
         3Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OD5x47wzfa369B76+0GFXgQg2DoKl8DjcZ/KoBNdB1w=;
        b=ui0/VzmrbIQ1h/67MCJBHgib68KgaLy+PeB12qGMWcQfVqS/GXLP1fsW/wDpUdGVyl
         MD+glxJ7Tdv9ESFnz5Xxc4mLzMq5LwL6O8gSex6q5BwE+gIrBLpj8dX0YuxLxNt27Cqa
         /RlXZc7T3QCNeZSi3EaPPHUuB1E6CyHOayDjbgfOhCwpG1OnPXqVyntQgjGEZLSBj0Qy
         1TvIm6WU1cvvg72hbHwXSUxu5E/6u8v79Pfr10WHrftE1YIFbIVjjDd+b/SF6oOQ919e
         U1y8wMBLU96Q3/N/USm1x+2FtbztPkAmtzGtPa55OyZGymjWoOTnGQXk5LHIkV9MJT1d
         nZ5Q==
X-Gm-Message-State: AOAM533JtAjwjlwM44curEc4UWPWswFihtkfzQM81Y9OQw6cGsOzDtM3
        U5aCuuXSEYdUwOL4ItYIGiQvVQnDU+M4uQ==
X-Google-Smtp-Source: ABdhPJw5rBTsCDy13syhtF2rhhr8u32nqfFJ8Ar8dK8Y8TUQv7QFBA4kOtL9DTLBOQEKj1wcYio8dA==
X-Received: by 2002:a05:6a00:be5:b029:28e:d71b:5b5f with SMTP id x37-20020a056a000be5b029028ed71b5b5fmr20910721pfu.34.1620580352212;
        Sun, 09 May 2021 10:12:32 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id l126sm9249374pga.41.2021.05.09.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:12:31 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 5/6] mailinfo: allow stripping quoted CR without warning
Date:   Mon, 10 May 2021 00:12:12 +0700
Message-Id: <448daac5b3d58f948184d63046ab4aa02be9b036.1620580178.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620580178.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620580178.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous changes, we've turned on warning for quoted CR in base64 or
quoted-printable email messages. Some projects see those quoted CR a lot,
they know that it happens most of the time, and they find it's desirable
to always strip those CR.

Those projects in question usually fall back to use other tools to handle
patches when receive such patches.

Let's help those projects handle those patches by stripping those
excessive CR.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-mailinfo.txt | 1 +
 mailinfo.c                     | 7 +++++++
 mailinfo.h                     | 1 +
 t/t5100-mailinfo.sh            | 6 ++++++
 4 files changed, 15 insertions(+)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 824947a070..3fcfd965fd 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -102,6 +102,7 @@ The valid actions are:
 *	`nowarn`: Git will do nothing when such a CRLF is found.
 *	`warn`: Git will issue a warning for each message if such a CRLF is
 	found.
+*	`strip`: Git will convert those CRLF to LF.
 --
 +
 The default action could be set by configuration option `mailinfo.quotedCR`.
diff --git a/mailinfo.c b/mailinfo.c
index a784552c7b..ed863c3a95 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -998,6 +998,11 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 		    line->buf[len - 2] == '\r' &&
 		    line->buf[len - 1] == '\n') {
 			mi->have_quoted_cr = 1;
+			if (mi->quoted_cr == quoted_cr_strip) {
+				strbuf_setlen(line, len - 2);
+				strbuf_addch(line, '\n');
+				len--;
+			}
 		}
 		handle_filter(mi, line);
 		return;
@@ -1227,6 +1232,8 @@ int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
 		*action = quoted_cr_nowarn;
 	else if (!strcmp(actionstr, "warn"))
 		*action = quoted_cr_warn;
+	else if (!strcmp(actionstr, "strip"))
+		*action = quoted_cr_strip;
 	else
 		return -1;
 	return 0;
diff --git a/mailinfo.h b/mailinfo.h
index 768d06ac2a..2ddf8be90f 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -8,6 +8,7 @@
 enum quoted_cr_action {
 	quoted_cr_nowarn,
 	quoted_cr_warn,
+	quoted_cr_strip,
 };
 
 struct mailinfo {
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 1ecefa381d..141b29f031 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -259,6 +259,12 @@ test_expect_success 'mailinfo warn CR in base64 encoded email' '
 	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=nowarn &&
 	test_must_be_empty quoted-cr/0001.err &&
 	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=nowarn &&
+	test_must_be_empty quoted-cr/0002.err &&
+	cp quoted-cr/0001-expected.msg quoted-cr/0002-expected.msg &&
+	cp quoted-cr/0001-expected.patch quoted-cr/0002-expected.patch &&
+	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=strip &&
+	test_must_be_empty quoted-cr/0001.err &&
+	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=strip &&
 	test_must_be_empty quoted-cr/0002.err
 '
 
-- 
2.31.1.448.g9c2f8508d1

