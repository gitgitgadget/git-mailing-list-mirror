Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC3C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbiCWUex (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344768AbiCWUeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87A8CDA7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r13so3766079wrr.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anN1P8DULs1bDl+4NtSS5NQzSf6WI2D2hNa7dekEtko=;
        b=gwaOidDCMAVI0y392tL7AoVgIsQ6JVAJsac7661H1mNqrqEFliqN2cjzYl4uQzfA+H
         ZD3W0ZXBZSfKdaiP/xyMjaCl/M7ksITeNqLkjaldx8tOGmjZy6+LETqUlSZKpQqvlgpw
         1Xh92IAs2hmpigMJsN6LY9nUkaqAR/o26Y00o8MZNpxNq3nkc2Fj3EzhXTUHH61PkmLU
         waqizYpZB10Mq4Dr/ZQNrmD0pkXTFrx6U52jD9mHu7ft2krJ4rBTEjVHyfBXBayTxkUz
         TU3Glxj0wv1FwHHSFBP3/uL+2JrqAoa8lD+Re9ZivKFSkLHO7k6UZ40+78qXHOj3bBe6
         Infw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anN1P8DULs1bDl+4NtSS5NQzSf6WI2D2hNa7dekEtko=;
        b=A3g4hs1ufBAH6C4TmWCeVL3A4PAnS7UAwPKGrFu5PRDbKHTz9T0bnO2t/clTUtSjQl
         drHn0AwkKpoBVxevGvwxriIJIak7BZFjcIv0rpNlXpz37XzeS6comj1LTDIBPAx/GpQQ
         oUiaj/nf/tfvtt7DjZU0BInyp2O7E0X8U75wAikk5z7rW1Zyvyk0McwJzvI/mIpn4RhL
         wbEpwK3KXWmjCaBD9gZRi3tm0RArpgaM2J6INC54R8dalCm4HGYGBxmZyxf35YrYpAuS
         dD/EUBHPeQj6b2lUJJHWM1ujTPhvamNCmRQPhgHCGUoPVQn9u8c3AZLLATlvs+yKHRDo
         RAow==
X-Gm-Message-State: AOAM533Mx2bUChGYIECX5VPoKu4CpjVNJ1UWLhhUEVFVYxn6a35x+GZf
        cDOC+WCN5CsWHGp+4mcK4oq09kyLbyXjRA==
X-Google-Smtp-Source: ABdhPJykAVuD2eRqlWmZp7kuJB9IzHEcOQ0Pq97B/SU9ILVOLAzq1elz9PgQ0vMfBm4PEnQTkRIC+Q==
X-Received: by 2002:a5d:4204:0:b0:203:d794:93e0 with SMTP id n4-20020a5d4204000000b00203d79493e0mr1619170wrq.136.1648067564320;
        Wed, 23 Mar 2022 13:32:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/27] revisions API: have release_revisions() release "grep_filter"
Date:   Wed, 23 Mar 2022 21:32:10 +0100
Message-Id: <patch-v2-20.27-857880bb4b6-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"grep_filter" in the "struct ref_info".This allows us to mark a test
as passing under "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c               | 1 +
 t/t9151-svn-mergeinfo.sh | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 71f4ef3530d..eefb188d05e 100644
--- a/revision.c
+++ b/revision.c
@@ -2961,6 +2961,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	release_revisions_mailmap(revs->mailmap);
+	free_grep_patterns(&revs->grep_filter);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 85221d439bd..c93a5beab25 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,7 +5,6 @@
 
 test_description='git-svn svn mergeinfo properties'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
-- 
2.35.1.1452.ga7cfc89151f

