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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145CBC433F1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F16619EF
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhCXBtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhCXBtY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2328AC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v11so22762270wro.7
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeoTU1z3TEscNieD+fk+/DwGf3HbZFWWr0X0bDcHU5M=;
        b=Blt0PgLb6z/j5vWghQtgEzYAboUBgfBuZtQARcSbwweyai/UAi1cFH6+3WJUhofjz+
         dfYijWqR0sWu4iZSRQHoiU1gSdnJoiC2CKUr/+QBqbQ+rtZFfypus5Ch4t5nTo/H++Wx
         Lq5DUsM1QtEi8cGImZltpqZ1za2zP70V0IqX6rdiGQPyQhQWRbp0kBbQWH+qOAvfLBq8
         2vkUjhqoo0pJq46tEX4o51d7ff0zWuAiGbfdKUXUwz7rk69CQVdlUuVEpALy3HgZL9yI
         BCsSxBtY11WWh80SovQ5naB5xmMrzZWHtAQsrb49H/vUDI0QAoAjye4jFxay9a2+MUL8
         AaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeoTU1z3TEscNieD+fk+/DwGf3HbZFWWr0X0bDcHU5M=;
        b=QLcyku/3ZGLGYGVH9VYy6Uws/JM4WK1f4oGWu1f/Tyf+vzyLyxPtJX6Gy3DZZG9hFC
         QqIAyiR+rheJWJVmapzVK0ZVOlT0tkAqES0FqLj/p2Hxdq+YFplCBeav0CDMruvTu/r7
         qgt+HYwMQ4ooagMcO1D2IwUPK/fvjiHJ+pAZiMfcVw0XJEYZ2GnO96ee1BXHrRGf+L3E
         Iofa6I9Y2uP9zBsPJ6davwn+SkabdsS+6XiLHNteftNX3XvyDK+GhHgYbswz6EGLvlWi
         ZMnVgibOsvThVG19reCIG5c53c4Zd7c15BfyAVmHZ8DGx3oouKTN4xBZhm6T2P+qKK0Q
         s0oA==
X-Gm-Message-State: AOAM532Lp4zm3Y7RtzvRtG0r/l2lPjguIc5m3u+WrvXnr81A94F5QGig
        piA8EUSdjpP43ohiLDUwSONgo7hvvxtmYQ==
X-Google-Smtp-Source: ABdhPJz9w2PyIZLS6qdKH61a5vRRMoEeXyRDnFJnxfYiPkm8hrStMtXxk5a8FhhK5IaWIM3pG8BD+w==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr781410wrb.24.1616550561576;
        Tue, 23 Mar 2021 18:49:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:21 -0700 (PDT)
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
Subject: [PATCH v4 09/10] blame tests: don't rely on t/t4018/ directory
Date:   Wed, 24 Mar 2021 02:48:51 +0100
Message-Id: <patch-09.11-4e0b4b42e16-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) so that the blame tests don't rely
on stealing the contents of "t/t4018/fortran-external-function".

I have another patch series that'll possibly (or not) refactor that
file, but having this test inter-dependency makes things simple in any
case by making this test more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 29ce89090d8..04a2c58594c 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -482,12 +482,22 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 test_expect_success 'setup -L :funcname with userdiff driver' '
 	echo "fortran-* diff=fortran" >.gitattributes &&
 	fortran_file=fortran-external-function &&
-	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
-	cp "$orig_file" . &&
+	cat >$fortran_file <<-\EOF &&
+	function RIGHT(a, b) result(c)
+
+	integer, intent(in) :: ChangeMe
+	integer, intent(in) :: b
+	integer, intent(out) :: c
+
+	c = a+b
+
+	end function RIGHT
+	EOF
 	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
 	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >"$fortran_file" &&
+	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
+	mv "$fortran_file".tmp "$fortran_file" &&
 	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
 	git commit -m "change fortran file"
-- 
2.31.0.366.ga80606b22c1

