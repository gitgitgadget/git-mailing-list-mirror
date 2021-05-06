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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2AFC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C40613C7
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhEFPDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbhEFPDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A29C061761
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso3609482pjb.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV+70STJKt6SOYsN1RvyNwxoJVQzbE8euUx3eDzXmq8=;
        b=GlleocEF/8ZnO0aazMuu2do7n0rMOWFFb/WG+I63490gH8u0ZYc0kh9PRyRTgvnp4a
         ihx7doPLe6kVVnzPO/iH9nKE6HY9lLM6cjKeMwe7a6oFkRiFqxHPlZixNKxQ7favabNl
         oQBRlGNGgXQJ+dqTAOBKrZyP+uAqdLWMpYXZm2OOmHm+diQSUtupeFhimnXep8A0P8Zc
         VeYPqH6aCCamczg1xW9pLqOyR6Kxwm88G+s4H06cbSQrrkacJgtqwa9YVp5AdWdWtgB7
         9Z5IAXFcwuscvQqQNgBb1T6LQfwgs1wIfU34N4WFhnJNZAmn1kAUiZ5QHGerQ7v6bgut
         YXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV+70STJKt6SOYsN1RvyNwxoJVQzbE8euUx3eDzXmq8=;
        b=LfRvRuz+mEY7mFGS28jpv3u/IDBYu9Wu7bYwbDTeHEn0ZXWwldEHvFSQxQ2oSFKns4
         +wkGSYvpzNviV0IlJNzyHZJfkJjWfCuEEJUSegRG7Hw1xPdypdcT2O405+7rwoYY2Ool
         rAy6gdSadktFF8cNQS/11tgBZysl+VRM8jy8udeasTFQ6wKhZUNaMgUyC7jzI5BxiysH
         pHSsHrLeei1cEJc09wItuxP9CE8wbsrQRg/Df6N8KW6nrW4OauozjRAD4c1HGCp0Xt+E
         MqcUQ15uCiT11m+ZzyTvOHGQTj2FGg33BYczWW8rXZ8BNwbyoxdYAn1Nd/CsS2FNc3IQ
         EVKw==
X-Gm-Message-State: AOAM531myxcmyOXj23b5k8ct3hOvD8FqDnEYkzO2n/61x2p3pPWx7Zoh
        si1/eHjV0LxAE8lGBb+AGgPOYnDWQ8TCmw==
X-Google-Smtp-Source: ABdhPJys14X9hTsGUJyJqyeSPAPgO2z+MajsXCXeEl0BLlLFPF6HW84/eRUp3ct3291TxVRQxw45Yw==
X-Received: by 2002:a17:90b:1811:: with SMTP id lw17mr17974256pjb.154.1620313364720;
        Thu, 06 May 2021 08:02:44 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:44 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 5/6] mailinfo: allow stripping quoted CR without warning
Date:   Thu,  6 May 2021 22:02:23 +0700
Message-Id: <9e96d4bf5e06df57b13af1dec354ca5cf2ea58a1.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620311544.git.congdanhqx@gmail.com>
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
 t/t5100-mailinfo.sh            | 4 ++++
 4 files changed, 13 insertions(+)

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
index c57eed25a5..5cddcdc8ae 100644
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
index 51e8690fbd..06807f3852 100755
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
2.31.1.448.g9c2f8508d1

