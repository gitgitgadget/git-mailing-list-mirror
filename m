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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55212C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2643061165
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhHUL0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUL0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 07:26:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A8BC061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 04:25:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bo18so9069653pjb.0
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dloKmhReLMrxONfaUaAeUM778cQKj0NmcWTmK1EHZZo=;
        b=StMVQrEAB//2O2Js0ypy2Axm56lidR1+pqFhkwMRrHAGpdSzeltjNqII01H+3DVeo7
         54E4B0mHo9remSLj+mtOpx8WBMmHMlfJCl7S6f8YaD5KlD1/AqZpG1K1fM2T6BzpuK3Y
         Aa3wLbOQEgFmSiD9ze6jbVBiH+MyRavpLSVcTHIocW5mcPjYrdOrFOWLH9FEwnXJEOBo
         CQYF71KMDBFk6XKJRIY9FuWlBeb/fbGXLz1ldb/FcQ5icFXjUoLY6Q/eSN9oUagPJGMo
         4rKnn6+kbovtsajOYLmy1CICVsstG47XoWidh9T9kbAJdBq83Am9dgIXbNmkNqkbP9B0
         1YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dloKmhReLMrxONfaUaAeUM778cQKj0NmcWTmK1EHZZo=;
        b=rRMsJa4bBQ1KJ+iZF+ZkFbJuxYTK/o0AjyH0jPTMWisJcMkLs1j5m1Mci4VMKINmL2
         lxyT45YULTyi15HB1g0UZiRP/TxSgpLnES1jzQumZfh3drNXVKUwRnZ9jU86BM9PYGTi
         a3B2dFCuIl/dQGY56JsGxxcENZZs4iHfq/wMQ1PMQWVPpTxA3rBQbH5W2yuEhqhYseGM
         BwFp/HfjKZtO6CuujuUkbXxUv1qLS/mwYyai8zvinL62Ez5eCjovvRgzybWpLt5T0vor
         8CcU4VT3GEFoROFnaIlmsdePtZQ1yOsGXKr5nTvg29TB+Bc8+RvjFFqjP22xWVyxSYJV
         48aA==
X-Gm-Message-State: AOAM5334r1Qu+zKvJ+AxaNYXhqmYilBbCagLIbJjH0v7uhbBNQj0OO/+
        jbVVdGJwMeCxG9/H9A+JF/2zU/jaCWg=
X-Google-Smtp-Source: ABdhPJy8fVL9q6MJlooRftkVUQDs5nmVzmTkL4z31VWVQW+bfT7OWvpxrAoslJ6b3jmTbnzwA29a2g==
X-Received: by 2002:a17:902:b084:b029:12b:6caa:7d9e with SMTP id p4-20020a170902b084b029012b6caa7d9emr20071854plr.57.1629545139529;
        Sat, 21 Aug 2021 04:25:39 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-66.three.co.id. [180.214.232.66])
        by smtp.gmail.com with ESMTPSA id 129sm10360346pfg.50.2021.08.21.04.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 04:25:39 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] make: add INSTALL_STRIP variable
Date:   Sat, 21 Aug 2021 18:25:11 +0700
Message-Id: <20210821112510.50468-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some environments (most notably embedded systems and small production
servers), it is often desirable to have stripped Git binaries due to
tight disk space constraint.

Until now stripped Git can be built wih `make strip install`. Add
INSTALL_STRIP make variable so that they can install stripped Git
binaries with `make INSTALL_STRIP=yes install`.

Also document stripping and using INSTALL_STRIP in INSTALL.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes from v1 [1]:

   - install target depends on strip when INSTALL_STRIP is defined
     (sugested by Đoàn)

 [1]: https://lore.kernel.org/git/YSDW3nsG2iWPGakF@danh.dev/T/#t

 INSTALL  | 8 ++++++++
 Makefile | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/INSTALL b/INSTALL
index 66389ce059..98e541ee4d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -58,6 +58,14 @@ suite has to be run using only a single CPU.  In addition, the profile
 feedback build stage currently generates a lot of additional compiler
 warnings.
 
+You can also strip debug info from built binaries by:
+
+	$ make strip
+
+or for stripping and installing together:
+
+	$ make INSTALL_STRIP=yes install
+
 Issues of note:
 
  - Ancient versions of GNU Interactive Tools (pre-4.9.2) installed a
diff --git a/Makefile b/Makefile
index 9573190f1d..43c47f5560 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,8 @@ all::
 # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
 # to PATH if your tools in /usr/bin are broken.
 #
+# Define INSTALL_STRIP if you want to install with stripped binaries.
+#
 # Define SOCKLEN_T to a suitable type (such as 'size_t') if your
 # system headers do not define a socklen_t type.
 #
@@ -3004,6 +3006,9 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
+ifdef INSTALL_STRIP
+install: strip
+endif
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
2.25.1

