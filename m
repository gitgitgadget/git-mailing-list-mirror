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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B037C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F76722D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbhAEToz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbhAEToy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C8C0617A6
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 190so608055wmz.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cmw+KtIkVva3phLPHPxZT2YEJYOfdGs2hrBDNqixXno=;
        b=Wk8TdAq/XnJgjJ8mleAcuYubFDJEuWA/Nv2kSkMFgxaYYUIgaTjY/ujfu/YB3utwun
         EZlfPa8SWQZ5Bc4fLrdreOygkyIbtKvCEltwdpHrrMXSvej+w/p/XTzlUW2zRts+5Rqp
         Im260AM/vR7A498CaqglxNniaB62YkCl+lT7rh8EdjfIIpb7d5lVlwee2M2gcs6vppSb
         XS6U+Jg4zThrHTAgjXZ/BPajSIMCWPL70THtrztNzbBVxJVyPvuspSa7ep4ZUB+FrV7Z
         y/bWfwO1mbuPo2o5QgBF5gA1tbKamqT2ssC3b/aWFTFcK0T0wBTEOinHxuBSMPtJ/6Ei
         6ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cmw+KtIkVva3phLPHPxZT2YEJYOfdGs2hrBDNqixXno=;
        b=EyDidKOGmA+FtVEo62jSEv6bfbtqbawG6OHKcfy3JXyY3Fhm97c/0yhXaeCpD7abGC
         P3AdjFY+w9ARYOTPL5WAT2fVfXIaH/t78Ulw7frXSpRoLIZPJLwdjkW1TfZV8mFcfMpl
         6E6PWbm5CQVLpoji0oOxh8J3Nzct+Ha/mcnFUBlA1mgCeAVQSA9y6bM+X26nEIFazDEU
         TZjlolEiK+dVn1KRdp9IsqoutjMPZWWsDY5J6UlnZXYkh/PDl9vr/QuTUYO2E9CLI2fV
         1cCZbuwCRuj2TTla+0rKWkgkqflTbEn7gqgK+SgG8Cq/SZi2rxo0RZVY68/DQ8Mg28Re
         /bIg==
X-Gm-Message-State: AOAM531R0IYa1EEHQyJ7NCtZH7YTTpIcDp8EcILwgDdg0jUDL1wKEHf7
        vDjDh81CnJYHxgDDQteEVn9LVylb77IxLQ==
X-Google-Smtp-Source: ABdhPJxXih3PgtH8UEFIaVCBe52r/Fim/qAycOBSwbmO5b2eY5EOKZpRTu3LnBf/jZ2VZiEBDto9pg==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr595878wma.17.1609875821031;
        Tue, 05 Jan 2021 11:43:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:40 -0800 (PST)
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
Subject: [PATCH v5 13/23] mktag tests: test verify_object() with replaced objects
Date:   Tue,  5 Jan 2021 20:42:42 +0100
Message-Id: <20210105194252.627-14-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to demonstrate what "mktag" does in the face of replaced
objects.

There was an existing test for replaced objects fed to "mktag" added
in cc400f50112 (mktag: call "check_sha1_signature" with the
replacement sha1, 2009-01-23), but that one only tests a
commit->commit mapping. Not a mapping to a different type as like
we're also testing for here. We could remove the "mktag" test in
t6050-replace.sh now if the created tag wasn't being used by a
subsequent "fsck" test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index ced540035d4..fbaf648491f 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -38,7 +38,11 @@ test_expect_mktag_success() {
 # for the tag.
 test_expect_success 'setup' '
 	test_commit A &&
-	head=$(git rev-parse --verify HEAD)
+	test_commit B &&
+	head=$(git rev-parse --verify HEAD) &&
+	head_parent=$(git rev-parse --verify HEAD~) &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	blob=$(git rev-parse --verify HEAD:B.t)
 '
 
 ############################################################
@@ -180,6 +184,35 @@ tagger . <> 0 +0000
 
 EOF
 
+check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
+	'^error: char7: could not verify object'
+
+############################################################
+#  9.5. verify object (hash/type) check -- replacement
+
+test_expect_success 'setup replacement of commit -> commit and tree -> blob' '
+	git replace $head_parent $head &&
+	git replace -f $tree $blob
+'
+
+cat >tag.sig <<EOF
+object $head_parent
+type commit
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+test_expect_mktag_success 'tag to a commit replaced by another commit'
+
+cat >tag.sig <<EOF
+object $tree
+type tree
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
 	'^error: char7: could not verify object'
 
-- 
2.29.2.222.g5d2a92d10f8

