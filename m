Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA9C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 01:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65CB61409
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 01:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhDUBet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhDUBes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 21:34:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E9C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 18:34:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so27123650pfn.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzka1k0n28NxEpq2VOqIE+UHmdA9LPSTjA4wypi2C+4=;
        b=tbRF+nEU0Z/Y0TwHIFb+/FqQznvmNxelq+9GX/6qOjRn5pqjgGS+ACif9AWhfk7G34
         EurU52YuYKMpzzL0ylQDmt9aktBx35BKWbFdlaucNP4mnOQY493qYHR7Eqn/82Ien5/x
         AQ7Bw1CIb5J9SFtbT26ydSQPpyc6ul76uCUcIWQRiJARYyNB98nz7egVExeid41kUaOb
         kX5wOGZ9UsJiMqLGb3UAMmMpMQeORhiJneeRgKBoCRZE0fk/I5k9UPDQVEE5l4EswSR8
         IRMxxeblRybTQbVCF1W/BR9f36iitO1NKEBqqYUJeNeb8PQXX/f0CKpqzqr75IlgMSbG
         iDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzka1k0n28NxEpq2VOqIE+UHmdA9LPSTjA4wypi2C+4=;
        b=Jyqh5QstBFDse6DoJxl4i6pvZW/LUeDXtXUnDFVpptZ5IhUaKjgGKJu2YDDhFb++Dp
         eH0PbQ3KdhjrfEfH5Sn8n7Nhm+uWZH4vyyaJMpI9Oc8hxVG01tRlfYtC17xMoBj5Qr77
         Yu1ayM30BCrDO2QmJYR369ExMpliK4TIe1HLfPuUw7HlaEwpHiOvnezsL5yvFLr0sW4+
         ZHitiHW8LHNZTQRUgm41ayPgqZWh+fcsCAy8klZB+gxgSpbZ7dheN4ChMwV+oCUJRPRM
         yaBMwudaQLk2ZbZIpUePgJQ1WdOs8O9KBDJaOjrQaAiMpuC5dQMAkckd04ruKnHa+bVY
         V7Bg==
X-Gm-Message-State: AOAM531ASUwQyZtLDPTJy7z1l3xW2aEhxZWnhQ0yfTU4sDnVxl6m39Q2
        BVaPnWx2TOOreysOVPvC2hkgeyWefO4=
X-Google-Smtp-Source: ABdhPJyqM3wf/Nela2RdjzBUBb+0l7gF1r24fPYUr5vF2Zpk4Edk0pUlUULZco0jtc5N4/YtJLT2Gw==
X-Received: by 2002:a17:90a:e28b:: with SMTP id d11mr8233588pjz.53.1618968855781;
        Tue, 20 Apr 2021 18:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id x18sm296297pjn.51.2021.04.20.18.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 18:34:15 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] mailinfo: strip CR from base64/quoted-printable email
Date:   Wed, 21 Apr 2021 08:34:04 +0700
Message-Id: <20210421013404.17383-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.192.g0881477623
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an SMTP server receives an 8-bit email message, possibly with only
LF as line ending, some of those servers decide to change said LF to
CRLF.

Some other SMTP servers, when receives an 8-bit email message, decide to
encoding such message in base64 and/or quoted-printable instead.

If an email is transfered through those 2 email servers in order, the
final recipients will receive an email contains a patch mungled with
CRLF encoded inside another encoding. Thus, such CR couldn't be dropped
by mailsplit. Such accidents have been observed in the wild [1].

Let's guess if such CR was added automatically and strip them in
mailinfo.

[1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 I'm not sure if guessing the heuristic to strip CR is a good approach.
 I think it's better to pass --keep-cr down from git-am.
 Let's say --keep-cr=<yes|no|auto>

 mailinfo.c             | 20 +++++++++++++++++---
 t/t5100-mailinfo.sh    |  5 +++++
 t/t5100/cr-base64.mbox | 22 ++++++++++++++++++++++
 t/t5100/info1000       |  5 +++++
 t/t5100/msg1000        |  2 ++
 t/t5100/patch1000      | 22 ++++++++++++++++++++++
 6 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100644 t/t5100/cr-base64.mbox
 create mode 100644 t/t5100/info1000
 create mode 100644 t/t5100/msg1000
 create mode 100644 t/t5100/patch1000

diff --git a/mailinfo.c b/mailinfo.c
index 5681d9130d..dbff867f42 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -988,16 +988,27 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 }
 
 static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
-				 struct strbuf *prev)
+				 struct strbuf *prev, int *keep_cr)
 {
 	size_t len = line->len;
 	const char *rest;
 
 	if (!mi->format_flowed) {
+		if (*keep_cr == -1 && len >= 2)
+			*keep_cr = !(line->buf[len - 2] == '\r' &&
+				     line->buf[len - 1] == '\n');
+		if (!*keep_cr && len >= 2 &&
+		    line->buf[len - 2] == '\r' &&
+		    line->buf[len - 1] == '\n') {
+			strbuf_setlen(line, len - 2);
+			strbuf_addch(line, '\n');
+			len--;
+		}
 		handle_filter(mi, line);
 		return;
 	}
 
+	*keep_cr = 1;
 	if (line->buf[len - 1] == '\n') {
 		len--;
 		if (len && line->buf[len - 1] == '\r')
@@ -1036,6 +1047,7 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 static void handle_body(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
+	int keep_cr = -1;
 
 	/* Skip up to the first boundary */
 	if (*(mi->content_top)) {
@@ -1081,7 +1093,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 						strbuf_addbuf(&prev, sb);
 						break;
 					}
-				handle_filter_flowed(mi, sb, &prev);
+				handle_filter_flowed(mi, sb, &prev, &keep_cr);
 			}
 			/*
 			 * The partial chunk is saved in "prev" and will be
@@ -1091,7 +1103,9 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			break;
 		}
 		default:
-			handle_filter_flowed(mi, line, &prev);
+			/* CR in plain message was processed in mailsplit */
+			keep_cr = 1;
+			handle_filter_flowed(mi, line, &prev, &keep_cr);
 		}
 
 		if (mi->input_error)
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 147e616533..9ccc11d16a 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -228,4 +228,9 @@ test_expect_success 'mailinfo handles unusual header whitespace' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mailinfo strip CR after decode base64' '
+	cp $DATA/cr-base64.mbox 1000 &&
+	check_mailinfo 1000 ""
+'
+
 test_done
diff --git a/t/t5100/cr-base64.mbox b/t/t5100/cr-base64.mbox
new file mode 100644
index 0000000000..6ea9806a6b
--- /dev/null
+++ b/t/t5100/cr-base64.mbox
@@ -0,0 +1,22 @@
+From: A U Thor <mail@example.com>
+To: list@example.org
+Subject: [PATCH v2] sample
+Date: Mon,  3 Aug 2020 22:40:55 +0700
+Message-Id: <msg-id@example.com>
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: base64
+
+T24gZGlmZmVyZW50IGRpc3RybywgcHl0ZXN0IGlzIHN1ZmZpeGVkIHdpdGggZGlmZmVyZW50IHBh
+dHRlcm5zLg0KDQotLS0NCiBjb25maWd1cmUgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
+ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9jb25m
+aWd1cmUNCmluZGV4IGRiMzUzOGIzLi5mN2MxYzA5NSAxMDA3NTUNCi0tLSBhL2NvbmZpZ3VyZQ0K
+KysrIGIvY29uZmlndXJlDQpAQCAtODE0LDcgKzgxNCw3IEBAIGlmIFsgJGhhdmVfcHl0aG9uMyAt
+ZXEgMSBdOyB0aGVuDQogICAgIHByaW50ZiAiQ2hlY2tpbmcgZm9yIHB5dGhvbjMgcHl0ZXN0ICg+
+PSAzLjApLi4uICINCiAgICAgY29uZj0kKG1rdGVtcCkNCiAgICAgcHJpbnRmICJbcHl0ZXN0XVxu
+bWludmVyc2lvbj0zLjBcbiIgPiAkY29uZg0KLSAgICBpZiBweXRlc3QtMyAtYyAkY29uZiAtLXZl
+cnNpb24gPi9kZXYvbnVsbCAyPiYxOyB0aGVuDQorICAgIGlmICIkcHl0aG9uIiAtbSBweXRlc3Qg
+LWMgJGNvbmYgLS12ZXJzaW9uID4vZGV2L251bGwgMj4mMTsgdGhlbg0KICAgICAgICAgcHJpbnRm
+ICJZZXMuXG4iDQogICAgICAgICBoYXZlX3B5dGhvbjNfcHl0ZXN0PTENCiAgICAgZWxzZQ0KLS0g
+DQoyLjI4LjANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
+CmV4YW1wbGUgbWFpbGluZyBsaXN0IC0tIGxpc3RAZXhhbXBsZS5vcmcKVG8gdW5zdWJzY3JpYmUg
+c2VuZCBhbiBlbWFpbCB0byBsaXN0LWxlYXZlQGV4YW1wbGUub3JnCg==
diff --git a/t/t5100/info1000 b/t/t5100/info1000
new file mode 100644
index 0000000000..dab2228b70
--- /dev/null
+++ b/t/t5100/info1000
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: mail@example.com
+Subject: sample
+Date: Mon, 3 Aug 2020 22:40:55 +0700
+
diff --git a/t/t5100/msg1000 b/t/t5100/msg1000
new file mode 100644
index 0000000000..5e8e860aae
--- /dev/null
+++ b/t/t5100/msg1000
@@ -0,0 +1,2 @@
+On different distro, pytest is suffixed with different patterns.
+
diff --git a/t/t5100/patch1000 b/t/t5100/patch1000
new file mode 100644
index 0000000000..51c4fb4cb5
--- /dev/null
+++ b/t/t5100/patch1000
@@ -0,0 +1,22 @@
+---
+ configure | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/configure b/configure
+index db3538b3..f7c1c095 100755
+--- a/configure
++++ b/configure
+@@ -814,7 +814,7 @@ if [ $have_python3 -eq 1 ]; then
+     printf "Checking for python3 pytest (>= 3.0)... "
+     conf=$(mktemp)
+     printf "[pytest]\nminversion=3.0\n" > $conf
+-    if pytest-3 -c $conf --version >/dev/null 2>&1; then
++    if "$python" -m pytest -c $conf --version >/dev/null 2>&1; then
+         printf "Yes.\n"
+         have_python3_pytest=1
+     else
+-- 
+2.28.0
+_______________________________________________
+example mailing list -- list@example.org
+To unsubscribe send an email to list-leave@example.org
-- 
2.31.1.192.g0881477623

