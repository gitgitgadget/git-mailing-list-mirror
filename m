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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB7DC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A012256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLWBia (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLWBia (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F2C061282
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e25so4626777wme.0
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgLR052BmWKstzCMaXV7x0thq6EyIOUZ/6tWgNnVfVE=;
        b=surnxKmZzgAr2fHkhdOrGvUBsCj1vUFHpzFiaVT+piMutXflwgyouwtonL/9hQCES4
         ukPr1yn7a1R354WsKvlHFFxaewMdUINzngbTURQWpBX8mG1Pj/RurKUTQlvmTazxxnzi
         avjadprP6lnhYH6nYxrfkjAr64nBSZA3BR7ujSNRqEjCxswxJi+aSGaldJ1FE6LEKm3a
         8+viZBkBd6QU2HihcMLrrizv2/YQ2XnAw+QznD+bq+8L7Hd3UZBFt2mIO5Whv8YFS6CN
         N9fVH+77yKYyGzdc9sPVwRxvFlX+xHE8BZkigWYLcNMQlzHCWRC+OWwZqaSf3+zXhRIb
         h64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgLR052BmWKstzCMaXV7x0thq6EyIOUZ/6tWgNnVfVE=;
        b=Cnx1q/lRcAdm838PKDZ/iTakJ49He+gkIHSJxOqplTmrzozMmNZvlh1ZXgMkmlrlZF
         q2BOFB2IszY86K9YWmlYNXRfuOCY/ZFLAInC/7ck+vO+qhdThMrCH3xoc8+yCRJBCPYB
         HNCHyY22EkLoPkv97Nb3e6S2m/yM0E4CkzcFtgDxSbwKyVQ2didM7GKjZnTcxgpr88Kd
         wC0giDuML1jVrl/IdlJUQ9udz6gHKx8mXLL8eZ4qBTk/0u+3/Rbk/if6vSJfqfBwG/+K
         FdRcENqNohK/rEMXAVlzASdQpS9KoH5ElQirfruiOVcAa7n+y3uqoeLo7soy5364oh5W
         UyZQ==
X-Gm-Message-State: AOAM532/v2sXDb5Bi5p003G20tvzR3PJFuHA8Ui7swguJZGjeaaBUdJh
        BowHfLeBMYuMdfPV1UZslEKABQsmPsCJNA==
X-Google-Smtp-Source: ABdhPJx0+oaiNiAvIDQGg+NqW8wEMBRt2vsMW80i77+9pYQBfdGmXrl6ZvOhY+F3yfTztZjEUzgrqQ==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr24258996wmi.35.1608687466447;
        Tue, 22 Dec 2020 17:37:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/20] mktag tests: don't needlessly use a subshell
Date:   Wed, 23 Dec 2020 02:35:49 +0100
Message-Id: <20201223013606.7972-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
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

