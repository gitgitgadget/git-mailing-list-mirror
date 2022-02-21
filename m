Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55DC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356180AbiBULVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:21:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356235AbiBULUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F94EA5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k1so26396881wrd.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iqaxVSiB12UtAol0ouxrRdYyVpj3Yne/p84KirKNfjA=;
        b=Cn637Sc8A6DeenlFXGI4AxbS1QgJE2uqkcGKgMkxc1munj1kOKpCzzD/A7PIk2Juth
         g9dHN1ZIb+xZ7UoCESGJPh4rY5kCZX/c6gZUPPVfYEKJmwfaAjBzfJsG/GW+CUldxYIB
         3pdhQK4ZXmvfO1XFw2jd0wmRA+NaTu7WoKF3p74G7//L8Xd7Xj8Kq70QksD5W2Y6TICs
         lnB/S5NpYxdCv3cQRQsq2fma5WIv5AuwfGqVfBUr0Pc4uhug0845AptJoQ/p3wAqe759
         jz8Gx5YUBoXoMMiewZW6XaqJF/mWKBS9ntxOnRYcrgdOn3pMnnhIiNY8PRttmklBzi+9
         Kjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iqaxVSiB12UtAol0ouxrRdYyVpj3Yne/p84KirKNfjA=;
        b=qO7QunLWd7Zhl5YtCZoR2pnwop+zNTgYcEZMot1GDUr+VjckojHLHQDnSd0CDcBBxS
         66t+qy2I30h/n+BCH0CbHnSyXjnI3AtR/K8gbDvRtP+0XIUK3EYv79I2Wb5Pvc1FjnlF
         6Sha+ewHeb/A3qunV9Z8ReSEPcC0y8IKAXvDwZVURlGQjziv2lJHykuUjJ4OebkzU0Yo
         3SRm1NVFJkidUUwzL3H1G+1yfMEAs7y94zYCYUqY1YT3w3JyhpmG5go6UUZSJgAwkNlS
         DSfBHZfY5+RhfbrosWOHND2mN+i4us40NYbk7tz+d4shDNzsKDB9hyvAbpSbO/rPT/Gk
         o+7g==
X-Gm-Message-State: AOAM532UVj2XZubEqc5oDU8JPmwZOVKaMP7nnTLDgyeBI3659gjuqz8i
        ioowYeNYzcv3f+LKBKOapD0LvVfB8g4=
X-Google-Smtp-Source: ABdhPJxb0z71FVna0XKiZVorAujozoxKs8D1EsgG/+bsFRpHs2dvaHJM+g6hG2GLnbDajeUA79vvOA==
X-Received: by 2002:a05:6000:1a89:b0:1e8:db90:54cd with SMTP id f9-20020a0560001a8900b001e8db9054cdmr15241999wry.303.1645441858537;
        Mon, 21 Feb 2022 03:10:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm17731234wrz.50.2022.02.21.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:10:57 -0800 (PST)
Message-Id: <f4e6e94bc2c894f369546d16d147d970b71554e7.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:50 +0000
Subject: [PATCH 3/7] rebase --merge: fix reflog message after skipping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog message for every pick after running "rebase --skip" looks
like

	rebase (skip) (pick): commit subject line

Fix this by not appending " (skip)" to the reflog action.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |  2 --
 t/t3406-rebase-message.sh | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cd9a4f3e2f1..36863117fba 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1273,8 +1273,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		options.action = "skip";
-		set_reflog_action(&options);
-
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 3ca2fbb0d59..8aa6a79acc1 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -163,6 +163,30 @@ test_reflog () {
 	# check there is only one new entry in the branch reflog
 	test_cmp_rev fast-forward@{1} X
 	'
+
+	test_expect_success "rebase $mode --skip reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --skip
+	) &&
+
+	git log -g --format=%gs -4 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget

