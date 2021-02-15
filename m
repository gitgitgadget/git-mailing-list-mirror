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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E7C433E9
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD67464DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBOAy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBOAyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9DC061793
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v14so7147811wro.7
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/pFllhqsaduEjBYEBQ5AgLgBIA72BE54aQQQGm/Fi8=;
        b=Tr010ycXPEVw354uODjQDfRHop9vTA6awExduBDQgXlLMbEA5s/KidOS02DKw78QGL
         J+5B26jDIRKkqIjiDayxPBLl7qKC2y9gnZObNn7PQkYIbo4dpIT7W1A3P3exSwBds5bo
         S83AeXIUuXtBSUjeOHKhhL+11fLQhePXIZCjzyrxqTPFA49jngih6Q+qcT8NUl2Kexw5
         tpBuy1IIX71SnXP2Ra6HyS0XqNmvq1BQZnG5rrzTH5KM975sOFS5MXfEANMacoZmkmwj
         rJsD5MX3YtC868Urg4D7S/uRGBlvo3qRHJDxDDIAzNQIYtn85XMJsnEp+A32K4gZmyvH
         TN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/pFllhqsaduEjBYEBQ5AgLgBIA72BE54aQQQGm/Fi8=;
        b=k0GFBlkyJ0MvesAsTbUvGtIBTv45VgI1kjWS3POQCQE7IMnCPOj2ejEuPdT5aXTBU+
         eElGlcSvfrK4gKCHqxOGdxhpf6hPnk8xpnm3o96BJLGS7k+a3sV6RM88lMV+v0DXOOX5
         57bzW0Ljf9XoYPQk2Bdapa82g8G/ebpSPfDSbPz0AFr7mR9JwpUZ126xrw6RuBy6oTf9
         ZPblWYc8bnfFK1lbm80yCWxKkDJs/e9RkUlp7ID8shvIJt77LjAxU4DBxhzN2xU7TIsh
         ZoQlkr1MIqjvMdQvAGcNkZcB6aoZMuy4CoMZ1Fl4CjPzkXGEku/HfEZUYLKl38wdBg9K
         crwg==
X-Gm-Message-State: AOAM532G1yEyGfasjtafxwMCFEafNntj5DE1yPz62zXfn9/zC5sm6WR6
        Mc2NR56wL+U7I2pRe86ZyblC60eBzM1FSw==
X-Google-Smtp-Source: ABdhPJxGDLR27193/l8P/QnQloHL6erZ6xzZSE+5b+79LtcKauwoc2KIgObgc5ORD7qmOrrFspuJBg==
X-Received: by 2002:a5d:51d0:: with SMTP id n16mr16815030wrv.382.1613350386540;
        Sun, 14 Feb 2021 16:53:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/20] blame tests: don't rely on t/t4018/ directory
Date:   Mon, 15 Feb 2021 01:52:25 +0100
Message-Id: <20210215005236.11313-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) so that the blame tests don't rely
on stealing the contents of "t/t4018/fortran-external-function".

I'm about to refactor that directory, just moving the relevant test
file here inline is the easiest solution, and I think also the most
readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 29ce89090d..04a2c58594 100644
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
2.30.0.284.gd98b1dd5eaa7

