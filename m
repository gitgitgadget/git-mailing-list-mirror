Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E7C43460
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5C261221
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhDSL3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbhDSL3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:29:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8382C061761
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:28:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n4-20020a05600c4f84b029013151278decso6644493wmq.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/hjM/1l4z9XOg3Z+s2ZRLQqy32lglklRKTb17KmrRLg=;
        b=MExSkPZ9s20m0CbX2M1Q3q+z7/kGG9GzYXgRSRtqdiUBseapUZpLXkN+f3bOiN3eA5
         l2syhabKizlR2/ymsPz1me/5E5B08QKrGVJ94xkkcM0qNrdHH9lHQ91SRlLYwum6ythh
         1ltZ7XucrGjg5XDDkMvj0ZCql7v1uFSZJP4tK3vyUbICizvJQ9YFl3hUFH9FzPslzcI5
         6+wSedswxMH+07Adh4D2EX/8zYl5Rffh/EWr3qkDuN2lvO7IN0qq3oX0DLAmSLz9f6Xm
         4PCggBNwPLZ7sOlJScwa6hLawKGlNOLMnJiDjzKACw10J+ljz7bUnupwJiFLjsvs6qE6
         +r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/hjM/1l4z9XOg3Z+s2ZRLQqy32lglklRKTb17KmrRLg=;
        b=HH4V9yQelqqxj+xTCZjisluDBmjPKN6vs+NSlNhbzOpFJG869C3XblcxdfxWYL3lTv
         IfIb517uqq+jjKY6MYU8Ga9PAaN/jOpoR7/2H22VxabLyNOuBGdzIoFWhKqaJ9CNCXrR
         PlWaTv7Wv0bp9QRfXEmdkoEZFV3uUElJFE3o4A3dzHavB64kaSh2+L1nKKuiM1zgd/Ej
         sd9N7fC1NteqOJS55+kpY5p3wVkREV49cV3Jpu1msmOzgwiRt+u7jskHJzfC1HwtlwJL
         8QPNAL5zu0YAq42LFKSjUhHLmLwVeI6iQuw+Xpnsp5l6ZNPdpf7SlxxXW3fhel45Kmcp
         9YRg==
X-Gm-Message-State: AOAM53226WWputMH/JcfG6BuMbZw3ali6O8Z6+NVlsIvC6Z7EBXSEewq
        qMVmfXvC08/7YveD3rGazqx389Bd+FY=
X-Google-Smtp-Source: ABdhPJzL2yj3JRXs3L7yoCYOJ/QEpi+uPSHLvOndZTQeDE+3O5fTsweBykewoYlvXzJyiwvYxDH0FA==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr21433379wmq.85.1618831728562;
        Mon, 19 Apr 2021 04:28:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm22580831wrt.71.2021.04.19.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:28:48 -0700 (PDT)
Message-Id: <1c7a69ba072ac740273ef06972122f74cf3fa684.1618831726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.935.git.1618831726.gitgitgadget@gmail.com>
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:28:45 +0000
Subject: [PATCH 2/2] [GSOC] ref-filter: reuse output buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use `git for-each-ref`, every ref will allocate
its own output strbuf. But we can reuse the final strbuf
for each step ref's output.

The performance for `git for-each-ref` on the Git repository
itself with performance testing tool `hyperfine` changes from
23.7 ms ± 0.9 ms to 22.2 ms ± 1.0 ms. Optimization is relatively
minor.

At the same time, we apply this optimization to `git tag -l`
and `git branch -l`.

This approach is similar to the one used by 79ed0a5
(cat-file: use a single strbuf for all output, 2018-08-14)
to speed up the cat-file builtin.

Helped-by: Jeff King <peff@peff.net>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       |  9 +++++----
 builtin/for-each-ref.c | 12 ++++++------
 builtin/tag.c          | 12 ++++++------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index bcc00bcf182d..00081de1aed8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 {
 	int i;
 	struct ref_array array;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	char *to_free = NULL;
@@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		struct strbuf out = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
+		strbuf_reset(&out);
 		if (format_ref_array_item(array.items[i], format, &out, &err))
 			die("%s", err.buf);
 		if (column_active(colopts)) {
@@ -452,10 +453,10 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			fwrite(out.buf, 1, out.len, stdout);
 			putchar('\n');
 		}
-		strbuf_release(&err);
-		strbuf_release(&out);
 	}
 
+	strbuf_release(&err);
+	strbuf_release(&out);
 	ref_array_clear(&array);
 	free(to_free);
 }
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8520008604e3..bf24c595c526 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -81,17 +83,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++) {
-		struct strbuf output = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
-
+		strbuf_reset(&output);
 		if (format_ref_array_item(array.items[i], &format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
 		putchar('\n');
-
-		strbuf_release(&err);
-		strbuf_release(&output);
 	}
+
+	strbuf_release(&err);
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index d92d8e110b4d..592af1d154ea 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
 {
 	struct ref_array array;
+	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
 	int i;
 
@@ -64,17 +66,15 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		struct strbuf output = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
-
+		strbuf_reset(&output);
 		if (format_ref_array_item(array.items[i], format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
 		putchar('\n');
-
-		strbuf_release(&err);
-		strbuf_release(&output);
 	}
+
+	strbuf_release(&err);
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	free(to_free);
 
-- 
gitgitgadget
