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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A1EC6379D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041552145D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3K4Oo7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391794AbgKZWXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391785AbgKZWXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E750C0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 1so3813469wme.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMxphDVj7IeRrDlyqqQGvFK5ry9X0MLYClQvtmWXq0o=;
        b=c3K4Oo7kQkJiDw5AzrgsR/FIL7umemDaQ/FAd5rS4RC51jLSOIfUNPY8sdWzlTuTzj
         lg7juIklwPiuPR/NP5OUTZoNZFpDXepnvgkM8w2tVgSPmEyZmx5Ybv2whiS0swDLTP3L
         DUL7BUkzn0gzi4A7VrnpCdRfKId7+WRHyTuzDZiZ8gvfvIvJZJvGgDgde1pqu1tBO9rq
         +aYhBAme+cS8cz73Rd1OPI84mrRaeE4RuHesm8S0Qw7TEeOCDcBWD60b4XAk9vtVf42j
         XbDMHsGPsVqbNQYADaATC79ZatvxjqSaGN2LjR3IFrsNAPUV3DNh0jYq/rPMnK13K40Y
         CmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMxphDVj7IeRrDlyqqQGvFK5ry9X0MLYClQvtmWXq0o=;
        b=PDuu3/3x92Dc5m9wEGXhlYnCxrLsk/LEv5XbEYeq0ATEaVIgPH8QvfY+asy4Hhs11J
         9S0QCRxFv2UxvcYgSgDYL8/9mmSC5aKxKZHcR8AbAzSGP4pt+z7jYJmVauGz5alHSJtm
         H5WXTQvmgiL4TsST+uV4spwtzm7p9ddTTlo/v1blBNRALbmjmwfzyPqA3oGB/GmzZRw1
         vj/hZxAFcz45uIFPekuU9O6puJ/kr7lzS7AaJxdD766GViBnZ0zzxqsBdYuRxenmmGjy
         LK7/7U7aiNscEo852LcxlTHC/3j3aOG0GuR7TemLi1r+++TjvgBj/AVwqnlYzJj674PR
         owGg==
X-Gm-Message-State: AOAM531l6IyxX3/9/8ItYMRSfArfAwn0j3dRdSsxJ5Y9XhSMjHwcdBl9
        7KS6VToZ/t61L9xwzkWb+8A0ncC66ZrpVw==
X-Google-Smtp-Source: ABdhPJzl4/78PDeAIymP/nQ4srccAToWMoBQKP1RT/4zPiQBSutMSPHsp03IK3p9oQeS2Xz3C21iAA==
X-Received: by 2002:a1c:a786:: with SMTP id q128mr5547302wme.115.1606429389475;
        Thu, 26 Nov 2020 14:23:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] mktag doc: say <hash> not <sha1>
Date:   Thu, 26 Nov 2020 23:22:48 +0100
Message-Id: <20201126222257.5629-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "mktag" documentation to refer to the input hash as just
"hash", not "sha1". This command has supported SHA-256 for a while
now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index fa6a756123..a158428eb9 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -23,7 +23,7 @@ Tag Format
 A tag signature file, to be fed to this command's standard input,
 has a very simple fixed format: four lines of
 
-  object <sha1>
+  object <hash>
   type <typename>
   tag <tagname>
   tagger <tagger>
-- 
2.29.2.222.g5d2a92d10f8

