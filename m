Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A521F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdBBIub (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33028 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdBBIua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so1265501pgd.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=En+9RQ2SlKW6Rdj9M74hxkWmb4yuais2kSOYQw6vGdI=;
        b=FNTRBk8ByNYlz+6S+cv+tcUPjshb/LMiwY/GPXA9dfabK+XOIG3l34uE7T5jtCCLjL
         Ai+HDnCb7vdyzvHLdARRHC2iZfSHFyTEpP+Z2vRgR+pAae9ZfRjG3nivuJK8gpkKmjrd
         YKVnt/NVb308ISC29SwwDfqrUsHE7guT324HVvBh+GO0fYnqkgAJ88JBv4TiN1ZgMfWB
         omBGwAvG47JN5ZQJ8jJNErQITi3OI1DTL5UQoiCfXTnctKDxPlqVcR8+09uubXSXvQLM
         v8kmBmDsGLmGCtZel6LhI5DzswWfLX7pAh65oVoA7uK/2NDpvMbpRs/8DDjNy5XU0EhL
         OdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=En+9RQ2SlKW6Rdj9M74hxkWmb4yuais2kSOYQw6vGdI=;
        b=l6mb/mC2wPWn7meQjheanDL/cQ6uLXd56NzxoAOeGINT3mM8hbJ5iZSxlssLRR+kh2
         IvY4komxT1J4/21uPJa0A8RzGS60nojj+QA36eFniAwa1D5zh6qrwWIB4ivd+SBlPNic
         M4IagzyLvYir5peg3TdRbiG+F3I+vBCNdZLy8Wdy4YWNrjW/QMdapWfcazQNNFkMoiMm
         zftc9W/V0qxuASJ1C+8iHs5a/+odHsud5cnB43Km3it/C1753GEMlsz5xyhbsVfnwS5A
         HUQ5slIpjDDDN56jYOjZrgYRsnO1dHIMKH9rz7RJrw2ovYue1SSpGhjFRML2HagGphFD
         rQRQ==
X-Gm-Message-State: AIkVDXLKBHQcWc+BNyY2+3iO/olNQ9I494IVd+XtOJWaDqXMb4Fbhf6pVcRzIg/u7zajgQ==
X-Received: by 10.99.105.8 with SMTP id e8mr9106501pgc.217.1486025429489;
        Thu, 02 Feb 2017 00:50:29 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d29sm56079887pfk.83.2017.02.02.00.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/11] get_worktrees() must return main worktree as first item even on error
Date:   Thu,  2 Feb 2017 15:49:59 +0700
Message-Id: <20170202085007.21418-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c       |  6 ++++--
 t/t2027-worktree-list.sh | 21 +++++++++++++++++++++
 worktree.c               | 10 +++-------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8a654e4ad3..b835b91f63 100644
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
index 1b1b65a6b0..98b5f340e5 100755
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
index f7c1b5e24d..3145522536 100644
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
2.11.0.157.gd943d85

