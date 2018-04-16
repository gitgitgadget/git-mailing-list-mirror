Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FE61F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeDPWlt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35849 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeDPWlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id q13so26830009wre.3
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aYV3TyCfN4m4AmJuZIzDLwjQTCDeZRYVlywu57hr78c=;
        b=We9b6/6JGZrOXuO7bKCFWcmyhhf8uLHH5o/LTgkSTkZNJXwol+1AFqwfuljbHfn7+y
         gudtBErRIReMlH1vC1rR+Dyj0o84pRyK4fUhfr2rqKSCeMhcqI7CXjUcNrBUz/dlnxbd
         OyyboKSQz8MyNUnAs3IKpkbO719w3nTIHUQ+rrkIyDdX1dOwdZMF4nIcFn675fWik9nI
         Wjk3ZH3NcLdYLGsGCjaF/UheoZPtvMRyPyb8UN6YWTd5fa7uMLf5xI8omxx8hTcS825B
         bkE9PCBhCN/IRdOeoUI0idd4TTSm1sAPSKzMRFRJYOxZbIR5qOIp/PsDUUj+dlrbgkQe
         0UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYV3TyCfN4m4AmJuZIzDLwjQTCDeZRYVlywu57hr78c=;
        b=NhFVMEkC6m2hHSdxSAXGCkhfZkSEPi5sVrQv9ja4xxlFkX6plol+frDPyX8ZG2VOHB
         b+FvwXeWPyfG1drw+Su8EcN4lXw9rLY+WwmMuVhfdTGzpSt0We4tqIm/90IId/XJENf9
         ZcNCSPMF+9cwfcdFiPGrAB2Q6K7yVEqwMmHyzYwrdPw6U4yPRMCq643SlLDzDoBOnBuz
         7EavQUam94a7RyZkIuMk1v2m6prmbYUDir1uZhUvvpRIs8n9Q9LntnkyVeaBT74D9yPD
         zL/HJfqsiL9p8R2YND5fYPNf7aWqf9gTrcJs/DhQ8IxGGx1stPcw/I/6jls6KyZ6twET
         LzBA==
X-Gm-Message-State: ALQs6tBPGQM86phjgv3h6c/t5ujR2+tsC5It3/KNS8i2R+Z60PG2GojB
        vUOwvjYsRGTNZySf8cFmF8SBZw==
X-Google-Smtp-Source: AIpwx4+vZLdpjlp1atCjFqu7m/AjYGhwEOnK2wC2AQiuwh2A0CwUZn2KNF3BAhXQINd9RifPICgb3g==
X-Received: by 10.28.141.138 with SMTP id p132mr67942wmd.51.1523918483995;
        Mon, 16 Apr 2018 15:41:23 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/11] completion: simplify prefix path component handling during path completion
Date:   Tue, 17 Apr 2018 00:41:07 +0200
Message-Id: <20180416224113.16993-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time 'git -C "" cmd' errored out with "Cannot change to
'': No such file or directory", therefore the completion script took
extra steps to run 'git -C "." cmd' instead; see fca416a41e
(completion: use "git -C $there" instead of (cd $there && git ...),
2014-10-09).

Those extra steps are not needed since 6a536e2076 (git: treat "git -C
'<path>'" as a no-op when <path> is empty, 2015-03-06), so remove
them.

While at it, also simplify how the trailing '/' is appended to the
variable holding the prefix path components.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 36d3c6f928..72cd3add19 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -385,7 +385,7 @@ __git_ls_files_helper ()
 #    slash.
 __git_index_files ()
 {
-	local root="${2-.}" file
+	local root="$2" file
 
 	__git_ls_files_helper "$root" "$1" |
 	while read -r file; do
@@ -406,13 +406,12 @@ __git_complete_index_file ()
 
 	case "$cur_" in
 	?*/*)
-		pfx="${cur_%/*}"
+		pfx="${cur_%/*}/"
 		cur_="${cur_##*/}"
-		pfx="${pfx}/"
 		;;
 	esac
 
-	__gitcomp_file "$(__git_index_files "$1" ${pfx:+"$pfx"})" "$pfx" "$cur_"
+	__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
 }
 
 # Lists branches from the local repository.
-- 
2.17.0.366.gbe216a3084

