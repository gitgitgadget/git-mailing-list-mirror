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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81FAC43462
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954F361004
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEIRNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhEIRNd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 13:13:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189AC061574
        for <git@vger.kernel.org>; Sun,  9 May 2021 10:12:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p4so12045906pfo.3
        for <git@vger.kernel.org>; Sun, 09 May 2021 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRx/baUEMcirH1lB9RvRxUgt6B5T0Ip3hpfROBNlWo8=;
        b=Wta5P/uszahGJXQfpVlBZXJjNuOGQwhm203JkDUXEdk1bXh3ZbTpt+ULY/ITOLLJFk
         XfH43DGBiWEL/mBzVdOGSg3m5o+jN3FbU9+n3GIgwhh0iLjDEGB9tumVaUQCnTCsJvV4
         jJajXLQMHIMg5BX1OL6pjWSQH+UE0bq9ZvjzV4961gmHkSZuEto0tlYfIg1sS5EXm8s+
         yi7o7y16L3pw5vOVBRt3xa7vS6LvkHVFr7YS6fKqOD7z8M2M0R1qH5lFCX4Yc0mEY+qW
         uHXm8K2FgIliMsBlJLoAscw/gIdG1lIiXwX3a1eju/rx7vR4WokAij0H5H3FcI4Y0Zr4
         ItPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRx/baUEMcirH1lB9RvRxUgt6B5T0Ip3hpfROBNlWo8=;
        b=AE0KCeBOMWqLrBlabSTULcYdvMooTYJKO7/quigx6WLLO8hVAaM3eEjBulyGdVZ2Y+
         WwNFynHO9nWn2kZfMj/JoDRVe45j5uGk/qpbntCUWBIXABKsGo0PHLJH+8EL53WDKLva
         ZXxzIusYW9FWZZJ3WeyZWEEpIfSU5L7zvUk6m6a2u79rp2DDoocart8bfnXlU1JNuCUt
         zkbOXoBNyJy4A9J6rZlMPoXX8DFRLvLUIswYW89nYgaAGPPEkwvbNSR/exySnQKX6df2
         vb7BDzGbdg2iq7OMBgE/AIzUXJFFhok5sw2878auXjLh6Fztiw9NRl7Q3jmrPg6SIAP1
         +9Qw==
X-Gm-Message-State: AOAM5306SZI5srT4j6JnGnwIq0qjAVPmBX+oKRRgEcFkWwvJUWnunZYS
        FlLAgorvZwcrudmFu11yWQjOonjFMJTXJg==
X-Google-Smtp-Source: ABdhPJw0RTDx8k9N0Smyn8vbKViX/Jumchy/eUjDqis/iXtgf2+HrH9LF+FGx+pric5RqxFo598iLg==
X-Received: by 2002:a65:6844:: with SMTP id q4mr21512134pgt.224.1620580348930;
        Sun, 09 May 2021 10:12:28 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id l126sm9249374pga.41.2021.05.09.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:12:28 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 3/6] mailinfo: warn if CRLF found in decoded base64/QP email
Date:   Mon, 10 May 2021 00:12:10 +0700
Message-Id: <50404ffe7425a32fd26e19fc406f80693985e644.1620580178.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620580178.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620580178.git.congdanhqx@gmail.com>
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

Thus, such CR (in CRLF) couldn't be dropped by "mailsplit".
Hence, the mailed patch couldn't be applied cleanly.
Such accidents have been observed in the wild [1].

Instead of silently rejecting those messages, let's give our users
some warnings if such CR (as part of CRLF) is found.

[1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c              | 14 ++++++++++++
 mailinfo.h              |  1 +
 t/t5100-mailinfo.sh     | 30 ++++++++++++++++++++++++++
 t/t5100/quoted-cr-info  |  5 +++++
 t/t5100/quoted-cr-msg   |  2 ++
 t/t5100/quoted-cr-patch | 22 +++++++++++++++++++
 t/t5100/quoted-cr.mbox  | 47 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 121 insertions(+)
 create mode 100644 t/t5100/quoted-cr-info
 create mode 100644 t/t5100/quoted-cr-msg
 create mode 100644 t/t5100/quoted-cr-patch
 create mode 100644 t/t5100/quoted-cr.mbox

diff --git a/mailinfo.c b/mailinfo.c
index 5681d9130d..c8caee4f55 100644
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
+		warning(_("quoted CRLF detected"));
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
index 147e616533..ac6fbfe596 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -228,4 +228,34 @@ test_expect_success 'mailinfo handles unusual header whitespace' '
 	test_cmp expect actual
 '
 
+check_quoted_cr_mail () {
+	mail="$1" && shift &&
+	git mailinfo -u "$@" "$mail.msg" "$mail.patch" \
+		<"$mail" >"$mail.info" 2>"$mail.err" &&
+	test_cmp "$mail-expected.msg" "$mail.msg" &&
+	test_cmp "$mail-expected.patch" "$mail.patch" &&
+	test_cmp "$DATA/quoted-cr-info" "$mail.info"
+}
+
+test_expect_success 'split base64 email with quoted-cr' '
+	mkdir quoted-cr &&
+	git mailsplit -oquoted-cr "$DATA/quoted-cr.mbox" >quoted-cr/last &&
+	test $(cat quoted-cr/last) = 2
+'
+
+test_expect_success 'mailinfo warn CR in base64 encoded email' '
+	sed -e "s/%%$//" -e "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-msg" \
+		>quoted-cr/0001-expected.msg &&
+	sed "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-msg" \
+		>quoted-cr/0002-expected.msg &&
+	sed -e "s/%%$//" -e "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-patch" \
+		>quoted-cr/0001-expected.patch &&
+	sed "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-patch" \
+		>quoted-cr/0002-expected.patch &&
+	check_quoted_cr_mail quoted-cr/0001 &&
+	test_must_be_empty quoted-cr/0001.err &&
+	check_quoted_cr_mail quoted-cr/0002 &&
+	grep "quoted CRLF detected" quoted-cr/0002.err
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
index 0000000000..89b05a0784
--- /dev/null
+++ b/t/t5100/quoted-cr-msg
@@ -0,0 +1,2 @@
+On different distro, %%pytest is suffixed with different patterns.%%
+%%
diff --git a/t/t5100/quoted-cr-patch b/t/t5100/quoted-cr-patch
new file mode 100644
index 0000000000..65b13eeef7
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
+     printf "%%Checking for python3 pytest (>= 3.0)... "%%
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
index 0000000000..909021bb7a
--- /dev/null
+++ b/t/t5100/quoted-cr.mbox
@@ -0,0 +1,47 @@
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <mail@example.com>
+To: list@example.org
+Subject: [PATCH v2] sample
+Date: Mon,  3 Aug 2020 22:40:55 +0700
+Message-Id: <msg-id@example.com>
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: base64
+
+T24gZGlmZmVyZW50IGRpc3RybywgDXB5dGVzdCBpcyBzdWZmaXhlZCB3aXRoIGRpZmZlcmVudCBw
+YXR0ZXJucy4KCi0tLQogY29uZmlndXJlIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
+aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29uZmlndXJl
+CmluZGV4IGRiMzUzOGIzLi5mN2MxYzA5NSAxMDA3NTUKLS0tIGEvY29uZmlndXJlCisrKyBiL2Nv
+bmZpZ3VyZQpAQCAtODE0LDcgKzgxNCw3IEBAIGlmIFsgJGhhdmVfcHl0aG9uMyAtZXEgMSBdOyB0
+aGVuCiAgICAgcHJpbnRmICINQ2hlY2tpbmcgZm9yIHB5dGhvbjMgcHl0ZXN0ICg+PSAzLjApLi4u
+ICIKICAgICBjb25mPSQobWt0ZW1wKQogICAgIHByaW50ZiAiW3B5dGVzdF1cbm1pbnZlcnNpb249
+My4wXG4iID4gJGNvbmYKLSAgICBpZiBweXRlc3QtMyAtYyAkY29uZiAtLXZlcnNpb24gPi9kZXYv
+bnVsbCAyPiYxOyB0aGVuCisgICAgaWYgIiRweXRob24iIC1tIHB5dGVzdCAtYyAkY29uZiAtLXZl
+cnNpb24gPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgICAgIHByaW50ZiAiWWVzLlxuIgogICAg
+ICAgICBoYXZlX3B5dGhvbjNfcHl0ZXN0PTEKICAgICBlbHNlCi0tIAoyLjI4LjAKX19fX19fX19f
+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZXhhbXBsZSBtYWlsaW5nIGxp
+c3QgLS0gbGlzdEBleGFtcGxlLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
+c3QtbGVhdmVAZXhhbXBsZS5vcmcK
+
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <mail@example.com>
+To: list@example.org
+Subject: [PATCH v2] sample
+Date: Mon,  3 Aug 2020 22:40:55 +0700
+Message-Id: <msg-id2@example.com>
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: base64
+
+T24gZGlmZmVyZW50IGRpc3RybywgDXB5dGVzdCBpcyBzdWZmaXhlZCB3aXRoIGRpZmZlcmVudCBw
+YXR0ZXJucy4NCg0KLS0tDQogY29uZmlndXJlIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
+c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29u
+ZmlndXJlDQppbmRleCBkYjM1MzhiMy4uZjdjMWMwOTUgMTAwNzU1DQotLS0gYS9jb25maWd1cmUN
+CisrKyBiL2NvbmZpZ3VyZQ0KQEAgLTgxNCw3ICs4MTQsNyBAQCBpZiBbICRoYXZlX3B5dGhvbjMg
+LWVxIDEgXTsgdGhlbg0KICAgICBwcmludGYgIg1DaGVja2luZyBmb3IgcHl0aG9uMyBweXRlc3Qg
+KD49IDMuMCkuLi4gIg0KICAgICBjb25mPSQobWt0ZW1wKQ0KICAgICBwcmludGYgIltweXRlc3Rd
+XG5taW52ZXJzaW9uPTMuMFxuIiA+ICRjb25mDQotICAgIGlmIHB5dGVzdC0zIC1jICRjb25mIC0t
+dmVyc2lvbiA+L2Rldi9udWxsIDI+JjE7IHRoZW4NCisgICAgaWYgIiRweXRob24iIC1tIHB5dGVz
+dCAtYyAkY29uZiAtLXZlcnNpb24gPi9kZXYvbnVsbCAyPiYxOyB0aGVuDQogICAgICAgICBwcmlu
+dGYgIlllcy5cbiINCiAgICAgICAgIGhhdmVfcHl0aG9uM19weXRlc3Q9MQ0KICAgICBlbHNlDQot
+LSANCjIuMjguMA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
+X18KZXhhbXBsZSBtYWlsaW5nIGxpc3QgLS0gbGlzdEBleGFtcGxlLm9yZwpUbyB1bnN1YnNjcmli
+ZSBzZW5kIGFuIGVtYWlsIHRvIGxpc3QtbGVhdmVAZXhhbXBsZS5vcmcK
-- 
2.31.1.448.g9c2f8508d1

