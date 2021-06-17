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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0863C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988E761003
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhFQKDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhFQKDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:03:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638AC061767
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id df12so688276edb.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkBqMAj37II0b82GDIevL14OL3m7NcWvRjykWzrv2pg=;
        b=cgLp9AbROKNWujHJxSrRfTLH1ZaqdnAdNP7O/iVgY0Piro7uA1gTUppR7Xtc9pHOCM
         6L9+1P1ZCtMf73L9IjIMJT6xdX4cgdsB7EZSwOPnjLEeRmHB4EsaWVeFEc1EN8u8GQLx
         ZyCOAklOXT7PcS6hUSBEYPluERTdHkdWf/YtccNRp1hM9qgAGVzLXbX00IQeuxSw66si
         DoZyjFz6uJpCOj+4pVUjDjqqAc2WVB0kX15JDye1tUZWbwMGeefFB7sd8rJC7XoPlzBF
         KiZxCmTK2RDs4nq/V3En7Ujx5V0CnkxA/rqo3Xou8QDiJKPNrUWrlajKk0rU6DHN6ZKd
         WCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkBqMAj37II0b82GDIevL14OL3m7NcWvRjykWzrv2pg=;
        b=VetAk6hV06cpi2BQVx2TRZxJbbuoiASdef/jCprNvMbFXGE4lhr38BzTTiS8w65wvb
         MDFbdd3m9ZrRdVRtA5utDa2GP9ZYagfxLqDq36HtSZkPzI/IkPkz4T5gD+BmgQ2frYdH
         YLo6/K9SWFezGqFpH8TIBxBhB5rZ2v8FTeiTn4vOaH0jqx7zBXNBSXe+ugiB5qSkFmCp
         buo2rJIsYbI2thPHKklK3toajemHPSEKX+oCT56aPS/07S1ffQz8KQA68oupdlZ6Odkt
         ycADxLuXgFtCkdL15ekF5kDIWYpZZjzb7NqJlcLQ85DLWYYI1mbVvhTlZMbAXCK5LKtT
         JlrA==
X-Gm-Message-State: AOAM530DDVoj2LS8Afxx9rIKXMEqepxAVYBBAClbS7lq8gfCWpNTogSH
        +i8pOcgnXBblK/6osVq5ud8MmSwUS5iIkQ==
X-Google-Smtp-Source: ABdhPJwvFIc6FcGYgq75mliFQqjKd0MLnMl/j/+Z19eDI8ROYe/WpUNTMgtpHQZV39dC6L8fZiBXzQ==
X-Received: by 2002:a50:afe2:: with SMTP id h89mr5499100edd.308.1623924101590;
        Thu, 17 Jun 2021 03:01:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7sm3827031edc.46.2021.06.17.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:01:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] Makefile: mark "check" target as .PHONY
Date:   Thu, 17 Jun 2021 12:01:36 +0200
Message-Id: <patch-1.3-27c94247f8-20210617T095827Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 44c9e8594e (Fix up header file dependencies and add
sparse checking rules, 2005-07-03), we never marked the phony "check"
target as such.

Perhaps we should just remove it, since as of a combination of
912f9980d2 (Makefile: help people who run 'make check' by mistake,
2008-11-11) 0bcd9ae85d (sparse: Fix errors due to missing
target-specific variables, 2011-04-21) we've been suggesting the user
run "make sparse" directly.

But under that mode it still does something, as well as directing the
user to run "make test" under non-sparse. So let's punt that and
narrowly fix the PHONY bug.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index c3565fc0f8..7f984bce50 100644
--- a/Makefile
+++ b/Makefile
@@ -2910,6 +2910,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
+.PHONY: check
 check: config-list.h command-list.h
 	@if sparse; \
 	then \
-- 
2.32.0.576.g59759b6ca7d

