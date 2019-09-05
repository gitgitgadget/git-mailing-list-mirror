Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14F91F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfIEPrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33280 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfIEPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so2034911pfl.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGt7sArqWSytDm7iQxUDTJsRuu98o3F6VnKUnGwObRU=;
        b=YZqQHGERjxWtdrXoi7qwNacr8uXjV2ZUow07seJRH0oSOmOIaykwD9s0KDNk8StFH+
         GQnyL+vQwum//qW5ylUaKbs9xGLc6K4RpDtBs8GfPAQqH9F21KCertytNYSQ6EezGXuK
         vKk6pewmIP0Dpgr+VvN0Qdf733FzKmraJUsZd0V6mHVTvEPyqa1WQTZAUycK0KXtBiC6
         lPVZVvcMSW4OT90X6HdMz/TKh0ZG5GlieaCWRrj3oQu7HEARwEWwLQE4x18TcZIlOdSZ
         S5mZH6k0+yPvanOMqqbcjyn683rlrkd6sq65mRBJy/kxbMVb1mQakOi1Z+7fdu9jT5Lx
         FlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGt7sArqWSytDm7iQxUDTJsRuu98o3F6VnKUnGwObRU=;
        b=CNR2ZX0wil6Kilvq6DQmVpCeFp4Mm6Im6DdzWIUA0zU6arkHCSDkjskoReS1Jjy+ZM
         vJq18Tj26fiOWymAHxwRSW26/RZv46iwEQmVb8FMldXB9ccHNxOj/qr56vegcs4iO3l2
         BmpuE592awq+dnCuk9qJYvB1KLWuL3JNHjsIvfRJoTg1fB3wRCtMkp+LPctLZ6CDOoHX
         8gC+3OJUcR3/X1V/NhBQ7Z4WgN/lDNY4+yjZJtA09Pai2Hsef45W9YXO3UZzwYVjfKho
         QAlT3CNO2bobuqkppcRCFeb+fiuslbklD+EBDgwCMmJ0knt8yUIDMofM8Axe9FStBE0G
         j9Rg==
X-Gm-Message-State: APjAAAW7pB/lvNDTR0Jur9FPhBtXJsWM9Uqh5V2HCVVT1sgnLkPkT0ub
        llseNbiBR2aPShVtBAWaMtzf/VyO
X-Google-Smtp-Source: APXvYqxTQkKW5uWOJ8QmyoTby1s1wyM3MwJJ5dw/ndu7XHCKXSCIGmAEJZpue4tajcBIwtysbxmvEw==
X-Received: by 2002:a17:90a:9105:: with SMTP id k5mr4724871pjo.9.1567698461739;
        Thu, 05 Sep 2019 08:47:41 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:41 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 01/12] t7300: Add some testcases showing failure to clean specified pathspecs
Date:   Thu,  5 Sep 2019 08:47:24 -0700
Message-Id: <20190905154735.29784-2-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Someone brought me a testcase where multiple git-clean invocations were
required to clean out unwanted files:
  mkdir d{1,2}
  touch d{1,2}/ut
  touch d1/t && git add d1/t
With this setup, the user would need to run
  git clean -ffd */ut
twice to delete both ut files.

A little testing showed some interesting variants:
  * If only one of those two ut files existed (either one), then only one
    clean command would be necessary.
  * If both directories had tracked files, then only one git clean would
    be necessary to clean both files.
  * If both directories had no tracked files then the clean command above
    would never clean either of the untracked files despite the pathspec
    explicitly calling both of them out.

A bisect showed that the failure to clean out the files started with
commit cf424f5fd89b ("clean: respect pathspecs with "-d", 2014-03-10).
However, that pointed to a separate issue: while the "-d" flag was used
by the original user who showed me this problem, that flag should have
been irrelevant to this problem.  Testing again without the "-d" flag
showed that the same buggy behavior exists without using that flag, and
has in fact existed since before cf424f5fd89b.

Add testcases showing that multiple untracked files within entirely
untracked directories cannot be cleaned when specifying these files to
git clean via pathspecs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index d01fd120ab..2c254c773c 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -691,6 +691,38 @@ test_expect_failure 'git clean -d skips nested repo containing ignored files' '
 	test_path_is_file nested-repo-with-ignored-file/file
 '
 
+test_expect_failure 'git clean handles being told what to clean' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -f */ut &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean handles being told what to clean, with -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -ffd */ut &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean works if a glob is passed without -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -f "*ut" &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean works if a glob is passed with -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -ffd "*ut" &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
 test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_config core.longpaths false &&
 	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
-- 
2.22.1.11.g45a39ee867

