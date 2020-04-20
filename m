Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A69C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A212068F
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4GOXQYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDTXzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgDTXzD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:55:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90896C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:55:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o10so2662092pgb.6
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqtItZC+XixwTYcTckqk84K5rYg4Z4qSVRZCTYhA3fU=;
        b=n4GOXQYaoMg11rubuNRi39UHEhHfT+H2nf9CpdInXyRqgNgVQ/m5B+Qpk7T19lerWv
         vLXlqBpzzMxEH/5okdctit72gbg306Ni/vUyuco8ufzohz9/g9vaxXp6lUp+pWk3qjr5
         3CzP8w+oTPafxgj8HZjeRIpYWDiOyNBCMBkoFvPl/oN9a0jodbWdS1r8MR10Eo4INipC
         KglIjo9/H2EVODt/oNcgYjiAJjD7QlJH/OBl+vKJD5OY+taM94keq7Fh9Ui7z3cKkzse
         +XqjgB+AeeWXs1XcPp5idZJE+CtlTYVw0ofeh6TwchpVhnkoFSNje31N6gRvYAI4NQbL
         +/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqtItZC+XixwTYcTckqk84K5rYg4Z4qSVRZCTYhA3fU=;
        b=OD8aRa7ZYPjbf0e1tSLKuI2gVxzaU27a+kwK6c0ECAyDZfvcX7B86hLnvnQLKEjnmj
         p7uxvla1qxtl3XRAiV4dqlBCeETEc6V1JoA+fStIqb3DhM2DBmlC2ntqUsdSdZaE923A
         CPS8iOWz+pxM8fHo2gjmqcOyuqa5Q0KQrQXl9EF6lMlZ2nOq8R1LSC48clnC2Wczh1Lk
         lKi86pV0h5vJDj5pjv2fEEUIVWb3FzM/T0/tGCbgW95K3931x12icAuYebIhOrHSONbQ
         72n/+F1Rg8lCtRvZaOXkjYL+pm24DAejWUBA1JwH2gkYJ4ChbJ90TM3V3AdPAocWbJr4
         QRJA==
X-Gm-Message-State: AGi0PubP/bvzO0iEk3byxyTiJpxxcyv5E8+HaMLxoASY/zGWSPaUXu/G
        r8K7n8PYOlbFgLU5joCY3aAyV2XW
X-Google-Smtp-Source: APiQypIOHmS3phrcbyXkXm01Nwtth8PporldYIlx7tq5oWDuvHxo2g45BsYmRkQIxiSfsxnytUirtg==
X-Received: by 2002:a65:62c7:: with SMTP id m7mr18129308pgv.16.1587426901776;
        Mon, 20 Apr 2020 16:55:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:effc:5180:3a91:1887])
        by smtp.gmail.com with ESMTPSA id g14sm609248pfh.49.2020.04.20.16.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 16:55:01 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 2/3] mailinfo.c: avoid strlen on strings that can contains NUL
Date:   Tue, 21 Apr 2020 06:54:35 +0700
Message-Id: <97ede4aab2ece936eab3caf06db5a8f5d0eea4ba.1587426713.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <cover.1587426713.git.congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587426713.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're passing buffer from strbuf to reencode_string,
which will call strlen(3) on that buffer,
and discard the length of newly created buffer.
Then, we compute the length of the return buffer to attach to strbuf.

During this process, we introduce a discrimination between mail
originally written in utf-8 and other encoding.

* if the email was written in utf-8, we leave it as is. If there is
  a NUL character in that line, we complains loudly:

  	error: a NUL byte in commit log message not allowed.

* if the email was written in other encoding, we truncate the data as
  the NUL character in that line, then we used the truncated line for
  the metadata.

We can do better by reusing all the available information,
and call the underlying lower level function that will be called
indirectly by reencode_string. By doing this, we will also postpone
the NUL character processing to the commit step, which will
complains about the faulty metadata.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c            |  6 ++++--
 t/t4254-am-corrupt.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 742fa376ab..0e9911df6d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -447,19 +447,21 @@ static int convert_to_utf8(struct mailinfo *mi,
 			   struct strbuf *line, const char *charset)
 {
 	char *out;
+	size_t out_len;
 
 	if (!mi->metainfo_charset || !charset || !*charset)
 		return 0;
 
 	if (same_encoding(mi->metainfo_charset, charset))
 		return 0;
-	out = reencode_string(line->buf, mi->metainfo_charset, charset);
+	out = reencode_string_len(line->buf, line->len,
+				  mi->metainfo_charset, charset, &out_len);
 	if (!out) {
 		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
+	strbuf_attach(line, out, out_len, out_len);
 	return 0;
 }
 
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index ddd35498db..1bbc37bc92 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -3,6 +3,37 @@
 test_description='git am with corrupt input'
 . ./test-lib.sh
 
+make_mbox_with_nul () {
+	space=' '
+	q_nul_in_subject=
+	q_nul_in_body=
+	while test $# -ne 0
+	do
+		case "$1" in
+		subject) q_nul_in_subject='=00' ;;
+		body)    q_nul_in_body='=00' ;;
+		esac &&
+		shift
+	done &&
+	cat <<-EOF
+	From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00 2001
+	From: A U Thor <author@example.com>
+	Date: Sun, 19 Apr 2020 13:42:07 +0700
+	Subject: [PATCH] =?ISO-8859-1?q?=C4=CB${q_nul_in_subject}=D1=CF=D6?=
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=ISO-8859-1
+	Content-Transfer-Encoding: quoted-printable
+
+	abc${q_nul_in_body}def
+	---
+	diff --git a/afile b/afile
+	new file mode 100644
+	index 0000000000..e69de29bb2
+	--$space
+	2.26.1
+	EOF
+}
+
 test_expect_success setup '
 	# Note the missing "+++" line:
 	cat >bad-patch.diff <<-\EOF &&
@@ -32,4 +63,17 @@ test_expect_success 'try to apply corrupted patch' '
 	test_i18ncmp expected actual
 '
 
+test_expect_success "NUL in commit message's body" '
+	test_when_finished "git am --abort" &&
+	make_mbox_with_nul body >body.patch &&
+	test_must_fail git am body.patch 2>err &&
+	grep "a NUL byte in commit log message not allowed" err
+'
+
+test_expect_failure "NUL in commit message's header" "
+	test_when_finished 'git am --abort' &&
+	make_mbox_with_nul subject >subject.patch &&
+	test_must_fail git am subject.patch
+"
+
 test_done
-- 
2.26.1.301.g55bc3eb7cb

