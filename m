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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D72FC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FFB2256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLWBi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLWBiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD8C061793
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i9so16990074wrc.4
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMxphDVj7IeRrDlyqqQGvFK5ry9X0MLYClQvtmWXq0o=;
        b=pWRZ+OSxIXGfcUbtIyX+v7x2/gKKJxfY8wvRXkmKcMpGEsDYmev7lc3rW4TP6ELlbe
         bx0K6ur6hHv4TF6UNve9nHeh8Aujc6MgVKQ7n2X96J6lqzbGqEJbm+uq85fwkYlfdk26
         PCynWK0UWOdhfLQOp4rcJHFXbgkLdKb/rcgZz8dznBd+exn+ebEJ2X7lE5WE953yoAPF
         hQrQ0lTFILsLQ7zC7Wt7oP2h2yIASWZm+Mw47OgCUXDdc81eRAfKQU9aLsbUaY1sQBWm
         0y3UfZjxwexbQa0CvFV04psxJdcV8aQvzz2Ev9UTVSe3XGJSjihpNfA8xKybPFO3P2kf
         NH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMxphDVj7IeRrDlyqqQGvFK5ry9X0MLYClQvtmWXq0o=;
        b=XXfVB6dYL3ANcR7TyMhSZdtdFeqMRTVcApzZmshfdwSmLe+MogWCAOifdO9TomTn7F
         Ix6kkTpFfTtkAyryxgtB59ZcfBFiKNdSknJ1QLTRJfNST4+ffSFY8XiPIe9MbAcDjj9c
         51Z5RZ+gDjxDl9l8FE2jxS3JI4IXU8Sr8euqBNWYG6iXYXJN7ZdfOndR2GaMKqA0GZ/k
         8QDt0UH9Hcwy9xgak+X/Wiq7USxqW96dKX/ixFnvKr8NQqwOx0pJ4UXOnOxk26WOV5IW
         HR5LIoXNoXrIszRN9nCeZF8f+/YveM34xzoJO/aFl6ku0YyVHjOE9efgZTT9IF+FO263
         +Ukg==
X-Gm-Message-State: AOAM532Qh4fIjSmi/5F6sHPVm947euqJdaUHbS5g1Y+K7n/xT6NSoITi
        XbQgaMKdklhEf26tz6v1GmOCkp+vcLU9oQ==
X-Google-Smtp-Source: ABdhPJwkZPhZ0SJlzjxE+eyPvpGjYi5wdFBmr5qYaJjfmuW+KXFf4gbJnz8ZI8R0sAU6Ou59CjnnLA==
X-Received: by 2002:adf:c40e:: with SMTP id v14mr26823722wrf.163.1608687463304;
        Tue, 22 Dec 2020 17:37:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/20] mktag doc: say <hash> not <sha1>
Date:   Wed, 23 Dec 2020 02:35:46 +0100
Message-Id: <20201223013606.7972-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
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

