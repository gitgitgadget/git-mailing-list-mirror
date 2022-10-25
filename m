Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E69C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiJYW50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYW5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:57:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FD19C37
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:57:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bu30so23553201wrb.8
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh8+5T680GnlYteoFhK1ErD7VbXiuEct4zc8RsMqlNo=;
        b=SUY+BydIQQoawdtJ2zwyME6OTUT5jyxPnYveCzbTP5a/G1+tex1BVmQxjcoaNslDxX
         PGJ2d/LhZTvYum+E5QLpA2urR2+drLoXiw2nW3w0FGr1WmN38vgfA0ftgIB6vGAz6kdu
         pbm18U6iboXmCrGd777835ukXEn4YXzkFuyL+qTD9d/zshmA0PI8eRsC1DQ+bHiKlOcq
         HUPZDd2zK2en5qehKwgX2ICPfk+CJZQ6I4tJ/lRg6v4a8Zq6wOICi0OLe8RVGIScrVyb
         nxUNWzAgZQT5zDCEfpI4q9SFWi5UXfajwKpCogjiCscSsVj79cJg5Up1+bB95Y/Onr/q
         6TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh8+5T680GnlYteoFhK1ErD7VbXiuEct4zc8RsMqlNo=;
        b=nX3Ec11ydAg+H0/ppnbv3hNbOphKr1KkO2KCg49nkFfLGjJQ15hyXhXY8YdxpHOG3Z
         6v48FP/E6CCDslg6Lw00g6BTCr6kG1BN3e99Spu+z9mT4IPbRAupm4vo8yh/1XcZmsP2
         LKnuMo/5fsy2oLdsDzvrYSSngIOHXvpzmf8KsBAAel9+18KBWnnAx1pCwwJOvDk5iGs1
         +e1OChPN05GqCqCSQKBgqHOV8o6LT9GMvZXxsGEnjNovokJHVOCcRLpKl60L26QCVBNW
         soiS/lsixey1pIUiiD3Oc11VFBcPPBYssVta4ND8jEjuESqJ2U6awHW0Tz00dPy+YAne
         sOng==
X-Gm-Message-State: ACrzQf2ZEGCjsk/xpBETnguf+Ciwy9caX34RM5FReg0Syjk/1ikyLZqg
        ImiQeHmj2sziMZgSSApMkKP7BwcioQo=
X-Google-Smtp-Source: AMsMyM6OFApdmgQFCBNJT2BnM1LHfqaAK0dupHoxsAJ1ApUYi7tFxFzSb5wXHQ9PU4LbpM6XMdybhA==
X-Received: by 2002:adf:d1c9:0:b0:225:f98:d602 with SMTP id b9-20020adfd1c9000000b002250f98d602mr27266435wrd.419.1666738640937;
        Tue, 25 Oct 2022 15:57:20 -0700 (PDT)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003c6237e867esm88001wmq.0.2022.10.25.15.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 15:57:20 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: error code with --edit-description
Message-ID: <b0f96b35-4e69-a889-bcdf-e0b40b89384f@gmail.com>
Date:   Wed, 26 Oct 2022 00:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since c2d17ba3db0d (branch --edit-description: protect against mistyped
branch name, 2012-02-05) we return -1 on error editing the branch
description.

Let's change to 1, which follows the established convention and it is
better for portability reasons.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  | 2 +-
 t/t3200-branch.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c964ac7bb4..15be0c03ef 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -809,7 +809,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			ret = error((!argc || !strcmp(head, branch_name))
+			error((!argc || !strcmp(head, branch_name))
 			      ? _("No commit on branch '%s' yet.")
 			      : _("No branch named '%s'."),
 			      branch_name);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 38c57de71b..7f605f865b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1394,7 +1394,7 @@ test_expect_success 'branch --delete --force removes dangling branch' '
 
 test_expect_success 'use --edit-description' '
 	EDITOR=: git branch --edit-description &&
-	test_must_fail git config branch.main.description &&
+	test_expect_code 1 git config branch.main.description &&
 
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
-- 
2.36.1
