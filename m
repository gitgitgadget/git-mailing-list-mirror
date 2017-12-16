Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68161F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdLPJEb (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:04:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35213 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbdLPJE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:04:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id q20so7252846pgv.2
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 01:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6BLL0dm8HF0AfKyKErVzELDp7VG5INonrn7N/DxkEVk=;
        b=X9YouGXN0MJlnwmU5S+3ZtTdSjjmn1Ajb7+aqNd6N9/WAB02OxoH1XJSearABnuNTb
         ci25LmBHrEk6IOdX+MVQanw9N+nwnZznJlmzmEB4WTvMRLQJtQS79NZPXM+WasUjqOY8
         Ah3MuMkcGNGy0HdKz1HXX/gSn4b/pin48Ht2B6KOABl49B0VXHv6Itnf+XyUVXrJRhXg
         T6PNuPUmtv9/70bUQ6fVfJPXehWFWSzOhR09k7GQALN/TO8CaNEmDp2SSsJGNDw/SWxZ
         MD0m42a1Fo+K5tDdoNNgLBXuLraY4j4N4NMXtUSzoHPtphXf9d3FZb56lg81RrujBlNb
         s9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6BLL0dm8HF0AfKyKErVzELDp7VG5INonrn7N/DxkEVk=;
        b=VmX8uD74PgKzsU21iGM7f5bFS2KKXMctHv/1m7KTHC23gKlQpJgaqhTBUGlISLVDO4
         YPLXtExsQvO2ny4SMggUL1jDls/Cdc4CaEMkdMmDIO0sTtf9qYUBPNFcirhZoDU8nLa3
         txsZqhXlQ94DJwDtSC/sC5PP7V9z3LLxEK/h7sIxYoQ2/X0FyAvZC2U64z2cPufr0pXl
         Xf8y6MTVj3JAAYSd+Kv1Aps36pNesyWZ7a9nthh5zcsdLZGHxRoWSvHzcqA+kuYqkOrb
         O8Bl9X9k97yr/29Dcp1YjP8jgvk4IXCFxDBIbQjGvYIY8Le/EMgJm9FLl8wf2fBfzq4J
         PK1Q==
X-Gm-Message-State: AKGB3mLIogkCO+FoL0nJrJi/BJjG8XVb0uiavEu/INHreCtLPAI4xjZk
        ps16DK8Wd0K9WSjak+lOe+4v29Yj
X-Google-Smtp-Source: ACJfBov9h6CcZHqJHQ2OH9xsaANaHBlR3dSKnYCzr2yvy/ViPLwcfizmqfhxkRycPk8+yoqDV0ZFrw==
X-Received: by 10.101.74.8 with SMTP id s8mr14188949pgq.259.1513415065478;
        Sat, 16 Dec 2017 01:04:25 -0800 (PST)
Received: from localhost.localdomain ([117.249.248.104])
        by smtp.gmail.com with ESMTPSA id u68sm15775852pfu.17.2017.12.16.01.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 01:04:24 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/3] rebase: distinguish user input by quoting it
Date:   Sat, 16 Dec 2017 14:33:18 +0530
Message-Id: <20171216090319.11902-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
References: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
 <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a299bcc52..0f379ba2b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -477,7 +477,7 @@ then
 		;;
 	esac
 	upstream=$(peel_committish "${upstream_name}") ||
-	die "$(eval_gettext "invalid upstream \$upstream_name")"
+	die "$(eval_gettext "invalid upstream '\$upstream_name'")"
 	upstream_arg="$upstream_name"
 else
 	if test -z "$onto"
@@ -539,7 +539,7 @@ case "$#" in
 		head_name="detached HEAD"
 
 	else
-		die "$(eval_gettext "fatal: no such branch/commit: \$branch_name")"
+		die "$(eval_gettext "fatal: no such branch/commit '\$branch_name'")"
 	fi
 	;;
 0)
-- 
2.15.0.531.g2ccb3012c

