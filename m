Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4505C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 10:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjC2Kf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjC2KfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 06:35:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A881BFC
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 03:35:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so61246550edd.5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680086111;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmQJAL3wwx8C3RKdW1mCEmBOPwUtCebMpVXRThmh+8o=;
        b=TJiz5xTp+No+dn6hwbOyLW9otnjPSuOjH8GbnOwKmuEGNl1Ij25JcgqMao/0ioK9lw
         rYFge45Bo37qELOknPH+hyKDE/WT2IcH8vWoS89agPJBxqR7DqcAUTKcSoBcmt9d5Kcc
         cjoFUqPRAVpaoQE0ZdtSiPLXfKp63bMyahp5fHYGqcX/Jh/4g0AkYijXrGdepgkG7HRd
         eE5sz4QPNqtEdU/AQVTFqfj70FqPevuS9Gqhnna957N9TiKvXABbIbO6XgfpAzKKJrps
         vjKdznjDDpPtMg8FfdQXHfGlOW/mkleNuutrh1nv/WCJqQ+l3Q44q2BNtAUiiRa87REC
         7UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680086111;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmQJAL3wwx8C3RKdW1mCEmBOPwUtCebMpVXRThmh+8o=;
        b=rdHvPwAZcNGeyhWt1FEOFJxPrFnKd7zfgeI0ilgpBrnWb/MIeHEGHBjwBxp9xzb0iL
         WVRdyCFJ2fC3AC5NfU4r1lcKWqswYsYAzRFc16mc4qx2NNxRkgKIqgXjoHJ48Cae3GTt
         I8EgjQtfNjf1lyazsC3hXeYcTUAdZlyGieW93RWh+AnUh/vYCR7ddytMQvPGSA+klNGs
         fZkp7XaDgX9CEPcahaWmpPi31L5LkQ3SKTIcNPDt/2N8iGgi3w6nXYT+gewog3VTO2a1
         OhaOnPemXdR1Ge2gcjxZdNfT0r7V9cNT2WhPzouGGI5P23Lib+3LJT6xuaP6it/qYuex
         qwtQ==
X-Gm-Message-State: AAQBX9fmLLgk5S8NW1llVvL0L+rvO/v9Hql2NPpdYqNJwr0gM3Ba4QDH
        2OnEevrLNfXCEQqQZhiOX+I=
X-Google-Smtp-Source: AKy350YuJ21Bx+ESMNziasMYpLvnqXdAMeBlDIMsRHNWyL3/6aJJOFlfMLprIIVje4g1ilMVxJOEGA==
X-Received: by 2002:a17:906:5850:b0:935:3028:ff58 with SMTP id h16-20020a170906585000b009353028ff58mr19357417ejs.55.1680086111134;
        Wed, 29 Mar 2023 03:35:11 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id cd11-20020a170906b34b00b0093009bc5825sm16328639ejb.2.2023.03.29.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 03:35:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1phT93-0057N6-30;
        Wed, 29 Mar 2023 12:35:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 1/4] tests: run internal chain-linter under "make test"
Date:   Wed, 29 Mar 2023 12:20:00 +0200
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202207.GA1241631@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230328202207.GA1241631@coredump.intra.peff.net>
Message-ID: <230329.86wn2zvo9u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 28 2023, Jeff King wrote:

> Since 69b9924b875 (t/Makefile: teach `make test` and `make prove` to run
> chainlint.pl, 2022-09-01), we run a single chainlint.pl process for all
> scripts, and then instruct each individual script to run with the
> equivalent of --no-chain-lint, which tells them not to redundantly run
> the chainlint script themselves.
>
> However, this also disables the internal linter run within the shell by
> eval-ing "(exit 117) && $1" and confirming we get code 117. In theory
> the external linter produces a superset of complaints, and we don't need
> the internal one anymore. However, we know there is at least one case
> where they differ. A test like:
>
> 	test_expect_success 'should fail linter' '
> 		false &&
> 		sleep 2 &
> 		pid=$! &&
> 		kill $pid
> 	'
>
> is buggy (it ignores the failure from "false", because it is
> backgrounded along with the sleep). The internal linter catches this,
> but the external one doesn't (and teaching it to do so is complicated[1]).
> So not only does "make test" miss this problem, but it's doubly
> confusing because running the script standalone does complain.
>
> Let's teach the suppression in the Makefile to only turn off the
> external linter (which we know is redundant, as it was already run) and
> leave the internal one intact.
>
> I've used a new environment variable to do this here, and intentionally
> did not add a "--no-ext-chain-lint" option. This is an internal
> optimization used by the Makefile, and not something that ordinary users
> would need to tweak.
>
> [1] For discussion of chainlint.pl and this case, see:
>     https://lore.kernel.org/git/CAPig+cQtLFX4PgXyyK_AAkCvg4Aw2RAC5MmLbib-aHHgTBcDuw@mail.gmail.com/
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/Makefile    | 2 +-
>  t/test-lib.sh | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/Makefile b/t/Makefile
> index 88fa5049573..10881affdd0 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -45,7 +45,7 @@ CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
>  # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
>  # checks all tests in all scripts via a single invocation, so tell individual
>  # scripts not to "chainlint" themselves
> -CHAINLINTSUPPRESS = GIT_TEST_CHAIN_LINT=0 && export GIT_TEST_CHAIN_LINT &&
> +CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
>  
>  all: $(DEFAULT_TEST_TARGET)
>  
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 62136caee5a..09789566374 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1593,7 +1593,8 @@ then
>  	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
>  fi
>  
> -if test "${GIT_TEST_CHAIN_LINT:-1}" != 0
> +if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
> +   test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
>  then
>  	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
>  		BUG "lint error (see '?!...!? annotations above)"

So, we used to use the "sed" script to run against the *.sh, and do the
"eval 117" check, but since chainlint.pl we've checked all the tests in
one go when invoked from the Makefile, and turned off the "eval 117".

And, as this change points out, there's cases where chainlint.pl won't
catch everything, so we'd like to keep the "eval" bits by default, but
not the invoking of chainlint.pl by the script itself.

All of which makes sense.

But it seems to me that the findings in this change make the docs
outdated, and we should update them, but maybe I'm missing something.

Now the comment in the Makefile still says (as seen in the context):

	# `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
	# checks all tests in all scripts via a single invocation, so tell individual
	# scripts not to "chainlint" themselves

But as the commit message notes that's not accurate anymore. We're *not*
telling them to turn off chainlint in its entirety, we're telling them
to only suppress the chainlint.pl part.

So if you invoke the Makefile with GIT_TEST_CHAIN_LINT=0 we'll still
turn all of it off, but an invokation of chainlint.pl for the scripts as
a batch is no longer thought to make the "eval 117" trick redundant.

I haven't looked too deeply, but it seems that we should at least adjust
that comment in the Makefile, or perhaps we should rename this "eval
117" thing to be "internal lint" or something, and not "chain lint", to
avoid conflating it with chainlint.pl itself.

So maybe something like this, i.e. we'd just "rebrand" this to begin
with, and avoid editing the t/Makefile at all (untested)?

 t/README      | 12 ++++++++++++
 t/test-lib.sh |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 29576c37488..83d58f2e680 100644
--- a/t/README
+++ b/t/README
@@ -196,6 +196,18 @@ appropriately before running "make". Short options can be bundled, i.e.
 	this feature by setting the GIT_TEST_CHAIN_LINT environment
 	variable to "1" or "0", respectively.
 
+--internal-lint::
+--no-internal-lint::
+	If --internal-lint is enabled, the test harness will try to
+	detect missing "&&"-chains in edge cases that "--chain-lint"
+	wouldn't notice, unlike "--chain-lint" this check is run from
+	within "test_expect_*" itself, and thus requires the tests to
+	run.
+
+	You may also enable or disable this feature by setting the
+	GIT_TEST_INTERNAL_LINT environment variable to "1" or "0",
+	respectively.
+
 --stress::
 	Run the test script repeatedly in multiple parallel jobs until
 	one of them fails.  Useful for reproducing rare failures in
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62136caee5a..792c68aa56a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -205,6 +205,10 @@ parse_option () {
 		GIT_TEST_CHAIN_LINT=1 ;;
 	--no-chain-lint)
 		GIT_TEST_CHAIN_LINT=0 ;;
+	--internal-lint)
+		GIT_TEST_INTERNAL_LINT=1 ;;
+	--no-internal-lint)
+		GIT_TEST_INTERNAL_LINT=0 ;;
 	-x)
 		trace=t ;;
 	-V|--verbose-log)
@@ -1090,7 +1094,7 @@ test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
 
-	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
+	if test "${GIT_TEST_INTERNAL_LINT:-1}" != 0; then
 		# turn off tracing for this test-eval, as it simply creates
 		# confusing noise in the "-x" output
 		trace_tmp=$trace
