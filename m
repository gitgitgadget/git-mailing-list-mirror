Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8970C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 21:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiKMV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 16:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiKMV3D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 16:29:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351F13F77
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:28:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b11so8758186pjp.2
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuR80NzvLposCHz1dATcq7xtH6HNWVtoEjbgjTnVlQI=;
        b=Zr952QPPbWGbVCI+40YXOpnQPqRq0hTb+ytOZgR979005hucm7v03dcKf2eC5BhVj8
         YY/7LkwaP/4+zJVYr5zqD16f1AUDKlr/LAKwz0zv0MuzIxYygFbgifNRZQY4lRirRugr
         o0O5sZCHsPKFaHnXp/6JRy1TPuUyzT56gxAR48hXx2mjpPrHgbEsMTZ7X/eR1Yc+xpXP
         BpMsCcVT2AkwzEDJeH+Q/ewhaKawi+wyyYi046L0SQRPlElgL8fUaU2CMjXFX1L9iT2+
         pqfBlJzKWEA95fRAfJ5jkLLKXEc0JozRaczFZgVupnof7epdpFrsr9xlnD6oHh6FvBTc
         m/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuR80NzvLposCHz1dATcq7xtH6HNWVtoEjbgjTnVlQI=;
        b=hcSCfAHAfhu5BYjJOyu4agPQi0QwQGaMoWKXFKJhgWpOKf3hLAy0JR7pT809s6ku8l
         uPpTWw0mMJF1EDZ/UCbRxWQgHWRxWhwzUpJdBcODp/NsIXydS91OL774vj7irKBGsPTs
         uHgRymuaecRgWo3Nt48J5XvmhTHHOTjNeeUIQbbBNqA7QyPhLbdLwb0II5qMyuUL5fki
         EAcF9jiqcbGJFCux7Gw6FcNO6k1h7juj6in6wxpypZp6p2Wnk6i+218+c8sfibjqlqyt
         4p9JgnIxchlT1LFrh9A18FvF72TAPSYEM5GXTo3ihmdJB2ycpk2+6jJf6CMr0zq/5hE5
         k05w==
X-Gm-Message-State: ANoB5pkAOnria10p+jzs8H4oTJJQqKG9iBGnNgRTzPHsykRf+WLdswAw
        19YkaX8rO78RXbJC6asCoLGbI/TiA0USXqTZ
X-Google-Smtp-Source: AA0mqf7Jd/P2Y+4TfOuLnlM4kZbn44/8YnxjjpizALWUhRfflo9CpfDQZ/9rzhHKAxPNSfq2Qiq0uA==
X-Received: by 2002:a17:903:3286:b0:187:a98:7eea with SMTP id jh6-20020a170903328600b001870a987eeamr11081047plb.109.1668374938528;
        Sun, 13 Nov 2022 13:28:58 -0800 (PST)
Received: from HB2.. ([2409:4043:4c81:51c0:8e7b:5efe:71ba:3c2f])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0056c704abca7sm5116337pfv.220.2022.11.13.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 13:28:58 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 2/3] cat-file: add mailmap support to --batch-check option
Date:   Mon, 14 Nov 2022 02:58:29 +0530
Message-Id: <20221113212830.92609-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.423.g41b4650b24
In-Reply-To: <20221113212830.92609-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the cat-file command with `--batch-check` option does not
complain when `--use-mailmap` option is given, the latter option is
ignored. Compute the size of the object after replacing the idents and
report it instead.

In order to make `--batch-check` option honour the mailmap mechanism we
have to read the contents of the commit/tag object.

There were two ways to do it:

1. Make two calls to `oid_object_info_extended()`. If `--use-mailmap`
   option is given, the first call will get us the type of the object
   and second call will only be made if the object type is either a
   commit or tag to get the contents of the object.

2. Make one call to `oid_object_info_extended()` to get the type of the
   object. Then, if the object type is either of commit or tag, make a
   call to `read_object_file()` to read the contents of the object.

I benchmarked the following command with both the above approaches and
compared against the current implementation where `--use-mailmap`
option is ignored:

`git cat-file --use-mailmap --batch-all-objects --batch-check --buffer
--unordered`

The results can be summarized as follows:
                       Time (mean ± σ)
default               827.7 ms ± 104.8 ms
first approach        6.197 s ± 0.093 s
second approach       1.975 s ± 0.217 s

Since, the second approach is faster than the first one, I implemented
it in this patch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/cat-file.c | 14 ++++++++++++++
 t/t4203-mailmap.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8a6e2343ec..39f2a2483f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -444,6 +444,9 @@ static void batch_object_write(const char *obj_name,
 	if (!data->skip_object_info) {
 		int ret;
 
+		if (use_mailmap)
+			data->info.typep = &data->type;
+
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);
@@ -457,6 +460,17 @@ static void batch_object_write(const char *obj_name,
 			fflush(stdout);
 			return;
 		}
+
+		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
+			size_t s = data->size;
+			char *buf = NULL;
+
+			buf = read_object_file(&data->oid, &data->type, &data->size);
+			buf = replace_idents_using_mailmap(buf, &s);
+			data->size = cast_size_t_to_ulong(s);
+
+			free(buf);
+		}
 	}
 
 	strbuf_reset(scratch);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index b500b31c92..b4355c3e51 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1051,4 +1051,34 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
+	EOF
+	echo "HEAD" >in &&
+	git cat-file --batch-check <in >actual &&
+	git cat-file --use-mailmap --batch-check <in >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
+	EOF
+	echo "info HEAD" >in &&
+	git cat-file --batch-command <in >actual &&
+	git cat-file --use-mailmap --batch-command <in >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1.420.g319605f8f0

