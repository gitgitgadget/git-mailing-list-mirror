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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCEE61166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhIUW4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhIUW4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:56:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F033C061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so1415087wrb.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYeeWQMPaLi3LimZFAioYHAKtZxlhyoTad6RBYOpNnI=;
        b=NXjczHm1nsUmW4NyJF74oF2H/ve97RM0dNoyI+74O2janamtXY1PFEJZ7+YfQtnGBj
         f6BtGRVhGXoa5aIvDUSP6RTVfsSfK5+GUI2MXoBBUax7Tq75Ja3X17jtbcI8BS2/C8VY
         buFYzvZBQAhQ/rePxrovkgFNn3bORQZg1NVCUMJsOcz51xYnBNfiBJPau27HRp4C0jIQ
         jAPrdYddLwDWwPIAO9Ea6XGgHbI5ECzTexH+dA14Ue9H2FfZpcnOjLsMveZZ0d0dHrWP
         Y+ZZjLARdw0ircUCv4FcSvYNRWf8w/BRXwlHuIYB7grFXQ9fR8gFN9lMr6pEEVkOAGHZ
         Uxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYeeWQMPaLi3LimZFAioYHAKtZxlhyoTad6RBYOpNnI=;
        b=hRlS2b3UAcdwGc0hYzfBF3J0JYWzM3l/U8LbPcjR8VU2dVoU1/suZMyKisfzUPvewU
         qWzueATBXxvjHzo5FlQJqH3AUpWMHY0gSzgfALqTyPCsDUexK+SzvQ2VELe0HpcF+RUj
         MW/Gnn3Nk+zaLozfUG5kEBdqUOxT2wo+s5/EIDInKH9GK0jpzZ3whF6ZUkLgIFum5x/g
         ZuJMCo6M+pVyo6ybjzeRpuvQa0E72zN+rgy181SdK5ZxdkNKW3dWrXIfzfnjYAlDigQ1
         SHgsbEd38ByxbLjDWNfk0eeFYLqG2zv0KnFzg+I82ddlHgiy3MKEGFzQJ12+bAK76ili
         /bXg==
X-Gm-Message-State: AOAM533x0ZTFqVt0FXE2tiiZa6m7FVseK6Bb3Z+NtoqIwNMR4XTeHhw5
        EOKVMrxs0FWQvaEHIbGsIB9a4yoXL7px4g==
X-Google-Smtp-Source: ABdhPJwZcvieyz0qG6ysbctJT+wD+6ADEMEzbdFKHYaxe9tvNXW64VZzQeoXKLcJ7mkUDKVOyjjTTQ==
X-Received: by 2002:adf:f185:: with SMTP id h5mr38576432wro.302.1632264920361;
        Tue, 21 Sep 2021 15:55:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s3sm399474wra.72.2021.09.21.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:55:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] Makefile: make the "hdr-check" target non-.PHONY
Date:   Wed, 22 Sep 2021 00:55:15 +0200
Message-Id: <patch-3.3-e2ad1700f9e-20210921T224944Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the same reason as the preceding commit (which made "sparse"
non-.PHONY), let's make the "hdr-check" target non-.PHONY.

We could also change this to do "-o $@" instead of creating an empty
file, but there would be no point, and it would just waste I/O and
disk space, we're not interested in the compilation output, just
whether or not we had an error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore | 1 +
 Makefile   | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index b02250a50c4..4579985e2f4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -220,6 +220,7 @@
 /cscope*
 /compile_commands.json
 *.hcc
+*.hco
 *.obj
 *.lib
 *.res
diff --git a/Makefile b/Makefile
index ce4063a031a..7980e69955a 100644
--- a/Makefile
+++ b/Makefile
@@ -2919,10 +2919,11 @@ HCC = $(HCO:hco=hcc)
 		echo '#include "$<"'; \
 	} >$@
 
-$(HCO): %.hco: %.hcc FORCE
-	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
+$(HCO): %.hco: %.hcc
+	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $< && \
+	>$@
 
-.PHONY: hdr-check $(HCO)
+.PHONY: hdr-check
 hdr-check: $(HCO)
 
 .PHONY: style
-- 
2.33.0.1098.gf02a64c1a2d

