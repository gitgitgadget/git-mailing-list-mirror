Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73BC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DBC206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQQarpQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgFOMuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOMuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA83C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f185so14702316wmf.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8982IMY216dh/2zL8TAIDsMLrlSornWQ5042fmHnoJ0=;
        b=XQQarpQtmKB5hO7jDRagtKGxwfbBNmx6Bsp5VBYRrsqf2SNR2WzFhSRNG9w/oGaERp
         t6/UafKEN8lWOOD0wyL+yFAnMwXFDXi/r8frbqxJCWHOi/nQ+bBn9iP3vZl1+ypxznX1
         hsy5oxEEnkr7XJUzo07ieZ4MuLagmeejZu1yVqfas3YRnbo4iCWT0uLWDgQvUr+6KihE
         nw/s9Kql1hSb4E2xhAD8x3f77b9ll6SH9gk0s2q2MonrWMge3wz6i4K1BDC1sv0cZS/Z
         mecRZR1xg4G33dx/QiH5j7F+Xmj48pzeqFnpbCNAbbI6YjDZnUL+EXFvNfir1JivMCMP
         3V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8982IMY216dh/2zL8TAIDsMLrlSornWQ5042fmHnoJ0=;
        b=AxTPQSLYBYNxdwbqnlIn9lTJFeadM/CPVe/ffQongSdQ/+udvPAD45ViRZ6jLllx5c
         8EDKC8tGE9tZq0JQuGYNGCS1nfRZt45FpO4z+rhv6REqqW5cKCUs9UN6MMabBXA9HRtD
         ma3pyDCQjMyp/i7wHBNxmemSC1HdOnxxFfiysfKXI6xRK6M1qiOAgjBCgXX2KjHczR3w
         vpeacH9sp9/f65Jzr0npqn5Pmxfe8JUHCR7wAXRL4C6oSCVjQD7ql8JUx5FqT6/QNiJ1
         EX3zOjWDCVqeE3xgvmOxOt+6Z8e+iOamrFIU08sRumEgg68vCO9YH9IsnLS1BXqnNPoi
         5FOQ==
X-Gm-Message-State: AOAM533djZVNG0h2X2BHYyo0dPzIAbj7aG6+VDIHd6ei1/p4/gv7cE0z
        r9xSMUgqvUrMBfGvRzZufDuvlLwX
X-Google-Smtp-Source: ABdhPJzLMJNZQNj8BIlGSgg5BqW27BW52fQ8Htt0w3k4XsZ85si1eL6OdlxtTXmgz3prNmp+++lw5g==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr12731640wmc.10.1592225419423;
        Mon, 15 Jun 2020 05:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm27081312wrb.46.2020.06.15.05.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:18 -0700 (PDT)
Message-Id: <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:05 +0000
Subject: [PATCH v2 01/12] fast-export: do anonymize the primary branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

In a fast-export stream with --anonymize option, all the end-user
data including refnames are munged to prevent exposure, but the
'master' branch is left intact.

There is a comment that explains why it is OK to leave 'master'
unanonymized (because everybody calls the primary branch 'master'
and it is no secret), but that does not justify why it is bad to
anonymize 'master' and make it indistinguishable from other
branches.  Assuming there _is_ a need to allow the readers of the
output to tell where the tip of the primary branch is, let's keep
the special casing of 'master', but still anonymize it to "ref0".
Because all other branches will be given ref+N where N is a positive
integer, this will keep the primary branch identifiable in the
output stream, without exposing what the name of the primary branch
is in the repository the export stream was taken from.

This is in preparation for introducing a mechanism to affect the
name of the primary branch used in the repository.  Once the
mechanism is in use, the name of the primary branch won't be
'master', and may not be allowed to be exposed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c            | 9 +++++----
 t/t9351-fast-export-anonymize.sh | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85868162eec..1072bbf041f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -497,7 +497,7 @@ static void *anonymize_ref_component(const void *old, size_t *len)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
-	strbuf_addf(&out, "ref%d", counter++);
+	strbuf_addf(&out, "ref%d", ++counter);
 	return strbuf_detach(&out, len);
 }
 
@@ -518,11 +518,12 @@ static const char *anonymize_refname(const char *refname)
 	int i;
 
 	/*
-	 * We also leave "master" as a special case, since it does not reveal
-	 * anything interesting.
+	 * In certain circumstances, it might be interesting to be able to
+	 * identify the main branch. For that reason, let's force its name to
+	 * be anonymized to `ref0`.
 	 */
 	if (!strcmp(refname, "refs/heads/master"))
-		return refname;
+		return "refs/heads/ref0";
 
 	strbuf_reset(&anon);
 	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 897dc509075..2415f0ec213 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -26,8 +26,9 @@ test_expect_success 'stream omits path names' '
 	! grep xyzzy stream
 '
 
-test_expect_success 'stream allows master as refname' '
-	grep master stream
+test_expect_success 'stream translates master to ref0' '
+	grep refs/heads/ref0 stream &&
+	! grep master stream
 '
 
 test_expect_success 'stream omits other refnames' '
@@ -57,7 +58,7 @@ test_expect_success 'import stream to new repository' '
 test_expect_success 'result has two branches' '
 	git for-each-ref --format="%(refname)" refs/heads >branches &&
 	test_line_count = 2 branches &&
-	other_branch=$(grep -v refs/heads/master branches)
+	other_branch=$(grep -v refs/heads/ref0 branches)
 '
 
 test_expect_success 'repo has original shape and timestamps' '
@@ -65,7 +66,7 @@ test_expect_success 'repo has original shape and timestamps' '
 		git log --format="%m %ct" --left-right --boundary "$@"
 	} &&
 	(cd .. && shape master...other) >expect &&
-	shape master...$other_branch >actual &&
+	shape ref0...$other_branch >actual &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget

