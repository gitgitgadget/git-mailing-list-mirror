Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C711F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJUQWh (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36062 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUQWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id l1-v6so8293595lfc.3
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbxL0oq1uMPkdonrJg76BHAHkoLloracXCooYWts0KI=;
        b=IcxtBQjnlhjTdHDXar8U+3dHBLDC5yBHgkqkkwZc76z3hhrh6QztvxoB2iy0XyFgFD
         j+gsoQvcZDLhqmH0ip+09IO9r7iqvZm0tEy/UCtXS/Q2U+CzJOKIrvU0/l5D+76fyoQO
         yKrNLYGOTsWpny3IHaELxndX7DKWNnYqkLB7hwIgzV6vFkumeoXC1X1bA2m8GfEBGGxK
         midQRmjsmvG0LvSjqwvKitj18LilsxdDTnRYv58JTVNYkdU8PJQ3YTfia9DJc/GPG3el
         bmxKHCfahbQi3AyK5p0gn1Nh6siBtYDtlI4Yk2bA79ATFQV9fokXfwPzpWqMESbzI0Hj
         QRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbxL0oq1uMPkdonrJg76BHAHkoLloracXCooYWts0KI=;
        b=G1csIMXg9+waXdRHNa6BE3sHOUEEAokweB9jqSyEgavV0EB5u+ynZ/Qm+U3Nyq8gGt
         Lkv9x6CeT3mQXetKoBn1+zBRYWRO7i3ap0AUChIaBo/VGGX4ys0mbXkeP/c214M2Jiwp
         PLrnbu5fLcIbSVmyGaVr2I/dEJrulJTmZUEDQL1MXtLiRU/FJCIiK8vSGI1/Z5bjtMTx
         V0Rt4xJNboGQQ50lQIobHX4HWFjbjvh0qaI3blzcFzBN7RwrWv16A7tZchM+C390C0pF
         n7/CPhLjJAB7VQIkjr0kxib8d39aGr9SXNvEz7SMrBTEaKhg5gKVoD6Q+UMiGUE42pM/
         u+yA==
X-Gm-Message-State: ABuFfoj00yteojIrkwBpsPzEoZrmL5xIUD2dYS+vsN8cQQsTS4o1XtXh
        fruoXT8X1ZIsDIQG4SC3ZPc=
X-Google-Smtp-Source: ACcGV62/wVL+ju0AVoGfmA0ofJfA3Ag0SNUnCyZ5Npi6fWqC2Lo4EVLQkN2q55t9HKKJjVn+Kj+gpw==
X-Received: by 2002:a19:14c6:: with SMTP id 67mr1896699lfu.7.1540109343907;
        Sun, 21 Oct 2018 01:09:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 0/8] fix per-worktree ref iteration in fsck/reflog expire
Date:   Sun, 21 Oct 2018 10:08:51 +0200
Message-Id: <20181021080859.3203-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 changes

- fix incorrect ref reporting (it reported main/HEAD instead of
  main-worktree/HEAD)
- other document typos
- fix strbuf_worktree_ref() producing refs that cannot be handled by
  files-backend.c, e.g. worktrees/foo/refs/heads/master (one day the
  ref store will, but not now)
- make sure the "HEAD" special case in reflog expire still works
  with main-worktree/HEAD and worktrees/xxx/HEAD
- tests added for reflog

Elijah Newren (1):
  fsck: Move fsck_head_link() to get_default_heads() to avoid some
    globals

Nguyễn Thái Ngọc Duy (7):
  refs.c: indent with tabs, not spaces
  Add a place for (not) sharing stuff between worktrees
  refs: new ref types to make per-worktree refs visible to all worktrees
  revision.c: correct a parameter name
  revision.c: better error reporting on ref from different worktrees
  fsck: check HEAD and reflog from other worktrees
  reflog expire: cover reflog from all worktrees

 Documentation/git-reflog.txt           |  7 ++-
 Documentation/git-worktree.txt         | 32 ++++++++++-
 Documentation/gitrepository-layout.txt | 11 +++-
 builtin/fsck.c                         | 68 +++++++++++++++-------
 builtin/reflog.c                       | 46 +++++++++++++--
 path.c                                 |  2 +
 refs.c                                 | 24 +++++++-
 refs.h                                 |  8 ++-
 refs/files-backend.c                   | 42 +++++++++++++-
 revision.c                             | 22 ++++---
 t/t0060-path-utils.sh                  |  2 +
 t/t1410-reflog.sh                      | 15 +++++
 t/t1415-worktree-refs.sh               | 79 ++++++++++++++++++++++++++
 t/t1450-fsck.sh                        | 35 ++++++++++++
 worktree.c                             | 79 +++++++++++++++++++++++++-
 worktree.h                             | 24 ++++++++
 16 files changed, 449 insertions(+), 47 deletions(-)
 create mode 100755 t/t1415-worktree-refs.sh

Range-diff against v2:
1:  328a4d1263 ! 1:  fff4cfcc93 refs: new ref types to make per-worktree refs visible to all worktrees
    @@ -24,7 +24,7 @@
         "blah". This syntax coincidentally matches the underlying directory
         structure which makes implementation a bit easier.
     
    -    The main worktree has to be treated specially because well.. it's
    +    The main worktree has to be treated specially because well... it's
         special from the beginning. So HEAD from the main worktree is
         acccessible via the name "main-worktree/HEAD" instead of
         "worktrees/main/HEAD" because "main" could be just another secondary
    @@ -53,9 +53,9 @@
      shared.
      
     +Refs that are per working tree can still be accessed from another
    -+working tree via two special paths main-worktree and worktrees. The
    ++working tree via two special paths, main-worktree and worktrees. The
     +former gives access to per-worktree refs of the main working tree,
    -+while the former to all linked working trees.
    ++while the latter to all linked working trees.
     +
     +For example, main-worktree/HEAD or main-worktree/refs/bisect/good
     +resolve to the same value as the main working tree's HEAD and
    @@ -128,6 +128,14 @@
      diff --git a/refs/files-backend.c b/refs/files-backend.c
      --- a/refs/files-backend.c
      +++ b/refs/files-backend.c
    +@@
    + #include "../object.h"
    + #include "../dir.h"
    + #include "../chdir-notify.h"
    ++#include "worktree.h"
    + 
    + /*
    +  * This backend uses the following flags in `ref_update::flags` for
     @@
      	return refs;
      }
    @@ -137,16 +145,18 @@
     +					      const char *refname)
     +{
     +	const char *real_ref;
    ++	const char *worktree_name;
    ++	int length;
     +
    -+	if (!skip_prefix(refname, "worktrees/", &real_ref))
    -+		BUG("refname %s is not a other-worktree ref", refname);
    -+	real_ref = strchr(real_ref, '/');
    -+	if (!real_ref)
    ++	if (parse_worktree_ref(refname, &worktree_name, &length, &real_ref))
     +		BUG("refname %s is not a other-worktree ref", refname);
    -+	real_ref++;
     +
    -+	strbuf_addf(sb, "%s/%.*slogs/%s", refs->gitcommondir,
    -+		    (int)(real_ref - refname), refname, real_ref);
    ++	if (worktree_name)
    ++		strbuf_addf(sb, "%s/worktrees/%.*s/logs/%s", refs->gitcommondir,
    ++			    length, worktree_name, real_ref);
    ++	else
    ++		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir,
    ++			    real_ref);
     +}
     +
      static void files_reflog_path(struct files_ref_store *refs,
    @@ -157,11 +167,8 @@
      		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
      		break;
     +	case REF_TYPE_OTHER_PSEUDOREF:
    -+		return files_reflog_path_other_worktrees(refs, sb, refname);
     +	case REF_TYPE_MAIN_PSEUDOREF:
    -+		if (!skip_prefix(refname, "main-worktree/", &refname))
    -+			BUG("ref %s is not a main pseudoref", refname);
    -+		/* passthru */
    ++		return files_reflog_path_other_worktrees(refs, sb, refname);
      	case REF_TYPE_NORMAL:
      		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
      		break;
    @@ -172,7 +179,7 @@
     +	case REF_TYPE_MAIN_PSEUDOREF:
     +		if (!skip_prefix(refname, "main-worktree/", &refname))
     +			BUG("ref %s is not a main pseudoref", refname);
    -+		/* passthru */
    ++		/* fallthrough */
     +	case REF_TYPE_OTHER_PSEUDOREF:
      	case REF_TYPE_NORMAL:
      		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
    @@ -193,9 +200,9 @@
     +
     +test_expect_success 'ambiguous main-worktree/HEAD' '
     +	mkdir -p .git/refs/heads/main-worktree &&
    -+	test_when_finished rm .git/refs/heads/main-worktree/HEAD &&
    ++	test_when_finished rm -f .git/refs/heads/main-worktree/HEAD &&
     +	cp .git/HEAD .git/refs/heads/main-worktree/HEAD &&
    -+	git rev-parse main-worktree/HEAD 2>warn >/dev/null &&
    ++	git rev-parse main-worktree/HEAD 2>warn &&
     +	grep "main-worktree/HEAD.*ambiguous" warn
     +'
     +
    @@ -207,9 +214,9 @@
     +
     +test_expect_success 'ambiguous worktrees/xx/HEAD' '
     +	mkdir -p .git/refs/heads/worktrees/wt1 &&
    -+	test_when_finished rm .git/refs/heads/worktrees/wt1/HEAD &&
    ++	test_when_finished rm -f .git/refs/heads/worktrees/wt1/HEAD &&
     +	cp .git/HEAD .git/refs/heads/worktrees/wt1/HEAD &&
    -+	git rev-parse worktrees/wt1/HEAD 2>warn >/dev/null &&
    ++	git rev-parse worktrees/wt1/HEAD 2>warn &&
     +	grep "worktrees/wt1/HEAD.*ambiguous" warn
     +'
     +
    @@ -232,3 +239,62 @@
     +'
     +
      test_done
    +
    + diff --git a/worktree.c b/worktree.c
    + --- a/worktree.c
    + +++ b/worktree.c
    +@@
    + 	return ret;
    + }
    + 
    ++int parse_worktree_ref(const char *worktree_ref, const char **name,
    ++		       int *name_length, const char **ref)
    ++{
    ++	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
    ++		if (!*worktree_ref)
    ++			return -1;
    ++		if (name)
    ++			*name = NULL;
    ++		if (name_length)
    ++			*name_length = 0;
    ++		if (ref)
    ++			*ref = worktree_ref;
    ++		return 0;
    ++	}
    ++	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
    ++		const char *slash = strchr(worktree_ref, '/');
    ++
    ++		if (!slash || slash == worktree_ref || !slash[1])
    ++			return -1;
    ++		if (name)
    ++			*name = worktree_ref;
    ++		if (name_length)
    ++			*name_length = slash - worktree_ref;
    ++		if (ref)
    ++			*ref = slash + 1;
    ++		return 0;
    ++	}
    ++	return -1;
    ++}
    ++
    + int other_head_refs(each_ref_fn fn, void *cb_data)
    + {
    + 	struct worktree **worktrees, **p;
    +
    + diff --git a/worktree.h b/worktree.h
    + --- a/worktree.h
    + +++ b/worktree.h
    +@@
    + 				     const char *fmt, ...)
    + 	__attribute__((format (printf, 2, 3)));
    + 
    ++/*
    ++ * Parse a worktree ref (i.e. with prefix main-worktree/ or
    ++ * worktrees/) and return the position of the worktree's name and
    ++ * length (or NULL and zero if it's main worktree), and ref.
    ++ *
    ++ * All name, name_length and ref arguments could be NULL.
    ++ */
    ++int parse_worktree_ref(const char *worktree_ref, const char **name,
    ++		       int *name_length, const char **ref);
    + #endif
2:  ffdd30f7fc = 2:  e936a0af1e revision.c: correct a parameter name
3:  6809bab191 ! 3:  382c645d73 revision.c: better error reporting on ref from different worktrees
    @@ -87,18 +87,35 @@
      --- a/worktree.c
      +++ b/worktree.c
     @@
    - 	return ret;
    + 	return -1;
      }
      
     +void strbuf_worktree_ref(const struct worktree *wt,
     +			 struct strbuf *sb,
     +			 const char *refname)
     +{
    -+	if (wt && !wt->is_current) {
    -+		if (is_main_worktree(wt))
    -+			strbuf_addstr(sb, "main/");
    -+		else
    -+			strbuf_addf(sb, "worktrees/%s/", wt->id);
    ++	switch (ref_type(refname)) {
    ++	case REF_TYPE_PSEUDOREF:
    ++	case REF_TYPE_PER_WORKTREE:
    ++		if (wt && !wt->is_current) {
    ++			if (is_main_worktree(wt))
    ++				strbuf_addstr(sb, "main-worktree/");
    ++			else
    ++				strbuf_addf(sb, "worktrees/%s/", wt->id);
    ++		}
    ++		break;
    ++
    ++	case REF_TYPE_MAIN_PSEUDOREF:
    ++	case REF_TYPE_OTHER_PSEUDOREF:
    ++		break;
    ++
    ++	case REF_TYPE_NORMAL:
    ++		/*
    ++		 * For shared refs, don't prefix worktrees/ or
    ++		 * main-worktree/. It's not necessary and
    ++		 * files-backend.c can't handle it anyway.
    ++		 */
    ++		break;
     +	}
     +	strbuf_addstr(sb, refname);
     +}
    @@ -141,9 +158,10 @@
      --- a/worktree.h
      +++ b/worktree.h
     @@
    - 				     const char *fmt, ...)
    - 	__attribute__((format (printf, 2, 3)));
    - 
    +  */
    + int parse_worktree_ref(const char *worktree_ref, const char **name,
    + 		       int *name_length, const char **ref);
    ++
     +/*
     + * Return a refname suitable for access from the current ref store.
     + */
    @@ -153,7 +171,7 @@
     +
     +/*
     + * Return a refname suitable for access from the current ref
    -+ * store. The result may be destroyed at the next call.
    ++ * store. The result will be destroyed at the next call.
     + */
     +const char *worktree_ref(const struct worktree *wt,
     +			 const char *refname);
4:  2e13fa8361 = 4:  e2b99ef955 fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
5:  65f1547df3 ! 5:  8fbff370c3 fsck: check HEAD and reflog from other worktrees
    @@ -136,7 +136,7 @@
     +	echo $ZERO_OID >.git/HEAD &&
     +	# avoid corrupt/broken HEAD from interfering with repo discovery
     +	test_must_fail git -C wt fsck 2>out &&
    -+	grep "main/HEAD: detached HEAD points" out
    ++	grep "main-worktree/HEAD: detached HEAD points" out
     +'
     +
     +test_expect_success 'other worktree HEAD link pointing at a funny object' '
6:  86326b44b5 ! 6:  2cd501f2ce reflog expire: cover reflog from all worktrees
    @@ -48,12 +48,48 @@
      };
      
      /* Remember to update object flag allocation in object.h */
    +@@
    + 	return 0;
    + }
    + 
    ++static int is_head(const char *refname)
    ++{
    ++	switch (ref_type(refname)) {
    ++	case REF_TYPE_OTHER_PSEUDOREF:
    ++	case REF_TYPE_MAIN_PSEUDOREF:
    ++		if (parse_worktree_ref(refname, NULL, NULL, &refname))
    ++			BUG("not a worktree ref: %s", refname);
    ++		break;
    ++	default:
    ++		break;
    ++	}
    ++	return !strcmp(refname, "HEAD");
    ++}
    ++
    + static void reflog_expiry_prepare(const char *refname,
    + 				  const struct object_id *oid,
    + 				  void *cb_data)
    + {
    + 	struct expire_reflog_policy_cb *cb = cb_data;
    + 
    +-	if (!cb->cmd.expire_unreachable || !strcmp(refname, "HEAD")) {
    ++	if (!cb->cmd.expire_unreachable || is_head(refname)) {
    + 		cb->tip_commit = NULL;
    + 		cb->unreachable_expire_kind = UE_HEAD;
    + 	} else {
     @@
      {
      	struct collected_reflog *e;
      	struct collect_reflog_cb *cb = cb_data;
     +	struct strbuf newref = STRBUF_INIT;
     +
    ++	/*
    ++	 * Avoid collecting the same shared ref multiple times because
    ++	 * they are available via all worktrees.
    ++	 */
    ++	if (!cb->wt->is_current && ref_type(ref) == REF_TYPE_NORMAL)
    ++		return 0;
    ++
     +	strbuf_worktree_ref(cb->wt, &newref, ref);
     +	FLEX_ALLOC_STR(e, reflog, newref.buf);
     +	strbuf_release(&newref);
    @@ -94,9 +130,34 @@
     +			if (!all_worktrees && !(*p)->is_current)
     +				continue;
     +			collected.wt = *p;
    -+			for_each_reflog(collect_reflog, &collected);
    ++			refs_for_each_reflog(get_worktree_ref_store(*p),
    ++					     collect_reflog, &collected);
     +		}
     +		free_worktrees(worktrees);
      		for (i = 0; i < collected.nr; i++) {
      			struct collected_reflog *e = collected.e[i];
      			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
    +
    + diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
    + --- a/t/t1410-reflog.sh
    + +++ b/t/t1410-reflog.sh
    +@@
    + 	)
    + '
    + 
    ++test_expect_success 'expire with multiple worktrees' '
    ++	git init main-wt &&
    ++	(
    ++		cd main-wt &&
    ++		test_tick &&
    ++		test_commit foo &&
    ++		git  worktree add link-wt &&
    ++		test_tick &&
    ++		test_commit -C link-wt foobar &&
    ++		test_tick &&
    ++		git reflog expire --verbose --all --expire=$test_tick &&
    ++		test_must_be_empty .git/worktrees/link-wt/logs/HEAD
    ++	)
    ++'
    ++
    + test_done
-- 
2.19.1.647.g708186aaf9

