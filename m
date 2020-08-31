Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE5C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12389208A9
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+l7qPRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgHaG7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHaG7H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A263EC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so4841997iom.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KK4AphuII7tWHXVVnabDu6ebr07vqPjbP766wPgBq8=;
        b=S+l7qPRVfvHsMfiWMPl+0HHSB/9f9DcdvLIEPNWx7uXeLfP83DkuA2a1eve9+mourU
         bZUpF7+kzLoI2FQh/7tI6wxPm84/dF2e06ZyZqxyMI5/91BnFl/A4/Ws6/TVUTB9vYxW
         O/YuPUjykWlshO3Xr4Pxt54DJy+s12NkVX+l/k99H6NY64PyGFx8dVB5rIQrR3hvilIC
         UfkjEJXtefIMM5zHfODHCDUJp6JiEMw9uJ/aO6ZG25ID3wLl6p6hGba0V50S4n91Sj34
         ODWEy2z8/IDBKbEQIQH+xvOpQRPixjAfeSGcTDYpk4Tir60w6iv7rsPfrW4ZS019AWhy
         SikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2KK4AphuII7tWHXVVnabDu6ebr07vqPjbP766wPgBq8=;
        b=N5Cg+vWMIgpkwQxjO+9Krsw7QFygcJB//4drKDj96cwnuPFhxdoTgHjbMBuD7L9zQd
         XZLjz1HtWSbXJE6Z2Hk3JA8/Nt67XKBtUPSfYrSBeOUDKkTRyZlgrUUjanktqQ/vlyCn
         qrh7b3PXtC2SP1h+dX0P7ByPZ/WHPWDWBd/hLiYD8BFHa4d2JFchqHGpSa3pbKzzruZ4
         aDwqqI2jmm49A+46LxxAkUP++vTr2cwdLfwviF+Omz6rvnLpdBldM/QR7uBGaWXIv1MY
         G2T5GwsEv8V/7DzmAizEZEmpQt/cCg1HAGeiIwE1asK2piH8voYj/P/ijOcCUaRK1HDj
         PUnQ==
X-Gm-Message-State: AOAM530CdP/7i63CYTjvYKkBBoqwCth+cU2onEHTlOHa+pKWRoLKsvpa
        z4h9LW4KHuRjkvw/sv42Y50x9vGhOSY=
X-Google-Smtp-Source: ABdhPJwvuSmpuLnZtWzbH+rVowdaHRG3sfljutpxXQxQft/VftQ28ZqnLoJ6VqXx4/orOv0bbai3hA==
X-Received: by 2002:a02:454:: with SMTP id 81mr26911jab.142.1598857146650;
        Sun, 30 Aug 2020 23:59:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id x1sm1878615ilo.50.2020.08.30.23.59.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:59:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] init: teach --separate-git-dir to repair linked worktrees
Date:   Mon, 31 Aug 2020 02:57:59 -0400
Message-Id: <20200831065800.62502-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.531.g41c3d8a546
In-Reply-To: <20200831065800.62502-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200831065800.62502-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A linked worktree's .git file is a "gitfile" pointing at the
.git/worktrees/<id> directory within the repository. When `git init
--separate-git-dir=<path>` is used on an existing repository to relocate
the repository's .git/ directory to a different location, it neglects to
update the .git files of linked worktrees, thus breaking the worktrees
by making it impossible for them to locate the repository. Fix this by
teaching --separate-git-dir to repair the .git file of each linked
worktree to point at the new repository location.

Reported-by: Henré Botha <henrebotha@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/init-db.c |  2 ++
 t/t0001-init.sh   | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index bbc9bc78f9..7b915d88ab 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "parse-options.h"
+#include "worktree.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -364,6 +365,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 		if (rename(src, git_dir))
 			die_errno(_("unable to move %s to %s"), src, git_dir);
+		repair_worktrees(NULL, NULL);
 	}
 
 	write_file(git_link, "gitdir: %s", git_dir);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 50222a10c5..e489eb4ddb 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -405,6 +405,17 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
+test_expect_success 're-init to move gitdir with linked worktrees' '
+	test_when_finished "rm -rf mainwt linkwt seprepo" &&
+	git init mainwt &&
+	test_commit -C mainwt gumby &&
+	git -C mainwt worktree add --detach ../linkwt &&
+	git -C mainwt init --separate-git-dir ../seprepo &&
+	git -C mainwt rev-parse --git-common-dir >expect &&
+	git -C linkwt rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success MINGW '.git hidden' '
 	rm -rf newdir &&
 	(
-- 
2.28.0.531.g41c3d8a546

