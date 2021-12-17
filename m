Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03AC4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhLQA0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhLQA0m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB832C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so912051wrg.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzrG+96l2LPWTg8/TsoXxU5IWjS8QhJcy8AFixPPgIw=;
        b=jZDQtUOcCwMcmey5QlhXnZQtMRWGl/kiedSK1Cp9LGXX7cWCSuiQ8pkczuDLCZqNur
         Q35uigD0pNZkq5OXHA9HZb/YTni7ot1NvNOJBSVxwnB3Ps6fEwjIQA2LqOa8UJ+qXXrK
         Fmm+Wz/Eu3NM1P4wwSUu2s8Lu0qENeEgmUnSbTZQ73orLGJxkKuSZVXJwhBfqV8hxDlf
         J3jW/Jg3QXgaqHY9zi4glPttoPuF/WfY8m5yd8ASChNSyMWbp7LqEzBUXB4q7Q1iOmIN
         I/9dVCinl928DeiJ0+yG33rvA7gfd23cxA8BfEKZFfy7FRKrLxK6ECS/0Z6tf7YynVtF
         VHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzrG+96l2LPWTg8/TsoXxU5IWjS8QhJcy8AFixPPgIw=;
        b=5P0NF7lGQDhSFw3zJUrH7MjTZMHZmtb21Af/gTfCNAT7TVQ3MU67LQzYpG/CAA5hUI
         cVFQx2O/XKObX4EYAI/z/aRxKfWgjOHoV9jUcPVjviVLSMDl2hD+CzyUGH4dwzHpIbdi
         BHJXxL3u4aQUSaYcnFlB8CjjMnHQ1nMWOCC4guiE18rlUBrQtgDqoELw0g1dKvhAQeF8
         +zr+t9ysWU4zsUOSK4eXy1NmKJBaq9VYsotk15wtuDnOFLEi1n4LRacGQ9yylXOdhhsm
         SuiamT1aqTHx7jpVa6KqxkZKP5nBx6NULTYRAgw0Eb30iOqU32JFVQlUxzfD+Q1WnPul
         JtjQ==
X-Gm-Message-State: AOAM5326SiIQmN6LBhf5+d2KY03RkDHSlPtYs+B4OD3OPLES3OuqrA3O
        O8dXtQTH8Yg+b7fCkLyH1LrDEvJVlO+01w==
X-Google-Smtp-Source: ABdhPJyHr54vlPc0poaMYB3ooGLDpGNk/7mB0kK6MLClJjhN7ZnHEI48/GqZyM8DOy7pbZnn27H5qg==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr371614wrq.28.1639700800223;
        Thu, 16 Dec 2021 16:26:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/11] Makefile: sort PERL_DEFINES list
Date:   Fri, 17 Dec 2021 01:26:25 +0100
Message-Id: <patch-09.11-5ff768a5cec-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sort the PERL_DEFINES list, this will make it easier to maintain it in
the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 356c98dff45..3be3dc9621d 100644
--- a/Makefile
+++ b/Makefile
@@ -2321,16 +2321,16 @@ endif
 
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 
-PERL_DEFINES += $(PERL_PATH_SQ)
+PERL_DEFINES += $(NO_GETTEXT)
+PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
-PERL_DEFINES += $(perllibdir_SQ)
+PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
-PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
-PERL_DEFINES += $(NO_GETTEXT)
+PERL_DEFINES += $(perllibdir_SQ)
 ifdef RUNTIME_PREFIX
 PERL_DEFINES += $(gitexecdir_relative_SQ)
-PERL_DEFINES += $(perllibdir_relative_SQ)
 PERL_DEFINES += $(localedir_relative_SQ)
+PERL_DEFINES += $(perllibdir_relative_SQ)
 else
 PERL_DEFINES += $(perllocaledir_SQ)
 endif
-- 
2.34.1.1119.g7a3fc8778ee

