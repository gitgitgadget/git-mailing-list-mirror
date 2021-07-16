Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ED8C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE03D613ED
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhGPHqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhGPHqf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 03:46:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A57C061760
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 00:43:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so11043005wrn.0
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t2SzA1w0E0tHOBVr1fgOoa/rjdqAluQWikPdvDIa52I=;
        b=cX5QxM6aFDX0NvfJVrR2QxtgARfmX9wdK/RRo0TnBPuRkbc/6npnGmBA6tPFV6VDCj
         CtBJH7m9YgAceZQY/Fc5n8No7DrzaNYUw9la6W2I50J9G2J+0uK3hL9zRT7kjwH6zzZu
         mTZmdbisuuWMoNVnWbL87XM3wJu1zjYCfr1cV6Z64TMgGADusKzkGRE++KMGndb9hbLF
         bKl67sUqykeDkKFFFc6GoWJM0rJ8K9H3t3dIR3tr0CnfhX56ySjlCU9e5TXpCr93lTnB
         CcFCo4f/bai0KxPoQCQmXg8U5XCF7HkcEvOJwDJ4cBtS/9Ad/3cybMjMsGZIN5rzu6SO
         hlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t2SzA1w0E0tHOBVr1fgOoa/rjdqAluQWikPdvDIa52I=;
        b=S8PpIN7i4eiP3W6z41nWKDQtwHV2dxfFp0ksS2pCNZDU7n8amjcUFYBKNmljGIyiRV
         tIb1jGhVek7+vp4lcZpRX5/YHrzFSmm6MiCVSJbGjmoy9IFPZAjD5IrPTbGK/p2x4kuJ
         eS/5HhEaIAm/LiUAewQf8PIHV4AUiWE1X314iIBlQ/+74n45rye4kYB7897eDRT+b3mc
         n+9wRYZHzjPrpJXL2jV7W7Tapvhq2ppNuGhqSBZEQFgA90xOm/4Ss2ndPUAtBGp9DJ4t
         3mmHacsmtyVgBXL57c5PfexFBaMgX5Z2NxZhqOgX/aQrT2AFUyZYwghAY0/6QYuNDKv7
         066g==
X-Gm-Message-State: AOAM5334R8+Gjfel/NvGUJE+ah00I15Aar8q7GupKezDHVqoFAK3iXdw
        LsLmM7Cf0kKSnZVPK/01aWqymaMRcAE=
X-Google-Smtp-Source: ABdhPJwfHps8L7TTQ91afwoL+mYsJk6QhWfnkCtzI+nIsVD61yFaY+6bUg0i7kaDO90mbvW6Cmfskw==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr10359791wru.119.1626421418717;
        Fri, 16 Jul 2021 00:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm8750904wrx.59.2021.07.16.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:43:38 -0700 (PDT)
Message-Id: <c17ff7ac483ad3990680a3bb1b67898564eb9379.1626421416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
From:   "Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 07:43:35 +0000
Subject: [PATCH 1/2] trailer: handle input without trailing newline
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, Luca Weiss <luca@z3ntu.xyz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

Add a corresponding test case for this as well

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 t/t7513-interpret-trailers.sh | 7 +++++++
 trailer.c                     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 04885d0a5e5..ff5f1724ad0 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -17,6 +17,7 @@ test_expect_success 'setup' '
 
 		body
 	EOF
+	printf "subject\n\nbody" > basic_message_no_eol &&
 	cat >complex_message_body <<-\EOF &&
 		my subject
 
@@ -676,6 +677,12 @@ test_expect_success 'with message that has an old style conflict block' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with message without trailing newline twice' '
+	git interpret-trailers --trailer "Cc: Peff" basic_message_no_eol > intermediary &&
+	git interpret-trailers --trailer "Cc: Peff" intermediary > actual &&
+	test_cmp intermediary actual
+'
+
 test_expect_success 'with commit complex message and trailer args' '
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 7c7cb61a945..f53cf7d07d4 100644
--- a/trailer.c
+++ b/trailer.c
@@ -765,6 +765,9 @@ static void read_input_file(struct strbuf *sb, const char *file)
 		if (strbuf_read(sb, fileno(stdin), 0) < 0)
 			die_errno(_("could not read from stdin"));
 	}
+
+	/* Make sure the input ends with a newline */
+	strbuf_complete_line(sb);
 }
 
 static const char *next_line(const char *str)
-- 
gitgitgadget

