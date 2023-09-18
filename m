Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94564C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjIRUyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIRUyj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BA38E
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f7638be6eso4718262f8f.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070472; x=1695675272; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPUNwTpoGT9m/YFejKsp7W7P/TOk3usDGQALMcYRJwg=;
        b=HwxLCkLVVveT5dRszTF1SrPIEDV8pdVNnxTTqArzKy0fuUsPaV2Q2HxSgLKTz2uNQE
         MPrxh3mCcXOVrHJGz0WQerXhLGPkFmnCkXONsj3J/uzRiLo3SQFW2V8qUAkTKMFp6CYY
         UlI4lUIPmLPLU6A4US8el7Ub48Mxw6VqwudkWkJtqgRoCu9ZD0R49Z0sybC2wO0u3fdR
         F3Pf3Mts10VqKcnEcpL4inh+P6wFsrn8EvKmM8j1GFJwrYHKaaXz+RTj0oJaXN76Czq+
         ZzCIEC1YcwpHsMBn/8rcJmASSq4szA8r6Dy2etPivmqPBVmBFVyXUv1QFWG8q4ambJjg
         cofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070472; x=1695675272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPUNwTpoGT9m/YFejKsp7W7P/TOk3usDGQALMcYRJwg=;
        b=jk8hy2jLicqSF0TN8REutiaC2lw5uoiHlM3a1FVyq8BstkufuUHNHg2aS0SynQPCFx
         zvOhGfGUiPcQqX44Wn/hpncirWM6vz/sKLvA2ZYpAsxySQwa3vl/SYmlqIvt+OsN+xcx
         V+yw0JRGw/yNjGozilExW0MUuMTAerddF268k5xjGlDWjkAdYXi//oIXgViZhFe+EkU+
         2FBtldLsm3wlnKThzxr8y5DnPI40GwgjREgODB/YGZseY/gym8Br8HHn9iiIfvt21spc
         zE8vlxMlvibhXtC3UOaG6Nv/WUX7DSe0e7OgmcRU9TAjJTLEAV5Shli4y/zOIJK8xZBO
         dbHA==
X-Gm-Message-State: AOJu0YyhRHuiKf4e5wfOADIwD0dVUySthdd3dqJMfYm+vwGBajqoYANS
        wM4PY1/3gehCTmGNNE9rQhDNESMi/uI=
X-Google-Smtp-Source: AGHT+IHZKQDcqg/vdJWRbGAUiFwdxugz0mltf3GJkg60HOgboiwNtVHgbYCTCR55IzeQ0ar7/+q5tg==
X-Received: by 2002:adf:db49:0:b0:313:f0d7:a43 with SMTP id f9-20020adfdb49000000b00313f0d70a43mr7264178wrj.23.1695070471907;
        Mon, 18 Sep 2023 13:54:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v23-20020adfa1d7000000b003142ea7a661sm11532087wrv.21.2023.09.18.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:31 -0700 (PDT)
Message-ID: <a70339f57a7f49b5db7d7b96131e53601592e8b5.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:25 +0000
Subject: [PATCH v2 4/7] artifacts-tar: when including `.dll` files, don't
 forget the unit-tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of recent, Git also builds executables in `t/unit-tests/`. For
technical reasons, when building with CMake and Visual C, the
dependencies (".dll files") need to be copied there, too, otherwise
running the executable will fail "due to missing dependencies".

The CMake definition already contains the directives to copy those
`.dll` files, but we also need to adjust the `artifacts-tar` rule in
the `Makefile` accordingly to let the `vs-test` job in the CI runs
pass successfully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4016da6e39c..d95a7b19b50 100644
--- a/Makefile
+++ b/Makefile
@@ -3596,7 +3596,7 @@ rpm::
 .PHONY: rpm
 
 ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
-OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
+OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-- 
gitgitgadget

