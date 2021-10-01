Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE3C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05BA61361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353618AbhJAKjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJAKjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:39:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E429C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:37:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so6402600wmb.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkM9wLfFRhBzIUl5wzmYRpz9skDn13dQA0eNjpySdlM=;
        b=Upa7kqWgdwauDqRsB8M+fxiozTKKJvQvN6Ypg4e/1V2uYhcRjku01Bsm/MGtxgV0pH
         p3w5yBcjoKj8LWRVISv1myqmIWmmTxuOLzYlmyG9EEuBVFyiB4oVqAzoAOB9DNflLpVO
         M4h+RFaXD+PbkV0NRORI4k5paSMsZZMJJUIakfWLsRhwDqeXlqcbuDGbkTIKoAinph3q
         KwOHoO7GzO1yT5KBpZCD7vmySmn+8YpTzSPdQc2161EXBPRsw8Ma7qOrCQJmiB5/6ppA
         89zNk8fr5wAz9nbtHpZDrRDLPMTTqZaxfcDi8I8y3OJzQLgCHopckGGHLVOAAZntBQwP
         Nkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkM9wLfFRhBzIUl5wzmYRpz9skDn13dQA0eNjpySdlM=;
        b=zioxq+kE+BCESpgJ6HvVfhb78W7CUowq0VeWnp+Md1nQnIH1Nsc+vPEStSAQ26H6lT
         P/9v/s2841vztROQ5VgOYFpiPH7DJ+3KUPE+Vo59ccHyfHSOCGnZ6tjJbe8pHsjIEokb
         +EL6SR47C3cvY+4q0kXfOHC+wOKutZZ8VtTBND4gMK4Bv+XbuA8HLD8PEsMknKBZEtDe
         c4MyIXYFqih9ybbvSswfjsjno/T5Z1v8Dm905jpdicALAg3pQwrl9KErLLLyo9QNyX9c
         vW4x5vJPRqG5IR498vk/u1qRGqMC3hiaIbldTh/hj+lnbCTaCEUC/KLVKCaI9jXKgv0K
         La9Q==
X-Gm-Message-State: AOAM530mPLA0cTa52NXNGxMJtVCFUuUiohCJe+RgAw9QLPEhiuemxNic
        eRN+fZyz/qHaBHVU6QRdMqxr5kSCb2wc5g==
X-Google-Smtp-Source: ABdhPJxZvZYItpYKldnROUPAXx4URaVzkblKqidoxliQZj5eHOWxe/PGUnC42QDe5ExEpjG6HpSAjw==
X-Received: by 2002:a1c:1f8a:: with SMTP id f132mr460772wmf.186.1633084674567;
        Fri, 01 Oct 2021 03:37:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm7235586wmr.32.2021.10.01.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:37:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] builtin.h: remove cmd_tar_tree() declaration
Date:   Fri,  1 Oct 2021 12:37:40 +0200
Message-Id: <patch-1.4-bba00811a2b-20210928T125228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_tar_tree() function itself was removed in
925ceccf050 (tar-tree: remove deprecated command, 2013-11-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 16ecd5586f0..8a58743ed63 100644
--- a/builtin.h
+++ b/builtin.h
@@ -225,7 +225,6 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 int cmd_switch(int argc, const char **argv, const char *prefix);
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 int cmd_tag(int argc, const char **argv, const char *prefix);
-int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 int cmd_unpack_file(int argc, const char **argv, const char *prefix);
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 int cmd_update_index(int argc, const char **argv, const char *prefix);
-- 
2.33.0.1340.ge9f77250f2b

