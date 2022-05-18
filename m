Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328AC433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiERUGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbiERUFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C712375C2
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so3783017wma.4
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwDPmVX+XkHArFj69SFSq4Kj+fFOLyuvER1lDFiQKco=;
        b=Wunrv0iDR/MrwYHZ9cYWT7VwPgsBwA7sEF75Xz4tClTp/bSJyL9xBXe01Aw03kYv/4
         yhARVk+dfrsxLKTbfw4gAnAPL1htTmFdvmAs7xG/ZCduImJiPxm/uUEpgUnb9u14XzL9
         C75DHhkKtkscLApS0f5zAmwar592Wq7IZnZhG5QxnP3PA8UYfMM26vy/p50i7SeW/rwu
         Oz+slzVkUQsmuLC6/oWVnegPKlQsV0spxF2aQmxhjSCJy/LgzjEX4ZJX7LrsPbWf+u5l
         7VN9CMHTFBnJlNQm8qvi7WQGjTvNB1HqJZw6nEUvVmbiuKBmV00SzOIn8C0llfYVv1u0
         gCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwDPmVX+XkHArFj69SFSq4Kj+fFOLyuvER1lDFiQKco=;
        b=x2CndpdPVVOxkSJNjTpeYtQoxVx1NpWGK0kGtFwQXcWNjBgQUEmEYKEjUmodSPKrVT
         Zb3JU5yHQjgORfOxKvEyYQwMVuesZNND0qEi8ENGrFcI325RQRB3C9xdJ3D7oFhguKPH
         rW7dvfrOWXG9b08el2dLAoZ1cvulZaFVMbr2kMJNByVNQ2ei5bCHDmYoGnkfpJ5R1VIG
         IoEONzOiVRKrdW+1Jq2lA7LkRlfNGcTpHO7tP7bpR9l+F0+x8D8HAMNO/CPm+5iUdsJd
         9eR4RClC0LuaPolUfJTYCTgMzp+Hr/GZluwKt99kjUZP2Z7PS+7OH54FknLTkWHviD06
         AZVQ==
X-Gm-Message-State: AOAM531UtCZfdSeYenxAwkHD68v4Hp5hNXEU2UTQmYyVxtAv2d/armyb
        f+J7vAze3Tquc4fm0LCAg47UXdBqs9zVew==
X-Google-Smtp-Source: ABdhPJw/WapFfLjcRmEtewv2hoPnPZwMHJall8l2VAyHt0L9qp2qyIJcdLy9g0qe24ISP4NTcxG33w==
X-Received: by 2002:a05:600c:1986:b0:394:867f:984c with SMTP id t6-20020a05600c198600b00394867f984cmr1410331wmq.20.1652904335507;
        Wed, 18 May 2022 13:05:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
Date:   Wed, 18 May 2022 22:05:23 +0200
Message-Id: <patch-v2-7.8-bf7d871565f-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) to stop setting these two flags. We use the
run_process_parallel() API added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15), which always sets
these in pp_start_one() (in addition to setting .err = -1).

Note that an assert() to check that these values are already what
we're setting them to here would fail. That's because in
pp_start_one() we'll set these after calling this "get_next_task"
callback (which we call pick_next_hook()). But the only case where we
weren't setting these just after returning from this function was if
we took the "return 0" path here, in which case we wouldn't have set
these.

So while this code wasn't wrong, it was entirely redundant. The
run_process_parallel() also can't work with a generic "struct
child_process", it needs one that's behaving in a way that it expects
when it comes to stderr/stdout. So we shouldn't be changing these
values, or in this case keeping around code that gives the impression
that doing in the general case is OK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hook.c b/hook.c
index 9aefccfc34a..dc498ef5c39 100644
--- a/hook.c
+++ b/hook.c
@@ -53,9 +53,7 @@ static int pick_next_hook(struct child_process *cp,
 	if (!hook_path)
 		return 0;
 
-	cp->no_stdin = 1;
 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
-	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
-- 
2.36.1.952.g0ae626f6cd7

