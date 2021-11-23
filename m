Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD5C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhKWLto (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhKWLtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96200C061746
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso1771779wmh.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mAVKMVNALo31TFHc0kKoUnf6Q7cV1M2z+G0+o3HaFY=;
        b=UAr/AoSHaDXdrC/+fXcQNEl5sTH1l2gqlHD+ADM5QFr3XdMQNG7Qn7/GmaXV6Zsq0z
         1F2qfVjjK+1kzPrHgRywWSoNCZlM+gi10JgJtgfszyebK2IXkz5FQuJAidHVuk0+GrfW
         oTcI7/w/PYcrLqmCjiUNamMfcBuCD4oX9yqlh6CIzT/xmqQBlxESUTwlQB0WpP28Kh+n
         uAtlaq3gHLUrQHjnrVpsrxK/77raCBqnG/6XFxvjfSedN8dvuwOriwuKrBkhIYlQTrMg
         qVUxpOQOw961RrIAtMGv13GYLgi/c2ae3qKH9yBYX7wpNpe17zoSR2vAKjhNIQNEWuv9
         OdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mAVKMVNALo31TFHc0kKoUnf6Q7cV1M2z+G0+o3HaFY=;
        b=GphkyYtfnoe017OE/yw5QV/HuqVwL3/BG3VTrjvunBuYh+itVuNOW/QdNa1unWGu6E
         cGBC+FXEO3dxNrBPmGQNQi0Sz04anHS9Nt5JT7mi4qUGGEnwpgp3APFRNYWWZxZhcRKc
         aBcfjFRmhT40UaDqwafU6pYEz0V9hlzrm0Ut5HIrsHqcJeobmVQ6CppQ11CqjwOeK07t
         qUAPjJQAwipnl4R5VPKztKaT2llVJRwwhzIMXTMkS6foeZ1s4M0hPqtG4+RtoV9nj/S9
         xAQUjtwQIUjjWHbo7W7dF1wPUlu0xO/Ma+Ox1kyf5SQ6go8eQh+U2837mMeHJ0/AmwxA
         5tig==
X-Gm-Message-State: AOAM530ouwnfejURkQkrrP3HBEYRmblRlzkVROt6VDshjo5H9nmxG1dE
        SMPRarbu6I4k2amiSXPz4XAbgPrr+Jk6iA==
X-Google-Smtp-Source: ABdhPJyyzGapnRsaB5py+QnJ7vJtfS9uCaYreLMEFiTKwb8kCBf79hM9QxIsSfQQR5R1ATPgJO5s9g==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr2280992wma.30.1637667983774;
        Tue, 23 Nov 2021 03:46:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/17] am: convert {pre,post}-applypatch to use hook.h
Date:   Tue, 23 Nov 2021 12:46:03 +0100
Message-Id: <patch-v5-04.17-c88eb5d4c25-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach pre-applypatch and post-applypatch to use the hook.h library
instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..4b334cb7b12 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1609,7 +1609,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch"))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1661,7 +1661,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks("post-applypatch");
 
 	strbuf_release(&sb);
 }
-- 
2.34.0.831.gd33babec0d1

