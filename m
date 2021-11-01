Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D57C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F13060F24
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKATBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhKAS7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27599C061205
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso126518wmd.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BX2Vbp10V3biCAGbAR+8Jw3LCRTeAAOD9LP8H3MoIpI=;
        b=M5gZOxm3+Dltu+itMR7WR9LKVPQEMUDW1jeKSLWo8g0MkedI/9faKau1p5NLW8P8tb
         /IolUCt5sFoLf6DTcngtf2uGeGahfhYsd0f+C6ISlw55RoH1rU+49xGAAVKHKtovIck8
         mHt5zWmWdj/N4QTO+B37GxK8Sr/cKHLANy7v0hOboXxWI6xNVyAXZSEr+VmApTX8Iuxk
         2kOhGtFzqjTDWXNBI/3+8XXcmiyYgA4uE1RltCU4Okx8UVDaRT2BB3caRdM5gz5T5JXT
         WDi5UBIEBIkpRUDj+FCNupWpYHbZXXWy+y3DpM64hwJYk/qYGTrAzqWyPl5yLXCOTfqW
         8e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BX2Vbp10V3biCAGbAR+8Jw3LCRTeAAOD9LP8H3MoIpI=;
        b=ZtC/CTSP7lj3C6JUHVOQwK0/e2lt7Pfx/B2cBIDKzAbWR9xq9QLDja3xDlYl8FkDCt
         XxIkXJ07PhVTdyjBl3MdMJfsz0tj6Qng0DDaD1tBJVhMAuekL04DZ+/N4UKpJc9MEggQ
         OBc37qTul6dADUVrIxfdDkAw1EVE0+oWrFDCIsmkebfqgyiL0oLK3ZBJMg0YKwvPKHQU
         4NHF0djoVmh3sUc0QehTEaMS2tcA6sbYrGXdvC/aeOI5aet7afOdWn4cZY8HtuK7EZlD
         iqNkAgd8XRvVk8un6RMmtwN4KzNQiWwXeOAW0C4OGpp3E919NvsWiC7FCK1rHRxQvBtY
         5vUA==
X-Gm-Message-State: AOAM531q7//r2i0IlwP3OpVW0c9Maksyc/xolNvhVJfvGbDLDD/3ntHC
        qM71aZgtupl+i91Nq+jAN6B7YMsigAhyWdK7
X-Google-Smtp-Source: ABdhPJzm+dNAVxlhsWBogCtBQwRiDJNeArXzl58QFxUA+doWTn7NEV63WXKbxOFYAF0NKXVwTRGw0w==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr823494wmi.123.1635792990462;
        Mon, 01 Nov 2021 11:56:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:30 -0700 (PDT)
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
Subject: [PATCH v4 07/17] am: convert applypatch-msg to use hook.h
Date:   Mon,  1 Nov 2021 19:56:12 +0100
Message-Id: <patch-v4-07.17-ccba3ddf52e-20211101T184938Z-avarab@gmail.com>
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

Teach applypatch-msg to use the hook.h library instead of the
run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4b334cb7b12..ae0c484dcba 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -448,7 +448,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	int ret;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
-- 
2.33.1.1570.g069344fdd45

