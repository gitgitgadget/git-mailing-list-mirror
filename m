Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E8C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiKQLao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiKQLai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FCE429A2
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t17so716030pjo.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYs1XQAtgBF+mAFz2tGoG6J4xF6KDUhA8aM+Qa5N/74=;
        b=Wrsmqc3va9Ty+dnV4O2SVFJG7qwT1uyUsnhqoO8FEyLsvqjO5rTzLcTpZ9qIhCfX7c
         M+ayzqHvhnzNQKHUlBxBCYQbMVdfN6QJXTWeVtSy6Mt3xs1cYx5fQqx7W5sAOIXbi3l7
         R5wsHRNCOfRTvkoTgvVbnmbfuvyWd6031i8vrb8P1dPg7xAXxl58rjjlefDDMDoSrS20
         WRhEYP8QEqNhhaSh4mToILuv3Jago8mWYE2Q78rA9msBjM/TrvSsiAU+bW/X7LrXt0Mx
         qa8j18DnG1p6Ir0DvE5UDawuKpP4XEl6nVUX/IZl2IqZgygnY+eu2+3rcIxJj0nzMd22
         HSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYs1XQAtgBF+mAFz2tGoG6J4xF6KDUhA8aM+Qa5N/74=;
        b=3kVmt551xrjqg1WxlvUbjVqi0QdM5lmRTfaDOOSVBwoqWRp3qI3IeArtqm33cHounA
         mr2aWabx4FVTlh+OffDxDnbrt+J+HWQVDcUvis3ja39yd6EARE4iY8bigZKxC+z6Vaym
         SRlnTfpy+vszmj24ddR3lg+1nA2ct61sS8i2+cSPh4QP+JspMzFUW54+owzTyv3KYX0Y
         b4rwbvQ7gDVQ6p3B7qF95LiffGko2Lq+LSKzxyzZf3+DzWrfvb1mBpXZZbCuFjUmImVh
         vDcpfOz+McmKF7hExbq4mFj8JQex0uxHgalsDtHxbIz3CiOZU+qLshjbOVy5PHjskYPb
         Ceag==
X-Gm-Message-State: ANoB5pk37Ep1CMErA6jJDkw3n0hJmWMEfRLxWt+R+3eP6HdK4rOe6yFu
        yB609zly4Dww7pT7LIvPnnRQJ5EynYKoAQ==
X-Google-Smtp-Source: AA0mqf78upJgGeAcozKeWzDbyPev5P6rI8kndpj6C8dDORF2L8itUaGosQ1FrOqLnAi/DRc3yOo9zQ==
X-Received: by 2002:a17:90a:4f4e:b0:212:84c:1e59 with SMTP id w14-20020a17090a4f4e00b00212084c1e59mr2327993pjl.88.1668684636711;
        Thu, 17 Nov 2022 03:30:36 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:36 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 2/6] t3104: remove shift code in 'test_ls_tree_format'
Date:   Thu, 17 Nov 2022 19:30:19 +0800
Message-Id: <20221117113023.65865-3-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In t3104-ls-tree-format.sh, There is a legacy 'shift 2' code
and the relevant code block no longer depends on it anymore,
so let's remove it for a small cleanup.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t3104-ls-tree-format.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 383896667b6..74053978f49 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -20,7 +20,6 @@ test_ls_tree_format () {
 	format=$1 &&
 	opts=$2 &&
 	fmtopts=$3 &&
-	shift 2 &&
 
 	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
 		git ls-tree $opts -r HEAD >expect &&
-- 
2.38.1.426.g770fc8806cb.dirty

