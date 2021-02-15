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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7817AC433E9
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FFA64DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhBOPsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhBOPpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9AC06121F
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t15so9398858wrx.13
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReTnfaTWYHRczkIt49IvidPHYZ4VQRgf1Sdth2DKELQ=;
        b=rygyxd4GPEpGAu5g/AY1H5x6JtFCGvQfBjrjuQCriDiysh73UK8x7rlZ1fKTBnMRk6
         cM2xx7gECXRWSbKYnp+FEk1jjb0nF3r0eyW8MRb7khLmM4yzbq4f7J7cb1b9juhs3RWj
         BW3AgfbqeZ8vCAS5EeUvRlu3eg4QZeKkbsAKmz0ZaaiPP5ssFTYOhYUPcyj5d186OJ3N
         xyRLGukFlMIL6r5zbgqyAzAC7yeQfMkB9zNvyowlHP8JNv2ZYoZNb0v8CGh+VYIGsvja
         zTEKkshts6SsFyu7BAiXS6+9BK2zBfMQaLyJOvkHj4oahmSZsBb+XOEpoCzJjRBafHTG
         XWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReTnfaTWYHRczkIt49IvidPHYZ4VQRgf1Sdth2DKELQ=;
        b=ryXzyZDFyntvQHaPDy+9jih0vAxVHJz6lnSxlKRe8QEhv0NjDOWI7JGc/wUoPTf2Du
         XWfIeMCDqHZ5XltaqcLdGV/Kxf75/egTTC32dYaxj/5uuXWDY1qwcwBlukkws7Ar+9YP
         HJw9Cwvv9jSrZPaNj+Wnas4A1cPDkSvhoNSr1c/qaNnBsoGq7bot8PsVoz/sdt+UU8T+
         q2EboxDGTleEqkn9fkjK0mOM8ib4u+u9VjluR01Fge6G5wqdXgqbfLXQbVQ1cx+i/90e
         G3LqeVSK+ou46OzE/x6ss2qRUFnBeUvufr5BkXTPZE7jwlW4UqQiGbfHK1oHRuYU1Jsw
         oRaA==
X-Gm-Message-State: AOAM530FR0D7eH1t6eauumhsux3z2fbZKu/uPXwgcO5ZzYfjeGa38uu3
        h//yWbUNKLQxusc6O8zbpu6tP09Rcy6MbA==
X-Google-Smtp-Source: ABdhPJx88p1vTmN+XdHbTjuNXkoYM66d3wfEhhpAYIem5pO4eZoLe06PUu3AKs69aZiIdMbLK1DzXQ==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr6195614wrd.232.1613403894032;
        Mon, 15 Feb 2021 07:44:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:53 -0800 (PST)
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
Subject: [PATCH v2 10/27] blame tests: don't rely on t/t4018/ directory
Date:   Mon, 15 Feb 2021 16:44:10 +0100
Message-Id: <20210215154427.32693-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) so that the blame tests don't rely
on stealing the contents of "t/t4018/fortran-external-function".

I'm about to refactor that directory to delete that file, just moving
the relevant test file here inline is the easiest solution, and I
think also the most readable.

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

