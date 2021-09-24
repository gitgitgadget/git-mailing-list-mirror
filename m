Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C038C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 00:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACB661211
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 00:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbhIXA7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 20:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbhIXA7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 20:59:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A1FC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 17:58:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so22213075wra.8
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHZ4z0nq4e/rcNljHvqWBZL5IAfYHZcsqdzkz5AfhY8=;
        b=N8bnPbhLWWRIOwZn6DfyemTJv1fzt/h4B9Vm/dwKzqERtVLBB7vxluVQ80PoEuZ87p
         rDoJ7fmLZi8kY14mFqS+pQ3qhosi9mBQnGdURmGeN/jU/yjzn0izfhnvYjLsMOWtKTEc
         YTnRFkPuRtPFTGU+2H4v9JNT7bM+FoeMjdKe4J1PmUafRTI74Y1cagCuKvI0kYrP+4bu
         KMP2kiSfEiY1XzT+5Fo/knFQkTREZHNXN++8tQ77S7YSWENpZno3ov56quGDTrUv2pHP
         eHdKrPd8Y/o6XuL2GNbIENPR3OZpzCTl+Lo+TLB1YqK3SQTTSv3xp2tzau1fc/5QrzTm
         vvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHZ4z0nq4e/rcNljHvqWBZL5IAfYHZcsqdzkz5AfhY8=;
        b=1BPQePMFuaO21TuPgZ3YKe3Qk7FJVyLOt+spB621nzUvwAhki91kVFk82lBAw6V8mW
         jCUxmiSGbjaPdSNaj6LS5z7OxEC6Hda60ugAGEIT+mc38sU9Y7ivPyz9lgbKcBRSOEgY
         D5/fYtwXXQMBr9kfIn1qSYaaqWQfKs2Go3nMcGfemZwNgCnaPu/jl0uVnGF/eic/P9ek
         GTtc2yRMcLXi+fku/A/2FS1t/TjYf46uAOzMtlYCu74Kr5Ry2hiHGBxYNijcXo1pmk9I
         gfkF7moPJdI+ID3lwHO4Yr6RMwgG67K0qT3Bx5YZXR/DTPPak1MQVnkASIDwPJ02iswP
         ncNg==
X-Gm-Message-State: AOAM531KS6aUGNR+ZalCdp1ZdELwNcRfMI80wLMelNVnD05UGis9B0VY
        FZLGUK0f5CHQJIV+3x1eMtzB7pHKrPdJ9A==
X-Google-Smtp-Source: ABdhPJy2JuNhgxoI6evMA1OevcA9l7ZvBP3D5Fs6PCmS06QFj9+aqfp/H7NT2ko6X9eKCnZtvCRmSQ==
X-Received: by 2002:a5d:60c8:: with SMTP id x8mr8198472wrt.293.1632445093259;
        Thu, 23 Sep 2021 17:58:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm7548597wri.53.2021.09.23.17.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 17:58:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Date:   Fri, 24 Sep 2021 02:58:04 +0200
Message-Id: <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1231.g24d802460a8
In-Reply-To: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an "includeIf" directive that's conditional on the value of an
environment variable. This has been suggested at least a couple of
times[1][2] as a proposed mechanism to drive dynamic includes, and to
e.g. match based on TERM=xterm in the user's environment.

I initially tried to implement just an "env" keyword, but found that
splitting them up was both easier to implement and to explain to
users. I.e. an "env" will need to handle an optional "=" for matching
the value, and should the semantics be if the variable exists? If it's
boolean?

By splitting them up we present a less ambiguous interface to users,
and make it easy to extend this in the future. I didn't see any point
in implementing a "/i" variant, that only makes sense for "gitdir"'s
matching of FS paths.

I would like syntax that used a "=" better, i.e. "envIs:TERM=xterm"
instead of the "envIs:TERM:xterm" implemented here, but the problem
with that is that it isn't possible to specify those sorts of config
keys on the command-line:

    $ git -c includeIf.someVerb:FOO:BAR.path=bar status --short
    $ git -c includeIf.someVerb:FOO=BAR.path=bar status --short
    error: invalid key: includeIf.someVerb:FOO
    fatal: unable to parse command-line config
    $

I.e. not only isn't the "someVerb" in that scenario not understood by
an older git, but it'll hard error on seeing such a key. See
1ff21c05ba9 (config: store "git -c" variables using more robust
format, 2021-01-12) for a discussion about "=" in config keys. By
picking any other character (e.g. ":") we avoid that whole issue.

1. https://lore.kernel.org/git/YUzvhLUmvsdF5w+r@coredump.intra.peff.net/
2. https://lore.kernel.org/git/X9OB7ek8fVRXUBdK@coredump.intra.peff.net/
3. https://lore.kernel.org/git/87in9ucsbb.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

> On Wed, Sep 22, 2021 at 10:21:22PM -0700, The Grey Wolf wrote:
>
>> Anything else you want to add:
>>      I searched google and the documentation as best I was able for
>>      this, but I am unable to find anywhere that will let me disable
>>      (or enable) colour for a particular term type.  Sometimes I'm on
>>      an xterm, for which this is GREAT.  Sometimes I'm on a Wyse WY60,
>>      for which this is sub-optimal.  My workaround is to disable colour
>>      completely, which is reluctantly acceptable, but it would be nice
>>      to say "If I'm on an xterm/aterm/urxvt/ansi terminal, enable
>>      colour or cursor-positioning, otherwise shut it off."  If this
>>      seems too much of a one-off to handle, fine, but most things that
>>      talk fancy to screens are kind enough to allow an opt-out based on
>>      terminal type. :)
>
> Git doesn't have any kind of list of terminals, beyond knowing that
> "dumb" should disable auto-color. It's possible we could expand that if
> there are known terminals that don't understand ANSI colors. I'm a bit
> wary of having a laundry list of obscure terminals, though.
>
> If we built against ncurses or some other terminfo-aware library we
> could outsource that, but that would be a new dependency. I'm hesitant
> to do that even as an optional dependency given the bang-for-the-buck
> (and certainly making it require would be right out).
>
> Obviously you can wrap Git with a script to tweak the config based on
> the current setting of the $TERM variable. It would be nice if you could
> have conditional config for that. E.g., something like:
>
>   [includeIf "env:TERM==xterm"]
>   path = gitconfig-color
>
> That doesn't exist, but would fit in reasonably well with our other
> conditional config options.

Perhaps something like this?

 Documentation/config.txt  | 35 ++++++++++++++++++++
 config.c                  | 61 +++++++++++++++++++++++++++++++++--
 t/t1305-config-include.sh | 67 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c0e6b859f1..58f6d49216d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -159,6 +159,41 @@ all branches that begin with `foo/`. This is useful if your branches are
 organized hierarchically and you would like to apply a configuration to
 all the branches in that hierarchy.
 
+`envExists`::
+	The data that follows the keyword `envExists:` is taken to be the
+	name of an environment variable, e.g. `envExists:NAME`. If the
+	variable (`NAME` in this case) exists the include condition is
+	met.
+
+`envBool`::
+	The data that follows the keyword `envBool:` is taken to be the
+	name of an environment variable, e.g. `envBool:NAME`. If the
+	variable (`NAME` in this case) exists, its value will be
+	checked for boolean truth.
++
+The accepted boolean values are the same as those that `--type bool`
+would accept. A value that's normalized to "true" will satisfy the
+include condition (a nonexisting environment variable is "false").
+
+`envIs`::
+	The data that follows the keyword `envIs:` is taken to be the
+	name of an environment variable, followed by a mandatory ":"
+	character, followed by the expected value of the environment
+	variable. If the value matches the include condition is
+	satisfied.
++
+Values may contain any characters otherwise accepted by the config
+mechanism (including ":").
+
+`envMatch`::
+	Like `envIs`, except that the value is matched using standard
+	globbing wildcards.
+
+There is no way to match an environment variable name with any of the
+`env*` directives if that variable name contains a ":" character. Such
+names are allowed by POSIX, but it is assumed that nobody will need to
+match such a variable name in practice.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
diff --git a/config.c b/config.c
index 2edf835262f..064059b0d6d 100644
--- a/config.c
+++ b/config.c
@@ -271,6 +271,54 @@ static int include_by_gitdir(const struct config_options *opts,
 	return ret;
 }
 
+static int include_by_env_exists(const char *cond, size_t cond_len)
+{
+	char *cfg = xstrndup(cond, cond_len);
+	int ret = !!getenv(cfg);
+	free(cfg);
+	return ret;
+}
+
+static int include_by_env_bool(const char *cond, size_t cond_len)
+{
+	char *cfg = xstrndup(cond, cond_len);
+	int ret = git_env_bool(cfg, 0);
+	free(cfg);
+	return ret;
+}
+
+static int include_by_env_match(const char *cond, size_t cond_len, int glob,
+				int *err)
+{
+	const char *eq;
+	const char *value;
+	const char *env;
+	char *cfg = xstrndup(cond, cond_len);
+	char *key = NULL;
+	int ret = 0;
+
+	eq = strchr(cfg, ':');
+	if (!eq) {
+		*err = error(_("'%s:%.*s' missing a ':' to match the value"),
+			     glob ? "envMatch" : "envIs", (int)(cond_len),
+			     cond);
+		goto cleanup;
+	}
+	value = eq + 1;
+
+	key = xmemdupz(cfg, eq - cfg);
+	env = getenv(key);
+	if (!env)
+		goto cleanup;
+
+	ret = glob ? !wildmatch(value, env, 0) : !strcmp(value, env);
+
+cleanup:
+	free(key);
+	free(cfg);
+	return ret;
+}
+
 static int include_by_branch(const char *cond, size_t cond_len)
 {
 	int flags;
@@ -292,7 +340,8 @@ static int include_by_branch(const char *cond, size_t cond_len)
 }
 
 static int include_condition_is_true(const struct config_options *opts,
-				     const char *cond, size_t cond_len)
+				     const char *cond, size_t cond_len,
+				     int *err)
 {
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
@@ -301,6 +350,14 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "envExists:", &cond, &cond_len))
+		return include_by_env_exists(cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "envBool:", &cond, &cond_len))
+		return include_by_env_bool(cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "envIs:", &cond, &cond_len))
+		return include_by_env_match(cond, cond_len, 0, err);
+	else if (skip_prefix_mem(cond, cond_len, "envMatch:", &cond, &cond_len))
+		return include_by_env_match(cond, cond_len, 1, err);
 
 	/* unknown conditionals are always false */
 	return 0;
@@ -325,7 +382,7 @@ int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
+	    (cond && include_condition_is_true(inc->opts, cond, cond_len, &ret)) &&
 	    !strcmp(key, "path"))
 		ret = handle_path_include(value, inc);
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index ccbb116c016..cebe2bb75f1 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -348,6 +348,73 @@ test_expect_success 'conditional include, onbranch, implicit /** for /' '
 	test_cmp expect actual
 '
 
+test_expect_success 'conditional include, envExists:*' '
+	echo value >expect &&
+	git config -f envExists.cfg some.key $(cat expect) &&
+
+	test_must_fail git -c includeIf.envExists:VAR.path="$PWD/envExists.cfg" config some.key 2>err &&
+	test_must_be_empty err &&
+
+	VAR= git -c includeIf.envExists:VAR.path="$PWD/envExists.cfg" config some.key >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual &&
+
+	VAR=0 git -c includeIf.envExists:VAR.path="$PWD/envExists.cfg" config some.key >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+'
+
+test_expect_success 'conditional include, envBool:*' '
+	echo value >expect &&
+	git config -f envBool.cfg some.key $(cat expect) &&
+
+	test_must_fail env VAR= git -c includeIf.envBool:VAR.path="$PWD/envBool.cfg" config some.key 2>err &&
+	test_must_be_empty err &&
+
+	test_must_fail env VAR=0 git -c includeIf.envBool:VAR.path="$PWD/envBool.cfg" config some.key 2>err &&
+	test_must_be_empty err &&
+
+	test_must_fail env VAR=false git -c includeIf.envBool:VAR.path="$PWD/envBool.cfg" config some.key 2>err &&
+	test_must_be_empty err &&
+
+	# envBool:* bad value
+	cat >expect.err <<-\EOF &&
+	fatal: bad boolean config value '\''gibberish'\'' for '\''VAR'\''
+	EOF
+	test_must_fail env VAR=gibberish git -c includeIf.envBool:VAR.path="$PWD/envBool.cfg" config some.key 2>err.actual &&
+	test_cmp expect.err err.actual
+'
+
+test_expect_success 'conditional include, envIs:*' '
+	echo value >expect &&
+	git config -f envIs.cfg some.key $(cat expect) &&
+
+	VAR=foo git -c includeIf.envIs:VAR:foo.path="$PWD/envExists.cfg" config some.key &&
+	test_must_fail env VAR=foo git -c includeIf.envIs:VAR:*f*.path="$PWD/envExists.cfg" config some.key &&
+
+	cat >expect.err <<-\EOF &&
+	error: '\''envIs:VAR'\'' missing a '\'':'\'' to match the value
+	fatal: unable to parse command-line config
+	EOF
+	test_must_fail env VAR=x git -c includeIf.envIs:VAR.path="$PWD/envBool.cfg" config some.key 2>err.actual &&
+	test_cmp expect.err err.actual
+'
+
+test_expect_success 'conditional include, envMatch:*' '
+	echo value >expect &&
+	git config -f envMatch.cfg some.key $(cat expect) &&
+
+	VAR=foo git -c includeIf.envMatch:VAR:foo.path="$PWD/envExists.cfg" config some.key &&
+	VAR=foo git -c includeIf.envMatch:VAR:*f*.path="$PWD/envExists.cfg" config some.key &&
+
+	cat >expect.err <<-\EOF &&
+	error: '\''envMatch:VAR'\'' missing a '\'':'\'' to match the value
+	fatal: unable to parse command-line config
+	EOF
+	test_must_fail env VAR=x git -c includeIf.envMatch:VAR.path="$PWD/envBool.cfg" config some.key 2>err.actual &&
+	test_cmp expect.err err.actual
+'
+
 test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
 	git -C cycle config include.path cycle &&
-- 
2.33.0.1231.g24d802460a8

