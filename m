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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69DC56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C3720781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVF5unyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgKJVWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbgKJVWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:04 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD6C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:03 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 30so104377otx.9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgROHsOqiiHds70f46AQaTOFp80zriEFNciFNyN8yaU=;
        b=cVF5unyfDL+o1w6/nWNVDgZPGmcpdKgmtjM84NaguqvsDNudSr9RFg7Kul8Za2flud
         5BjrmgnV5sSDBaFkpqVumG2cwe0GnqaSDAfPfiIafSLiCiHFR9Q4jtK92f4E8H7P9Td7
         p8sC8/UeuJ6n2APy8PnuX3pO/jV5w2ynzgsDTITHyPtuWMXLJu4fBHT+4uiYokNCsyRx
         kRS9udfXZNFZRWowj2HaP9gFg5ny9oeRWOjWDgJEXnPrMtNjnyIqGyAST9hFtxJnQR2T
         d3w8jYUcIkLJ+ap2DeJTOw+hLmMkYH49EqxM3Wo+vKqFQMnKH6DgjA1ql/rDeIPayqPu
         9XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgROHsOqiiHds70f46AQaTOFp80zriEFNciFNyN8yaU=;
        b=ErBDvz5AouyxKep4hXDp6Uuly9hPopPzuZUpST1AgZzAqLZtdVKuXOPUXEwDjV6DtX
         LvaGhxNxwXGZU1OoFVsAfju6zjCaDVxYpnl8duTWV2VJ/clyNAKp9OEwJCl1kC3L7tVd
         R9p3A0I7cY8Tqnixcdxy9bXt9cHDZ8JDUzcbxttWqHU2SkM+4sucSLG+9UmGKdKtXC6h
         gBbX6aZYwXeIqVOv8+O3SCTa5TbqAM8iklJX0iKDBO4XpeGbN60hX3YJydlhlwWP5gHz
         c1qbh+FviOZc6Ctw9oZU0sk5p/LobbZiRY0Jlb1G8ylUX43uui/KBHGnR8A/fbmXM/dE
         Ir4Q==
X-Gm-Message-State: AOAM533HENu7CyT35SCUcc+vF7vTtkcrOv/gD1WWtSikfPShn08EwNeP
        quJ72AtJMYlxjtLhCMgYCKbdUFvsDcNPiA==
X-Google-Smtp-Source: ABdhPJxKs5G9pSynJNEqJdaye/MH4woRJiPtoXF/GPcaAXnP4s4y3Y9xtNDY/MiVx9QVTE2lywxkMQ==
X-Received: by 2002:a9d:46f:: with SMTP id 102mr15815937otc.293.1605043322237;
        Tue, 10 Nov 2020 13:22:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j23sm47135oos.4.2020.11.10.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:01 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/26] completion: bash: refactor __gitcomp
Date:   Tue, 10 Nov 2020 15:21:22 -0600
Message-Id: <20201110212136.870769-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to chunks of code doing exactly the same. There's no need for
that.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 52 +++++++++-----------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3f684cfe59..8b4308fc99 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -325,44 +325,28 @@ __gitcomp ()
 		return
 	fi
 
-	case "$cur_" in
-	--no-*)
-		local c i=0 IFS=$' \t\n'
-		for c in $1; do
-			if [[ $c == "--" ]]; then
+	local c i=0 IFS=$' \t\n'
+	for c in $1; do
+		if [[ $c == "--" ]]; then
+			if [[ "$cur_" == --no-* ]]; then
 				continue
 			fi
-			c="$c${4-}"
+
+			c="--no-...${4-}"
 			if [[ $c == "$cur_"* ]]; then
-				case $c in
-				*=|*.) ;;
-				*) c="$c " ;;
-				esac
-				COMPREPLY[i++]="${2-}$c"
-			fi
-		done
-		;;
-	*)
-		local c i=0 IFS=$' \t\n'
-		for c in $1; do
-			if [[ $c == "--" ]]; then
-				c="--no-...${4-}"
-				if [[ $c == "$cur_"* ]]; then
-					COMPREPLY[i++]="${2-}$c "
-				fi
-				break
+				COMPREPLY[i++]="${2-}$c "
 			fi
-			c="$c${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				case $c in
-				*=|*.) ;;
-				*) c="$c " ;;
-				esac
-				COMPREPLY[i++]="${2-}$c"
-			fi
-		done
-		;;
-	esac
+			break
+		fi
+		c="$c${4-}"
+		if [[ $c == "$cur_"* ]]; then
+			case $c in
+			*=|*.) ;;
+			*) c="$c " ;;
+			esac
+			COMPREPLY[i++]="${2-}$c"
+		fi
+	done
 }
 
 # Clear the variables caching builtins' options when (re-)sourcing
-- 
2.29.2

