Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EAEC48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6106613BD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFJH0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFJH0V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 03:26:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E0C061280
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 00:24:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g8so42549822ejx.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ey44OWMxWcA6ywNYqgwMYyD9pTBJ17GXE5MoQ4yyiZ4=;
        b=AoWwc1FEH7JT/MMwhd9vH/JsWtEWmlp35CHHH6iBy/A9CzNnWlM/eAlgTN8quE9g2b
         F4zX0K89TD57ybeCe2Oxd63H5b3SPxBfFrkDuXCaeKN4IUeouIoWJQAOs46OcBya68WT
         w70h82jEjCff6yuM0AhQvoSQQeDQ1MxWCO439Q3RvrVwsa1FD+OzoNC1kkuy4hBJhbxn
         nFJ4Yuw1n4unEuWmDFmE6tyVKGvc0coORsMxQGskcMy3GgjUWFcN2XpLZpPsAjd4GlUP
         f3a3c1+aUUOIC4u/trnlmgfmvP+OPQOyMoLbJbX6jWa/dkWdSbdW16hn+MAZoJaBGhPi
         qPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ey44OWMxWcA6ywNYqgwMYyD9pTBJ17GXE5MoQ4yyiZ4=;
        b=txZHe78EBgI//E+hB1XrRNREgM9zjulLrBCFXtOpV3xkKloFvYlPHa4xd/lWslljBt
         hCJHnvfZ+Ry0+0sCwdviz5+1dW1Gq5ZAlIn+8KHSotMYwR9NxBg0GcsLipTFsN8dY4rl
         UGl+h9JnDvJsR/HfgorhLaDNCUfPjGNXjNawhCmCseoX8yEmOuiVe/OFQ6dNGgrZRy2r
         730ea4+LNkd933otrJ8t2u36417+3JtYWwWk/+FmqIyqL+odhF6JXXkRrljnto/FEvdq
         gLPsO8aB7XO6n5U4uBVgsV9EA9n1piTQ/i9deBuLYYfbEPgY8o31Wp3uLMSUgxle9M3w
         /IwQ==
X-Gm-Message-State: AOAM530tEGjlCh7iikutBsrcc+xhcHIKehdEpqTL1sNL3gATqRYHnUsf
        Z6ICzA+Z7yyfGPrLnn6gJLSmzQsJS0PGEa6C
X-Google-Smtp-Source: ABdhPJyK+I77sCcjxLKzlftr44HSkK5SG96MwpHkmGVbvfH9I85o0/J9wtizNC3ClSl5lXYiqDqQMw==
X-Received: by 2002:a17:906:85da:: with SMTP id i26mr3206389ejy.185.1623309848820;
        Thu, 10 Jun 2021 00:24:08 -0700 (PDT)
Received: from localhost.localdomain ([138.199.18.64])
        by smtp.gmail.com with ESMTPSA id o21sm649041ejh.57.2021.06.10.00.24.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:24:08 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] *: fix typos which duplicate a word
Date:   Thu, 10 Jun 2021 09:24:06 +0200
Message-Id: <20210610072406.10203-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609102641.3531183-1-rybak.a.v@gmail.com>
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typos in documentation and code comments which repeat various words.
These typos were found by searching using scripts like this:

	for w in $(grep '^....$' /usr/share/dict/words)
	do
		git grep -P "\b$w $w\b"
	done

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Thanks to Felipe Contreras for review.

Changes from v1:

  - added "*: " as area prefix to follow example of Derrick Stolee
    https://lore.kernel.org/git/c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com/
  - Dropped change in t/t6416-recursive-corner-cases.sh where I misread a
    sentence and the duplicated word "that" is used correctly. Quote for
    reference:

      ... so we use one path whose name is arbitrary in the virtual merge base X
      between D and E" and then further let the rename detection to notice that
      that arbitrary path gets renamed ...

    where first "that" is a conjunction between clauses "we let" and "path gets
    renamed" and second "that" is a determiner to qualify "arbitrary path" to
    refer to "one path" mentioned in the first clause

 Documentation/technical/protocol-v2.txt | 2 +-
 attr.c                                  | 2 +-
 builtin/log.c                           | 3 +--
 git-compat-util.h                       | 2 +-
 git-cvsserver.perl                      | 2 +-
 remote.c                                | 2 +-
 t/t5505-remote.sh                       | 2 +-
 t/t9100-git-svn-basic.sh                | 2 +-
 8 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index a1e31367f4..1040d85319 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -540,7 +540,7 @@ An `object-info` request takes the following arguments:
 	Indicates to the server an object which the client wants to obtain
 	information for.
 
-The response of `object-info` is a list of the the requested object ids
+The response of `object-info` is a list of the requested object ids
 and associated requested information, each separated by a single space.
 
 	output = info flush-pkt
diff --git a/attr.c b/attr.c
index 9e897e43f5..d029e681f2 100644
--- a/attr.c
+++ b/attr.c
@@ -685,7 +685,7 @@ static struct attr_stack *read_attr_from_array(const char **list)
  * Callers into the attribute system assume there is a single, system-wide
  * global state where attributes are read from and when the state is flipped by
  * calling git_attr_set_direction(), the stack frames that have been
- * constructed need to be discarded so so that subsequent calls into the
+ * constructed need to be discarded so that subsequent calls into the
  * attribute system will lazily read from the right place.  Since changing
  * direction causes a global paradigm shift, it should not ever be called while
  * another thread could potentially be calling into the attribute system.
diff --git a/builtin/log.c b/builtin/log.c
index 6102893fcc..516a1142dd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1968,8 +1968,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	} else if (rev.diffopt.close_file) {
 		/*
 		 * The diff code parsed --output; it has already opened the
-		 * file, but but we must instruct it not to close after each
-		 * diff.
+		 * file, but we must instruct it not to close after each diff.
 		 */
 		rev.diffopt.no_free = 1;
 	} else {
diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..df7dae9be1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1368,7 +1368,7 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
 
 /*
- * like offsetof(), but takes a pointer to a a variable of type which
+ * like offsetof(), but takes a pointer to a variable of type which
  * contains @member, instead of a specified type.
  * @ptr is subject to multiple evaluation since we can't rely on __typeof__
  * everywhere.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f6f3fc192c..ed035f32c2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2149,7 +2149,7 @@ sub req_diff
                    ( $meta2->{revision} or "workingcopy" ));
 
         # TODO: Use --label instead of -L because -L is no longer
-        #  documented and may go away someday.  Not sure if there there are
+        #  documented and may go away someday.  Not sure if there are
         #  versions that only support -L, which would make this change risky?
         #  http://osdir.com/ml/bug-gnu-utils-gnu/2010-12/msg00060.html
         #    ("man diff" should actually document the best migration strategy,
diff --git a/remote.c b/remote.c
index 6d1e8d02df..dfb863d808 100644
--- a/remote.c
+++ b/remote.c
@@ -1592,7 +1592,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			else
 				/*
 				 * If the ref isn't stale, and is reachable
-				 * from from one of the reflog entries of
+				 * from one of the reflog entries of
 				 * the local branch, force the update.
 				 */
 				force_ref_update = 1;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c7b392794b..e6e3c8f552 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -182,7 +182,7 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
-test_expect_success 'rename errors out early when when new name is invalid' '
+test_expect_success 'rename errors out early when new name is invalid' '
 	test_config remote.foo.vcs bar &&
 	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
 	test_must_fail git remote rename foo invalid...name 2>actual &&
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 1d3fdcc997..ef35a54885 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -330,7 +330,7 @@ test_expect_success 'git-svn works in a bare repository' '
 	git svn fetch ) &&
 	rm -rf bare-repo
 	'
-test_expect_success 'git-svn works in in a repository with a gitdir: link' '
+test_expect_success 'git-svn works in a repository with a gitdir: link' '
 	mkdir worktree gitdir &&
 	( cd worktree &&
 	git svn init "$svnrepo" &&
-- 
2.31.1

