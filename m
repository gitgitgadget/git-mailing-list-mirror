Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166EE208AD
	for <e@80x24.org>; Mon, 28 Nov 2016 09:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbcK1Jh6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:37:58 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35328 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbcK1Jhf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:37:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so12678143pga.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCMWd21usXpaZ5X2YT4fl8HlU9jO71hLyxEjnSc/JVA=;
        b=ghZPg9OvWYdSnMKI3VCZ1/sIGvx3bpMnQy3EzO3byIBRHDk90bMBzPOj7A0R0K4BNA
         uXpkhF9kmv8xOItP6drKdOkCXwMjWUD3dhmRLW5ZBM914a9GqaXzZlXlsEnYmQio/aOp
         yNPbc3k6BG1pvZ/BwcR8ZgKv4Q3Gt3sZ+uGprslu6Td74Ep+hmNvsSsLZpksu8HkJbGr
         0zi4ZOsyiJyaDaVDmsD5BmMgrBDxhH2s59slh1mHqDpN5x3AoLr5GK7sQKPDGCSNJlYP
         X2cZrup89XrxitcuCjzoBRb0+0oPlQwHkPyk2y6+Ukf5daQ6fKBhDGW4hYN5lN7l6Eqf
         32DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCMWd21usXpaZ5X2YT4fl8HlU9jO71hLyxEjnSc/JVA=;
        b=gUZ/Lev/VgnVHH4bhrGouhUEARh2Uy49WnfNdXYp7vCdvjQOWzQ7XJuVA7SSR8aVvs
         cBVUdeJwiOFFzvcj2XshHcTJRjT3AFqP2MpL0Tg7BiPwE3LAJbZir5Sky/eoSdxCwIxT
         s+RlZYR0ppkUmSeYiAQ+XzK5ARG6X0GSrjUg0YVXZnqU71lzpl/Fx7+O66leT/S2Gsw8
         3eGGNNTq0m3vJzi9ofwl9vj1QEgFT2WpjMttykV6S0x64P0XY/EIMMhb9k4NLyZZfZNU
         4FuVize46p72pgn15EX7yc2czv4jO5WDAF06wq6EThfHbrvVDNzhZqJjP+ENLg5LVyep
         uayw==
X-Gm-Message-State: AKaTC02tb7WxzkT3ekkl+dREzglpbsNNnXdwKTxdXdMMUXKZ4bH9dPG+xxiDpBd8UkocZA==
X-Received: by 10.84.164.162 with SMTP id w31mr47736530pla.9.1480325854733;
        Mon, 28 Nov 2016 01:37:34 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id o29sm49489435pgn.28.2016.11.28.01.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:37:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:37:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/5] get_worktrees() must return main worktree as first item even on error
Date:   Mon, 28 Nov 2016 16:36:54 +0700
Message-Id: <20161128093656.15744-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128093656.15744-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
 <20161128093656.15744-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is required by git-worktree.txt, stating that the main worktree is
the first line (especially in --porcelain mode when we can't just change
behavior at will).

There's only one case when get_worktrees() may skip main worktree, when
parse_ref() fails. Update the code so that we keep first item as main
worktree and return something sensible in this case:

 - In user-friendly mode, since we're not constraint by anything,
   returning "(error)" should do the job (we already show "(detached
   HEAD)" which is not machine-friendly). Actually errors should be
   printed on stderr by parse_ref() (*)

 - In plumbing mode, we do not show neither 'bare', 'detached' or
   'branch ...', which is possible by the format description if I read
   it right.

Careful readers may realize that when the local variable "head_ref" in
get_main_worktree() is emptied, add_head_info() will do nothing to
wt->head_sha1. But that's ok because head_sha1 is zero-ized in the
previous patch.

(*) Well, it does not. But it's supposed to be a stop gap implementation
    until we can reuse refs code to parse "ref: " stuff in HEAD, from
    resolve_refs_unsafe(). Now may be the time since refs refactoring is
    mostly done.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c       |  6 ++++--
 t/t2027-worktree-list.sh | 21 +++++++++++++++++++++
 worktree.c               | 10 +++-------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8a654e4..b835b91 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -388,7 +388,7 @@ static void show_worktree_porcelain(struct worktree *wt)
 		printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
 		if (wt->is_detached)
 			printf("detached\n");
-		else
+		else if (wt->head_ref)
 			printf("branch %s\n", wt->head_ref);
 	}
 	printf("\n");
@@ -408,8 +408,10 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
-		else
+		else if (wt->head_ref)
 			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
+		else
+			strbuf_addstr(&sb, "(error)");
 	}
 	printf("%s\n", sb.buf);
 
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 1b1b65a..98b5f34 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -96,4 +96,25 @@ test_expect_success 'bare repo cleanup' '
 	rm -rf bare1
 '
 
+test_expect_success 'broken main worktree still at the top' '
+	git init broken-main &&
+	(
+		cd broken-main &&
+		test_commit new &&
+		git worktree add linked &&
+		cat >expected <<-EOF &&
+		worktree $(pwd)
+		HEAD $_z40
+
+		EOF
+		cd linked &&
+		echo "worktree $(pwd)" >expected &&
+		echo "ref: .broken" >../.git/HEAD &&
+		git worktree list --porcelain | head -n 3 >actual &&
+		test_cmp ../expected actual &&
+		git worktree list | head -n 1 >actual.2 &&
+		grep -F "(error)" actual.2
+	)
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index f7c1b5e..3145522 100644
--- a/worktree.c
+++ b/worktree.c
@@ -88,16 +88,13 @@ static struct worktree *get_main_worktree(void)
 
 	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
-	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
-		goto done;
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_bare = is_bare;
 	worktree->is_detached = is_detached;
-	add_head_info(&head_ref, worktree);
+	if (!parse_ref(path.buf, &head_ref, &is_detached))
+		add_head_info(&head_ref, worktree);
 
-done:
 	strbuf_release(&path);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
@@ -173,8 +170,7 @@ struct worktree **get_worktrees(void)
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	if ((list[counter] = get_main_worktree()))
-		counter++;
+	list[counter++] = get_main_worktree();
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
-- 
2.8.2.524.g6ff3d78

