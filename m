Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB8C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F11206B5
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVn70fap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHSMwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgHSMwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 08:52:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1906C061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:52:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so21431131wrh.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OS2sRKB34GpX+DjHnAPxp4cG4XQ9WPhbPQMol2NtnuM=;
        b=jVn70fapFRniwTidcQNdDzGgeIpNtcQsrpHrJFmj2+rltmmco28F7fNWvaNMnefimv
         UqVWsMyLrDkMUaqDxSgMy8YdApi4hB8SobeGGIm95h0NU0IUXxJTqEYVrLfSQwRWvKko
         rBx5yZWmKe/kFLhNGU31BFqK401mlLGdaCPqSeoi07cmeEj1900Kqz6N8D4zjEdiHvVS
         hxXQFszLWhMJFVGF1KC8x9KEMrYsBiGZ7kMLQVV3nnMiAD2kOOhDa3UfH5GaZm3/pYhu
         K1qEC8DlyvXgOP/lsiIHRnOvCkxO4yZ9MJdC++5nzauxw1o1y6hZy+kS3gOTEeFmjwp5
         tAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OS2sRKB34GpX+DjHnAPxp4cG4XQ9WPhbPQMol2NtnuM=;
        b=qNru9mC8PrtH8D/F8siOR/EXxDUpCl1P2HjfJoXEODrSr0YCU6xbYhiNQ5+6jfC3KK
         HMIIgTPDbuMt9i3wCuf6BoZl9QfZD65tt4d95lmYf3iVtvgWYu+xpqEuv9byotaf1jZB
         LvkFUorT44lTu2nIMiIbSlX4CJbafoV7coU9W3hQ7fwephxhhmJd9X+DOJoWABWttGmm
         oQ00IgvB39N3XDsvNsavhtz8UFwUsuH+9VhJJyjaVxgcjrvSmE2+D1BU2tPWCAP3HyPR
         BfOMCXXz6rODRYjpXfGJholVGx//imvIOsfXQGqc0HGSuE2ovIq9SgboC4QOCr8u4AbO
         4peQ==
X-Gm-Message-State: AOAM530+2ndBOpLd8S3a9Ys+SFjjQgPqlzsH3ao6Hv1HrvhQ5WGD26YJ
        raEHAO12XTCiabO77hTSEzVs1NTH55A=
X-Google-Smtp-Source: ABdhPJw6OMiHQKzR4rlHxThtm1s4ie2MN8xtU1gDugXOy1Dx9j5Gv+nTCnnH7VCXK5SAYftMA/QklQ==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr4037601wro.193.1597841554219;
        Wed, 19 Aug 2020 05:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m126sm5319271wmf.3.2020.08.19.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:52:33 -0700 (PDT)
Message-Id: <bd0bb8d0ef0936866c2a957e5391424a7481a33c.1597841551.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.git.1597841551.gitgitgadget@gmail.com>
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 12:52:30 +0000
Subject: [PATCH 1/2] t6300: unify %(trailers) and %(contents:trailers) tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Currently, there are different tests for testing %(trailers) and
%(contents:trailers) causing redundant copy.

Its time to get rid of duplicate code.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t6300-for-each-ref.sh | 50 +++++++++--------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a83579fbdf..495848c881 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -776,60 +776,39 @@ test_expect_success 'set up trailers for next test' '
 '
 
 test_expect_success '%(trailers:unfold) unfolds trailers' '
-	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
 	{
 		unfold <trailers
 		echo
 	} >expect &&
+	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%(trailers:only) shows only "key: value" trailers' '
-	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
 	{
 		grep -v patch.description <trailers &&
 		echo
 	} >expect &&
+	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
-	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
-	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
-	test_cmp actual reverse &&
 	{
 		grep -v patch.description <trailers | unfold &&
 		echo
 	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:unfold) unfolds trailers' '
-	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
-	{
-		unfold <trailers
-		echo
-	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:only) shows only "key: value" trailers' '
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
-	{
-		grep -v patch.description <trailers &&
-		echo
-	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) work together' '
+	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
+	test_cmp actual reverse &&
+	test_cmp expect actual &&
 	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/master >actual &&
 	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >reverse &&
 	test_cmp actual reverse &&
-	{
-		grep -v patch.description <trailers | unfold &&
-		echo
-	} >expect &&
 	test_cmp expect actual
 '
 
@@ -839,14 +818,7 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
 	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual
-'
-
-test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
-	# error message cannot be checked under i18n
-	cat >expect <<-EOF &&
-	fatal: unknown %(trailers) argument: unsupported
-	EOF
+	test_i18ncmp expect actual &&
 	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
 	test_i18ncmp expect actual
 '
-- 
gitgitgadget

