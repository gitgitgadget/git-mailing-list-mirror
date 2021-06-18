Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9FCC49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D397613ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhFRS3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbhFRS2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:49 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB00C0611C2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:37 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10601131otl.3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WK5DcBRoX39UMfCB5g6tpkfosOcIkrgJzYkuTqSHiHE=;
        b=D+zi0Gpuni5ycRbTUFCjlWzLRp6JYtSEytENcS4PgjG/CQcdmY3SQ+GWsAyF7wOrer
         nF489S6bPZXBoc4O4SaJuHUN4v8hf7I1PzoRAFCCKZ/z8aE2kOAZK/SYddQxthVsLfv5
         TxMwBLEFaafO/+JKMwN/LFFLrmfXOevnk3Y+DRKpb5exh0uh56dlrybzGeGJLUCp+J9t
         i3k60QSQSRiQRTbUBE3h1+Au+lXSrwT6vqFpypN7dXh7Lcq3eulSrP+XS7Il1GwiR1Rd
         1Eu7ngsSITpEU/IRBeS+aFGwsHt7OjuJd5VmtTG47Q7VFiGmzvFrQ+i7RzmCXFYqsvdo
         /usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WK5DcBRoX39UMfCB5g6tpkfosOcIkrgJzYkuTqSHiHE=;
        b=tdflJDcb0CN16LN/gUL8P4ZAmVP/HKBLx7tJgldFWFHUG3R3y5j5s0ymOWSuh3NZ7n
         HBQPv3/YeC9Z3WxIGTpg8NfjqC+NNvKDzqERa0/ZCogZWsyIgt+12WHOtJtf5cHeRy3t
         c6Lm4JEslfC1SpTgYqEu/n+InxE0WJSEzSOv8rmwbAXQZA6bwjO1fLAcGxTR1gk4vpFj
         Un5ArLiUxkdW6r1uug7RnjdKIvuBlanmhh2J4/Z6vQQ5/rSIasDia7IWm5L0Mk21Fqyz
         Tmi2MyTSWlYpgtRSSB1Z1lLriiQwvANK7i/C3h/J9rvE++vrXnUtIC57/al+yYRhNz5d
         g6Pw==
X-Gm-Message-State: AOAM531YzJ26g1CNsHuFYyPuYzs11CG9h+mCV7mio2ZcN5TAOs/C7jnK
        49PCuAa9AqXP6ncMM9E4D2yXe/PGDVXJIQ==
X-Google-Smtp-Source: ABdhPJzQsrr42r5856RX2OebfHgMBoTj1JxUkw5EO4uiCUHHk7XLBz2JhwpebyV44I4GSDEEEBaMCw==
X-Received: by 2002:a9d:2222:: with SMTP id o31mr10566098ota.75.1624040797083;
        Fri, 18 Jun 2021 11:26:37 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x31sm2134261ota.24.2021.06.18.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 41/45] completion: bash: simplify _get_comp_words_by_ref()
Date:   Fri, 18 Jun 2021 13:25:14 -0500
Message-Id: <20210618182518.697912-42-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the whole functionality of _get_comp_words_by_ref(), we
know exactly what we need from that function, so only do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++--------------------
 t/t9902-completion.sh                  | 21 ++++--------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 47c96b918e..2c0b869aba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -408,30 +408,12 @@ __git_reassemble_comp_words_by_ref()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local exclude cur_ words_ cword_
-	if [ "$1" = "-n" ]; then
-		exclude=$2
-		shift 2
-	fi
-	__git_reassemble_comp_words_by_ref "$exclude"
-	cur_=${words_[cword_]}
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=$cur_
-			;;
-		prev)
-			prev=${words_[$cword_-1]}
-			;;
-		words)
-			words=("${words_[@]}")
-			;;
-		cword)
-			cword=$cword_
-			;;
-		esac
-		shift
-	done
+	local words_ cword_
+	__git_reassemble_comp_words_by_ref "=:"
+	cword=$cword_
+	cur=${words_[cword]}
+	prev=${words_[cword-1]}
+	words=("${words_[@]}")
 }
 fi
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3dbb5eb121..8745f6afe9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -43,23 +43,10 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # So let's override it with a minimal version for testing purposes.
 _get_comp_words_by_ref ()
 {
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=${_words[_cword]}
-			;;
-		prev)
-			prev=${_words[_cword-1]}
-			;;
-		words)
-			words=("${_words[@]}")
-			;;
-		cword)
-			cword=$_cword
-			;;
-		esac
-		shift
-	done
+	cword=$_cword
+	cur=${_words[cword]}
+	prev=${_words[cword-1]}
+	words=("${_words[@]}")
 }
 
 print_comp ()
-- 
2.32.0

