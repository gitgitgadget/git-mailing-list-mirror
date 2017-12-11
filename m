Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B481F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbdLKXQd (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:16:33 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:45900 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdLKXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:16:31 -0500
Received: by mail-it0-f66.google.com with SMTP id z6so20055417iti.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8EehMDYCtL6Pfga53dY6tBC9itP0FfByq4lynm+ge0=;
        b=TFp98gGpWXoZOuhBNeTkk1LmCkNExUrMS/C3rIH9hBOZjdTBVXXbYplQKcuFdZsRev
         C8ti4aJTIHUUHnEk04eJj5Hcro7+HRsk087JXXknMzkFwVt82g7lE/LMBn/0j8BZEgYv
         o38liYOFJbSNIkNPol6PrLeT6STekdMUhbgPUxImsujH+k2l9OTAcvDdZbEGloWdNdfO
         0fN8vmbjwm+35Gw2AERroZ9Sjap++uGeR/5Skkc4LFbJICNKUIoGhCnNZBaq/8TmlfB6
         xy6vSXOZGsGrZ8nA0CTxVs0Nsa5ua/o7CzJIWN9ZbLFtSkbxbuxcX2FbttijWzBANygP
         LcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=S8EehMDYCtL6Pfga53dY6tBC9itP0FfByq4lynm+ge0=;
        b=oPXEC5NylcK3hqa++pHxhsZGH/hHWQOH7sVJ+9URJhNJbHcna1e+eLX+aKIVgncEUD
         6xqJ0fSPGuFmZunTR0e+g+J23daQXfd/IZyxTiPjwcqH7pFxBSQuoKqQygTwJciRSgQn
         7hD+v/ohD3EheOdV//pACjaKVdDRPaAI2VhwjIlGhenz25V2zslvFuLm8vrmFnGcmDjL
         2sSIfoy8Tb6PlGqKP0vFofszmUE/orG9weo7UB7DTQYh8XFtJ3795L/AJ5oAvRZ7cVzl
         VfaOvTNN3ua4bO+CPAKAMjOtfB1PneNLOTwjJuUzVQocM9e0P9AslQXr+dYd1PMB6E2m
         GgAg==
X-Gm-Message-State: AKGB3mK9k8MHRSHjMRrSjHnRziPmQF+fYncR2SzmEfu8xSgk/ncYveMG
        sZjbErG7iIMTBAKidZApmpFibA==
X-Google-Smtp-Source: ACJfBosGMGFk/5izR5RH06A2wjkqybwX4SS+N+u2wqX4MMNHJM7Qxc+iu2/ifoZn8/UQkPECj9fDfg==
X-Received: by 10.36.239.195 with SMTP id i186mr3026968ith.29.1513034190399;
        Mon, 11 Dec 2017 15:16:30 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w133sm4253264itc.44.2017.12.11.15.16.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:16:29 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] clone: support 'clone --shared' from a worktree
Date:   Mon, 11 Dec 2017 18:16:12 -0500
Message-Id: <20171211231612.29275-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.15.1.502.gccaef8de57
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When worktree functionality was originally implemented, the possibility
of 'clone --local' from within a worktree was overlooked, with the
result that the location of the "objects" directory of the source
repository was computed incorrectly, thus the objects could not be
copied or hard-linked by the clone. This shortcoming was addressed by
744e469755 (clone: allow --local from a linked checkout, 2015-09-28).

However, the related case of 'clone --shared' (despite being handled
only a few lines away from the 'clone --local' case) was not fixed by
744e469755, with a similar result of the "objects" directory location
being incorrectly computed for insertion into the 'alternates' file.
Fix this.

Reported-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/clone.c         | 3 ++-
 t/t2025-worktree-add.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b22845738a..6ad0ab3fa4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -452,7 +452,8 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 {
 	if (option_shared) {
 		struct strbuf alt = STRBUF_INIT;
-		strbuf_addf(&alt, "%s/objects", src_repo);
+		get_common_dir(&alt, src_repo);
+		strbuf_addstr(&alt, "/objects");
 		add_to_alternates_file(alt.buf);
 		strbuf_release(&alt);
 	} else {
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b5c47ac602..7395973318 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -245,6 +245,12 @@ test_expect_success 'local clone from linked checkout' '
 	( cd here-clone && git fsck )
 '
 
+test_expect_success 'local clone --shared from linked checkout' '
+	git -C bare worktree add --detach ../baretree &&
+	git clone --local --shared baretree bare-clone &&
+	grep /bare/ bare-clone/.git/objects/info/alternates
+'
+
 test_expect_success '"add" worktree with --no-checkout' '
 	git worktree add --no-checkout -b swamp swamp &&
 	! test -e swamp/init.t &&
-- 
2.15.1.502.gccaef8de57

