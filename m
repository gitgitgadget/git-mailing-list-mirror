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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF05C4332E
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C0822571
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgLWBjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgLWBjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F0C0611E4
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a6so3958570wmc.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va7CpPhjGNCgLQvnqaVBe7Xyt++ip/WzZSnrVX8fCDU=;
        b=O0ccf36fiYTKVJNV+QAf2s/2CQh/EvySvnH6KGZLFF/R2X7/fR20CMUuZ3rLvhFS0Q
         Wvi9A9NS/ZYkfpGogIUqa59NSXqV63xvdc58lSDRUnzVIuhlBV3IVQtpMCjpGcAuKqnP
         M5D2O0x7wXppdbDtyO9pqM4kLG3ZTqq8ZvIREUGhR2TnfKy3y+EcT/9T5tiWYtNs8e26
         79hz5J4FelBcBWYJ6M84aVsEnofVudtCPAFuF8CLO9aHhmDVb1HJvVDmUD+w+0+AzVXf
         s0azBnvuuIC0x5eGXP/RWVqoH4JE/uLq448Ulr5gyYvf55QF60ROFa42e8hFvOP1Ekb8
         teAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va7CpPhjGNCgLQvnqaVBe7Xyt++ip/WzZSnrVX8fCDU=;
        b=E5tCzX4SbQ+fgZNdIjrdPI9HrZElguKxQXqg3Ki8ThovjE4NNAH6K7k8prvSLCtK3o
         TYBuWcaYcFfqbxbQUnX5H9CW2YKdIdpiom+afHC9il4Zw3Xlxs1K1k0EwFxEGFDcBjWn
         CA9HXAEcWUChLIYWFL0G/z2wCTgy6AtatU1hywsxPA3MgquLIFXdsPjhvqJ8lTlVjrCk
         FprXtpwxAcrjclenE4kyfrK2icKTamCBTLGuwCZKDEtLVRSRUC5r3PwBa3Qr+jc5orN9
         qJEauXow24GhiNO71v66jVt3vqZztnXK0GVy59poTrKUaBSsxZcDNmfQiz99bdrzT5SV
         yo8g==
X-Gm-Message-State: AOAM530SrP27wfCu2UvZH9ZYNvmHxSuwHfExPxlCvbslr7E21pDs68ms
        loRtAym/1t3vY5rTd+0NV4P079bxTn4NTA==
X-Google-Smtp-Source: ABdhPJyEx7MyqQObVsEyFOX73/Cz4mY6GLazw99E+c/jM6dz0HgcDq7+7q3umoqET96qAYxmD2uhUw==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr24160301wmb.77.1608687479169;
        Tue, 22 Dec 2020 17:37:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/20] mktag: allow omitting the header/body \n separator
Date:   Wed, 23 Dec 2020 02:36:02 +0100
Message-Id: <20201223013606.7972-18-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change mktag's acceptance rules to accept an empty body without an
empty line after the header again. This fixes an ancient unintended
dregression in "mktag".

When "mktag" was introduced in ec4465adb3 (Add "tag" objects that can
be used to sign other objects., 2005-04-25) the input checks were much
looser. When it was documented it 6cfec03680 (mktag: minimally update
the description., 2007-06-10) it was clearly intended for this \n to
be optional:

    The message, when [it] exists, is separated by a blank line from
    the header.

But then in e0aaf781f6 (mktag.c: improve verification of tagger field
and tests, 2008-03-27) this was made an error, seemingly by
accident. It was just a result of the general header checks, and all
the tests after that patch have a trailing empty line (but did not
before).

Let's allow this again, and tweak the test semantics changed in
e0aaf781f6 to remove the redundant empty line. New tests added in
previous commits of mine already added an explicit test for allowing
the empty line between header and body.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c           | 2 ++
 t/t3800-mktag.sh | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index 9067a290a2..29c1eaca4c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -987,6 +987,8 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	}
 	else
 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
+	if (!*buffer)
+		goto done;
 
 	if (!starts_with(buffer, "\n")) {
 		/*
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 1019b42378..9383f7795b 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -432,8 +432,9 @@ tag mytag
 tagger T A Gger <tagger@example.com> 1206478233 -0500
 EOF
 
-check_verify_failure 'disallow no header / body newline separator' \
-	'^error:.* extraHeaderEntry:'
+test_expect_success 'allow no header / body newline separator' '
+	git mktag <tag.sig
+'
 
 ############################################################
 # 24. create valid tag
@@ -443,7 +444,6 @@ object $head
 type commit
 tag mytag
 tagger T A Gger <tagger@example.com> 1206478233 -0500
-
 EOF
 
 test_expect_mktag_success 'create valid tag object'
-- 
2.29.2.222.g5d2a92d10f8

