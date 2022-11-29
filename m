Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DEC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiK2NQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiK2NPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2B62F7
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:19 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s196so12974496pgs.3
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0V0sYNad7jdnyrdAOI1ipPaF3PwTLpgfiiBcNbeRoc=;
        b=ncogcARweQHYLdx9qvxaVD98WBVquN1Mg7tRDQPfmw3vr8ad8+7GIL8RfksZZYaxx8
         bk+TX4NwtPgiUgiz1kDmytVsm7+7/8k2MQWu0kmYsV69QbWRxymXtR5an15C0YEN6/x3
         DCYErQNdNnPo0RoHpcEMCoHOh13LTFzdRXtkH8SRhbQWmHODtoYT41DjYPh3HctelqI+
         38hBJg0xM+G+xzFF5FoMdhykdgJhv2S5F3eO+RR/nwneu4YhiYQQafDhTWjcKMPrD+Hf
         LFshsdokd0b0JEWpQz3sjFMwpcQH89jDHAsKXXflH1GHNENd+GhNIW3uixuDbUoyChdB
         0qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0V0sYNad7jdnyrdAOI1ipPaF3PwTLpgfiiBcNbeRoc=;
        b=6u8lrR3IuU6ZVQVtMzX/skSH032S9PYEzbyv7VzY57hdHWeC1Q6jht4uaVc05/CEUE
         rCZg7yrfb4Kz+/asvESkTo5m4MQdRgIgwIT8o6Lbf0A+MqJswXukMm9LMlBzQ1vHujh+
         1r88adYW1AZQxOoqt8l6mpoyAp8crld6dJS01fXWmI0i3j/jOIKeLomVIEG3bda76tXl
         KaHBR6AyxYUSrUoEkJD/9Tc7SNmH16nZeDmW7OxGxJuIkBaBHkigYOCGoo/sxB2a5DuL
         x/yKRZYMwIt0kNZ561ku1C67RDca5ug8SciKiZ4rffSo5+MmMsK8p/oRacggTPJcS1vv
         hyZw==
X-Gm-Message-State: ANoB5pmV4P0MWPyLuqaSyOL8/pSpo1atRYXVtEVo1Pm5X2OTb6gZuyRu
        eo+C20xAG5vtdCGZn/wSccVZMoOC/lg=
X-Google-Smtp-Source: AA0mqf6/DeQAjZh+Hfug5XMn/Dv1hVzfw4bkfBRJcwujhF998atff4Ff9mnWfJa2A7AesIIRNVuDKQ==
X-Received: by 2002:a63:ed0b:0:b0:477:9319:eb4f with SMTP id d11-20020a63ed0b000000b004779319eb4fmr33026042pgi.257.1669727718614;
        Tue, 29 Nov 2022 05:15:18 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b005745635c5b5sm9904524pfp.183.2022.11.29.05.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:15:18 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 3/3] t1301: do not change $CWD in "shared=all" test case
Date:   Tue, 29 Nov 2022 21:15:11 +0800
Message-Id: <20221129131511.7173-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221128130323.8914-1-worldhello.net@gmail.com>
References: <20221128130323.8914-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In test case "shared=all", the working directory is permanently changed
to the "sub" directory. This leads to a strange behavior that the
temporary repositories created by subsequent test cases are all in this
"sub" directory, such as "sub/new", "sub/child.git". If we bypass this
test case, all subsequent test cases will have different working
directory.

Besides, all subsequent test cases assuming they are in the "sub"
directory do not run any destructive operations in their parent
directory (".."), and will not make damage out side of $TRASH_DIRECTORY.

So it is a safe change for us to run the test case "shared=all" in
current repository instead of creating and changing to "sub".

For the next test case, the path ".git/info" is assumed to be missing,
but we no longer run the test case in the "sub" repository which is
initialized from an empty template. In order for the test case to run
properly, we can set "TEST_CREATE_REPO_NO_TEMPLATE=1" to initialize the
default repository without a template.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1225abbb6d..58d6da7feb 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -8,6 +8,7 @@ test_description='Test shared repository initialization'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
@@ -46,8 +47,6 @@ do
 done
 
 test_expect_success 'shared=all' '
-	mkdir sub &&
-	cd sub &&
 	git init --template= --shared=all &&
 	test 2 = $(git config core.sharedrepository)
 '
-- 
2.39.0.rc0

