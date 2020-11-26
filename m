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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB81C64E7D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF512145D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p527zWv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391806AbgKZWXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbgKZWXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADECC0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so3714659wrt.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+KJsND/oeERASCD+pfl5SbNdfZIMHRxJA7WE8qitKQ=;
        b=p527zWv8Vf+T2x6bMSwOLZCZC3m6v4g2ly/OYelbJFN3Z86JFGXdIB62kwoY6voRJG
         XkuouNE55BdUlOdST2m/Z6ltes2S8ampwtUQ/2DEwHLIwBXB8HgTB1yeL4FjXiPobCtV
         VdtvdaG6pLk++ti4X+wcfOYIqi6HOyNuqDfhhlpNmgjio+8vChluUccWbjGwTlWu22dj
         v0eQbv2HFmYwCkcjkhqo6SZr1iKPiCYq+fTtguNB1flJkguaAFQoVd1RvlRZhHATtVo7
         0m3J0crn97NJKCBoNZdmlzSb085oVEeNIpcPbfbNtQuxkvGp4aIfkNfVT+/SsAub0y9y
         2IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+KJsND/oeERASCD+pfl5SbNdfZIMHRxJA7WE8qitKQ=;
        b=hIrenocKBvEAXPss8AAQCybDfEVZ8z+pxiRvhfMl/eOn7pp8jKLHnDORnnO4tJIx7J
         FtjR3edO0TUjPay+2mQLHsFaj7GqT1bCOtJX33OexXgSJ0Psx35zrS6ZRJSGdHe4sYxg
         6kEym7gKzHIaLHsdAude4BfqC/4TRI3bX3VHwUeyklwRtjJCdoq52H9JrSIn0OZsFDLw
         FU/v8aRH5vkfPG3NoretwdQArSOmbGcB0XoPNIfRMxe3uuIFZzo3spl6KUCIGv/HjJC/
         sHlE2JMirbJTTrrIaxFhPSsLV1pnmCJg3ORk8R3EfxKVup/S8gpTG1OTV7OFwlQx1jvK
         WoVw==
X-Gm-Message-State: AOAM533Led06+Ve38YHsJRRHu0m8KmoGhiZYX+K7I+9F9/765o3YdJZN
        weTim2fp0lGz/N3eZam3wpG+M7aycgkRog==
X-Google-Smtp-Source: ABdhPJzbr6z5q/AJf8A5XhUdB8Ng/RKbX7MB8RFESpKFxAaOUrezVY7z+Rr1T9q/vPuGKBUeuRRxng==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr6537254wrs.393.1606429395996;
        Thu, 26 Nov 2020 14:23:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] mktag tests: improve verify_object() test coverage
Date:   Thu, 26 Nov 2020 23:22:54 +0100
Message-Id: <20201126222257.5629-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_object() function in "mktag.c" is tasked with ensuring that
our tag refers to a valid object.

The existing test for this might fail because it was also testing that
"type taggg" didn't refer to a valid object type (it should be "type
tag"), or because we referred to a valid object but got the type
wrong.

Let's split these tests up, so we're testing all combinations of a
non-existing object and in invalid/wrong "type" lines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e9d7799537..a6a67b6f27 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -125,19 +125,52 @@ check_verify_failure '"type" line type-name length check' \
 	'^error: char.*: type too long$'
 
 ############################################################
-#  9. verify object (SHA1/type) check
+#  9. verify object (SHA/type) check
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
+type tag
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (SHA/type) check -- correct type, nonexisting object' \
+	'^error: char7: could not verify object.*$'
+
+cat >tag.sig <<EOF
+object $head
 type tagggg
 tag mytag
 tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure 'verify object (SHA1/type) check' \
+check_verify_failure 'verify object (SHA/type) check -- made-up type, nonexisting object' \
+	'^fatal: invalid object type'
+
+cat >tag.sig <<EOF
+object $(test_oid deadbeef)
+type tagggg
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
 	'^error: char7: could not verify object.*$'
 
+cat >tag.sig <<EOF
+object $head
+type tree
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
+	'^error: char7: could not verify object'
+
 ############################################################
 # 10. verify tag-name check
 
-- 
2.29.2.222.g5d2a92d10f8

