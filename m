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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F08C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01F864F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhBXTye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhBXTxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EADC06121E
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n4so1468257wmq.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qeCVDIPmNTCF1cRMK5wyyJqLDHKY0nCFz+Emh8bCGvM=;
        b=p3ewJo67kQifg3OIdTO7hTrh6ZQwLQ2ZEDLBdhwu77PwXkRHVy+hCUlXvF05Bdv2sJ
         RbodBVbFvt104wXKhbdJT+/LdIwpYodsLU0X+Gm5Yn0y0h9O5QJiov99COYu7JMFdjjW
         y+6guvs+0PLQpHhngNgB35cchg/y/K/G8p0WCQlvVAb5LPrbQJE4SIaUUzh5O/XtKsxS
         Gmr12+tT330RWu0RINLfIJdqKMe+YdgqQJMKz8KvCEnE0srRsGHUMjxiHhRiXaD3BeSp
         xSqvYAppELs9U/SPE2MAW1DXYidnnyGYyQMz/tPOnMBiP3EH7D0ie7uvP1q4JnhUiUGC
         G/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qeCVDIPmNTCF1cRMK5wyyJqLDHKY0nCFz+Emh8bCGvM=;
        b=thqI/Y3b17Yjug+cF5k67eGY+w0qqxyTjHD+jTe6yapmjGLKG5tsSl/9nZ3dSlYrsq
         YSlRJTb7/Tuim9k4UAu4pJEfgWNXvcBi+OrjCp7z1eHAnRS+QL1sqcvssnzO/QCYqUd2
         geN8nJc9CbkgH+D7hgpDfbQl7UVphJn1nmUPdkSzmXY09HBRPYIF8HzI4aO21HMBL348
         yuZtQqY5dPv+Oj/YS9+xI2b7j0Dpbq+Pg4DWZWkJLe+0gVpsF58gNLxHPUb70prcj6cu
         H7ckj+TK1abLu5LJB5quRkuOung8aDhPa6IXRLQHbjQxg6FyvB4G2qsANSTL0Fh9PR0b
         HzDA==
X-Gm-Message-State: AOAM533fYsP5fC+UGJ1njGmEQlSDpgZ+wr9HKhEEDg593nn4KvaU8AT9
        a5rb81boV36HCsstOVnzugnVOVX05MKuWw==
X-Google-Smtp-Source: ABdhPJzX8sJWBup6u6ofT/fCC5DDOue8AaNbFNY+GJUgKElTqY5iObYTK2OUldjOLUKOd8VhzceF6g==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr5140407wmj.11.1614196326071;
        Wed, 24 Feb 2021 11:52:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/35] userdiff tests: do config teardown in test_diff_funcname()
Date:   Wed, 24 Feb 2021 20:51:10 +0100
Message-Id: <20210224195129.4004-17-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a teardown of any custom "diff.<what>.x?funcname" config after a
test_diff_funcname() test runs. Nothing currently uses this, but a
follow-up commit will start setting custom config before certain
tests. Centralizing this teardown makes the tests simpler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 7fc4291f4be..496313fc900 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -123,6 +123,13 @@ test_diff_funcname () {
 		git diff -U1 "$what" >diff &&
 		last_diff_context_line diff >actual &&
 		test_cmp expected actual
+	' &&
+
+	test_expect_success "teardown: $desc" '
+		# In case any custom config was set immediately before
+		# the test itself in the test file
+		test_unconfig "diff.$what.funcname" &&
+		test_unconfig "diff.$what.xfuncname"
 	'
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7

