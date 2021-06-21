Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1287EC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0181861042
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhFURBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhFURBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B65C06114A
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso9112923otp.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vq5x/ATP/v/SYLYOfwx37tqjqRCFkcz3MZ9AefCNPsk=;
        b=i2WW0TQvG5L/WqIy+bEDknUS9FsCJAF2N/Gaghy/uyqCMJWWFubU67oqH+mf9cauBu
         /82JEJWa2KA7u1Zdyt+luieFHzzUd7JUeo+RsLGkkDluO6mRGlpZiOFgIbqbYh8jFGKy
         XelXcZ9C+MMtw5t/B7dW0sR+7BTJAIqbaUfZUMYGMdMBhrMmAp+rzEiNfJm9izKVEgrJ
         gVErS/UbthYE89uUowrrQPd13b/9YFRVsHN9yGFciUbIQYO9LjdA1MgP7gpixir/8B8G
         VB1P0axZBMzOzg5Ipb82ZyaEUQwLYfR9I2CFfDw1hdSPmgz4vjrlwwEiqM3izfF8gHTi
         WLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vq5x/ATP/v/SYLYOfwx37tqjqRCFkcz3MZ9AefCNPsk=;
        b=ld1Ed906PXkP/AraEqbU9SOJ6X8ROjd39g/ukZtn0P93Hvtc1Ugvili1ckt4bSIQ+p
         n7ihJ8XO0grGkWdmPlo4IBYy/NK477ESn1thnu6i17r/W9hwgb8eY44sOrq9reHB9XcA
         +s5bN/kuneU8x2b7UFv6Th4Hqs24iAY2QFqfshMgZXSx/GXbVdlMixBeLJ37h7enErKP
         h7eDByPW8S07LWMy7f5x2fsx4zDEjhF0rSN6xsozJDDcif0LfElkSu8Gf1xjGpqRxTE2
         bUWDcNY2FSczyr+YoS92ijbLk9MJd2/cxYMgZz91dL/QXL5SgcT+M0ICVo7hHjZADBZZ
         HGBQ==
X-Gm-Message-State: AOAM533UV+TZT4N3L7EIMiFJnhQx6Osm+xfiqOZm7ll9DaQnC6X/E5Ot
        AX1fue96q9RvShJ1KOjMx1aQP0QngH7ilA==
X-Google-Smtp-Source: ABdhPJyx0igsZRReJlpZXA7WY876hJUeSr+vPMNOBzgdqm5MgjhHgHewqRD4neZgOXW9xxMMGiVZSA==
X-Received: by 2002:a9d:7e2:: with SMTP id 89mr2661088oto.154.1624293107783;
        Mon, 21 Jun 2021 09:31:47 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s15sm3636468oih.15.2021.06.21.09.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/23] doc: doc-diff: set docdate manually
Date:   Mon, 21 Jun 2021 11:31:00 -0500
Message-Id: <20210621163110.1074145-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to minimize the differences in the footer.

Asciidoc automatically generates a date with format '%Y-%m-%d', while
asciidoctor '%F'.

I personally prefer the latter, so only modify it for diff purposes.

Fixes tons of these:

-Git omitted                       01/01/1970                        GIT-ADD(1)
+Git omitted                       1970-01-01                        GIT-ADD(1)

Note that we have to add quotes when passing around $makemanflags, as it
now may contain whitespace due to multiple arguments (but the
dereference inside render_tree must remain unquoted, because it wants to perform
whitespace splitting to get the individual arguments back).

Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 2 +-
 Documentation/doc-diff | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 47053c78f8..b68ab57239 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -136,7 +136,7 @@ ASCIIDOC_EXTRA =
 ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
-ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
+ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_FLAGS) $(ASCIIDOC_CONF) \
 		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 1694300e50..c11b90a6ef 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -111,7 +111,7 @@ construct_makemanflags () {
 		echo USE_ASCIIDOCTOR=
 	elif test "$1" = "-asciidoctor"
 	then
-		echo USE_ASCIIDOCTOR=YesPlease
+		echo USE_ASCIIDOCTOR=YesPlease ASCIIDOC_FLAGS='-adocdate="01/01/1970"'
 	fi
 }
 
@@ -181,6 +181,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid $from_dir $from_makemanflags &&
-render_tree $to_oid $to_dir $to_makemanflags &&
+render_tree $from_oid $from_dir "$from_makemanflags" &&
+render_tree $to_oid $to_dir "$to_makemanflags" &&
 git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
-- 
2.32.0

