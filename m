Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D6C433E1
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB1D2067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIdtuOm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgFHGZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHGZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FDC08C5C5
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c8so17341895iob.6
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvrD21hbRCEn7XqvpiO3X9JAVgezsBtPd/GuDPEv73c=;
        b=iIdtuOm64CRBT+zlsrPpMF+t5ikcIXHzcFrtmEGd7EU/pK6y4AfB2Prf1OBdHUTBSl
         tIVBkZ46v0giJASkWT5iANI3+rGefqc0htWNzhUE0GdA9knr/EDcLIfakG8VKXj24din
         PWQCERIP/jhCoxHXvhR+TPn4ho7cMFJVOMhkyrAYr/a7h6SdM9IflpEOiYTzF9SggoPz
         X28wDyEIcAuP7BwdNsPNUZ8zOfaacbM20ipkU/AumbVbDvqmDLLfuiqLMVGqIjJ+I/dG
         XhxuXRujjOVa/U1+/TWH+siLzvV+BzgDdHgJGHSMB4YxDTH3D2gnHM/fpLUZhKBI5B78
         s/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WvrD21hbRCEn7XqvpiO3X9JAVgezsBtPd/GuDPEv73c=;
        b=L6yOtMFdm6oWtC1QfExWEODnlhPkTqfGELZ7+t/hsPGRK1me5JFhSEvjWiVl3wdWzD
         Y9rcwiZ/QMMs/gUQimGMp8JL/rB3mk8Y/cPMuLeDIDEIHIeeJUc4PYB01qWr6I9azXSE
         NG6IxnMw520SHTpgGnYMECylkGwlQ/LYceZg7IXjEsWDJSi6mUCpkVQAihbQgjMOu3xX
         CHnYVNMWXf2Dy34g11rWwgxP5P3YGGfaaSWoDlU249NHj4mLynueixPG1CI0Co/fp9Xq
         s6ck3k7KHovfGe0o32FqgHGQJIizmoO6yzdzu1oUEodUBbtaJDf2QJ+mab0AB0FM81yA
         tInA==
X-Gm-Message-State: AOAM53324tHA8AcPw9u4THIkLefuveJwH0B85DmOLUGoykD8c+b78reH
        wRSz3gEYXACNRCXgIGjBNJFpo+3tkBI=
X-Google-Smtp-Source: ABdhPJwIOMa6YyfLV0TpYyDJgehCIVh0YZUw/FDdVsGaTdGNmyiKYpl2p13xsZ/oPg/l93F3xgk2OA==
X-Received: by 2002:a02:a895:: with SMTP id l21mr19635575jam.82.1591597504964;
        Sun, 07 Jun 2020 23:25:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:25:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 6/8] worktree: prune linked worktree referencing main worktree path
Date:   Mon,  8 Jun 2020 02:23:54 -0400
Message-Id: <20200608062356.40264-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree prune" detects when multiple entries are associated with
the same path and prunes the duplicates, however, it does not detect
when a linked worktree points at the path of the main worktree.
Although "git worktree add" disallows creating a new worktree with the
same path as the main worktree, such a case can arise outside the
control of Git even without the user mucking with .git/worktree/<id>/
administrative files. For instance:

    $ git clone foo.git
    $ git -C foo worktree add ../bar
    $ rm -rf bar
    $ mv foo bar
    $ git -C bar worktree list
    .../bar deadfeeb [master]
    .../bar deadfeeb [bar]

Help the user recover from such corruption by extending "git worktree
prune" to also detect when a linked worktree is associated with the path
of the main worktree.

Reported-by: Jonathan Müller <jonathanmueller.dev@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c        | 10 ++++++++++
 t/t2401-worktree-prune.sh | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2cb95f16d4..eebd77c46d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -153,6 +153,11 @@ static int prune_cmp(const void *a, const void *b)
 
 	if ((c = fspathcmp(x->string, y->string)))
 	    return c;
+	/* paths same; main worktee (util==0) sorts above all others */
+	if (!x->util)
+		return -1;
+	if (!y->util)
+		return 1;
 	/* paths same; sort by .git/worktrees/<id> */
 	return strcmp(x->util, y->util);
 }
@@ -171,6 +176,7 @@ static void prune_dups(struct string_list *l)
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
+	struct strbuf main = STRBUF_INIT;
 	struct string_list kept = STRING_LIST_INIT_NODUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
@@ -190,6 +196,10 @@ static void prune_worktrees(void)
 	}
 	closedir(dir);
 
+	strbuf_add_absolute_path(&main, get_git_common_dir());
+	/* massage main worktree absolute path to match 'gitdir' content */
+	strbuf_strip_suffix(&main, "/.");
+	string_list_append(&kept, strbuf_detach(&main, 0));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 7694f25a16..5f3db93b31 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -114,4 +114,16 @@ test_expect_success 'prune duplicate (linked/linked)' '
 	! test -d .git/worktrees/w2
 '
 
+test_expect_success 'prune duplicate (main/linked)' '
+	test_when_finished rm -fr repo wt &&
+	test_create_repo repo &&
+	test_commit -C repo x &&
+	git -C repo worktree add --detach ../wt &&
+	rm -fr wt &&
+	mv repo wt &&
+	git -C wt worktree prune --verbose >actual &&
+	test_i18ngrep "duplicate entry" actual &&
+	! test -d .git/worktrees/wt
+'
+
 test_done
-- 
2.27.0.290.gba653c62da

