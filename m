Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F76BC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2FB610D2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKJLMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhKJLMA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 06:12:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D65C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 03:09:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u18so3327850wrg.5
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 03:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4XVoFtzirZoXGsJOFTYsLEYN0+aEsdzDfL5wQastoMw=;
        b=gAkIIM2upbsQbGdxd56Vw749CYdicV27Mwm/pAFyQGCefyLqy85cArgEojoVS6Ob2O
         zCn9f7RrhpzWegE5o6nbbt+L7ggVJyR70Iy1UDoFdhDAoFxMCwvMrKGCyK3mqe57+62W
         dujSxXDPn+OnMN0VGPmvsDR6HPOwAQ4LNjoUmqsu91lvQCc5kq0mELRug1Kk3Dj9xAfJ
         6rjBTzGcoVk6ZqdGOEItCaaKij8PfpH6t9+9nvRiAiMvFG+I1AAaOa6MekuLjczPhw9l
         f3QukB5TaWvkxfItwMqLaIp9Fc51Rl7eHK83C9lh6rZvazY4d1LcCmvTkEC8HvWI5tnE
         UeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4XVoFtzirZoXGsJOFTYsLEYN0+aEsdzDfL5wQastoMw=;
        b=QKc1Y1aqHRSAzIgGwcy1V2Tt5DuXiq4xzoxCPrUEeXufFkPNFn/r33MRUdgoEmmt5G
         xShNhqK2RHE+F8SKSQuAa9Nyb1yQ8ZiwxUyTc3sSdhh5xTFa7u6oXtT03GpSKqKqbwJp
         3BgPr9J5t2/JEa9x+LoOl47Bc/5GE0useE6Z2qMfP4ACqhs80Lbc85QxoqZjzZHm38ia
         7I6CpPFoA7mwIqxFp3VGYnVrigOcV8YT6KgX2wue9T+1ZNdGnBAH/drsz1QtaTs79I1i
         lfn2pJI/24lRnhhwfXHuak+rcUXOuCxDBXlRlO+iFT5c3KHoWU/dq2q1KCIDJx+Da0AR
         1e6w==
X-Gm-Message-State: AOAM532AZcehmYwcg2dDZtTDRhGiROzvNLYOI/qnYPiUmRexpRZAflVA
        cjzNZLSuntrd70HA5sHG5A04KxowmY8=
X-Google-Smtp-Source: ABdhPJwQOWsmMtZjuryb9VEzLBW+Br+wiDycP5pMBg+rpOTqLHgigimLekIiAyZjnEN6gQKYHehDBA==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr18916149wrt.48.1636542551732;
        Wed, 10 Nov 2021 03:09:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm23759807wrt.36.2021.11.10.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:09:11 -0800 (PST)
Message-Id: <pull.1074.git.1636542550889.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 11:09:10 +0000
Subject: [PATCH] simple-ipc: work around issues with Cygwin's Unix socket
 emulation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Cygwin emulates Unix sockets by writing files with custom contents and
then marking them as system files.

The tricky problem is that while the file is written and its `system`
bit is set, it is still identified as a file. This caused test failures
when Git is too fast looking for the Unix sockets and then complains
that there is a plain file in the way.

Let's work around this by adding a delayed retry loop, specifically for
Cygwin.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    simple-ipc: work around issues with Cygwin's Unix socket emulation
    
    Adam Dinwoodie reported problems running the simple-ipc tests on Cygwin
    [https://lore.kernel.org/git/20211104194619.GA12886@dinwoodie.org]. This
    patch works around the underlying problem, which is rooted in Cygwin's
    implementation details.
    
    With this patch, I could not reproduce the problem, even with sh
    t0052-simple-ipc.sh --stress-limit=30.
    
    As per Junio's encouragement
    [https://lore.kernel.org/git/xmqqee7ozyx4.fsf@gitster.g], I am
    submitting this still in the -rc phase, hoping that it will make it into
    v2.34.0 final.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1074%2Fdscho%2Fcygwin-vs-simple-ipc-workaround-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1074/dscho/cygwin-vs-simple-ipc-workaround-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1074

 compat/simple-ipc/ipc-unix-socket.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 4e28857a0a1..28a79289d4f 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -35,6 +35,28 @@ enum ipc_active_state ipc_get_active_state(const char *path)
 		}
 	}
 
+#ifdef __CYGWIN__
+	/*
+	 * Cygwin emulates Unix sockets by writing special-crafted files whose
+	 * `system` bit is set.
+	 *
+	 * If we are too fast, Cygwin might still be in the process of marking
+	 * the underlying file as a system file. Until then, we will not see a
+	 * Unix socket here, but a plain file instead. Just in case that this
+	 * is happening, wait a little and try again.
+	 */
+	{
+		static const int delay[] = { 1, 10, 20, 40, -1 };
+		int i;
+
+		for (i = 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
+			sleep_millisec(delay[i]);
+			if (lstat(path, &st) == -1)
+				return IPC_STATE__INVALID_PATH;
+		}
+	}
+#endif
+
 	/* also complain if a plain file is in the way */
 	if ((st.st_mode & S_IFMT) != S_IFSOCK)
 		return IPC_STATE__INVALID_PATH;

base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
-- 
gitgitgadget
