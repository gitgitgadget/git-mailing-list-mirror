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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15730C43460
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE15861168
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhEFPDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhEFPDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA96C06138B
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b3so3527027plg.11
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NR22P6gyEs/hTUMqqMXXlxC57SP5gUx6uEcOMevDBj8=;
        b=U2U7uSnkE98qcOPpw38ZE4g/YMYTI7wnxOlm28BtDdHUf13eOOG8zZ4wfqWIyukvHH
         D8eLJYF/eSdlEYcf648mo317HULLSQxb+pj1K55xEPib+jmnLvVFuwtGPwFkbvXveNcu
         Nh/dLy3/deBHlqgpyiXfrCcevwKTqrb31Xb5t23RSGiULqTyeEi2Ir+BrnQDDOh4tGhq
         YjPCHPtDcsLf52pRMmKJ2Xss53V0F6G2oyHoaxjPugyy+088/zaKUqDfKTPxLfPFfRY+
         z/YuzN2KKaSWz6/wm4Rz+2HvRH3iU+EuE+usDnG7RImUdZb2bOIO5n5yQfXaFK550Y3b
         n7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NR22P6gyEs/hTUMqqMXXlxC57SP5gUx6uEcOMevDBj8=;
        b=PTHdmUmmwZDO0ngSUxaEge+v+0MISvTDfceL2zjDVJmNbUzomGL+ot4fT/l0ROKQnH
         jSy1Q5O9ZvyjKZAirTAeg0BS2HNEOHO4GJIHFC+6x1T9BPOklanP3oUTW8k4SZ9jqPiF
         6XGl2UP7a/5LG1k/uw5pjdZR25McHWCvUB2hJY/Z622KmfbCseq2KcST61IC2+OZFiH5
         zaUnHAHwYJjU5R1NF3gGL20mehYqgkpJtvWCsZOrRwZW4THhuMM+K2YA1fvBweBCWhcG
         JxLezuCRH6CI3v/IE2oe9IKpc1x6KQCFxY+Pw7qcMi6IEdx8b51gLGinTgBsxoe06O2Q
         6UHQ==
X-Gm-Message-State: AOAM530KSWomv3JLHr/Fxxb1qJpCGjrvgiC+0ROJRp4OZ0QDzkEdpNCJ
        3l0PuDJjPo/XlF8eklnpV/WviVmijTN1jg==
X-Google-Smtp-Source: ABdhPJwnGB8itY99yrbFrYTo/1+4lvGWNqY125Oh1oABpn6earTCc/qGpPGZ+X9fvufOWm80sPBwDg==
X-Received: by 2002:a17:902:b7c8:b029:ed:2577:8dc3 with SMTP id v8-20020a170902b7c8b02900ed25778dc3mr4779689plz.9.1620313361312;
        Thu, 06 May 2021 08:02:41 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:41 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 3/6] mailinfo: warn if CR found in decoded base64/QP email
Date:   Thu,  6 May 2021 22:02:21 +0700
Message-Id: <5aac2ba38e5442019d2816c63d7b65bf2bcf062a.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620311544.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When SMTP servers receive 8-bit email messages, possibly with only
LF as line ending, some of them decide to change said LF to CRLF.

Some mailing list softwares, when receive 8-bit email messages,
decide to encode those messages in base64 or quoted-printable.

If an email is transfered through above mail servers, then distributed
by such mailing list softwares, the recipients will receive an email
contains a patch mungled with CRLF encoded inside another encoding.

Thus, such CR couldn't be dropped by "mailsplit".
Hence, the mailed patch couldn't be applied cleanly.
Such accidents have been observed in the wild [1].

Instead of silently rejecting those messages, let's give our users
some warnings if such CR is found.

[1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c              | 14 ++++++++++++++
 mailinfo.h              |  1 +
 t/t5100-mailinfo.sh     | 15 +++++++++++++++
 t/t5100/quoted-cr-info  |  5 +++++
 t/t5100/quoted-cr-msg   |  2 ++
 t/t5100/quoted-cr-patch | 22 ++++++++++++++++++++++
 t/t5100/quoted-cr.mbox  | 22 ++++++++++++++++++++++
 7 files changed, 81 insertions(+)
 create mode 100644 t/t5100/quoted-cr-info
 create mode 100644 t/t5100/quoted-cr-msg
 create mode 100644 t/t5100/quoted-cr-patch
 create mode 100644 t/t5100/quoted-cr.mbox

diff --git a/mailinfo.c b/mailinfo.c
index 5681d9130d..dcf579700d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -994,6 +994,11 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 	const char *rest;
 
 	if (!mi->format_flowed) {
+		if (len >= 2 &&
+		    line->buf[len - 2] == '\r' &&
+		    line->buf[len - 1] == '\n') {
+			mi->have_quoted_cr = 1;
+		}
 		handle_filter(mi, line);
 		return;
 	}
@@ -1033,6 +1038,12 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 	handle_filter(mi, line);
 }
 
+static void summarize_quoted_cr(struct mailinfo *mi)
+{
+	if (mi->have_quoted_cr)
+		warning("quoted CR detected");
+}
+
 static void handle_body(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
@@ -1051,6 +1062,8 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 				handle_filter(mi, &prev);
 				strbuf_reset(&prev);
 			}
+			summarize_quoted_cr(mi);
+			mi->have_quoted_cr = 0;
 			if (!handle_boundary(mi, line))
 				goto handle_body_out;
 		}
@@ -1100,6 +1113,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 
 	if (prev.len)
 		handle_filter(mi, &prev);
+	summarize_quoted_cr(mi);
 
 	flush_inbody_header_accum(mi);
 
diff --git a/mailinfo.h b/mailinfo.h
index 79b1d6774e..b394ef9bce 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -24,6 +24,7 @@ struct mailinfo {
 	struct strbuf charset;
 	unsigned int format_flowed:1;
 	unsigned int delsp:1;
+	unsigned int have_quoted_cr:1;
 	char *message_id;
 	enum  {
 		TE_DONTCARE, TE_QP, TE_BASE64
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 147e616533..c7ea1b30df 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -228,4 +228,19 @@ test_expect_success 'mailinfo handles unusual header whitespace' '
 	test_cmp expect actual
 '
 
+check_quoted_cr_mail () {
+	git mailinfo -u "$@" quoted-cr-msg quoted-cr-patch \
+		<"$DATA/quoted-cr.mbox" >quoted-cr-info 2>quoted-cr-err &&
+	test_cmp "expect-cr-msg" quoted-cr-msg &&
+	test_cmp "expect-cr-patch" quoted-cr-patch &&
+	test_cmp "$DATA/quoted-cr-info" quoted-cr-info
+}
+
+test_expect_success 'mailinfo warn CR in base64 encoded email' '
+	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-msg" >expect-cr-msg &&
+	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-patch" >expect-cr-patch &&
+	check_quoted_cr_mail &&
+	grep "quoted CR detected" quoted-cr-err
+'
+
 test_done
diff --git a/t/t5100/quoted-cr-info b/t/t5100/quoted-cr-info
new file mode 100644
index 0000000000..dab2228b70
--- /dev/null
+++ b/t/t5100/quoted-cr-info
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: mail@example.com
+Subject: sample
+Date: Mon, 3 Aug 2020 22:40:55 +0700
+
diff --git a/t/t5100/quoted-cr-msg b/t/t5100/quoted-cr-msg
new file mode 100644
index 0000000000..a148bc7e26
--- /dev/null
+++ b/t/t5100/quoted-cr-msg
@@ -0,0 +1,2 @@
+On different distro, pytest is suffixed with different patterns.%%
+%%
diff --git a/t/t5100/quoted-cr-patch b/t/t5100/quoted-cr-patch
new file mode 100644
index 0000000000..580e2bddb8
--- /dev/null
+++ b/t/t5100/quoted-cr-patch
@@ -0,0 +1,22 @@
+---%%
+ configure | 2 +-%%
+ 1 file changed, 1 insertion(+), 1 deletion(-)%%
+%%
+diff --git a/configure b/configure%%
+index db3538b3..f7c1c095 100755%%
+--- a/configure%%
++++ b/configure%%
+@@ -814,7 +814,7 @@ if [ $have_python3 -eq 1 ]; then%%
+     printf "Checking for python3 pytest (>= 3.0)... "%%
+     conf=$(mktemp)%%
+     printf "[pytest]\nminversion=3.0\n" > $conf%%
+-    if pytest-3 -c $conf --version >/dev/null 2>&1; then%%
++    if "$python" -m pytest -c $conf --version >/dev/null 2>&1; then%%
+         printf "Yes.\n"%%
+         have_python3_pytest=1%%
+     else%%
+-- %%
+2.28.0%%
+_______________________________________________
+example mailing list -- list@example.org
+To unsubscribe send an email to list-leave@example.org
diff --git a/t/t5100/quoted-cr.mbox b/t/t5100/quoted-cr.mbox
new file mode 100644
index 0000000000..6ea9806a6b
--- /dev/null
+++ b/t/t5100/quoted-cr.mbox
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
-- 
2.31.1.448.g9c2f8508d1

