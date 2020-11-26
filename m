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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA3C64E7B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FA321734
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vheuS+52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgKZB3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZB3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250BCC061A52
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so360950wrn.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frXuVI0AIjBgEXytIBp3zbMeabIxHpPeNvuAp18QlY4=;
        b=vheuS+52ZHc1e18hos/AiLVoX/k3UAAOHqVEy9318sJNwp57DnthBOCsws0iM1Yaft
         wLYPN63pAYyyAAKe6C+jDNhgbg2Avo+wVaAlONt7X90R/eSPRgiaQfyR3O854Urc8Hcg
         WbUKt1ATn3SUl0rFWBNZOKK3qUkj9qpEx6Z8RSlk+RF9D6/lrDlZ9DkY512hcXId9VDm
         5kUhZLoSbf9I7m8MRdWUPgUmgI8wZkiKujALBmnNbZwAxaz7xKwZum0ArQLsgaZvjfvV
         dKy3i/pHmxIVKZY19zVYPbZUw69ziT3Z0nUMq+1yUgI0TRy/P3qO1QAduh3DVp+2VWHK
         SQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frXuVI0AIjBgEXytIBp3zbMeabIxHpPeNvuAp18QlY4=;
        b=Ide+jVU3l6npjN6F7gXeO1cabkSdBmGLbTlJqp2Vfr53dZtzTWBZ70R1w6bd8dvt72
         6BjJfzM3kyjpXnSv0McGEXLeORAcr+Fo8Ur9vPtUC6z7eZ1G7FiMQ+t2mkNwosvp4itF
         UbYp4umovwxs2klpPyq9madzqjfVgn81w8U/UgSYDli9nsGCDiLD8riBDruz3evqn5UO
         ISyk21olOWtJ/y6p0+7jn1WWbKAtC8TdZw30k4JqX2Y6111Rn81Z9D+1tsJL2km3VWD9
         5wZDEU+CSOjnKxMSACIBlSIFji0Q5VZb6IbRZRQdrZu4l03VDdaajrPClC9yYQvtdEV/
         SkzA==
X-Gm-Message-State: AOAM5319pwswzkCtAdN3n78tIy6wsOcHditZWqA2HdHrf04HFJyU9s3K
        a/PK/uhG+CgBB42uIF11eghrY903022BQw==
X-Google-Smtp-Source: ABdhPJyppah7MxrMH4UI0OhxRDLd1BLSQj2iDIQ0NdmZJOYNWA3LOA7XODBsQRd/99iBu088phbWKA==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr725690wro.61.1606354146676;
        Wed, 25 Nov 2020 17:29:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 06/12] mktag tests: improve verify_object() test coverage
Date:   Thu, 26 Nov 2020 02:28:48 +0100
Message-Id: <20201126012854.399-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_object() function in "mktag.c" is tasked with ensuring that
our tag refers to a valid object. The existing test for this might
fail because it was also testing that "type taggg" didn't refer to a
valid object type (it should be "type tag").

Let's split these tests up, so we're testing all combinations of a
non-existing object and in invalid "type" line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index b5013af2aa..3801d3a285 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -128,6 +128,28 @@ check_verify_failure '"type" line type-name length check' \
 ############################################################
 #  9. verify object (SHA1/type) check
 
+cat >tag.sig <<EOF
+object $(test_oid deadbeef)
+type tag
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (SHA1/type) check' \
+	'^error: char7: could not verify object.*$'
+
+cat >tag.sig <<EOF
+object $head
+type tagggg
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (SHA1/type) check' \
+	'^fatal: invalid object type'
+
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
 type tagggg
-- 
2.29.2.222.g5d2a92d10f8

