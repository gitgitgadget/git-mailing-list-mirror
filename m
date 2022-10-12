Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A56C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJLJBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJLJBi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:01:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6E8C03A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk15so25216511wrb.13
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9QLRCZIjiujdOGkUnMF91E4vCeJF8lxY/30LSSwR1E=;
        b=laNL/arbcknqoGuISZl0OLO1pAZpXW+V2JFKCtI4P+/owAjtLfZyF9qEwDQyPUqsjT
         JT+fShC6VPLKCPQmn2fr+g7cPDR+6dI2wAdWhe1fIUXPDJE/6vVH9SCRL36cdRbjdhvA
         HTS+snT4+qPNCoi/y9Ya4dXczdwJYYMsmpoSyK0gApxCLhxe4u3IhYhqnvGstmoqid1F
         RFbwX7m6gwqxv9EN5lKujt2ekiF99CndLxQ49A8HlyX984M+3R5IlqmC9kLzGmoDua4c
         wjyM7zzQOG3eaxn26CUXHC7/bSRLAW/I7jraIEBDOF3Xt3yTO7zjOXHnc9Lp2DlK+/Ke
         Tkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9QLRCZIjiujdOGkUnMF91E4vCeJF8lxY/30LSSwR1E=;
        b=hh/RbdC9xCxkA2dulW/+sfxSMNodbHrgOt+09+Llb0YaP2kM+4f6xRSM8RZ1GA7HG8
         bFnAZrX1fazN56YCMvf18xr313sxvGHuic7jnsWZZ0aZyEMOEzCafRbjhQYtrL1yRsiM
         sT/uHx7v290nGP3EiOaYsBqI4yQ2vEvCbWMuKEzX+FDTuXgbj22lfFDqthLMYtsqL1dd
         WRiYGM1TelWF1GzWCCHSyAYWAKPDEBJNzgSMzKF4CS/JOvpIH8oW7G4T7NGTiWpDqsGl
         +ufP6wPgwVIOD9Mko40zKyAwc/IQIk+pzYBreBZIkGQsT5/mD+vBeX7kwv3l/muQWf9E
         2bKQ==
X-Gm-Message-State: ACrzQf2vyKWN/0nV3eG/+APpkLxzkaY5F2oBslnTqDBpcU7nWdjz086g
        e61Ja0mUTTlEVMOvetuj7WOdWz8ZoRZrzQ==
X-Google-Smtp-Source: AMsMyM4QbyT2O/KLDgMG9AML91mgr/msShYGuUxsI7lT8Yq4KuJhrHMwHVO0J5vChN5+OwyTVDt8jQ==
X-Received: by 2002:a5d:64a2:0:b0:230:c757:e3db with SMTP id m2-20020a5d64a2000000b00230c757e3dbmr7932172wrp.495.1665565295997;
        Wed, 12 Oct 2022 02:01:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/22] hook tests: fix redirection logic error in 96e7225b310
Date:   Wed, 12 Oct 2022 11:01:09 +0200
Message-Id: <patch-v2-01.22-bc51dfcb1be-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) were redirecting to "actual" both in the body of the hook
itself and in the testing code below.

The net result was that the "2>>actual" redirection later in the test
wasn't doing anything. Let's have those redirection do what it looks
like they're doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 43fcb7c0bfc..2ef3579fa7c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -95,7 +95,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1 >>actual
+	echo Hook ran $1
 	EOF
 
 	cat >expect <<-\EOF &&
-- 
2.38.0.971.ge79ff6d20e7

