Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF57C2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8430F206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGW/v9Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFQIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so8394394wrr.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=KAX+kBFFNg1/q2sm2IoZMcUdZ+PNB6/Zcr50lilElDs=;
        b=vGW/v9Y6iSVs+mdRf6meBlnbo1XMX/OvugUvVMoNz6zmcRCljpr47H0I21KmXLFyrL
         QioTeJzuT0CzD3vpB3TwhNA2QfzLYbZIl0DabmyApuNz7sw1NB0XNffaPtL68hV1yNwf
         OKHuUPwBFaVrtlOefBkLW64iouKFAsBemK1KMFzKyYW+YLum2akNqe5EujkZlp/vUWbT
         ZOYfPKrEIgdJcc8dcXpzecNBVRl7+2Qw6gVwZ/AdRK5oo5G4DTCs0m7MHMKBsoRizAhr
         /E3f8/jsfziFQhhuotHFCVncKy+infgWFq/+Otoc/h487Byxrh3ZQib2fW7zg0x/hXGL
         S/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=KAX+kBFFNg1/q2sm2IoZMcUdZ+PNB6/Zcr50lilElDs=;
        b=b61ethzN/ug90GHbCZ396caEFfGrkfhnIJckQOTWaJCLvBZMsNgyFZt3uXsIxlPUUa
         TrFSvP27XmsXJ2XVkLlAgj6kCAg/6sedV64kMWz7UM/3Bl2s9fo6WHdNBw/7Z5YMD4i6
         0mImb33AdnK+z4YICd/LSL4hkl1JZsuMv1Vz2wkZESKr+z6huAglDB+7q6I0rH8yfTY2
         PoSBq0TqU4xG0XNpEuMp9hNapkPTFfKFesX9589ZLlMZwv/4qAIAmdPGFbVXSJSNj9a1
         yNjR2I5r1CSnpqd3KiAlpAx/5W8jcRADRf/1czIDPkyZJDz6vkeJN5RTpZJlWvOE3YIX
         Rr0g==
X-Gm-Message-State: APjAAAVw5T+NZEXcL/LFXxYF1fFkdXY49WtDgV/fmcKpLUohKht16i3M
        AvkR+Q6hcUhy+iMu/EPthbvxMOEv
X-Google-Smtp-Source: APXvYqxzxGjEFF2RqZZB5UpMICg4qxkN4FfZ1j8gpKMyfFGaLXNQqICgO8OGbF1xd8yDegn1HXFLjQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr12654068wrs.11.1575648514102;
        Fri, 06 Dec 2019 08:08:34 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:33 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/9] sequencer: write CHERRY_PICK_HEAD for reword and edit
Date:   Fri,  6 Dec 2019 16:06:09 +0000
Message-Id: <20191206160614.631724-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

`git commit` relies on the presence of CHERRY_PICK_HEAD to show the
correct error message in the case of an empty pick.  This fixes a
regression introduced by the conversion from shell to C. In the shell
version everything was a cherry-pick as far as the sequencer code was
concerned so it always wrote CHERRY_PICK_HEAD. The conversion to C
forgot to update the code that creates CHERRY_PICK_HEAD. We do not want
to create CHERRY_PICK_HEAD for fixup and squash commands as that would
prevent `git commit --amend` from running.

Note that the error message shown by `git commit` for an empty pick
during a rebase is currently wrong as it talks about running `git
cherry-pick --skip` rather than `git rebase --skip`. This will be fixed
in a future commit which is why the tests are in t3403-rebase-skip.sh.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c            |  4 +++-
 t/t3403-rebase-skip.sh | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 408b7885c7..4e0370277b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1916,7 +1916,9 @@ static int do_pick_commit(struct repository *r,
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
+	if ((command == TODO_PICK || command == TODO_REWORD ||
+	     command == TODO_EDIT) && !opts->no_commit &&
+	    (res == 0 || res == 1) &&
 	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
 		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index ee8a8dba52..db7e917248 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -29,6 +29,13 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m reverted-goodbye &&
 	git tag reverted-goodbye &&
+	git checkout goodbye &&
+	test_tick &&
+	GIT_AUTHOR_NAME="Another Author" \
+		GIT_AUTHOR_EMAIL="another.author@example.com" \
+		git commit --amend --no-edit -m amended-goodbye &&
+	test_tick &&
+	git tag amended-goodbye &&
 
 	git checkout -f skip-reference &&
 	echo moo > hello &&
@@ -85,6 +92,52 @@ test_expect_success 'moved back to branch correctly' '
 
 test_debug 'gitk --all & sleep 1'
 
+test_expect_success 'correct advice upon picking empty commit' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --onto goodbye \
+		amended-goodbye^ amended-goodbye 2>err &&
+	test_i18ngrep "previous cherry-pick is now empty" err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
+	test_must_fail git commit &&
+	test_i18ngrep "git cherry-pick --skip" err
+'
+
+test_expect_success 'correct authorship when committing empty pick' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --onto goodbye \
+		amended-goodbye^ amended-goodbye &&
+	git commit --allow-empty &&
+	git log --pretty=format:"%an <%ae>%n%ad%B" -1 amended-goodbye >expect &&
+	git log --pretty=format:"%an <%ae>%n%ad%B" -1 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'correct advice upon rewording empty commit' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="reword 1" git rebase -i \
+			--onto goodbye amended-goodbye^ amended-goodbye 2>err
+	) &&
+	test_i18ngrep "previous cherry-pick is now empty" err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
+	test_must_fail git commit &&
+	test_i18ngrep "git cherry-pick --skip" err
+'
+
+test_expect_success 'correct advice upon editing empty commit' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="edit 1" git rebase -i \
+			--onto goodbye amended-goodbye^ amended-goodbye 2>err
+	) &&
+	test_i18ngrep "previous cherry-pick is now empty" err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
+	test_must_fail git commit &&
+	test_i18ngrep "git cherry-pick --skip" err
+'
+
 test_expect_success 'fixup that empties commit fails' '
 	test_when_finished "git rebase --abort" &&
 	(
-- 
2.24.0

