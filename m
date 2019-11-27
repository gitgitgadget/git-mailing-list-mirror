Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B98C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0712082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaI0Rugh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfK0TyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:54:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38511 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0TyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:54:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so11018323pgl.5
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7N4J8rstHNCXMeIkDde+BaZpUa1sAaV3I3B+UrlLPs=;
        b=YaI0RughtqgmxCRgw+2HLrC8X07bYwXsVpvmaN6Y7NiE7fR24Hb9bF4Ce2V4tWHhmI
         yS3Mmi6y7j7M4gtf2JvBJZMq9WEML6TOlRKntNxalGTfN+ktTRIh2My4cxgKGKfczDPn
         Oj8lylcVD0li4dU8tL/09gUDY0VGjmx56QN8vq2cPEZgYeqJwgiY8V/83lZKHUqjz+Sf
         HjhtQKrSgWdc/+/uTGI9Q6YkjXNItIgWJQHK8azWKkNXAHvsJ5RVXLBfsoWRsOTIT+iM
         FDGD45I/L9MWra3uBj6yys21JyeQZqM4Jvg3rPHsKjMnaHFlvB66jwrRnk1/qaqV7Yno
         OBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7N4J8rstHNCXMeIkDde+BaZpUa1sAaV3I3B+UrlLPs=;
        b=lGvULQqhVKYKMvrclzfdGJWosBGEqqCvPMnNP43+Xx87YI76L9dtEqc7xsyM/OdMEu
         s1htrpBkMm6l8bccAimuGu8YTGc5O/fU3xiDIO6w2KrFYapxpBNGy4MeMyr/79BfsG/+
         Oxo4QqeN9MQP+m3hM9WeOQhZFHQZmu9bqBzd5p44vzPRXk1z+/A1xGkzfdKFpMgT/uIl
         MTddCkcHX/KEqeTTzI/RrlOONPTgPQDm2PTSO7eQQ4tkEJeDNunJI2DgEIpAhBY/EZhR
         FDFQKbfrtA4IhbiiDjjXAfUFL5AJyj3dTUUs6Kv4CMv4K6XlvkvjFHfEMdx0j5Z2sW52
         uhfw==
X-Gm-Message-State: APjAAAXSUzDw4zK/q7vLhBe28C4SvaGo8gFxFdfeP0oNHX4mWrycXLRy
        eBY7zapIIHnWCjqXTwsXWFl5Ef82
X-Google-Smtp-Source: APXvYqwBOhIU4BdKvrlP1NyzevjwDLrhxcMgv+2cFlgoRfzhlPxWkir+RhlBMXEyIIqMtCjbRZYwMQ==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr6662315pgr.377.1574884446299;
        Wed, 27 Nov 2019 11:54:06 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u20sm17158661pgf.29.2019.11.27.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:54:05 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:54:04 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 26/26] t7700: stop losing return codes of git commands
Message-ID: <1f6d9a80ad45fd9f51c8cffe9ce3721fce9b80c0.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1edb21bf93..d5cce7c06f 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -48,14 +48,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git commit -m initial_commit &&
 	# Create two packs
 	# The first pack will contain all of the objects except one
-	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack &&
+	git rev-list --objects --all >objs &&
+	grep -v file2 objs | git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packid=$(git rev-list --objects --all | grep file2 |
-		git pack-objects pack) &&
+	packid=$(grep file2 objs | git pack-objects pack) &&
 	>pack-$packid.keep &&
-	oid=$(git verify-pack -v pack-$packid.idx | head -n 1 |
-		sed -e "s/^\($OID_REGEX\).*/\1/") &&
+	git verify-pack -v pack-$packid.idx >packlist &&
+	oid=$(head -n 1 packlist | sed -e "s/^\($OID_REGEX\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -134,8 +133,8 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$coid " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! grep "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
@@ -151,8 +150,8 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$coid " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! grep "^$coid " &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
-- 
2.24.0.504.g3cd56eb17d

