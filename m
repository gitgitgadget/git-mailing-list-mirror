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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D2EC433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE0D20867
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL2RJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 12:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 12:09:22 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB68C0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:42 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id d203so15242749oia.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYMFb60oj1ozuA3IBJgnIIJ4JjKCmOzQUHPrcHLsidA=;
        b=tMP838FRz5wBmz4nfZYf1KKQG/Ms4k7Os90iF0TgLWNHz1za6y/NjDhgc0tufzHydh
         XTt5V9g6BQtobeyjd0Wd6ps7b9HY2HhL45ogjgTYIlYj5FJQ4/ou6Wodrpx67RYVvySQ
         fT7/i67u49mkVBtKLQsG009d4Slj7hbqOYgiq6Isr6Boeu3Z2HJfhrEi8t1/yqSTmvrr
         ytNScXHw9ivhRjm+E5CSVmGcywisEv6xaoyUtbkkCdCV4AqIcJmCHg18lXAZO1MBKBiF
         Z9A9y4+PLwzt6pnSlJnjVtxlWo+yanDfPDqkKLQLSrY/wIBhYfYkhyFm7hG0xFar8mAl
         KQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYMFb60oj1ozuA3IBJgnIIJ4JjKCmOzQUHPrcHLsidA=;
        b=R0uWdzAxgQeNCPIo/mtS3CLZyKe6k8S2X+BQww6c/3zoOdJChU7bjm1sa2IjDn0Tud
         zLdFpfk4LZ9XMCmacxvEha9hWlcl8yjt83AZ9r9+BlIPaXMGf6mOUJqoK2bph/BdlO0J
         6Q16kGvP04Q92kyDzd5pSYfiPsOCoan5cx1fyiBAYb0Ok1YJ/OUW82Zy7sB1OxVDtUSx
         YeNMiQIoa0eLVno6olFmmk0t5bMfwFY2bpxhAD5S58EItrMUDSwiy+h4AU6a+zKwkiBd
         iI6dJzpVjEAa3mGT0ZqOVh5At4ohBSjFgvZNyRh92nzUuYiyewe7SCDG8i4KP1zXV9ym
         CeEQ==
X-Gm-Message-State: AOAM530sbE7dgR0MWl5EXgN4upEhwImjYOn6KuEmnNWhYCllvnQLTjyA
        Nz3vaxswugXqHCjDwG9+3+fJ3C+N/XvyhQ==
X-Google-Smtp-Source: ABdhPJzpVAJGjKmr2UIVMn/Psf5RWRLuESw1w7d3umVHPq7dD5x7squhYtD1j82Ipmf6WdIh8/9lGA==
X-Received: by 2002:a54:4185:: with SMTP id 5mr2931281oiy.31.1609261721604;
        Tue, 29 Dec 2020 09:08:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l134sm9574416oig.25.2020.12.29.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:08:41 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] completion: bash: add __git_have_func helper
Date:   Tue, 29 Dec 2020 11:08:35 -0600
Message-Id: <20201229170837.297857-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201229170837.297857-1-felipe.contreras@gmail.com>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code more readable, and also will help when new code
wants to do similar checks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 463a3124da..869c73ee2c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3358,15 +3358,19 @@ __git_support_parseopt_helper () {
 	esac
 }
 
+__git_have_func () {
+	declare -f $1 >/dev/null 2>/dev/null
+}
+
 __git_complete_command () {
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
-	if ! declare -f $completion_func >/dev/null 2>/dev/null &&
-		declare -f _completion_loader >/dev/null 2>/dev/null
+	if ! __git_have_func $completion_func &&
+		__git_have_func _completion_loader
 	then
 		_completion_loader "git-$command"
 	fi
-	if declare -f $completion_func >/dev/null 2>/dev/null
+	if __git_have_func $completion_func
 	then
 		$completion_func
 		return 0
-- 
2.30.0

