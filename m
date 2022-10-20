Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CEFC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJTWni (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJTWnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55722BAD8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id iv17so1030074wmb.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amaq7l5TCsxW6yceQe9dZQYb3qBQ959BYCxu/DxviJE=;
        b=X3vtRVf0lPfwM8Qn14DDH4tfr9A9cONs51DCZhEc+8DyqGvxNVzJ4nV5pORF7Rwjm2
         IFp+xXhGJ2MFeDe6czGcX4BZt1NsnQfRgHB2kV8fu15595v8DS/Z5j8IwjR3U0vxbLpH
         5tNF88rGT/TsaHyDoLhLl/wyJe1w/rNi/pqGbuyDIvlE9K/9rlpeU80c2jDL1wf1797x
         ewZx7VhlDS1NJxp02mxTfqmc0OdmRUjBK11mDtlyVcSWrLrxeUDsNKl0j3ivgRtNgoTk
         J5pkk+jKJEi7tD2YBU8XSF1tzW3L7AUoAya0brVtWZKtxm0jadyDdafJM+t14Ho24v9e
         8sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amaq7l5TCsxW6yceQe9dZQYb3qBQ959BYCxu/DxviJE=;
        b=mFuUb/P4ej4M/wQz/i6mjV9cygX6HcIUF9Gtw9DeKUkhJXQ2Yna+jFzVEbh5ubEoB8
         M0dbMFEC2vVoWdafjviVhnu0nrdZnfWb8nqUITPQ0/+txe+M02MVx4nWe5zHEzcDgu4w
         OhwGEPIzJWH5wibQi3KiqXwTYO6xjBmChgG2zs1nXooZaEflxvti/BfqY7wz1d/38ZS0
         cxQCktgxqk9P+GcWWz5Fnd9MFSuC6uUJ/n+IxPkszbI6mhB5F6vUyWLEOAlhe4z9s4fm
         ULJPlIW+tWbnI3avtZM77efCmogMKKe04jrUsCj/1aGOFdxAWRSZ5ZOMOVwyHZAJYvN9
         qKsg==
X-Gm-Message-State: ACrzQf0cyQSLrHB1AZvwOqTeOvv0+4meuYLm3gIuKZVUZ1Zkdcox4hqa
        2RizjvEMHFNX/aZKWkH68wk0XeLrVnR6cg==
X-Google-Smtp-Source: AMsMyM7CGOvw61qWildoQpF8YHPE7N8JRKBYtdn3/1s2g6GfWSYRFohQ4fgdnSq1WdSwBzlRFC5qEA==
X-Received: by 2002:a7b:c005:0:b0:3c3:6b2a:33bf with SMTP id c5-20020a7bc005000000b003c36b2a33bfmr10709405wmb.167.1666305810206;
        Thu, 20 Oct 2022 15:43:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] INSTALL: remove discussion of SHA-1 backends
Date:   Fri, 21 Oct 2022 00:43:03 +0200
Message-Id: <patch-v3-2.9-017a0a9791c-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The claim that OpenSSL is the default SHA-1 backend hasn't been true
since e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17),
but more importantly tweaking the SHA-1 backend isn't something that's
common enough to warrant discussing in the INSTALL document, so let's
remove this paragraph.

This discussion was originally added in c538d2d34ab (Add some
installation notes in INSTALL, 2005-06-17) when tweaking the default
backend was more common. The current wording was added in
5beb577db8c (INSTALL: Describe dependency knobs from Makefile,
2009-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/INSTALL b/INSTALL
index 89b15d71df5..33447883974 100644
--- a/INSTALL
+++ b/INSTALL
@@ -133,10 +133,6 @@ Issues of note:
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
 	  NO_OPENSSL without losing git-imap-send.
 
-	  By default, git uses OpenSSL for SHA1 but it will use its own
-	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.
-
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
 	  git-imap-send if the curl version is >= 7.34.0. If you do
-- 
2.38.0.1178.g509f5fa8ce0

