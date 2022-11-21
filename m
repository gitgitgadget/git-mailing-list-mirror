Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7DC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKUDBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKUDBj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:01:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DDA31DC1
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:01:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s5so714811wru.1
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5KpvWGQQUnVUQXrJcV3LyEiXOLz3H/Le9DKxsc1a73o=;
        b=JQIpIKVJoOs1CbOPx/eMMkLosWOvsAfnoHzjSNmrYk2TlhmjE3RczTha4YfvwXMAdK
         n2wNj66/Uoh8yMe4pewQ5GB47xzd72WMSMc45rXJgcktrVWTny7kQioC+hod81CapKYm
         XEyLeZt/bRWeuf5Kjvk7LNo3MZfBYNkQGCyVsKnOJCj2RkSQeJ8ocoa93kx2eRGJNlaU
         lEJRuj8D5tv5IGszQSI2L0IysoHtR9rXTYVf9rxYDvQygb3OkFMhs3bkYdE+m0mgh598
         LS/lxvZygCsUL1Hf6XsNigCswgVlANVI+vMPkPmwiVnmYaU0RivaJMdgGLCrkByn2Hlm
         wCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KpvWGQQUnVUQXrJcV3LyEiXOLz3H/Le9DKxsc1a73o=;
        b=4ZfSEwPf5R9ZOxiflxobKEtri/CXQfA1vZz2Bw+NxK9sGmnwwH2pbRKU0MT5IlxQ8E
         rHqnDHODWnDowlXezkEmH88Jp3ke8mzUxCvWs+JiWzEROVSqCZX96IOiuNMVVcmMRjHX
         3V9KBuKEl7gNQeZrJoBLamKi595q9pdBa5ITz0DOhAbXVtxmQ00FyohfVfOlBTynWS9y
         1NZ0Ozb+f3Ey7cVSMc9PzA9qpbbjFc2OKnQQKZD2fAuRXDGwd81DzKLurG7yilhbx0mS
         5JF408iED2oynAz3nz9mfJAiaHmnSYvn7iazXpVyBOp7xlxrknBph0MvBJxzhEvKQ9XF
         9Q8A==
X-Gm-Message-State: ANoB5pks+u+dMHLKyVGSKSd0gpL9FTrpW6/0Ojw8izYTv9MF5LYa99nz
        pm/DOghdFGNWOlABkyYdksTs6pwUQW0=
X-Google-Smtp-Source: AA0mqf76zQPHcrW7/HimHn75jmkxyZvZSyYGg9kbEpxqMjQseG2YTGAF2sYp3t6OC6K4yBl51As+Zg==
X-Received: by 2002:adf:e94c:0:b0:236:6d79:b312 with SMTP id m12-20020adfe94c000000b002366d79b312mr9705672wrn.699.1668999697102;
        Sun, 20 Nov 2022 19:01:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b00225307f43fbsm9883345wrs.44.2022.11.20.19.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:01:36 -0800 (PST)
Message-Id: <pull.1426.git.1668999695898.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 03:01:35 +0000
Subject: [PATCH] lib-httpd: extend module location auto-detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Although it is possible to manually set LIB_HTTPD_PATH and
LIB_HTTPD_MODULE_PATH to point at the location of `httpd` and its
modules, doing so is cumbersome and easily forgotten. To address this,
0d344738dc (t/lib-http.sh: Restructure finding of default httpd
location, 2010-01-02) enhanced lib-httpd.sh to automatically detect the
location of `httpd` and its modules in order to facilitate out-of-the-
box testing on a wider range of platforms. Follow that lead by further
enhancing it to automatically detect the `httpd` modules on Void Linux,
as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
    lib-httpd: extend module location auto-detection
    
    Make httpd tests work out-of-the-box on Void Linux.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1426%2Fsunshineco%2Fvoid-httpd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1426/sunshineco/void-httpd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1426

 t/lib-httpd.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 1f6b9b08d1d..5be3ee44c25 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -65,7 +65,8 @@ done
 for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
 				 '/usr/lib/apache2/modules' \
 				 '/usr/lib64/httpd/modules' \
-				 '/usr/lib/httpd/modules'
+				 '/usr/lib/httpd/modules' \
+				 '/usr/libexec/httpd'
 do
 	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
 	then

base-commit: a0789512c5a4ae7da935cd2e419f253cb3cb4ce7
-- 
gitgitgadget
