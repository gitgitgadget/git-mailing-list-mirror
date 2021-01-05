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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9CFC43331
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D3C22D5A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbhAETpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbhAETpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43FC0617B9
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c133so587706wme.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZPPyLUhLb4dEp71bYMU5YEk5p1+ypy+0G9pkGPzcio=;
        b=DAzKG+Cos2h9uX9VTBOS7AA4d413lpe8ovgMFlDbV7Pk4yBbbPVwHi5tHn/jKpT5Wq
         PV8yI/XYeHgZVvlKFvHN7brdpjbnTg/GfBt1arEJGyxwaP/+76dTp0unf63LM2OWG51t
         z+19xAhrlytkp9CGl5v2K55WstOXbOVYP5dF4saNuY1p5tsoIHeV3unAZ1UGxx/m/+p4
         yNziwN9XZVTL2wFwzsRWS9q8JEilEdM2B/i5xzjjpZIGR4FM9ln9fZ9WS4EwSqYzNqJN
         b6fmCM9i9iGOG89mNQxfhxQ/Cg1/+6oXdjLcXJNozNmTc77DzGMwyIREi/qFQbjHnpBf
         sM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZPPyLUhLb4dEp71bYMU5YEk5p1+ypy+0G9pkGPzcio=;
        b=Sxgr405YA7/1RnKIK2bCmTRFXPF2ZkmoZd6EtGkH8B3myES8FbWC5txbbpRttbONO1
         Gpa7NNPdl5LUIhRgcBDpX4w+xGEhLTpsdwUlPKjbAgx4V0qulejdK66t/d4J7BJef5R8
         +aiUMvfA4vaqqhCPJwOVnaAiAI243GFgOaP3e2+NP0SUzBdqzaAezUAhIWZHdcWE8Vuc
         dEdO+ekISNzZPjMvmBJNeT8FEWGKUtvRKD35+MBgzBD7GzcnVR1USr1ykwDB7uAsAJix
         QRuzIq9emr6hGJm35S0ol6z8ZTgei98UieYvcjiftJCzgHfWlidF2tcCnFw5i1kLcXRz
         DBvw==
X-Gm-Message-State: AOAM533Sglnkq6F1TzUmi3QAjbDRCZCc5YZp3GUyMgW7PSCQlKg7tHLu
        7qYyXfW7OtRTAnJzG3qcCFMOL0QJnAWEuA==
X-Google-Smtp-Source: ABdhPJxc77HaW1ey9Cgf+5NuxcBKwAl/1zlwOtoDLmOJVtEoi6al5WknXj+6YVFCVR5DzhJ3hlkrTg==
X-Received: by 2002:a1c:e3c4:: with SMTP id a187mr645624wmh.58.1609875828543;
        Tue, 05 Jan 2021 11:43:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 20/23] mktag: allow omitting the header/body \n separator
Date:   Tue,  5 Jan 2021 20:42:49 +0100
Message-Id: <20210105194252.627-21-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
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
 t/t3800-mktag.sh | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 9067a290a2e..29c1eaca4cf 100644
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
index dccf4503235..601b064e97a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -446,7 +446,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_mktag_success 'require a blank line before an empty body (1)'
+test_expect_mktag_success 'allow a blank line before an empty body (1)'
 
 cat >tag.sig <<EOF
 object $head
@@ -455,8 +455,7 @@ tag mytag
 tagger T A Gger <tagger@example.com> 1206478233 -0500
 EOF
 
-check_verify_failure 'require a blank line before an empty body (2)' \
-	'^error:.* extraHeaderEntry:'
+test_expect_mktag_success 'allow no blank line before an empty body (2)'
 
 ############################################################
 # 24. create valid tag
@@ -466,7 +465,6 @@ object $head
 type commit
 tag mytag
 tagger T A Gger <tagger@example.com> 1206478233 -0500
-
 EOF
 
 test_expect_mktag_success 'create valid tag object'
-- 
2.29.2.222.g5d2a92d10f8

