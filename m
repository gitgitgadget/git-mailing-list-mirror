Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A654C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB52D207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbhAACRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbhAACRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:41 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE7BC0617A1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:25 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r9so19257626otk.11
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZp6NWCZygtofwsHD20PnvhNqp0Hfy3zfifN/QguG20=;
        b=ZS7lUoAcq2Gry/k2o6fN3PnnthFQLrTTu8UD8iwkzDnWf1iCtinOZt/tF/1RcDPbp2
         SFB8gL9Wje7WiSDT8gAWQVt6FeWD+2wUSwMqfsy1cJ5OW4kWWv0CnPMlmvijfWVbfc0W
         1hmmNA7PsMu7Bia9SDDBHc1qTekQojrU6LMuU7R8a/4izJgNkbxWvpZebL5p9+5yGd1k
         XV8PFxmbqaIiypXWORTN9D71pih7/K6ZeVCkJN2c2Gg5MPDkSjjBiFXsrEfxdk3tJiRf
         fNwpByxh5qkwo0AuAlNcEB39ECw87rSvnvnuUiDLSnTOHdFimQiMMj6PjVC/WFwIwpl7
         7jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZp6NWCZygtofwsHD20PnvhNqp0Hfy3zfifN/QguG20=;
        b=lirMqkO1HwaeH5Dzlj2bdKHA6fUKQICPgk4Zu8X+TSJ+6+8q+k9lQEPACgGdKsM+2w
         3tvBbzs3eZ+dCc4icqYcpvs1kKMDmtB1E1in1Z5T0R4JudMvyKr+rnDKvlRkCnOWA+HR
         YV35fAJJMvT+1s5uv77ylRh5SyRSTOtnDLmH0Htw0VxTG92rI3qYGfZKyk58LznPdFpL
         McQli9T8fJco6P8FKdKZluNVfboWHDK1kn+AC8o9xI0h0d322pO0UJ9smAhoUbjMoyyd
         KAkmYqfYpRvJoyfxGpt0Rs51bpQ4PhUe9K/Z2eD4ZETWHgFNmQquaqH6Mh+72G8OtCEH
         SYKA==
X-Gm-Message-State: AOAM5323ROHzJ4Dfo4xPFjGuIDu39EDq54w4FQUsvrm11KQdeOPH0R1L
        FtPmqnwRHquqmDL0LWdNpAeI9/6HxEpNBQ==
X-Google-Smtp-Source: ABdhPJxZsvaaCB3HB88Tc2ayeoGSTVetWu+H1jgGXAw09kMqQRZqgny5oAYe7hBrIH16bqwzLTg3Rw==
X-Received: by 2002:a05:6830:1ad4:: with SMTP id r20mr42902072otc.354.1609467444669;
        Thu, 31 Dec 2020 18:17:24 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l12sm3436935ooq.22.2020.12.31.18.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:24 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 38/47] completion: bash: simplify _get_comp_words_by_ref()
Date:   Thu, 31 Dec 2020 20:16:13 -0600
Message-Id: <20210101021622.798041-39-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 3fa597ce71..0510010ff6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -399,30 +399,12 @@ __git_reassemble_comp_words_by_ref()
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
index 50b7b04021..363d8817af 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -40,23 +40,10 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
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
2.30.0

