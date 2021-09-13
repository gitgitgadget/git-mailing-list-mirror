Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD6C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C2260F26
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhIMPiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbhIMPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487C4C020E74
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so14375947wra.8
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B03ahexfe6TLmP0FL/ueG7or82rBukrg7Htb7qQQX9s=;
        b=TuGCyZjQBsAauPRiD2ledf09YMoq7zv7hkiOhj7KddoZrITgS263DJjEeJZUzNjjsw
         u2dJ8vSg9C7SH/KFAbaB4QLBYD6m544yz8C1v/ceujbXekoNyu+TyqNjdc1A9p+P4deW
         W5b7QFT/Id0+6Nlk4+3vzQIXl5dlSZuI8Wc/U091Jz1oNpXZLzzf8r08H9QhPX5QQGFu
         Ycg+8XdIeuB58kolMc+ZrfVXZZ4N8JQ+CbRnejCOY/PnmOYNAABxLChSLog24mO8KGq7
         ql8gK1pVdp6mcMHG1NHrNhzrvIB7tPW0X2oTmZAdmnmdJDwoS9Jt81Zqtq35Z3cwrEYs
         x8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B03ahexfe6TLmP0FL/ueG7or82rBukrg7Htb7qQQX9s=;
        b=7AX70vzXwfBvajzuVVz2hIh8x/L1b4r9m0iywdD0EfzjHfBqKD4kZuMnRy6CJUc//T
         wo3kvvPpy4qPP+aJDNRVR9eBaGOLPdsCfEENThMjgwigPrWXH+xKG7TpUWbjlMrqAH77
         MhYKQQzSfI3zm/nnqUCsDaOoGIRsiiA+Kv1nhY/s2/hwVXKFMKsW3K095wiRTDvCrNnN
         5NXZD/l8VhB7yc1hNTdu9T3KWVljGX9YvoLQawSd4XDihC60yWqLLoCEHJUPwRSZ/8Kn
         YDAMTfcNnSKc6wmG/E32WIV2S81wJfDxvdfweXlFCmDudPCEJzbUXYGma50FIbJfSNbx
         pwqw==
X-Gm-Message-State: AOAM531fQvtzDjxorsx8VXqAMuX1Bk7vPUH+C8rfKUMEC+Xx4TDhH0Lk
        H2l/FehqK169a+2j011nNK7a67zE8Wd8Wg==
X-Google-Smtp-Source: ABdhPJwPpy7JiQZ8Nqab+S21eU+ghwj9IjCTHiSgTWd/f4CM1+XWrSO8TAz/LwhqIpiir7U3LA8JeQ==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr13389317wrq.131.1631544695635;
        Mon, 13 Sep 2021 07:51:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/9] INSTALL: reword and copy-edit the "libcurl" section
Date:   Mon, 13 Sep 2021 16:51:22 +0200
Message-Id: <patch-v4-2.9-2f3a09c98d2-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "libcurl" section shorter and more to the point, this is
mostly based on suggestions from [1].

1. https://lore.kernel.org/git/YTtxcBdF2VQdWp5C@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 5b8bd5ccce1..d593f628749 100644
--- a/INSTALL
+++ b/INSTALL
@@ -138,11 +138,11 @@ Issues of note:
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
 
-	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
-	  the curl version >= 7.34.0, for git-imap-send. If you do not
-	  use http:// or https:// repositories, and do not want to put
-	  patches into an IMAP mailbox, you do not have to have them
-	  (use NO_CURL).
+	- "libcurl" library is used for fetching and pushing
+	  repositories over http:// or https://, as well as by
+	  git-imap-send if the curl version is >= 7.34.0. If you do
+	  not need that functionality, use NO_CURL to build without
+	  it.
 
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
-- 
2.33.0.1013.ge8323766266

