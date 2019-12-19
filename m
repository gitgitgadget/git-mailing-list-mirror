Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A8C2D0C0
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40EA206EC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax1vBhcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLSPJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35807 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so5204826edv.2
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7C47W0M3UKRNXTi1T76WKs+LRU4jvXYIJGw9CE+aczk=;
        b=Ax1vBhcIxDSUSqVHBb2q/6XFfYvat4wEjnxEVqehKRDplTJyPl04KmdnRSpQzzxI+7
         NMX5LH/dnsHrwwmfjKgUvo4OY3tOTgMOYSHLhV66KEmtjjLlE58b19pwmQdVDABnHltU
         tcS6yVIN8Akf4PHRR8oSK7bsSIyWQ94W2OjpAgH5bcOgUoREn/YzMIncKBZ9/UGKZ35a
         p4x1YX99fSM+VcYwPSRXjz9/oUi8cLQFuAEC/pSCKm0KOx1xSZIm93BdGDDB6mlkDZoH
         uI0yARNhMj1u7jfogOR7uCA/0YoMNDa7V7FRY4MOAaE80yszDLsLHpI9jmB5jKXKBMqW
         1aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7C47W0M3UKRNXTi1T76WKs+LRU4jvXYIJGw9CE+aczk=;
        b=SIEM1UMZSZFGm0f4ZpMwKTtfm4aCuFAoim8oUfrJh5uVTuKzdPWDp6YX1gAr/jU+4/
         jHu4j5EfN+Gw2b3fuuVkMWkUBhmBFQm+evGuUbMJvX8R4hzBz4x6bADjE/RzfRV+GKVH
         zWUPGudfZwwVeryBkHXP5trP2it9f2OQEqumUvkV8hYcbkdAT0i54igCGkuUf8JKaRAJ
         j6PQETeeVJsit9z364XIS4+FkDbmGhZDgBSL12zYCjCGAhn1+cIbiSQKzBBLLlJgzQfI
         X3zKPYTJSvRIDeukXd/qwKDzF7wMqPb2zgX6PAWTvKIZPa+GVuJ3KYWsfaicYn4JsJik
         RyLA==
X-Gm-Message-State: APjAAAXOXuvNXpMwk38HbTZMu1dRAFNMftTyMO83gKsaeracqoU5bjQV
        9jvHLiuM+H1p7mOXQDh6ADZ7b1cS
X-Google-Smtp-Source: APXvYqwpVHpFPEWA0FGVpZZ3b0sXNHw1QsnTDwYOyJgf9oF9aqRtMPDc56JjbgaAnVIN6hLEdx+gdg==
X-Received: by 2002:a17:906:19ca:: with SMTP id h10mr10014239ejd.282.1576768180361;
        Thu, 19 Dec 2019 07:09:40 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/6] completion: simplify completing 'git worktree' subcommands and options
Date:   Thu, 19 Dec 2019 16:09:19 +0100
Message-Id: <20191219150921.5889-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.1.982.ga4d4aba446
In-Reply-To: <20191219150921.5889-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191219150921.5889-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion function for 'git worktree' uses separate but very
similar case arms to complete --options for each subcommand.

Combine these into a single case arm to avoid repetition.

Note that after this change we won't complete 'git worktree remove's
'--force' option, but that is consistent with our general stance on
not offering '--force', as it should be used with care.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 55a2d3e174..643272eb2f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2985,29 +2985,15 @@ _git_worktree ()
 {
 	local subcommands="add list lock move prune remove unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
-	if [ -z "$subcommand" ]; then
+
+	case "$subcommand,$cur" in
+	,*)
 		__gitcomp "$subcommands"
-	else
-		case "$subcommand,$cur" in
-		add,--*)
-			__gitcomp_builtin worktree_add
-			;;
-		list,--*)
-			__gitcomp_builtin worktree_list
-			;;
-		lock,--*)
-			__gitcomp_builtin worktree_lock
-			;;
-		prune,--*)
-			__gitcomp_builtin worktree_prune
-			;;
-		remove,--*)
-			__gitcomp "--force"
-			;;
-		*)
-			;;
-		esac
-	fi
+		;;
+	*,--*)
+		__gitcomp_builtin worktree_$subcommand
+		;;
+	esac
 }
 
 __git_complete_common () {
-- 
2.24.1.982.ga4d4aba446

