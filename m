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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBCC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086BB613BC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEDRVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhEDRVM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:21:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD39C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:20:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d29so7057496pgd.4
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOvauPPC12x4a98RPgcTnnhoSu6Cu/RcaTqFUCOUtME=;
        b=KxMNf48SBx49nVa5gXw4/ia+WG9O0OfyBH9k/pjNQWJ21/Wb1MMRAgfVe7EHX4SOmY
         oaxFILSbEjD/FJI0ceZ88/MQ6cqDHIGxQ7hHYQaYvH03ZH6lRqUavfKKbU7Mh+6N1bMO
         pVR4+t4xKk0vGhuTQSm5yP1tAp3cb6eHckepnO4qsh3u/iKVph2PWTbIsvDureAzw3dJ
         Od65v5Qoxr4BXIRuKhez61Fryad77uKQ/+5gnk4HgCNMochYRDgOdiLSy8MAVgzUHIDv
         s17TkApV43KaPALwyAwfuT+Ua0d8gJVl5uOoIVo0Gs57sAoQ39wQOjrP7Pk9bPcopq5g
         DKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOvauPPC12x4a98RPgcTnnhoSu6Cu/RcaTqFUCOUtME=;
        b=tHdeAe08PR6C3Ogoo5Ygk9wX/q1mBCWs4xwv6MYqFc6ycmzXLPg/pn+E8cr8QsdH0G
         VxSSJCSo1gSNihC9Di5X0ovNLDd2JDUebn5ASsl5krIgILRH2SN5u4Wklb+uFsCtuMIS
         B4xrRXAVR3Qc2UACHE1lOiLTyVfgAiws2w5PjTDR/slaqFoM9mhPh1SEg1H83XiwgzS5
         e8pw21adkAHHtJnnYCVtV4xJP7mceMtasiL6OW8EGN8gKbA8Jw5QrDWFxslarNeGAAAN
         QRsJt37BXona1sseQXnQyYjCyYt70TAvJ26I2ylqPZxyBRfr7HMGRZuutPangLlt2mqC
         AK3A==
X-Gm-Message-State: AOAM532VCvGoLH+0dL4Nnuo4A0qPpBv/1ewMIewOwmjRNV6bfSc/VbpL
        Tisz5Vyh7BQESMXuvV2n2HoouAdIxeyPpQ==
X-Google-Smtp-Source: ABdhPJxZp3Z46JXmqQ5mEP07RfugUqux2eLIvFIZ9Ubh+lzANkvV5N061rJpgzIw2gW+u6fTvJ2qgg==
X-Received: by 2002:aa7:8087:0:b029:28e:8174:565c with SMTP id v7-20020aa780870000b029028e8174565cmr12950313pff.12.1620148816698;
        Tue, 04 May 2021 10:20:16 -0700 (PDT)
Received: from athena.localdomain ([27.75.102.31])
        by smtp.gmail.com with ESMTPSA id a18sm4019267pgg.51.2021.05.04.10.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:20:16 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/5] mailinfo: warn if CR found in base64/quoted-printable email
Date:   Wed,  5 May 2021 00:19:59 +0700
Message-Id: <45d2c4ab58c4b0c6f0c7790890bbf75eb373f999.1620148732.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.500.gbc6bbdd36b
In-Reply-To: <cover.1620148732.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620148732.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an SMTP server receives an 8-bit email message, possibly with only
LF as line ending, some of those servers decide to change said LF to
CRLF.

Some mailing list softwares, when receives an 8-bit email message,
decide to encoding such message in base64 or quoted-printable.

If an email is transfered through above mail servers, then distributed
by such mailing list softwares, the recipients will receive an email
contains a patch mungled with CRLF encoded inside another encoding.
Thus, such CR couldn't be dropped by mailsplit. Hence, the mailed patch
couldn't be applied cleanly. Such accidents have been observed in the wild [1].

Let's give our users some warnings if such CR is found.

[1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c              | 21 ++++++++++++++++++---
 t/t5100-mailinfo.sh     | 15 +++++++++++++++
 t/t5100/quoted-cr-info  |  5 +++++
 t/t5100/quoted-cr-msg   |  2 ++
 t/t5100/quoted-cr-patch | 22 ++++++++++++++++++++++
 t/t5100/quoted-cr.mbox  | 22 ++++++++++++++++++++++
 6 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 t/t5100/quoted-cr-info
 create mode 100644 t/t5100/quoted-cr-msg
 create mode 100644 t/t5100/quoted-cr-patch
 create mode 100644 t/t5100/quoted-cr.mbox

diff --git a/mailinfo.c b/mailinfo.c
index 5681d9130d..713567f84b 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -988,12 +988,17 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 }
 
 static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
-				 struct strbuf *prev)
+				 struct strbuf *prev, int *have_quoted_cr)
 {
 	size_t len = line->len;
 	const char *rest;
 
 	if (!mi->format_flowed) {
+		if (len >= 2 &&
+		    line->buf[len - 2] == '\r' &&
+		    line->buf[len - 1] == '\n') {
+			*have_quoted_cr = 1;
+		}
 		handle_filter(mi, line);
 		return;
 	}
@@ -1033,9 +1038,16 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 	handle_filter(mi, line);
 }
 
+static void summarize_quoted_cr(struct mailinfo *mi, int have_quoted_cr)
+{
+	if (have_quoted_cr)
+		warning("quoted CR detected");
+}
+
 static void handle_body(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
+	int have_quoted_cr = 0;
 
 	/* Skip up to the first boundary */
 	if (*(mi->content_top)) {
@@ -1051,6 +1063,8 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 				handle_filter(mi, &prev);
 				strbuf_reset(&prev);
 			}
+			summarize_quoted_cr(mi, have_quoted_cr);
+			have_quoted_cr = 0;
 			if (!handle_boundary(mi, line))
 				goto handle_body_out;
 		}
@@ -1081,7 +1095,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 						strbuf_addbuf(&prev, sb);
 						break;
 					}
-				handle_filter_flowed(mi, sb, &prev);
+				handle_filter_flowed(mi, sb, &prev, &have_quoted_cr);
 			}
 			/*
 			 * The partial chunk is saved in "prev" and will be
@@ -1091,7 +1105,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			break;
 		}
 		default:
-			handle_filter_flowed(mi, line, &prev);
+			handle_filter_flowed(mi, line, &prev, &have_quoted_cr);
 		}
 
 		if (mi->input_error)
@@ -1100,6 +1114,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 
 	if (prev.len)
 		handle_filter(mi, &prev);
+	summarize_quoted_cr(mi, have_quoted_cr);
 
 	flush_inbody_header_accum(mi);
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 147e616533..d8fdda6bea 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -228,4 +228,19 @@ test_expect_success 'mailinfo handles unusual header whitespace' '
 	test_cmp expect actual
 '
 
+check_quoted_cr_mail() {
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
2.31.1.500.gbc6bbdd36b

