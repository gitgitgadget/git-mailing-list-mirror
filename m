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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEFC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D6420781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm3QGxEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgKJVWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbgKJVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:18 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A291C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:18 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a15so125462otf.5
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXZAVWG0M4U5JwK1FPNGQG1iy+b7fd3t8SiEHSWljbs=;
        b=Fm3QGxEmLBm2uHDSawu77ZKjOfS6UVvKKgHR+fRtKNuhQGWd6gMVLv2SWLlqHf7xtc
         n8uqmjbKuQSBC611Ksfkeih+9hdq5THOJUjUA5XHlNj8IA++zyV0lYwMFd64enavEXK5
         IJHKDW/a2jyww8lVRhLfXTu52c17JtRPVAYvmKg8GWdXJIx7h+ZJqPdxtFS6t19mXcCU
         iAB9hjhz+7bKgswk13nXvTqbcgJq4WUSflDktgPbqVbm7a2c8+YUIMZSWU+Aa/QgIxOb
         2ca3q+1Bo9ohEw59lH9QsyGuvGRPwmYFZA8O1X5eud1DDGSTzJNaxxKo/YlT06UPFdml
         T6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXZAVWG0M4U5JwK1FPNGQG1iy+b7fd3t8SiEHSWljbs=;
        b=bP9RMEPfNQRLfwcUOtR+1HBmAhN8DY3iEgGp7Vmpg3i3bcS8Gqy1eU3Ca3kXZ3TcZz
         N6vJklFiIjQe+KAYhDGAM9xYFfHFEkxAcnVrEy5TiOp3qqgBMQwl8tqreua6GNDw5TdK
         XD92fyogJ6WIK0q9WUsSBTryS/eiTBbDYDnK85e5dp40xLltF7g7OSYA5WZ0Q085tjH0
         kuZnmXnkUsto8rOmo55rzSS2efddS2rXSktfkquj90JvGGbdCwCludQwhsMTS5Ku/L5p
         EnF687SmkuZjuiem0kCt0TE2jaILZDnR7UJ5GlHQILz+7vYoqi35AYzFjlDLWV1yS/6C
         nt9g==
X-Gm-Message-State: AOAM5309XzUHStb65OCaB89PfsIGTHNEikK+7X1bc2sEjoAUf4PditjQ
        mmIYrygu15g2S8urp8Y7JKjh+ZNAwMid8Q==
X-Google-Smtp-Source: ABdhPJyL4WDOVLpfQ19o1ahlGLQ3MIpSf3SmRA+35K2YCvZ4rJf7eGbHX855ySDG2Uvs7NE/JSkf+Q==
X-Received: by 2002:a9d:171a:: with SMTP id i26mr14942119ota.313.1605043337560;
        Tue, 10 Nov 2020 13:22:17 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d10sm1662289oic.11.2020.11.10.13.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:17 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 20/26] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Tue, 10 Nov 2020 15:21:30 -0600
Message-Id: <20201110212136.870769-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove temporary variables.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a7dd04bb31..6da7aca481 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -202,14 +202,13 @@ __git_dequote ()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local words_ cword_
 	local exclude i j first
 
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword_=$COMP_CWORD
+	cword=$COMP_CWORD
 	if [ -z "$exclude" ]; then
-		words_=("${COMP_WORDS[@]}")
+		words=("${COMP_WORDS[@]}")
 	else
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
@@ -229,9 +228,9 @@ _get_comp_words_by_ref ()
 					((j--))
 				fi
 				first=
-				words_[$j]=${words_[j]}${COMP_WORDS[i]}
+				words[$j]=${words[j]}${COMP_WORDS[i]}
 				if [ $i = $COMP_CWORD ]; then
-					cword_=$j
+					cword=$j
 				fi
 				if (($i < ${#COMP_WORDS[@]} - 1)); then
 					((i++))
@@ -240,17 +239,15 @@ _get_comp_words_by_ref ()
 					break 2
 				fi
 			done
-			words_[$j]=${words_[j]}${COMP_WORDS[i]}
+			words[$j]=${words[j]}${COMP_WORDS[i]}
 			if [ $i = $COMP_CWORD ]; then
-				cword_=$j
+				cword=$j
 			fi
 		done
 	fi
 
-	cword=$cword_
-	cur=${words_[cword]}
-	prev=${words_[cword-1]}
-	words=("${words_[@]}")
+	cur=${words[cword]}
+	prev=${words[cword-1]}
 }
 fi
 
-- 
2.29.2

