Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E8C2D0B1
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B784721823
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJJz0Vdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfLDWD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:03:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44498 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:03:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id w5so354152pjh.11
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wQAWHVnUI9MZ2leYUkYV6h6KgNbJhq8DQeyyJJG6pZc=;
        b=aJJz0VdiBai8uCYaWeq8NKjYRaRATUZmOF+QPwcHJUv/xoavN9TcrbQctCE+WGbFuD
         I+CgMMXbKZZLTIErJ/CnIE3BdhDhliIh0lHhuajx2E0UEHeWMNhdiL8L4EHsvKyovOp6
         UvbwydVvXuaaxpVby08ZmwQ8ouuD3sWY+GyBo/a77oPpA3XLuI+T+jmFlyY/kl2o4pyP
         BlfXLJaybEo8tUOSJXNkRs4NiVeyCDT9BcuZrKF0EWXulxy4hr4z09UrNuUDrcaAbSqE
         EkNTWnIscbJao+hj2fMNGZiEAFVyQ5Q4Al+BEHtAJo323PByOfEOSjwMfAt+1NmAF9J6
         M8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wQAWHVnUI9MZ2leYUkYV6h6KgNbJhq8DQeyyJJG6pZc=;
        b=VBlx24kKBkRb6TWHJoq+04VQM2FKie5QLjzB3jP8PrL5nGh6QD95tWnyMduN7gOnXj
         ZBAET0vDD9DZOhgSlAh40xjKd7NNOfT9PEoL7BNyq99Gf+t2lQAkkjOBbnrBaVu1covd
         +VbbupmahOA2kEC9W2BENjOv6/4DKXKzUoQvgcynFeswDlPkhwDSvrs9a3LRNylip8UI
         NY0MBJ/jmlj9o1bvTr4UksdoUm+pYqr8JiEENP+0NJue1ZfeIJL7/ip3/V0+tuXaVOG0
         MOVO8qn7VdTtW2/9UMUCN4c0puRW+fMolnrLORvEvx8HFN7Ls4q/IsdCQkAhABrZVyY+
         XyMA==
X-Gm-Message-State: APjAAAUOpuQst6bw0oR2qihVfZaGrQHNW0Ga79vXh9kSnXkNNNXnRXJ4
        Z5480V6H7+xSlTOleAefNBTbL5RV
X-Google-Smtp-Source: APXvYqwDvMPkzgBRNYefUxv6rARn58hUxkbWopNeINiYXhBoSgfMq8E/Gvmmwn5JVesM3bDyi8A8cA==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr5566167plo.205.1575497004520;
        Wed, 04 Dec 2019 14:03:24 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 20sm8194268pgw.71.2019.12.04.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:03:23 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:03:19 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 3/5] t7700: replace egrep with grep
Message-ID: <c34477a5a9f5c48c20046abd6ebee2064095bbe5.1575496684.git.liu.denton@gmail.com>
References: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
 <cover.1575496683.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575496683.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The egrep expressions in this test suite were of the form `^$variable`.
Although egrep works just fine, it's overkill since we're not using any
extended regex. Replace egrep invocations with grep so that we aren't
swatting flies with a sledgehammer.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 80ded48088..bfef5888a2 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -30,7 +30,7 @@ test_has_duplicate_object () {
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
 		git verify-pack -v $p >packlist || return $?
-		if egrep "^$objsha1" packlist
+		if grep "^$objsha1" packlist
 		then
 			found_duplicate_object=true
 			echo "DUPLICATE OBJECT FOUND"
@@ -135,7 +135,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$csha1 " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
@@ -152,7 +152,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$csha1 " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
-- 
2.24.0.578.g4820254054

