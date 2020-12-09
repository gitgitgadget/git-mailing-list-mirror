Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0CC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3CB239D1
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbgLIUDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbgLIUDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:03:20 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE7EC0617B0
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:02:05 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so2625221wml.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HYyPIGs75GnN7uh4in8ZLCoKOZWam6NCCaOgCf/FWM=;
        b=QZxunmj/UvM/wk6vZQACT8Vrxq6dZvW9HZUPHNEQWI5x9h4QyJFrCZTTEMV2HY0FAl
         gki4VhjRW9MxiaCix86tPVZYNUQwqxqgL0t8VRLImvJ+ke9V2VDbG/9j8abppRo3citp
         j9MIwyVx2aijeiZY2NZH2QSed0emqEvERRdTjPoedwRewgILgMdmmmbuk3siZYUeJhyE
         o8aPtaDZVv+admNkmAZLENTGXtQN8E0hz6s7vc3H1JAtJ/RdIR4aNZ5QyQG9MRpZTUgT
         ss3/C2zEisw8lIRReosBKOm6C4I0yF55EWi2fiQVUFS43yt9K/0O7sB1aStd6RoKuovn
         +PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HYyPIGs75GnN7uh4in8ZLCoKOZWam6NCCaOgCf/FWM=;
        b=ZPuwXKYQ1qB+vsiG/kcnwEZwFixPXzORfMmOuby9oVo69LAyYAtlC9+YkT6VwzOXh/
         I54rNOzAEPkmDUby5EjPl87UQfawJl4YkBBEz1hTtlPyOiO2II11bvf0T+NOqKIhWKIx
         RdGLlnII5KEuMp/4eWifALTRtQPHQyUP0VRjkZgM6TSgUxpg+C74a76+1KQGyCJAB6HG
         NS3oCjzs0xwXM+OtD892+asUL3dhb5dwbzTVRJt0OPC9p8e9ex5WB1+s14lssCoe6+Uc
         hHZAq/cjTwvo/baRYm2uPwiFdZ6aIjC3J/pkfJwC4MpH1JmDaIkx1xYm0tFkDUdUmt1S
         3N2w==
X-Gm-Message-State: AOAM5309Oi3Wlz2mKOCia3RqCudowKoaKQf3QGbWoFPjfN4wMOXp1l+W
        N2/ttjQnIyRC283wtCXw69dNt88k2B4D+w==
X-Google-Smtp-Source: ABdhPJwdJmGa3+vQn6yew0SRJ4s47utRA1sF1OarhHRo9SnoFrs8LiKLZJhNUBPqpPK0v2q5CWfQ5Q==
X-Received: by 2002:a1c:491:: with SMTP id 139mr4436399wme.81.1607544124520;
        Wed, 09 Dec 2020 12:02:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:02:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] mktag tests: improve verify_object() test coverage
Date:   Wed,  9 Dec 2020 21:01:36 +0100
Message-Id: <20201209200140.29425-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_object() function in "mktag.c" is tasked with ensuring that
our tag refers to a valid object.

The existing test for this might fail because it was also testing that
"type taggg" didn't refer to a valid object type (it should be "type
tag"), or because we referred to a valid object but got the type
wrong.

Let's split these tests up, so we're testing all combinations of a
non-existing object and in invalid/wrong "type" lines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index a22a0954d5e..9ae1b0bb0af 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -125,19 +125,52 @@ check_verify_failure '"type" line type-name length check' \
 	'^error: char.*: type too long$'
 
 ############################################################
-#  9. verify object (SHA1/type) check
+#  9. verify object (hash/type) check
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
+type tag
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
+	'^error: char7: could not verify object.*$'
+
+cat >tag.sig <<EOF
+object $head
 type tagggg
 tag mytag
 tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure 'verify object (SHA1/type) check' \
+check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
+	'^fatal: invalid object type'
+
+cat >tag.sig <<EOF
+object $(test_oid deadbeef)
+type tagggg
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
 	'^error: char7: could not verify object.*$'
 
+cat >tag.sig <<EOF
+object $head
+type tree
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
+	'^error: char7: could not verify object'
+
 ############################################################
 # 10. verify tag-name check
 
-- 
2.29.2.222.g5d2a92d10f8

