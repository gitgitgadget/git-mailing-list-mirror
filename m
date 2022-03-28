Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD83C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiC1TLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC1TLu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:11:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0383FD88
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:10:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r7so20632902wrc.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zelExPNYf3t33hmTFoCFEPJxz6+9R9ToExophi44ikw=;
        b=LZObYuJtVDbdw6wicZSEvyE1jA+javnYGDE9Vx4S0r+HQjGkMp9wi+mRsKjWrzyn6B
         RUwClErHxCG3WGTuB/iYGgX257COQhodDUlnGdK/DZNDTc0w9ExgTw3tvgD282ODXozh
         nbBMgsJYDNHXRm3pX5Usgu45o3TDp+IXiXPnkfu3/4rvjl8oc6pdhFN0XCZ26XrVaQNA
         6Gbb0C+YmcgVYSpnbRkzRjLpWMlSA6ndqW0kttkQr9Hpua7C84a4GXfaUpcMt4ATHUGN
         2EciNz6Bq0BmkhhDyC0zEBxZ50833mW+L9YkaWfJxXNCNSzYDtdDt8KVeTqXS7Bzvkbm
         jxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zelExPNYf3t33hmTFoCFEPJxz6+9R9ToExophi44ikw=;
        b=LE3aHnYlNk6t/DN78QDmJp6J7sZYaiqGWh90BTun5CTKZtg6nO2X/LuGkNyKOFCVeg
         S3HrT9MjcqePQH9v4qkBdbhok9XAKGKjfEMqE/MjEr4wCJO6K2gwf1igfNQjD5pdXLRh
         6p/YIDtTOqEef8YeV2v6EVlbRr+OJ5xWah2giSze+yn+OBKCJxsmA7lu/4uN7qKX5azb
         Qx6KxpeGhOgD0m0cSADvcri2DwDfQSZOF92lvVsJz5FsMlaOa09Bw35hJuDbkVonb0D3
         5ZT/LvsQFMtup89zqaG4a1XM/I12fAB8XM779J/G3IagzU84bmZ3E5ENKgEcRyRPg+cF
         1x4g==
X-Gm-Message-State: AOAM531ZG7TCS39eJipRsA5Lw4DfySFF+5pQiYimuM28pabSXcJIWPvr
        6ssTvF7IISt3M+CDV8DgwwaVXwqjo+Q+JA==
X-Google-Smtp-Source: ABdhPJy7r4+AlP75v3LfcPR5GfL0puG4TUYRTTwcS8wTRVKfxpMN02cucqwotJUPfg+z/qUOSkKsyw==
X-Received: by 2002:a5d:6149:0:b0:204:4a17:bf2 with SMTP id y9-20020a5d6149000000b002044a170bf2mr25937084wrt.379.1648494607083;
        Mon, 28 Mar 2022 12:10:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d6d0c000000b001a65e479d20sm15698007wrq.83.2022.03.28.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:10:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] reftable: make assignments portable to AIX xlc v12.01
Date:   Mon, 28 Mar 2022 21:10:04 +0200
Message-Id: <patch-1.1-98267695418-20220328T190642Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.gaad2ca01774
In-Reply-To: <c052b97e-e788-f63a-15c5-b1fbb6a480e8@web.de>
References: <c052b97e-e788-f63a-15c5-b1fbb6a480e8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the assignment syntax introduced in 66c0dabab5e (reftable: make
reftable_record a tagged union, 2022-01-20) to be portable to AIX xlc
v12.1:

    avar@gcc111:[/home/avar]xlc -qversion
    IBM XL C/C++ for AIX, V12.1 (5765-J02, 5725-C72)
    Version: 12.01.0000.0000

The error emitted before this was e.g.:

    "reftable/generic.c", line 133.26: 1506-196 (S) Initialization
    between types "char*" and "struct reftable_ref_record" is not
    allowed.

The syntax in the pre-image is supported by e.g. xlc 13.01 on a newer
AIX version:

    avar@gcc119:[/home/avar]xlc -qversion
    IBM XL C/C++ for AIX, V13.1.3 (5725-C72, 5765-J07)
    Version: 13.01.0003.0006

But as we've otherwise supported this compiler let's not break it
entirely if it's easy to work around it.

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Feb 19 2022, René Scharfe wrote:

> Am 19.02.22 um 13:54 schrieb Ævar Arnfjörð Bjarmason:
> [...]
> The code is hard to read for me in general due to its many types and
> function dispatch tables, but this compiler seems to have an even harder
> time.  Where does it even get that char pointer type from?

Sorry about the very late reply, yes thath first suggestion worked,
d'oh in retrospect. This patch fixes it.


 reftable/generic.c     |  8 ++++++--
 reftable/record_test.c |  4 +++-
 reftable/writer.c      | 12 +++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index b27d152e89a..57f8032db94 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -130,7 +130,9 @@ int reftable_iterator_next_ref(struct reftable_iterator *it,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.u.ref = *ref,
+		.u = {
+			.ref = *ref
+		},
 	};
 	int err = iterator_next(it, &rec);
 	*ref = rec.u.ref;
@@ -142,7 +144,9 @@ int reftable_iterator_next_log(struct reftable_iterator *it,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.u.log = *log,
+		.u = {
+			.log = *log,
+		},
 	};
 	int err = iterator_next(it, &rec);
 	*log = rec.u.log;
diff --git a/reftable/record_test.c b/reftable/record_test.c
index f91ea5e8830..70ae78feca4 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -339,7 +339,9 @@ static void test_reftable_obj_record_roundtrip(void)
 		};
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_OBJ,
-			.u.obj = recs[i],
+			.u = {
+				.obj = recs[i],
+			},
 		};
 		struct strbuf key = STRBUF_INIT;
 		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
diff --git a/reftable/writer.c b/reftable/writer.c
index 6d979e245ff..427f1317c6b 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -257,7 +257,9 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.u.ref = *ref,
+		.u = {
+			.ref = *ref
+		},
 	};
 	int err = 0;
 
@@ -308,7 +310,9 @@ static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.u.log = *log,
+		.u = {
+			.log = *log,
+		},
 	};
 	if (w->block_writer &&
 	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
@@ -401,7 +405,9 @@ static int writer_finish_section(struct reftable_writer *w)
 		for (i = 0; i < idx_len; i++) {
 			struct reftable_record rec = {
 				.type = BLOCK_TYPE_INDEX,
-				.u.idx = idx[i],
+				.u = {
+					.idx = idx[i],
+				},
 			};
 			if (block_writer_add(w->block_writer, &rec) == 0) {
 				continue;
-- 
2.35.1.1548.gaad2ca01774

