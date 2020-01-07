Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49963C33CA3
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21369207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnDOwVVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgAGExh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39703 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgAGExd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so41601475qko.6
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1PpaJmx0aLNyY962YW2ZoEbKD5ybsIavN1/eoSLdJU=;
        b=HnDOwVVqYjpi4RdZSou5bI+uvFWtnbo2CplmkXKlaKNLvpSrMyjfFZM9JNmw8bbxMj
         e0uRWtZwH58yS9WP5L746pT02X9jkaVEz89a7Q5eigaddKgRbYvEDJm/rVFWiWYwRgjQ
         Tfo56lqAgpDvY9iGFFkXYaEm8PguXMwwif78j9M9eYsjZJXJ3dP1pgu0h/q8Zkrr0hsI
         pn83uLNg3bddqGs+OnRBKAVkOxqCOJ+nG7/SCQd0jKRl+IMXy3pD7a5k+MDk/8Zv7IcO
         Ksf7sCAEt3MEAPtUr5mITODMB/0bTjvAAUBnIEIYcDZz3842CJzi1w3rmkbmOAHQzITf
         /W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1PpaJmx0aLNyY962YW2ZoEbKD5ybsIavN1/eoSLdJU=;
        b=PgDKIX7gP2aQ4jvAd1mIJhULmHxIBbXrhC+g7W/0rIXL6gVAiYitTjG54ReOSPFFxx
         YVIsYLLw5Bs9U6pR15tiYITZHlL1t/jPzoSqVOrAGVaJ5Rp2zEltc5rR0YuNRKsE/BT6
         I/S0UAZfckQYA+E9QW4ifRCSXoLYxTu2i8PiZW2cCvKSFUO8jlmTtNmwDZ60qPoPtLMC
         Y1zBS/6b+MoB+Bi7EBXwfCa9lZKy/UMZivuDaaet7/kA/1m/nPBNGJu0KQbt7bT1RqLJ
         ue5aKLN7hYSUf3g8xE7AC/v0vISo91a8t5XmcLX8iwLyKPmYPp2Vk6GYiJCJNiRRRFgs
         U2Yg==
X-Gm-Message-State: APjAAAX3wagixrtVjfhndcuXRvMgAKyJGpvwAYD2Fl/k+RGBBUJ5xbUL
        r3TE23vn/HpNVssr8Awx4G/3o7v2
X-Google-Smtp-Source: APXvYqzTGAiFPyBprVGne3G7XOk6oTEO9flvZUQ9QFqKJj7SGL62ldMu7lwHLBBuwRrT0wTsGsoefw==
X-Received: by 2002:a05:620a:9c9:: with SMTP id y9mr52220064qky.397.1578372812392;
        Mon, 06 Jan 2020 20:53:32 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:31 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/16] t2018: don't lose return code of git commands
Date:   Mon,  6 Jan 2020 23:53:03 -0500
Message-Id: <e09a70f6ca9ec922f6da47f1e978de622f81698e.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix invocations of git commands so their exit codes are not lost
within non-assignment command substitutions.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 687ab6713c..caf43571b1 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -41,8 +41,12 @@ do_checkout () {
 		test_must_fail git checkout $opts $exp_branch $exp_sha
 	else
 		git checkout $opts $exp_branch $exp_sha &&
-		test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
-		test $exp_sha = $(git rev-parse --verify HEAD)
+		echo "$exp_ref" >ref.expect &&
+		git rev-parse --symbolic-full-name HEAD >ref.actual &&
+		test_cmp ref.expect ref.actual &&
+		echo "$exp_sha" >sha.expect &&
+		git rev-parse --verify HEAD >sha.actual &&
+		test_cmp sha.expect sha.actual
 	fi
 }
 
@@ -162,7 +166,8 @@ test_expect_success 'checkout -B to a merge base' '
 '
 
 test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
-	git checkout $(git rev-parse --verify HEAD) &&
+	head=$(git rev-parse --verify HEAD) &&
+	git checkout "$head" &&
 
 	do_checkout branch2 "" -B
 '
-- 
2.25.0.rc1.180.g49a268d3eb

