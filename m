Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25671F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeAaLHG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:06 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39404 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeAaLHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:04 -0500
Received: by mail-pg0-f66.google.com with SMTP id w17so9755057pgv.6
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bu9SUVd7bQqEtoa9vcQ8WTrm3EzAD99LZq3EXiQjDWI=;
        b=Azjv/nvoyZRnNYAe3wFRRz81N/z/JbDEn1YEoS5twvX8U3/nqaPIKIwWJDFltvBcEY
         z9dJTNURimXUbv/eePoUHCsS3MDZFJMD97pmUIH2+VNljmeDSTSaBcs38v4Bt+9nx11j
         kHG/fN36nZZp1tzjLJ5wkCmhotGSAeVUHpvIW74SH8f9ZEs00jAvtLzW8lOHOYDB2GKo
         WKy43gU/srAt6JtjkuMEimmUaKwmH44KBKCjboPICYCb21G+9iSPxEmUURajpZq67dX8
         P74/WldZwiV4TsGBP8zlO6L8b6XA87zILHMmGTltmwCtiwCq60ovJS66fZCIYJO4SW6M
         Me6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bu9SUVd7bQqEtoa9vcQ8WTrm3EzAD99LZq3EXiQjDWI=;
        b=SMhFbs95KlnHOO5q7X5ekoMa65I7CNigRqN/bwXxAKmKnOZwovLpkuzwpaZYT7CICh
         02Q02CcNqsQ3SgIgmBrLuyxdJCkdWBjeFJ+v8WE3gYPkF2NIYWGDz3qW4l2mPwQTg/6B
         UP/TPwjd16/tpdgvSbYAfxGp2rhAXYf0DiBRssA4UCmf+yZ7weMz85KnEOAAvZ9HVO7H
         br6e8JO9M4g1y+vLJmYS7I+GmbimaLnfSZqHtUpxtIzKXtZrPu5ZgvCtCBqVt0McRjUq
         eZHgLKGWQC5oZv4yLXR2XsuD7MSVuZFKN0qAsWYGszHUSmgVXAowsknL+WfFqNvbje2+
         QA1Q==
X-Gm-Message-State: AKwxytcvZWPca0sRqntcGmvj8NVLskMFkp6p3ju13gZwYHlcvvkOj11S
        rh6iYDsIuQK9GHFQOgNIBjrWQg==
X-Google-Smtp-Source: AH8x2277m+9RH4/AHwOBFTXjqqDdIuj2z01huF5D48YPiKb0AtqxN4sbmh72bj9Ojx3VPRGvhYexvQ==
X-Received: by 2002:a17:902:57ce:: with SMTP id g14-v6mr28017563plj.348.1517396823424;
        Wed, 31 Jan 2018 03:07:03 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id r26sm43425831pfi.72.2018.01.31.03.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/41] completion: use __gitcomp_builtin in _git_config
Date:   Wed, 31 Jan 2018 18:05:20 +0700
Message-Id: <20180131110547.20577-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--blob=
--bool
--bool-or-int
--edit
--expiry-date
--get-color
--get-colorbool
--get-urlmatch
--includes
--int
--null
--path
--show-origin

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8bbe94a94f..1713a583cf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2238,14 +2238,7 @@ _git_config ()
 	esac
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--system --global --local --file=
-			--list --replace-all
-			--get --get-all --get-regexp
-			--add --unset --unset-all
-			--remove-section --rename-section
-			--name-only
-			"
+		__gitcomp_builtin config
 		return
 		;;
 	branch.*.*)
-- 
2.16.1.205.g271f633410

