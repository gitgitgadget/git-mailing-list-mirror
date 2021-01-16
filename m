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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3505EC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3482251E
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbhAPRGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbhAPQbM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F9C06134D
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so9881149wmz.0
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wbs94HxbzEi95MxB427NzuZbCukVNphd7YJHAG20aK0=;
        b=SeaYm0B92P3CXOW17EYH/VQpkGXDr7RR6pqoPlfrktCFQ3GV6WLCemcZAGkCM7mF2y
         nm+zCjGwAxZ+w/Rd3khwiJAfGog+rwZkZDK/oZsJ7GQD9pvKT9tLtWLDwIqA3zDWVLVl
         jOY2f2QbonszCl10gLvh2RZADFDrlxKjygIAfnMQU0Odcyw5ElaVBwWiYb9MoBe67fw8
         wF8jTBEmpcCcSfspoxyPqcTiTRvBrFHfKxQKceo2GIPM8dgcL9IK1vPWGN6fQng375eJ
         IF96AKX6vZ5d8bQSsagW3iVJqwAIX8vrPGciEwxdhCaqq/TnmzlC9XIN3qcTJANBXBUO
         9Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wbs94HxbzEi95MxB427NzuZbCukVNphd7YJHAG20aK0=;
        b=FQok/6XAj+GFDivcNhqNQvvfDhP6bxFrR88SzpFx3gJqIBV/FC27k26kidSwyvxwrC
         lLx8+wzBPrR1feYM9/2+EJoCAkQu+3e+dMIJ5zLObKJXk+kXYFRPN0qLVeS7PKCKkyOJ
         HtTO20C3BTda0bZMAvN5GZMQfd9/OvHeXKlZXioKy1t5CNf4IlbFmqEZIc+m6c0bR565
         rwBj/eOy2zKTRCiOBt/dfrZIwuxaHLHACoQVPHsp6+jK1NYgZf+9iSL8Racs3DwgtkEK
         TeQbvHOT0p+g/jHE/g84hXuqTPULR9jLzkj2d02hI1TkIjWvVwehKPhF26I0YL1dlqC5
         BKkQ==
X-Gm-Message-State: AOAM5334aJo/837KIyHGbNaEMnT4/huqMlc7EiOJJFz51Y45IH+tgypl
        YaQAC54RqkBjkb8nIvQGNSIWoH9MqlC8WA==
X-Google-Smtp-Source: ABdhPJz/JH6S9liRUXiwKSgSQJFZzYXfHEeWpa3//NGAWYAvXbAWlrsflF1LH/+0HUrIgyVINoFtNg==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr2261881wmk.56.1610811366917;
        Sat, 16 Jan 2021 07:36:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] rm tests: actually test for SIGPIPE in SIGPIPE test
Date:   Sat, 16 Jan 2021 16:35:50 +0100
Message-Id: <20210116153554.12604-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test initially added in 50cd31c652 (t3600: comment on
inducing SIGPIPE in `git rm`, 2019-11-27) to explicitly test for
SIGPIPE using a pattern initially established in 7559a1be8a (unblock
and unignore SIGPIPE, 2014-09-18).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3600-rm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..4f7e62d05c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -250,8 +250,8 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
-	# git command is intentionally placed upstream of pipe to induce SIGPIPE
-	git rm -n "some-file-*" | : &&
+	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '
 
-- 
2.29.2.222.g5d2a92d10f8

