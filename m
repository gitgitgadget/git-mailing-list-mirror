Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C221F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfILWMt (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34612 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfILWMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so14204162pgc.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ptim27PnuEyvXFrP5tqSJumVkwythLTogNUrEYUqxs4=;
        b=eG73lbzGunBqmyaZP67VmFG8wvh7SaHP/pevgoLj+s0jhbETM2PvSalazFxDuS2vUC
         l3CQz2N5e5dP1cCzMs7227v88UsOzQSkDbdogA9VIQT/2SSqeP4+M23CnH7uQBOteNdM
         t750sMyUg6l6qiKv3A73I95t6hLrbUS/dxWXLTE7NXrb3EuqySD2qwAy0ez4aLDfKsfL
         zZtEXgcznXKVxwKyGvz2mtW3L3HWYuW0igjg/dU+osKNZVIivnvXdp1MspeKVS2YiDeH
         qHNh5XNLBtCxUDOylup72opDe+/WvSh9KlaarU5wMcfevmnwxPMW/6JgAO1nK30up4x3
         q7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ptim27PnuEyvXFrP5tqSJumVkwythLTogNUrEYUqxs4=;
        b=JPr4mvNcRayrXwERs/wRPwcWPHAPbHMCAO+rlbvILO9NDqXpcZhwYh01qXw+d2kYrx
         8IvTSmodrYeUXdqU2SFOY6asYGvzpJHS3gokrFvJ2LXIuWcRXKhT4ObKfVFrHDOTD/0K
         y0hw8btVoyFymtUEvGXXh/yBzhJM5gjeR3XFVozbB4wbB0LZ7H4BrgssdPg45i5nm1vq
         Qr2EuvvmvtPD7vFMJaBDzpPOx9i8xhIAuS3vAl1TD1WPdrPas3HmTK58LJ6vVQ7lZLeN
         Sze0C8gsrQ45ufYRlRt3zSJ83nHNjmvZBem6StCyI2+WVj2uOrkHodB2W0BjvzMQt8uR
         Bbuw==
X-Gm-Message-State: APjAAAWSXsO5Z3BI7Eg5Kx1t/B6Zx3VnNvmzRsi8x25aoL9/xoxXG2VA
        E1gZBShY+8gvwBtHej2jMj8pHqa/BWQ=
X-Google-Smtp-Source: APXvYqx/BkrXFiZzCHq362N7Qqq5x0ttXA5w9IcCOOt1rqiP0eq+X8Db+KAOrfVRcIen7Qf22f6Sbg==
X-Received: by 2002:a63:2943:: with SMTP id p64mr2823945pgp.98.1568326367449;
        Thu, 12 Sep 2019 15:12:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:46 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 01/12] t7300: add testcases showing failure to clean specified pathspecs
Date:   Thu, 12 Sep 2019 15:12:29 -0700
Message-Id: <20190912221240.18057-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
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
2.23.0.173.gad11b3a635.dirty

