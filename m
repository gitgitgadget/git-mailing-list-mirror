Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4271FC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A31660EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhKATCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhKATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D493C06122A
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y196so4785359wmc.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Inn+7q8q7ks0a2q7JFUno+lhpnHTJwP6ewE5lg0TxtI=;
        b=FJxBSH27ddwzlJR1UykXe/244OTjYymBC35Q/dlR8dkfGQLo+ihYdkH8mh098FJLxg
         gqsas8nO3hmB+uYBcPG7dq7yoUdM0O2w6C+gVrtYehqzQ3hdhL1Q20AbqE7Zle1tOCwd
         h3cj8Z/o6HfOozi2MtOiE+x/Vdlx2pMxD/GHIIEo7LRxS6yfKDPXuZsTqmcgruF4YmRq
         Lid/behqBU1fLTWcihP88xD5vKeT8sq/TR4qKigqb0mEDdtjxro4PiiGw7vYJQR4Dru+
         jgMnYJbVYQ8dh4SG9y9FFpSI9yPcvgrGbShxZ+VCULBgIetb9N6IUQ/MkcXSdfPDN57E
         nxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Inn+7q8q7ks0a2q7JFUno+lhpnHTJwP6ewE5lg0TxtI=;
        b=q+MPOkhp1FfJtIKwql4lb7Aj0WmRXIu/zAaotLA4NPsSLqB52ju6PLtCJaefwjQLck
         0bLeGZ3QFwAegjx6NrsEhk1LhsvhkMJkcZ3HUPPu7GEQRz0SlUjs+OiKNN4VkGRRr6fb
         +devum1sJ9acBl81IRzhmFpG137ptge61KtYPfp5aUxzzgoo7kLVXdCDAGr7jOJ1H64n
         iQ5m6aBZYZqLkZEf1sTczHMg/dPStfSQ761juvja2T9GwpiW9dxele6cFDYxuLRZSzXR
         JAybRFCU6gACBdyM1K3ijezHTXsTat+gyiOwv1VCrH50DjX3zlNPC98llwNz1GnXjgMF
         Agww==
X-Gm-Message-State: AOAM533637sf92dx722pPOm9M+n9O0T41ANy7g/EfUgedN30kGTkJ40r
        FWINoiMuYOziDkziOoWtONjlxcsocR2vSVJm
X-Google-Smtp-Source: ABdhPJyTiQr0ifxn117gyhD/RHVDhvpJ4b9CfregFnjtYQGwAUbIAGmPaFq+lNcnTTD3NjbCfHeVnw==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr920461wmj.38.1635792998565;
        Mon, 01 Nov 2021 11:56:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/17] receive-pack: convert push-to-checkout hook to hook.h
Date:   Mon,  1 Nov 2021 19:56:21 +0100
Message-Id: <patch-v4-16.17-43ecd6697e0-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_le(), so we could remove
that function now, but let's leave that to a follow-up cleanup commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..5d6d8dd9a26 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1439,9 +1439,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_opt(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.33.1.1570.g069344fdd45

