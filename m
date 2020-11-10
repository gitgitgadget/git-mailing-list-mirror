Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB7C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D51F206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgi98rx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgKJVWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbgKJVWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:21 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E814C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:20 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id k26so16145599oiw.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vR0rKYTjjX/qX3q2vcSfWbxdK1CoLcjvfq1eLIBdD78=;
        b=pgi98rx4T+CZNs7LSxG4BLliBYhb5KWFHAWtowl2hQRjOM8fJsEqzBIvbgO/h18fNJ
         LjqvCNwY/B+nz/69dAxsugHS4BQEWg1i78UC4qbdR08sKtXRSEBJ4kzVqtP/2Fc/RxjC
         8WVuUzOzq4ar95Si2UATWOkgLUxEy/s3e6YsjLgGaed62PojPt/RPfNg65NfaIj/D+df
         2FN5nuYGmYl+Wx/ykjqxJJXbUl4Dlz9XpPbUVC2VWMCcVc7XZ/F9AYHbMB6db6GXkJyL
         RmJHh0GDSZGdaVT06O6M64PzLyIXf0jTJaoTMrhJd/2PxTzznkE4FMyBXxm8eNBcvl5l
         8YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vR0rKYTjjX/qX3q2vcSfWbxdK1CoLcjvfq1eLIBdD78=;
        b=djMzg3HYd7EM1arYbRvExXPrPImSm+xhTpcEfonmuuqLEUs9j22rsxJD4BUxJrRzMj
         ODGjGPlxOlgBvfUyiZNgRKvObABxe2OXHqDge5ISXVWvjoukwovnn1ET+IjXgA2HvYxO
         jYCTjL1PsBq09OWWco+dc269S7mq2egVRJNbz3WVWOqfZqpjCYqRQXA5TXe73nmTeXXl
         gjJjZScLkw+6IF7KUVDr6JArPVUKvjtPt16IOjPYu5hSauSPDeruj2o939FkKVwXCUEp
         AMBudGueWJnoiO84tw4j3Niwh2sQnBzmQfl01mdiycrVHhrWEpgQh/wdZF702l4MUefN
         OHYg==
X-Gm-Message-State: AOAM531/p2mi6VrgSnrHqibtnu0v78/LO4cDB7D7Y3SmRtEJkcn+6/EL
        gncwgwESuoaxu5JX+wvFkU+hSSsckKKdqA==
X-Google-Smtp-Source: ABdhPJyfT/HdTxhtZ9cVlEJwOU09F48FrFuQv3ZrGCmyqpCEJNx0kG2mGSNP+RfXmV/Eq3ZfsaTIbQ==
X-Received: by 2002:aca:b887:: with SMTP id i129mr47960oif.25.1605043339394;
        Tue, 10 Nov 2020 13:22:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m10sm39766oon.27.2020.11.10.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:18 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 21/26] completion: bash: trivial cleanup
Date:   Tue, 10 Nov 2020 15:21:31 -0600
Message-Id: <20201110212136.870769-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most typical case first (COMP_WORDBREAKS contains our wanted words).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da7aca481..26f9accc30 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -207,9 +207,7 @@ _get_comp_words_by_ref ()
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
 	cword=$COMP_CWORD
-	if [ -z "$exclude" ]; then
-		words=("${COMP_WORDS[@]}")
-	else
+	if [ -n "$exclude" ]; then
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
 		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
@@ -244,6 +242,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.29.2

