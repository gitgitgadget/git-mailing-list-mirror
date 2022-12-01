Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D4C47088
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 17:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLARLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLARLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C542CA8968
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 09:11:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z92so3286873ede.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNYzl35IVsk1o+GkbvGkFXCh/7dy2D6r2STQIPk0FCs=;
        b=Yl207NljP1Wj/APUYJxOKJlxhJGJ1rkQ6amT3HyIP24PeTYTVcFERWQ0TatV4ww59m
         X4+exCYeKlfkgyuETAkkcd4oK3RJJ5DIEArrlJHcFpmqtr7ie91LKha6B93w6NHbSlm/
         e4ZJFw57IWrzAq2e79Sj0WEV4x/NGuAkwCTr3UN1X0ICb6EPGJv2okjy5QdetpkmpD43
         ZhN5YOV3LV5L/UlHEGlclcSxLrvkzMbJAAFIKnvkgTDG1gPGFdFT+F4E4FEBqAqJiC4D
         labQx5G3kRYYr4CHT/l9vv2y7cI2I1UM/FdUW2WdANC2EF0sMdQzeo4NnZlvshNacj3Z
         MbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNYzl35IVsk1o+GkbvGkFXCh/7dy2D6r2STQIPk0FCs=;
        b=hgDYZCgKfCQak9quWC9dyuz46wh1vOYMG9aV2AhakC3FgKHn6fzZ7r+aeLF+KYumNX
         VJULf10THSpOuJyyG8DHMjH1vHLgvWPLv9t9DsxONWKI0aLoMhDaF9WMWdXnEqtNU66y
         4tsn055RJ+BRtsSGneKDdpx0Ua+fNFW8XwvGUlzEMKUGRo11ApQaKyP/30Dzv7+lmHA3
         CSlFSqG4WCNLx6VvgKqoToIy0xPCih3Ay9l9G3y0ReE++3ExdyVSn70cBSnTzhyXGjtS
         ZNI+WRQY8K7/V8JEzI808HJ1X/xvnCHwq5rRXlIQRhi7XmJEsN6CLAIqrCySTwS0yRdf
         6EUw==
X-Gm-Message-State: ANoB5pku4u1ki3NUIg3CUKpXakW0XzDACFulzYuuSWUz1SWTUysbM+Qz
        0Vzlgla2PCjLzgBBsbCKsHU=
X-Google-Smtp-Source: AA0mqf5SypTDmbqqwGHk3lkd0qHIY6X3eWcjC6r6y+tdxJshq6NbTjFyvYIXpNtK+4dH3mRcvRZisA==
X-Received: by 2002:aa7:cb03:0:b0:46a:a12a:4dcd with SMTP id s3-20020aa7cb03000000b0046aa12a4dcdmr31743029edt.338.1669914661120;
        Thu, 01 Dec 2022 09:11:01 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090676c200b00770812e2394sm1962081ejn.160.2022.12.01.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:11:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0n5Q-002KXq-03;
        Thu, 01 Dec 2022 18:11:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] diff: build parseopts array on demand
Date:   Thu, 01 Dec 2022 17:54:31 +0100
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
Message-ID: <221201.86r0xjgicc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 01 2022, Ren=C3=A9 Scharfe wrote:

> Calling repo_init_revisions() and release_revisions() in that order
> leaks the memory allocated for the parseopts array in the embedded
> struct diff_options member.  Get rid of that leak by reducing the
> lifetime of that array.
>
> Original patch:
> https://lore.kernel.org/git/4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de/
>
> Submitted separately from that thread because it's independent enough.
>
> Change since v1:
> - Actually remove the parseopts member.  Its removal got lost during
>   refactoring in v1.  Thank you for spotting that, Junio!
>
>   diff: factor out add_diff_options()
>   diff: let prep_parse_options() return parseopt array
>   diff: remove parseopts member from struct diff_options
>
>  builtin/range-diff.c |  2 +-
>  diff-no-index.c      |  3 +--
>  diff.c               | 26 +++++++++++++++-----------
>  diff.h               |  2 +-
>  4 files changed, 18 insertions(+), 15 deletions(-)
>
> Range-Diff gegen v1:
> 1:  630f95320f =3D 1:  4dc8b2632b diff: factor out add_diff_options()
> 2:  4b56fa795c =3D 2:  10903d355e diff: let prep_parse_options() return p=
arseopt array
> 3:  7e54e4370a ! 3:  24bd18ae79 diff: remove parseopts member from struct=
 diff_options
>     @@ diff.c: void diff_free(struct diff_options *options)
>       }
>
>       void diff_flush(struct diff_options *options)
>     +
>     + ## diff.h ##
>     +@@ diff.h: struct diff_options {
>     + 	unsigned color_moved_ws_handling;
>     +
>     + 	struct repository *repo;
>     +-	struct option *parseopts;
>     + 	struct strmap *additional_path_headers;
>     +
>     + 	int no_free;

This looks good to me. Would you mind running the tests with:

	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue m=
ake SANITIZE=3Dleak=20

And then marking up the ones that now pass with
TEST_PASSES_SANITIZE_LEAK=3Dtrue. I think it's all except one of these
(one isn't marked on "master", I forget which one):

	Test Summary Report
	-------------------
	t1022-read-tree-partial-clone.sh                 (Wstat: 256 Tests: 1 Fail=
ed: 0)
	  Non-zero exit status: 1
	t2012-checkout-last.sh                           (Wstat: 256 Tests: 22 Fai=
led: 0)
	  Non-zero exit status: 1
	t3210-pack-refs.sh                               (Wstat: 256 Tests: 30 Fai=
led: 0)
	  Non-zero exit status: 1
	t4053-diff-no-index.sh                           (Wstat: 256 Tests: 19 Fai=
led: 0)
	  Non-zero exit status: 1
	t5554-noop-fetch-negotiator.sh                   (Wstat: 256 Tests: 1 Fail=
ed: 0)
	  Non-zero exit status: 1
	t5613-info-alternate.sh                          (Wstat: 256 Tests: 13 Fai=
led: 0)
	  Non-zero exit status: 1
	t6021-rev-list-exclude-hidden.sh                 (Wstat: 256 Tests: 42 Fai=
led: 0)
	  Non-zero exit status: 1
	t6415-merge-dir-to-symlink.sh                    (Wstat: 256 Tests: 24 Fai=
led: 0)
	  Non-zero exit status: 1
	t7403-submodule-sync.sh                          (Wstat: 256 Tests: 18 Fai=
led: 0)
	  Non-zero exit status: 1
	t7504-commit-msg-hook.sh                         (Wstat: 256 Tests: 30 Fai=
led: 0)
	  Non-zero exit status: 1
	t9115-git-svn-dcommit-funky-renames.sh           (Wstat: 256 Tests: 12 Fai=
led: 0)
	  Non-zero exit status: 1
	t9146-git-svn-empty-dirs.sh                      (Wstat: 256 Tests: 14 Fai=
led: 0)
	  Non-zero exit status: 1
	t9160-git-svn-preserve-empty-dirs.sh             (Wstat: 256 Tests: 12 Fai=
led: 0)
	  Non-zero exit status: 1

I.e. this makes a lot more tests pass leak-free, yay!

To nitpick a bit: I didn't find that splitting this up into three
patches helped to read it, e.g. 2/3 adds code that promptly goes away in
3/3.

I also wondered why add two API functions for this, instead of just
teaching the "prep options" to concat passed-in options with the user
options? That also avoids a parse_options_dup(). I.e. with that squashed
in the whole thing is:

 builtin/range-diff.c |  2 +-
 diff-no-index.c      |  3 +--
 diff.c               | 19 ++++++++-----------
 diff.h               |  3 ++-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e2a74efb42a..8fcd6663b89 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -47,7 +47,7 @@ int cmd_range_diff(int argc, const char **argv, const cha=
r *prefix)
=20
 	repo_diff_setup(the_repository, &diffopt);
=20
-	options =3D parse_options_concat(range_diff_options, diffopt.parseopts);
+	options =3D add_diff_parseopts(range_diff_options, &diffopt);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_DASHDASH);
=20
diff --git a/diff-no-index.c b/diff-no-index.c
index 18edbdf4b59..efac1d38b38 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -255,8 +255,7 @@ int diff_no_index(struct rev_info *revs,
 	};
 	struct option *options;
=20
-	options =3D parse_options_concat(no_index_options,
-				       revs->diffopt.parseopts);
+	options =3D add_diff_parseopts(no_index_options, &revs->diffopt);
 	argc =3D parse_options(argc, argv, revs->prefix, options,
 			     diff_no_index_usage, 0);
 	if (argc !=3D 2) {
diff --git a/diff.c b/diff.c
index 1054a4b7329..e186fc91802 100644
--- a/diff.c
+++ b/diff.c
@@ -4615,8 +4615,6 @@ static void run_checkdiff(struct diff_filepair *p, st=
ruct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
=20
-static void prep_parse_options(struct diff_options *options);
-
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4662,8 +4660,6 @@ void repo_diff_setup(struct repository *r, struct dif=
f_options *options)
=20
 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;
-
-	prep_parse_options(options);
 }
=20
 static const char diff_status_letters[] =3D {
@@ -4821,8 +4817,6 @@ void diff_setup_done(struct diff_options *options)
 			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &=3D ~options->filter_not;
 	}
-
-	FREE_AND_NULL(options->parseopts);
 }
=20
 int parse_long_opt(const char *opt, const char **argv,
@@ -5419,7 +5413,8 @@ static int diff_opt_rotate_to(const struct option *op=
t, const char *arg, int uns
 	return 0;
 }
=20
-static void prep_parse_options(struct diff_options *options)
+struct option *add_diff_parseopts(struct option *useropts,
+				  struct diff_options *options)
 {
 	struct option parseopts[] =3D {
 		OPT_GROUP(N_("Diff output format options")),
@@ -5689,22 +5684,25 @@ static void prep_parse_options(struct diff_options =
*options)
 		OPT_END()
 	};
=20
-	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
-	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+	return parse_options_concat(useropts, parseopts);
 }
=20
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
+	struct option no_options[] =3D { OPT_END() };
+	struct option *diff_parseopts =3D add_diff_parseopts(no_options, options);
+
 	if (!prefix)
 		prefix =3D "";
=20
-	ac =3D parse_options(ac, av, prefix, options->parseopts, NULL,
+	ac =3D parse_options(ac, av, prefix, diff_parseopts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
 			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
+	free(diff_parseopts);
=20
 	return ac;
 }
@@ -6513,7 +6511,6 @@ void diff_free(struct diff_options *options)
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
-	FREE_AND_NULL(options->parseopts);
 }
=20
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index fd33caeb25d..56704d3de22 100644
--- a/diff.h
+++ b/diff.h
@@ -394,7 +394,6 @@ struct diff_options {
 	unsigned color_moved_ws_handling;
=20
 	struct repository *repo;
-	struct option *parseopts;
 	struct strmap *additional_path_headers;
=20
 	int no_free;
@@ -539,6 +538,8 @@ int git_diff_ui_config(const char *var, const char *val=
ue, void *cb);
 #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
 #endif
 void repo_diff_setup(struct repository *, struct diff_options *);
+struct option *add_diff_parseopts(struct option *useropts,
+				  struct diff_options *options);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *=
);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
