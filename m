Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD2FC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57DE20760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx9L9/o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFJGcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFJGcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:32:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD7C08C5C3
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:32:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r2so928056ioo.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESEjbUB+uaU4CQwHyqqq5yhy/KHYQrDWTfZ/In/tZiw=;
        b=sx9L9/o242zM0Lf1GugUuHWkwi1YSlhFFt8xcUBwnignhicMQ2DxLVnlpP+LHxdIPV
         8U2LO0J/cPivXcifmDj+vvc+V8shy2B2f6ZH1P07LvSb9NiLwxtJkPc6qGCYkmy71WCN
         IHGWVzgPNKSgbi0EeN9CT8+UBrFMvuocx2LlLCHh4dg1qKtetQLFoGdenKf8fMlYxy/a
         0U8Kg/j3X9xQ2IT/hooilNabe1T3WhReYRAy6E4Knbl7UVp18v31+y23eoyOtyMjc2vq
         HYkI1jUO7qiiDqd3//Ao0fyyAUiAcFlmpsiDMn/oQ5TsytlPbdDpy+1TG2oTqvAtm+EA
         CpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ESEjbUB+uaU4CQwHyqqq5yhy/KHYQrDWTfZ/In/tZiw=;
        b=ktZq0tFIoZU2v0qUwNaEmyyQCxdG/wPH6Da7YLkVvlYdBdPGEnF+rOFkLILnLIEbG0
         WJseTNq+N1lAjJjaxNr6tDNDbfN7+uvrrpG0AHNUvn6ebboXZqAgA2pGkpWGjAONdn0S
         F33acYFA/oZz1JvytW+rrbY9V0YPBG+5pVy0AhP6E/dIF+rXDWbmuIQbahfts14pcO6N
         cAmPdShX501Pvk0cMJJpa37JFRwTb0eHOW7liIUxoUY5PtDJlhfKCZCiu6p9HuoWIfX8
         /QcRH1eBWdkrlLQvtg3Qnei4HxRsuJolZfB3A3PWoqHcx6Np5+XQH4SE95s5gUpenNNS
         CyPw==
X-Gm-Message-State: AOAM531D1BU0W7XQTvVYgbDTWODA0szenp+FyJhUhibN4/BRdDKcLDNU
        fzTWav2u0QJxcAOclD1oHIXy/BNQ4SE=
X-Google-Smtp-Source: ABdhPJyyLwQZkt+dBTzDbZajPW5UeawcC09m7HiBWHzE9Y+c6DcTCkd5txOHZpXqroRbKk8amOA7Lw==
X-Received: by 2002:a5d:9819:: with SMTP id a25mr1757062iol.85.1591770721624;
        Tue, 09 Jun 2020 23:32:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.32.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:32:00 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/7] worktree: prune linked worktree referencing main worktree path
Date:   Wed, 10 Jun 2020 02:30:47 -0400
Message-Id: <20200610063049.74666-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200610063049.74666-1-sunshine@sunshineco.com>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
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
 builtin/worktree.c        | 15 +++++++++++++++
 t/t2401-worktree-prune.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 65492752a7..350108eba0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -156,6 +156,16 @@ static int prune_cmp(const void *a, const void *b)
 
 	if ((c = fspathcmp(x->string, y->string)))
 	    return c;
+	/*
+	 * paths same; prune_dupes() removes all but the first worktree entry
+	 * having the same path, so sort main worktree ('util' is NULL) above
+	 * linked worktrees ('util' not NULL) since main worktree can't be
+	 * removed
+	 */
+	if (!x->util)
+		return -1;
+	if (!y->util)
+		return 1;
 	/* paths same; sort by .git/worktrees/<id> */
 	return strcmp(x->util, y->util);
 }
@@ -174,6 +184,7 @@ static void prune_dups(struct string_list *l)
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
+	struct strbuf main_path = STRBUF_INIT;
 	struct string_list kept = STRING_LIST_INIT_NODUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
@@ -191,6 +202,10 @@ static void prune_worktrees(void)
 	}
 	closedir(dir);
 
+	strbuf_add_absolute_path(&main_path, get_git_common_dir());
+	/* massage main worktree absolute path to match 'gitdir' content */
+	strbuf_strip_suffix(&main_path, "/.");
+	string_list_append(&kept, strbuf_detach(&main_path, NULL));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index fd3916fee0..a6ce7f590b 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -104,4 +104,16 @@ test_expect_success 'prune duplicate (linked/linked)' '
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
2.27.0.90.gabb59f83a2

