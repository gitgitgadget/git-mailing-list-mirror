Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D50C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4758564E58
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBRB1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRB1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 20:27:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4CAC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 17:26:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n13so747016ejx.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 17:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mW0+g5cHFm11qtdRmvLL/2zqYEW+c47pQ7aTv6FaISA=;
        b=i6wF3E0WWZFtdZORtj0jd7qeunsaTt9aGB/tYRsXnvWFmM3y2fGKN+Dok8Dd7z4xln
         Y5tKaJQGgmZ/bJ1oIOo5ghbdMTu1Eo/ZVXYzMpHQ/g+pyw49VIyEoMZ0DU9aW/qbFvXN
         FCRxq1mA57ooFwux9MGRPn3Gy7u9jnJmpWm0iEcNGzgQA3j0xnDDn619ejR/YWZwmq/Q
         vw82STmvhInY9Ua00jnlmZvILpw2KiR2g+eN7lT0XRQVLWohOk04UntECxMweUnh04B6
         Oax8JsCsV+Y9A0b8SqQQjBXNIgSlcpNrVeTmKQiTsVCUt5iUsQCngIPPb9naqtCMz3kF
         bS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mW0+g5cHFm11qtdRmvLL/2zqYEW+c47pQ7aTv6FaISA=;
        b=PKALdN7wt2+taJwSN7VcRnRQblCxu9S8vchAG7jD129zidXOxoH8uBON+E4h7LSXQL
         vSI9YQ1Y3goO1N9pGsAlB7mcuqzQCZr21epdbHyCyEuC4RTLB2EPMATWYzI2ahZJguf6
         u/k8zHFdWocTH7mA5VNcFgGeDP++I6/2HbNiAnd9V9JP4aw0QfAx7YFaRr0N/1AwVmA9
         LecUpSs4BWYBF5f9IXMs4ZQC47RMHGmaaQFXfNuwcOs1u3YWOITE4UVQ/d56tMO8jats
         e7HuSj1sSI+bDRaIt+6o4fHKG5Bb8j7NLuEK22cVcOCgQfKmp8Uv9UiubtbS2FNvjHN+
         aqEg==
X-Gm-Message-State: AOAM531WUq1qPTVIsCFzchQ8hiENS5nCmSiwgzHAQZ2ItzUV//SMTSbe
        tndL4dri9zjlBCeomCIsHAQ=
X-Google-Smtp-Source: ABdhPJz2CHX/srmvCjAYhRkKZfIEJHUfaQn/qQkxL6v+iC/rpNhoxdU+jnekP2qjJdcb2pb3FZS7/A==
X-Received: by 2002:a17:906:b356:: with SMTP id cd22mr1564410ejb.253.1613611589151;
        Wed, 17 Feb 2021 17:26:29 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id w3sm1313352eds.49.2021.02.17.17.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 17:26:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
Date:   Thu, 18 Feb 2021 02:26:27 +0100
Message-ID: <87wnv688u4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 06 2021, Eric Sunshine wrote:

> On Wed, Jan 6, 2021 at 2:41 PM Elijah Newren <newren@gmail.com> wrote:
>> On Wed, Jan 6, 2021 at 8:21 AM Stefan Monnier <monnier@iro.umontreal.ca>=
 wrote:
>> > I wish I could just do something like:
>> >
>> >     git worktree add --orphan foo newbranch
>>
>> Out of curiosity, why are you frequently creating orphan branches?
>> Such an option would drop the number of commands you need to run from
>> four down to two, but I'm surprised this would come up enough to
>> matter enough to do much more than create a personal git alias for it.
>
> I'm also curious about a use-case in which orphaned branches are used
> so frequently.
>
> Nevertheless, I'm not at all opposed to seeing an --orphan option
> added to `git worktree add`. In fact, --orphan has been on the
> radar[1] from the very beginning. Although the original implementation
> of `git worktree add` mimicked a small set of options from
> git-checkout, the plan all along was to mimic additional options from
> git-checkout as demand for them arose, and several such options have
> already been added.
>
>> Yeah, checkout --orphan is broken.  You should use switch --orphan,
>> which doesn't require the extra 'git rm -rf .' step.  That bit is
>> definitely cumbersome.
>
> Yep, when/if --orphan is added to `git worktree add`, it should mimic
> the behavior of --orphan in git-switch rather than git-checkout.

How would a mode for "worktree add --orphan" that mimics checkout rather
than switch even look like? The "checkout --orphan" special-case is
because we retain the index, so you need to "git rm -rf .".

But with worktrees we always get a new index, so AFAICT the only way to
make it work like "checkout" would be to have it be the only mode that
copies over the current worktree's index.

In any case I implemented a rough version of this today, and it uses the
"switch" semantics. I only discovered this ML thread afterwards.

It's surely full of bugs, and needs test work (see all the BUG(...)),
but if someone's interested in taking it further all it should need is
some more tests & dealing with the edge cases of incompatible options
etc. It's Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>.

I'd tried crafting as simple worktree manually, and discovered that I
could get worktree_add() to create it rather easily by jumping past some
of the "commit exists?" checks.

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e3..eeecb6da380 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -31,6 +31,7 @@ struct add_opts {
 	int quiet;
 	int checkout;
 	int keep_locked;
+	int orphan;
 };
=20
 static int show_only;
@@ -266,8 +267,12 @@ static int add_worktree(const char *path, const char *=
refname,
 			die_if_checked_out(symref.buf, 0);
 	}
 	commit =3D lookup_commit_reference_by_name(refname);
-	if (!commit)
+	if (opts->orphan) {
+		if (commit)
+			die(_("valid reference: %s"), refname);
+	} else if  (!commit) {
 		die(_("invalid reference: %s"), refname);
+	}
=20
 	name =3D worktree_basename(path, &len);
 	strbuf_add(&sb, name, path + len - name);
@@ -340,7 +345,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd =3D 1;
=20
-	if (!is_branch)
+	if (!opts->orphan && !is_branch)
 		strvec_pushl(&cp.args, "update-ref", "HEAD",
 			     oid_to_hex(&commit->object.oid), NULL);
 	else {
@@ -414,18 +419,28 @@ static int add_worktree(const char *path, const char =
*refname,
 static void print_preparing_worktree_line(int detach,
 					  const char *branch,
 					  const char *new_branch,
-					  int force_new_branch)
+					  int force_new_branch,
+					  int orphan)
 {
 	if (force_new_branch) {
 		struct commit *commit =3D lookup_commit_reference_by_name(new_branch);
-		if (!commit)
-			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
-		else
+		if (!commit) {
+			if (orphan)
+				printf_ln(_("Preparing worktree (new orphan branch '%s')"), new_branch=
);
+			else
+				printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+		} else {
+			if (orphan)
+				BUG("TODO");
 			printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
 				  new_branch,
 				  find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
+		}
 	} else if (new_branch) {
-		printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+		if (orphan)
+			printf_ln(_("Preparing worktree (new orphan branch '%s')"), new_branch);
+		else
+			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
 		struct strbuf s =3D STRBUF_INIT;
 		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
@@ -486,6 +501,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tre=
e")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree loc=
ked")),
+		OPT_BOOL(0, "orphan", &opts.orphan, N_("new unparented branch")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
@@ -505,6 +521,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
=20
 	path =3D prefix_filename(prefix, av[0]);
 	branch =3D ac < 2 ? "HEAD" : av[1];
+	if (opts.orphan)
+		branch =3D "";
=20
 	if (!strcmp(branch, "-"))
 		branch =3D "@{-1}";
@@ -542,9 +560,11 @@ static int add(int ac, const char **av, const char *pr=
efix)
 		}
 	}
 	if (!opts.quiet)
-		print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_bra=
nch_force);
+		print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_bra=
nch_force, opts.orphan);
=20
-	if (new_branch) {
+	if (opts.orphan && new_branch) {
+		branch =3D new_branch;
+	} else if (new_branch) {
 		struct child_process cp =3D CHILD_PROCESS_INIT;
 		cp.git_cmd =3D 1;
 		strvec_push(&cp.args, "branch");
@@ -560,6 +580,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
 			return -1;
 		branch =3D new_branch;
 	} else if (opt_track) {
+		if (opts.orphan)
+			BUG("TODO");
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
=20
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 96dfca15542..e52aa6a11a2 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -66,6 +66,19 @@ test_expect_success '"add" worktree' '
 	)
 '
=20
+test_expect_success '"add" worktree orphan branch' '
+	git worktree add --orphan -b orphan here-orphan &&
+	echo refs/heads/orphan >expect &&
+	git -C here-orphan symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C here-orphan rev-parse --verify HEAD &&
+	test_must_fail git -C here-orphan log &&
+
+	echo here-orphan/.git >expected &&
+	find here-orphan -type f >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '"add" worktree with lock' '
 	git rev-parse HEAD >expect &&
 	git worktree add --detach --lock here-with-lock main &&

