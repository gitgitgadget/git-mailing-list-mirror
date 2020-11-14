Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DBC63699
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210B6206F9
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLXtuqeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKNMVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgKNMVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 07:21:47 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E2C0613D2
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d12so13245384wrr.13
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhBVfhZm/YpT7LbS2cr9XARVjfWJPc4YCEtN+2mqPXA=;
        b=rLXtuqeHI3HD2C/A6YgFG6QwDqdwUyhcT93JImSBiOLT6XVxsYYEbivcRaN1MHdAAA
         +8V4NeThsftGx/VfgBwF2JLjx/9MkZQBymEoNS+nsZZquT9eTnmYdFtlwpl/JGmKn4Vi
         Ngyuw8AtTNat0TNFS3h1J4fqfA5EFMq23zLynEOxz14mE5ZSFxwQcW0fyG6r3KF3/ztb
         dYXQ12crwDHaf35cMnh0Ee1SvHwh3/Gbq0fjUB23jNvEjG+ttA+uRLo2hdurR+IxubKX
         K+alwI7TSs9tGHyAdvdqdx3gfx96XRQI3/KQMF63ALNyy0xCi/7B0gdYfLFC9z3XnUCy
         LJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhBVfhZm/YpT7LbS2cr9XARVjfWJPc4YCEtN+2mqPXA=;
        b=GaVjRRqLGhDzjV8U5DMvRWnL+TBcqMY9hdsy1MgMkIfSACv7ce8vSRJbTFQecHP/d6
         iR3TarmBxCpiwXU0ZQbCLlEPEMPWmjFjgthFuuwC1CUb53QCxEhhNyyz5sSCj/T6bgqf
         vc7fQo2BVobrylOdrwZLGyhDjYA6pxpJu+mNfZOA0DgIOXziQrHdDpvt858aRMsjvEIE
         sb4LKYESMUUd+fuqLALl5AizrgYg3LfYZeQ55yR6g7JyLGo7ofPFlRSNC3DJHlj8JfqF
         I382gMO7JHB27SnQ4s1l5jFg+YrmiekJys/ehwpI+OW64/0SzKV1imjaqyq67LGCKlbx
         uAcQ==
X-Gm-Message-State: AOAM533MJKyVIWxjZHOCQM+/z22pOLPbH8xmnTB1Xg6vCRDaKe/ImKP9
        ReM+0Z++IVfM4B62reU2+cZGTf2akoVeUw==
X-Google-Smtp-Source: ABdhPJx9XinXvtlp0ilpTsmCvuirmPmm3boUk3bQj1Ijed+nt3B1UZvKteOQjljwrKuEyjh8T9V7ZQ==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr9231400wrr.353.1605356505559;
        Sat, 14 Nov 2020 04:21:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12845225wml.21.2020.11.14.04.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:21:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] submodule: remove sh function in favor of helper
Date:   Sat, 14 Nov 2020 13:21:31 +0100
Message-Id: <20201114122132.4344-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
References: <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the now-redundant "get_default_remote" function by converting
its last user to the "print-default-remote" helper.

As can be seen in 13424764db ("submodule: port submodule subcommand
'sync' from shell to C", 2018-01-15) this helper is already used
internally by the C code for submodule remote name discovery.

The "get_default_remote" function in "git-parse-remote.sh" will be
removed in a follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d39fd226d8..d39a28215c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -578,7 +578,7 @@ cmd_update()
 				fetch_in_submodule "$sm_path" $depth ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
+			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
 			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
-- 
2.29.2.222.g5d2a92d10f8

