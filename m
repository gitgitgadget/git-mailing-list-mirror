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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C18C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC1E64F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhBXTzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhBXTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5FC0617AB
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so3049472wrx.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZ9RBdohkPzJ0/hq4JRsvjAEH5e3qtgkKeHPFQHDpV8=;
        b=ARw411qHtIoagoqjo/LoFfJki0cTR7rTMPCRADZMAzg8veJBOJWhdghKjQXVdKqZAG
         7zF5kad2qy2x1ODFMFnhLTPSBGEXYipcjhGYHeSdVrVPwPBnJwwStjm0asKWNL9Nj/qp
         0ZxTa9+iqR1J3mr+O0d6E4t+OAfgsRmXfRffC8QpDBloNPBp4rSkd8LtMWB8trOIuBFQ
         aJe2HzAo03NY3giTm125T8JfQ8MlXV8C2S2aSK6RxaxQSF8W1hxjes2lF6mIvG7OYxmq
         YSMc7IgiIWfxBOtBRlg7Ii8xCyEpOvAyem1TD1sWQ39JQKAcNBk4+wWPeh/U9VtsHxy3
         YdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZ9RBdohkPzJ0/hq4JRsvjAEH5e3qtgkKeHPFQHDpV8=;
        b=DT/5ZfCg/waltcp2v2Vfh5x1rvRpXB4lRg3kKs6N5k6mgZZjiXoyIIkJ5fn8wV2lys
         J37M0oG2RD90ufjIC1wPBCAxoIE1r3q+ECESzAx0HRIbuoFacz+COkIxKQYIdLh85Cz/
         Toi+LCNPUjS3rUmYFr3IkqNMxv6EmHrRbVZCu3zICa6cOZkOn7LAjnKfkL2IZy5h197q
         wM9mcIcRzxTmUmeYzGynj+9fmMzM1eyeDupmYGDcMnZ7BjSPMuUuuu/2kCZfyamdwaWd
         tMDLsq58XR85vYhRxlhReGcfVYpAh4QBXKNRfsmHrQfbXRVSmbEPbrb7Sz6QEYjS+5QG
         oCTw==
X-Gm-Message-State: AOAM531xqJ95HMNzKNwIf4tfF27prtPoBZavuW+oCVQtt9iW5nGlw9wJ
        2Dw9747NKW9k2lu4djpnh+FxVNCcN5rCUw==
X-Google-Smtp-Source: ABdhPJxpI5ZXN+q+0hV2Zy2dQvafYoLjY2fSGVNxLwRkaXdNKcgbjkw4AfUMv3HDKjRxk1OHbm1cKQ==
X-Received: by 2002:adf:bc01:: with SMTP id s1mr3417154wrg.240.1614196323390;
        Wed, 24 Feb 2021 11:52:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:02 -0800 (PST)
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
Subject: [PATCH v3 13/35] userdiff tests: factor out test_diff_funcname() logic
Date:   Wed, 24 Feb 2021 20:51:07 +0100
Message-Id: <20210224195129.4004-14-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out logic in test_diff_funcname() into two helper functions,
these will be useful in a follow-up commit where we'll do this munging
in more than one place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 2365f0e361e..8a8a7a99c88 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -75,6 +75,17 @@ test_expect_success 'setup hunk header tests' '
 	git -C t4018 add .
 '
 
+do_change_me () {
+	file=$1
+	sed -e "s/ChangeMe/IWasChanged/" <"$file" >tmp &&
+	mv tmp "$file"
+}
+
+last_diff_context_line () {
+	file=$1
+	sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <$file
+}
+
 # check each individual file
 for i in $(git -C t4018 ls-files)
 do
@@ -85,13 +96,12 @@ do
 
 		# add test file to the index
 		git add \"$i\" &&
-		# place modified file in the worktree
-		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
+		do_change_me \"$i\"
 	"
 
 	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >diff &&
-		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
+		last_diff_context_line diff >ctx &&
 		test_cmp t4018/$i.header ctx
 	"
 done
-- 
2.30.0.284.gd98b1dd5eaa7

