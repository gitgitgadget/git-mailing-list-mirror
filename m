Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE8C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA62206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMmakrJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfLPPsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfLPPsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so3661924wrj.12
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iCpCodiwQL5DzQGyiJhFi2eJdzpDVIO7zGr+qkEqLpU=;
        b=MMmakrJPOKu2aJBhOvx/LUyCdm/q85ikjD38UgVeMSVVb+atU58TpR8UXyZDrk+IYi
         MHlfhl60hRLGyAlbiehOGEfEolVjULazREeObqEpHEDEUxDksdNqoNj5+rySmtr11mnU
         OjUYK5CjTFUNMpcW6Pans2fLTBxp3yHzmSvVaivFoGfeGnGUlcVnMp4GpLkKpwgoDtJc
         hQSQDIHJAoxPqSTkr1+0Oe5EqW2UCxIYCxoTPOzTS7EUWJD7xk5JDJitaYX+qbXS7EmC
         ThCLE0xEHp0kkMApYtMqOjTWYjhoAs0HNUjBSneXrSxqjwxJu4IneZd5XTMlGa4fa9aq
         jq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iCpCodiwQL5DzQGyiJhFi2eJdzpDVIO7zGr+qkEqLpU=;
        b=oTOnLy9dsqBIvdB+qBRF+WFafsuqpqOYaOKg5O1mOKiX8wy9ESHQMOsxCs9MxSjR45
         T3mJUcbz6fzGPgZtIyXjMrDO/TYVbRrAFkIENwa2RRvocn/EajZEEla9TPCtOLuRY40i
         LnX+i+IE+A/A12kbRfMGrI8/WMu5C0mv17YDJX8VIA1H/SawcBHxa9j9FVxXupMUuwhD
         lEeORSSEeXyQy/4Vg+Qu/cZHA0G+W+640YC78+ZZjsXD/YNPwLki2Vk7pP1GxzlXH8zc
         YT74vIaFL7Ax2w59FbJ4qH9wDda7rXB3kwRlBrl5RttyOAXmZbPugzThPaExwChEAFXy
         Lr0A==
X-Gm-Message-State: APjAAAVJxGxL5X4lBtqbZL22SKTFQzDMrivbUmRdXijiAvtzdUypq9WQ
        xXmorg7MEyFpjOWNsQ6n9F1d6DRX
X-Google-Smtp-Source: APXvYqxjglWlAupIa30xIC1UOVghLUUWXLh4kbBMC7uKSFJ8xH1WHS8uj9K7Olf/zujNR2oXbkXG0Q==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr27860720wrn.320.1576511290898;
        Mon, 16 Dec 2019 07:48:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm21925522wrp.24.2019.12.16.07.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:10 -0800 (PST)
Message-Id: <deeb860a85d25e0645a5d2e1c82654653ab1e2d5.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:52 +0000
Subject: [PATCH v2 04/18] commit: forbid --pathspec-from-file --all
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

I forgot this in my previous patch `--pathspec-from-file` for
`git commit` [1]. When both `--pathspec-from-file` and `--all` were
specified, `--all` took precedence and `--pathspec-from-file` was
ignored. Before `--pathspec-from-file` was implemented, this case was
prevented by this check in `parse_and_validate_options()` :

    die(_("paths '%s ...' with -a does not make sense"), argv[0]);

It is unfortunate that these two cases are disconnected. This came as
result of how the code was laid out before my patches, where `pathspec`
is parsed outside of `parse_and_validate_options()`. This branch is
already full of refactoring patches and I did not dare to go for another
one.

Fix by mirroring `die()` for `--pathspec-from-file` as well.

[1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/commit.c                | 3 +++
 t/t7526-commit-pathspec-file.sh | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2db2ad0de4..893a9f29b2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -347,6 +347,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (interactive)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 
+		if (all)
+			die(_("--pathspec-from-file with -a does not make sense"));
+
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 68920e8ff9..ba769e0e5d 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -72,6 +72,9 @@ test_expect_success 'error conditions' '
 	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
 	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
 
+	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file with \-a does not make sense" err &&
+
 	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
 	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
 
-- 
gitgitgadget

