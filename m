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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29842C64E7A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C545021534
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPKrcMTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgKZB3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZB3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:06 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7F5C061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so565430wmi.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgLR052BmWKstzCMaXV7x0thq6EyIOUZ/6tWgNnVfVE=;
        b=iPKrcMTgnvZVZcUpPHDtey9Q+I7ZpVouXAMF/xERaZt2lqYZyGdsxeYRdMd2vt6TLn
         AdBHpD5GehEHHlPWSiQdz19VqnQcgN871UqNHN4rZBZpAMRtb0jrMsB8pXtYfYrVW1vu
         /P8cjEnfW68nIUhXUIShw9XJL+6VsTQgbwL0ApAL83DWhR3PdpnFjloyI4daCLLGs2Rb
         iXb2PYM6o3pfFVPgFVWF5iclYfbzriGVJEud1MqcbkCs59XWRlt6qPYcPuKFHJlemuSI
         8jUukj7QfCqhmxyWb9gmPCYwC8TSefX7oPW04WkYKIeoX34A72xnb0EbLyF6UqSr0IR7
         0BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgLR052BmWKstzCMaXV7x0thq6EyIOUZ/6tWgNnVfVE=;
        b=CjMMIhSviKV49242O4CmoX2EJJA55c4YfGPfVF728U9QIV+AYU7z1OfmKspo8gNYI0
         GsAG6eyOujxsFQm+INJoTIAWQQNSABzHmabDWq6zaPmfI/op+sB1Xm5e4gIHn9NbRDzq
         Qc5P5AAzLwaOZ4zBmnaLYKHK2bEzVVd6xlnn6IGteov0ySazgweVDP0BWOuFj+RcBmqu
         fwRMIcXYJZ/dQ51NGPLNJ2fMPCJk/U6Su9COox5g90JkqGOGpam2eVWsahDRYfyQJT9P
         8r0wx+i4R4r//tp+bAYt6n+YNs6B1LsTAwH4mkkZqUpmONpN04orr1tE8lJMzX4V/z1Y
         UypQ==
X-Gm-Message-State: AOAM533qX35vpRCmOnEUjG7tXL6uv8H1oYA84PDQ8i0Rkmxpjn89aS9T
        +CErJHv2AOvhs5mnz5JtxKUo8gWC0NjFaw==
X-Google-Smtp-Source: ABdhPJwdNjPjk+wTdbzU1lbdaxyx2i3staBoU/GbLj2Uba2gEfABrblAZD8dVy0w/GM2RlWdXMAAEg==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr457438wmc.57.1606354144581;
        Wed, 25 Nov 2020 17:29:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 04/12] mktag tests: don't needlessly use a subshell
Date:   Thu, 26 Nov 2020 02:28:46 +0100
Message-Id: <20201126012854.399-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of a subshell dates back to e9b20943b77 (t/t3800: do not use a
temporary file to hold expected result., 2008-01-04). It's not needed
anymore, if it ever was.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d696aa4e52..0e411e3c45 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,7 @@ test_description='git mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		( test_must_fail git mktag <tag.sig 2>message ) &&
+		test_must_fail git mktag <tag.sig 2>message &&
 		grep "$expect" message
 	'
 }
-- 
2.29.2.222.g5d2a92d10f8

