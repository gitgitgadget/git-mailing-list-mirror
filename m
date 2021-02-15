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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C00C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D85860C3D
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhBOPu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhBOPpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75DC06121D
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v62so229887wmg.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSSl8EisRV4PVwAFLFAf4uzUnQCMBa7SVbHMA210SnY=;
        b=J3rwF0+DWs5rX+odzRLLUvPKozq0JYK/BXdNvxBn0UEcYYt49SW1Z9BbB2+1kqZazk
         eRe9x2XjpKFwjrXpXYe6I6Ed9aUCWylh+thG2OyUbtgvsCOYn//gd5ser6qiro57dlvO
         CuEIJBGIsfnyX8sLhpDJHdO6OOGsWBKu50tmiCFN73TMjiyiNG9xNbAd0j+n2PvKXo3K
         RwsL7edHRDAD/uj4Dmq9x8Untdk3J9jSDAz+EEweCjByxRFra2WRfVzLRy5pMfRhOkRP
         hYY/wNxPvsd5aan188Vo8FZvTM62Hl1O2EpM2/ZPnCiBGh2lrVX7jUQXPAh5AL2/sz9/
         FI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSSl8EisRV4PVwAFLFAf4uzUnQCMBa7SVbHMA210SnY=;
        b=B1C0T87dU6rymBwyqiMIHTwDecz0zvMUAAABtEi9/ZPGSh7uSEhxzGa+Z3xIX3Ggd2
         odozI6Xa0z8Xj+uQTmco9FoczjZXKk6Gow65P+rwwNigsHhIXAgafTk0bpkbOPQqJhtM
         SXEdADG51FX1KHbQjXaWP+Iww3Ud0wBPfkTX/nW3fBmez69EvOYDNcFUAjkygkAbWkBR
         mg2gzklycJgEHXaK0xT3n2TSFysrvFu27BStesfzxCRQp+y9yL0+3ZN6z7aePSXvWdub
         ZT0/5bu6ehNv9PFNMF8z5TWyK2bmloW4wa8gTAuvnM1bMYsa/pRvf27MH/gCgZJWglln
         oZrw==
X-Gm-Message-State: AOAM5300uaRAsfDUg+j3tYgP29OpkKSJOpmS/g10sBU8FFH6L8jEEXDV
        cdTmy+qlSGw9rbCPDo44fdQcQGvFovLx2Q==
X-Google-Smtp-Source: ABdhPJxfgSERMlVC1OyU4uTSk1LsTV84cY7wN8rFp+puuMjWOaAnFUWEVmGmVvWHQWWHqA8T/qbfMA==
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr9862094wmq.118.1613403892499;
        Mon, 15 Feb 2021 07:44:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:52 -0800 (PST)
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
Subject: [PATCH v2 08/27] userdiff: remove support for "broken" tests
Date:   Mon, 15 Feb 2021 16:44:08 +0100
Message-Id: <20210215154427.32693-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
Fortran xfuncname regex, 2020-08-12). Let's remove the test support
for them, this is in preparation for a more general refactoring of the
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 +-------
 t/t4018/README           | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6faa719536..5994c5b47a 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -82,13 +82,7 @@ test_expect_success 'setup hunk header tests' '
 # check each individual file
 for i in $(git ls-files)
 do
-	if grep broken "$i" >/dev/null 2>&1
-	then
-		result=failure
-	else
-		result=success
-	fi
-	test_expect_$result "hunk header: $i" "
+	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >actual &&
 		grep '@@ .* @@.*RIGHT' actual
 	"
diff --git a/t/t4018/README b/t/t4018/README
index 283e01cca1..2d25b2b4fc 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -7,9 +7,6 @@ at least two lines from the line that must appear in the hunk header.
 The text that must appear in the hunk header must contain the word
 "right", but in all upper-case, like in the title above.
 
-To mark a test case that highlights a malfunction, insert the word
-BROKEN in all lower-case somewhere in the file.
-
 This text is a bit twisted and out of order, but it is itself a
 test case for the default hunk header pattern. Know what you are doing
 if you change it.
-- 
2.30.0.284.gd98b1dd5eaa7

