Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAFAECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiHaXPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiHaXO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A121408B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e20so20089544wri.13
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=b+Fin/U8My2sXpZAkBUbN0lsrFkTq6kXsZD4l19AFog=;
        b=Y6jAXeCQ0FoTO29cJVy534EWUBGPef5Xvv7lnEG9JB9yQFB9rL9wrVekcbcIVj1smR
         T4ArRNo0eY8E3oqTirXBZSGQ+24dIJDCCxc4COEpvn70iWnIedijGguKPbhPmtPfXx6w
         wKB1EM7evc0ME+YzLfrVRVJrq+M9rFjYHrjPnLs1UpQT4I1rXmG1pml4W5GWHFeiLRBM
         0mP7JRjIDIQ1EsMFSJqF4Bb1zA9Q+jumcKBFsYkVnxOBWSmgMjenLa0vtaqxXnSuVbUh
         +L7nEqgCG2iG3oQVTWIrg8MFaNm8JVtNtm9M2gpCQfga9XVv4yOy+/FZeO48hLpFgZW1
         aQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b+Fin/U8My2sXpZAkBUbN0lsrFkTq6kXsZD4l19AFog=;
        b=rV9Dkido/OKp+MGMgRTCcrzbv2bbNfG3OiuvTOMkcA+BgvfbbKsnELKe/TiPCAbR4D
         3GCPHENgvGzL1AaPogykg+iaxLSXtLKN5GPwG99VU1BQd5mrRBP5YVomm7elWEJCZxEg
         5QBduZ9Or4RKnOtLcuWKGj7N7iZxbmW/ugjlmq42KlRysjaZ1dFpNW4FC1DvlZo/Y0vE
         0eMbG/+SAiEefsTQ2YO6+Mu02yix+6WcC5G7wolvTwmdqj6JKCMVkVdC8IZFkicACSYu
         XPeUJOvFfKyKi/qcZS1k4bNabKG0SC7Y1NB2W8jEXI3aKpmG3bXGfJ4j8IFslKcoKi8R
         jCUw==
X-Gm-Message-State: ACgBeo2u5B+MZ21zepT/4kWAwGu9Kc7/OKrOU9A6QZQeHNHwBxvLQXad
        RusCJww14wsLNxl7PTUcE4wRUEInXigRyA==
X-Google-Smtp-Source: AA6agR6rxsfcZ1c+HPOMqNuPdwbuoku4dBNYFLjHldGH4SFA6trytSgtFgg3xq0FRXyQlANUwAbCWg==
X-Received: by 2002:adf:f642:0:b0:226:d4b1:8502 with SMTP id x2-20020adff642000000b00226d4b18502mr11539401wrp.553.1661987692542;
        Wed, 31 Aug 2022 16:14:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 09/17] submodule--helper: fix a leak with repo_clear()
Date:   Thu,  1 Sep 2022 01:14:16 +0200
Message-Id: <patch-v7-09.17-71ebaac73c1-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 162e92c033e..9a277057012 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2400,6 +2400,7 @@ static int ensure_core_worktree(const char *path)
 		strbuf_release(&sb);
 	}
 
+	repo_clear(&subrepo);
 	return 0;
 }
 
-- 
2.37.3.1420.g76f8a3d556c

