Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC8C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 04:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2816103B
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 04:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhIREyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 00:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhIREyq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 00:54:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EFFC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 21:53:23 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j66so16866506oih.12
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 21:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qTPIr9wvlHo3r124lOgWW72m7YFlZnU25ldyUugC57A=;
        b=j88mt70HjfXiLXTRA9rcA0kvoFJeJC6f6/7p7noqxspc8oErJXnN0ZH2Fvz7Afkhrl
         lzDiDDQO24GqmwY7MDB38Cyr1RvV9pVk5tM8yzAzIkLNDy1PHRwg2nJEHOIb9t+4Pky2
         K6LaY+NEF2LfUkAXrsR7f9F9ycvUeXs3c//nV/otySREA+dQljY7Gg7/FocvQpv/of+C
         2rxLKToaLffaZ0UVGOxWYek69PR/cXrxiAfGHuVlemKLMnI143hVoXqXy3/UVLe3r0A3
         9cVyDqPjh8RtsImJ99nJtQhHEtZ+G8DOup6stGRqqKiCeMzvEYSzE8LEiBRQQ4trhJTK
         vuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qTPIr9wvlHo3r124lOgWW72m7YFlZnU25ldyUugC57A=;
        b=71HyWFYKZjv4uO9iy7nWqKcYVq5j1NBjFN6SZBECYoEJxhbHA5RZ+DD8LpwMopSTut
         83OzMEjErPT00maE47H6pYysVexJUzvORGqARmEB4wnuYsDMLjTxXv0HElfRxiQZ2l42
         LP1dlUrFBYCxMDFnueCjSWO+YmLxQh6herUy8gdPjlkUWlSL/omNc/nzavKcDdMNN2Px
         xIEB8rjPVyz7EMkOTho2HLog+KluxCIrPKzWm5J4TI/JvtTzxe2SoUzDMrDQ+OUl9nbp
         Mdo7T/nCWNZFHa1woEtaEjMu8WQ8YeLlYDFA3dNmTCUgwKGztNVSWoAP4AqkT5HNejH/
         tAdA==
X-Gm-Message-State: AOAM533jHI9BORgu8ZDXg7Ph3Gm9RccwaFoZKR/rzobFhGgGeYyb7h1W
        MvHf2X/3XbQuNVi+vDx073A=
X-Google-Smtp-Source: ABdhPJwBPI5HRs8K0LPuODHr+dt9voZCuTg4+DP6NlvbkkOWNfFbnxM2g6sUZ/SCd57y746OhnHtEg==
X-Received: by 2002:a05:6808:1283:: with SMTP id a3mr6390791oiw.99.1631940802274;
        Fri, 17 Sep 2021 21:53:22 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a10sm1942599oil.30.2021.09.17.21.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 21:53:21 -0700 (PDT)
Date:   Fri, 17 Sep 2021 21:53:19 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, gitmailinglist.bentolor@xoxy.net,
        git@vger.kernel.org
Subject: Re: Should `@` be really a valid git tag name?
Message-ID: <YUVwvw+T3C/QXQ52@carlos-mbp.lan>
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
 <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
 <xmqq4kaihqjj.fsf@gitster.g>
 <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
 <YUUdjNDkL7Uy5erG@carlos-mbp.lan>
 <xmqqr1dmg5uq.fsf@gitster.g>
 <CAPUEspg3982Wk7vdO-vFimvyApzYwUtsryZdLt1=sLfrrYngyg@mail.gmail.com>
 <xmqqh7eig25r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh7eig25r.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 05:25:52PM -0700, Junio C Hamano wrote:
> 
> I think it is OK to forbid at the higher level Porcelain, while
> still allowing read access, but keep the door open for plumbing,
> just like Peff suggested.

I still think it would be better to forbid it fully (at least longterm)
and while I am not advocating for (neither against) the feature that
required a character to be reserved, I think it is good to have a way
to reserve more characters if needed, and so this might help as a POC.

The patch could use a better message, and covers all porcelain points
I am aware of (branch, tag, checkout and switch), but leaves push/pull
intentionally open.

I think preventing push might be worth adding, but I am concerned it
might be too intrusive; I coded a warning for tag, but I frankly suspect
no one really HAS a tag like this that they really want to keep, and the
reported problem behaves better with the new code (local/remote tag can
be removed normally):

  $ git log --oneline
  813e919 (HEAD -> master, tag: a, tag: @@, tag: @1, tag: 1@, origin/master, @) HEAD
  d52caf3 (tag: z, tag: foo, tag: bar, tag: @) init
  $ git tag -d @
  Deleted tag '@' (was d52caf3)
  $ git push origin :@
  To origin
   - [deleted]         @

Carlo
----- >8 -----
Subject: [RFC PATCH] refs: mark "@" as an invalid refname in the porcelain

9ba89f484e (Add new @ shortcut for HEAD, 2013-09-02) declares "@"
as an invalid refname, but only blocked it as a full refname and
not when a component of one, leaving a loophole that was tested
in t3204.11, even if ambiguous.

Remove the check and instead add it at the porcelain level, so
users will be blocked of creating tags or branches named "@", but
still allowed to delete or rename them in a consistent way.

To help transition, add a warning if "@" is used as a branch, so
that check could be removed and implemente properly in the future.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 branch.c                              | 7 +++++++
 builtin/branch.c                      | 3 +++
 builtin/checkout.c                    | 5 ++++-
 builtin/tag.c                         | 3 +++
 refs.c                                | 8 --------
 t/t3204-branch-name-interpretation.sh | 8 ++++----
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..a577a3ddc1 100644
--- a/branch.c
+++ b/branch.c
@@ -185,6 +185,13 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  */
 int validate_branchname(const char *name, struct strbuf *ref)
 {
+	/*
+	 * since 9ba89f484e (Add new @ shortcut for HEAD, 2013-09-02)
+	 * "@" is no longer a valid reference.
+	 */
+	if (!strcmp(name, "@"))
+		die(_("'@' is an ambiguous refname"));
+
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..7a5a10ad82 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -857,6 +857,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
+		if (!strcmp(argv[0], "@"))
+			die(_("'@' is ambiguous"));
+
 		create_branch(the_repository,
 			      argv[0], (argc == 2) ? argv[1] : head,
 			      force, 0, reflog, quiet, track);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..bc92a2c723 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1151,8 +1151,11 @@ static void setup_new_branch_info_and_source_tree(
 	setup_branch_path(new_branch_info);
 
 	if (!check_refname_format(new_branch_info->path, 0) &&
-	    !read_ref(new_branch_info->path, &branch_rev))
+	    !read_ref(new_branch_info->path, &branch_rev)) {
 		oidcpy(rev, &branch_rev);
+		if (!strcmp(new_branch_info->name, "@"))
+			warning("ambiguous name, rename this branch ASAP");
+	}
 	else {
 		free((char *)new_branch_info->path);
 		new_branch_info->path = NULL; /* not an existing branch */
diff --git a/builtin/tag.c b/builtin/tag.c
index 82fcfc0982..357efc37f8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -608,6 +608,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
+	if (!strcmp(tag, "@"))
+		die(_("'@' is ambiguous"));
+
 	create_reflog_msg(&object, &reflog_msg);
 
 	if (create_tag_object) {
diff --git a/refs.c b/refs.c
index 8b9f7c3a80..6b5d869bf5 100644
--- a/refs.c
+++ b/refs.c
@@ -167,14 +167,6 @@ static int check_or_sanitize_refname(const char *refname, int flags,
 {
 	int component_len, component_count = 0;
 
-	if (!strcmp(refname, "@")) {
-		/* Refname is a single character '@'. */
-		if (sanitized)
-			strbuf_addch(sanitized, '-');
-		else
-			return -1;
-	}
-
 	while (1) {
 		if (sanitized && sanitized->len)
 			strbuf_complete(sanitized, '/');
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff..862a5dff8e 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -110,11 +110,11 @@ test_expect_success 'disallow deleting remote branch via @{-1}' '
 
 # The thing we are testing here is that "@" is the real branch refs/heads/@,
 # and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
-# sane thing, but it _is_ technically allowed for now. If we disallow it, these
-# can be switched to test_must_fail.
+# sane thing, and should go away once "@" is correctly marked as an invalid
+# refname
 test_expect_success 'create branch named "@"' '
-	git branch -f @ one &&
-	expect_branch refs/heads/@ one
+	test_must_fail git branch -f @ one 2>err &&
+	grep "fatal: '\''@'\'' is ambiguous" err
 '
 
 test_expect_success 'delete branch named "@"' '
-- 
2.33.0.911.gbe391d4e11

