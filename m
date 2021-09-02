Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA122C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9560F12
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhIBO1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhIBO1E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:27:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B46C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 07:26:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u14so4780225ejf.13
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xJAfNnpcyU0FtxQS9QITuHImir0wWGW2/av89bjNw9Y=;
        b=BXKICw2pX7/zqeSOS5EkUFq5YjAk0Jv5cey8CN+X7i06LuWJsr0IeLBIuOPnYZWOLE
         lfxijruh9eSVMOvXs0RDeegVqgNz59AVoehF0vZvM2/jp2MYi36mu39rL+qhZilk+9DC
         1bVvogCMLYCbjHGzp7Es4I30DrYM3uvofPpvb9Fp8v0Su/29R8ae3jtL2kFT9j0EYGmM
         zFfWprtoahK+SLShV/NA5bj4D36D7808UeZpiyZzDk69zXNY+ezRH7vAtlyZSN0YKofB
         iZc7+6ZsiO4Vmh/L32bgyw6ENW7HrrZM//i8YT2+L8H8UgSnGHTBPYcAQyQMNE8IGvsc
         SbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xJAfNnpcyU0FtxQS9QITuHImir0wWGW2/av89bjNw9Y=;
        b=kD8YelJpIln1TR4/TFc0QseSDisHpGbpZ27IViva2zeEpihuWrzQsoVtF5x8cbDOnU
         pWunnanYgT3ScGeYpBFKnZZJFuzum/h+LUmOSusX5yaEDVaqUpnP5+gboO0HjGerkUXR
         XdHjguiwBb7ybBJsnD3acePXwOq/3VQv3gEDxy4Ui50dsrRGU9l6FacgjazbkdfzQ1NZ
         9X93q+qqhkW8K3ryBmizaSw5b7gDqrTCUtUGwvfz+yfrr/8sOCxwaSojIbXQWelAQZcl
         tudCLyhqQbrx9/dFRg/PDXSvr7bEF18N+Q+WMfuU2+9bHWx2SAZPjGVVBCmTa9JsxXut
         RBfw==
X-Gm-Message-State: AOAM5324FVsmrxZxoNnhUT7ctlOt3h3Mc6LynD32c9JyNjni4bKU/mch
        T4DpszXrxlu/vQqLWOkb47U=
X-Google-Smtp-Source: ABdhPJwhePYC8x1Jtwq5yLaye98Bs4hBQP/Qx8YWOtHDEIBKAbcxY6eCAG+rvobJG3/nBaIVp9y1NA==
X-Received: by 2002:a17:906:d0cd:: with SMTP id bq13mr4157189ejb.66.1630592764317;
        Thu, 02 Sep 2021 07:26:04 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x9sm1322292edj.95.2021.09.02.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:26:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Thu, 02 Sep 2021 16:16:22 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
 <87tuj4v2q5.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109021555050.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109021555050.55@tvgsbejvaqbjf.bet>
Message-ID: <87tuj39hqd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > This option was deprecated in favor of `--rebase-merges` some time ago,
>> > and now we retire it.
>>
>> >  static int is_merge(struct rebase_options *opts)
>> >  {
>> > -	return opts->type =3D=3D REBASE_MERGE ||
>> > -		opts->type =3D=3D REBASE_PRESERVE_MERGES;
>> > +	return opts->type =3D=3D REBASE_MERGE;
>> >  }
>>
>> This leaves us with a rather pointless is_merge() function and
>> nonsensical control flow in parse_opt_merge().
>
> Thank you for offering your perspective.
>
> From a readability point of view, I disagree with your assessment. Just
> because it can be written shorter does not mean that it is clearer. Quite
> the contrary, if you ask me. And since _I_ am contributing this patch
> series, I will respectfully disagree and keep the version I find more
> intuitive.
>
> You could potentially talk me into adding a patch that renames that
> function to `is_merge_backend()`, but that's as far as I would go. And I
> am not really certain that that would improve things, either.

I should have phrased that "Let's squash this in" less forcefully, to be
clear it was just a suggestion. I'm fine with you not taking that
squash. This series is good either way.

But just to poke a bit at the rationale: I'd be totally on-board with
keeping it because we'd like the smallest possible diff here, even if
that ends up including this oddity.

But in terms of making the end-result more readable I don't really see
that.

We're left with a mismatch of some things comparing the enum label
directly, and some using this function, and then there's
REBASE_APPLY. To make it consistent we could alternatively have the diff
here at the end, but having some mixture of both seems like the worst
end-result, shouldn't we pick one way of inspecting these flags and use
that consistently?

(I did not convert the few REBASE_UNSPECIFIED, but those comparisons
could similarly be is_unspecified(), and all three could be named
is_*_backend() per your suggestion).

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d707e3604e7..ef82a5f1668 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -388,6 +388,11 @@ static int is_merge(struct rebase_options *opts)
 	return opts->type =3D=3D REBASE_MERGE;
 }
=20
+static int is_apply(struct rebase_options *opts)
+{
+	return opts->type =3D=3D REBASE_APPLY;
+}
+
 static void imply_merge(struct rebase_options *opts, const char *option)
 {
 	switch (opts->type) {
@@ -558,7 +563,7 @@ static int finish_rebase(struct rebase_options *opts)
 	 * user should see them.
 	 */
 	run_auto_maintenance(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
-	if (opts->type =3D=3D REBASE_MERGE) {
+	if (is_merge(opts)) {
 		struct replay_opts replay =3D REPLAY_OPTS_INIT;
=20
 		replay.action =3D REPLAY_INTERACTIVE_REBASE;
@@ -744,7 +749,7 @@ static int run_specific_rebase(struct rebase_options *o=
pts, enum action action)
 	struct strbuf script_snippet =3D STRBUF_INIT;
 	int status;
=20
-	if (opts->type =3D=3D REBASE_MERGE) {
+	if (is_merge(opts)) {
 		/* Run sequencer-based rebase */
 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
@@ -759,14 +764,14 @@ static int run_specific_rebase(struct rebase_options =
*opts, enum action action)
 		}
=20
 		status =3D run_sequencer_rebase(opts, action);
-	} else if (opts->type =3D=3D REBASE_APPLY)
+	} else if (is_apply(opts))
 		status =3D run_am(opts);
 	else
 		BUG("Unhandled rebase type %d", opts->type);
=20
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
-	else if (opts->type =3D=3D REBASE_MERGE)
+	else if (is_merge(opts))
 		; /* merge backend cleans up after itself */
 	else if (status =3D=3D 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
@@ -1293,7 +1298,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	}
 	case ACTION_QUIT: {
 		save_autostash(state_dir_path("autostash", &options));
-		if (options.type =3D=3D REBASE_MERGE) {
+		if (is_merge(&options)) {
 			struct replay_opts replay =3D REPLAY_OPTS_INIT;
=20
 			replay.action =3D REPLAY_INTERACTIVE_REBASE;
@@ -1406,7 +1411,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 		imply_merge(&options, "--rebase-merges");
 	}
=20
-	if (options.type =3D=3D REBASE_APPLY) {
+	if (is_apply(&options)) {
 		if (ignore_whitespace)
 			strvec_push(&options.git_am_opts,
 				    "--ignore-whitespace");
@@ -1452,7 +1457,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
-	if (options.type =3D=3D REBASE_MERGE)
+	if (is_merge(&options))
 		imply_merge(&options, "--merge");
=20
 	if (options.root && !options.onto_name)
@@ -1461,7 +1466,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
=20
-	if (options.git_am_opts.nr || options.type =3D=3D REBASE_APPLY) {
+	if (options.git_am_opts.nr || is_apply(&options)) {
 		/* all am options except -q are compatible only with --apply */
 		for (i =3D options.git_am_opts.nr - 1; i >=3D 0; i--)
 			if (strcmp(options.git_am_opts.v[i], "-q"))
@@ -1486,7 +1491,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			    options.default_backend);
 	}
=20
-	if (options.type =3D=3D REBASE_MERGE &&
+	if (is_merge(&options) &&
 	    !options.strategy &&
 	    getenv("GIT_TEST_MERGE_ALGORITHM"))
 		options.strategy =3D xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
