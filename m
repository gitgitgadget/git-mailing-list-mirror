Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03839C77B6C
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDGPvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 11:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGPvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 11:51:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94A1993
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 08:51:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j22so9267547ejv.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680882694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WYB8VawpuetGDVC9XFx9j0/aVW6f8Zo38fxeN6+xjRQ=;
        b=oktlozWmboymLRy2yjZm2mR9cGyBMIoKB3gZozPPJ9K+bRY46yHmy98fBvAeww0HiH
         MOjjtG4uQ//90SwAr180poqyrk/OiKw5kZKiXmQLNujVf/S9KLSxJ5m18z8K+5udKUpL
         04WGsegwy/Ya1dvd6k8tOysfM62MU9YxlyRl9pfQJk1s4J+eL2rTDok6F5ssDmoQc6MI
         y9xpSKnuoXHIQtYNN2gxJ5cTwlsSxHFe77ee7dEsSE7XJ3lQTdkROgcQu3kML6zFtaaX
         97GiwWS8DE1ELA2/F5P+apymDnEHLSYZwjcWYfw2vOlPs28s/M6sRQ7jQMYUsTcNKHk4
         DiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYB8VawpuetGDVC9XFx9j0/aVW6f8Zo38fxeN6+xjRQ=;
        b=A8MBf94wkLD859hBwjlsR1wAnYBNlmZ0pDwDrRQzBxQpdxdBiI/mQ6+3a3PO3a6YkK
         /nhFu4DqgZzudNdCAxkIL1vOxcZelyz1x7z8CXe58Hl2/aLNLtfDz8yTWtBoeAsFghKc
         t/69BMt5ycR6TGAXppZtzzbXLkYAetz/u3POh9Woz39Xh/TfPycP6mFQBChtnqvU+yBr
         pkbddNggXXyPbd4rBnTtS6hqJihWzXJ0u/hlQ0Z7prY2ntpTGN4Cae+T64xshtVQK4rb
         6hPlEy7d/w4AV9CJvwWlmDAeYJu4Amm2i6vnHZs1B4+FAqkNwkFkpaypzkIIb+kLfdCC
         Tjog==
X-Gm-Message-State: AAQBX9c4pVbCsCIg38GTNtFC6VWKPT1jcbnRk6bh+BBNLpEqzaFdYK4d
        Obb3rpq6oM6SkiriZiI7CeQ=
X-Google-Smtp-Source: AKy350aFskbcbVgZaZwfO5+L0jV59e8gkwxh0f0AgIBWBWvx7wW8enD333qEKribzSXVRloIfcBr1w==
X-Received: by 2002:a17:906:4e0e:b0:922:78e2:7680 with SMTP id z14-20020a1709064e0e00b0092278e27680mr2739933eju.52.1680882694502;
        Fri, 07 Apr 2023 08:51:34 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090680cc00b00922a79e79c2sm2164230ejx.217.2023.04.07.08.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:51:33 -0700 (PDT)
Date:   Fri, 7 Apr 2023 17:51:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v8 9/9] for-each-repo: with bad config, don't conflate
 <path> and <cmd>
Message-ID: <20230407155132.GA3117@szeder.dev>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
 <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
 <patch-v8-9.9-6fce633493b-20230328T140127Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v8-9.9-6fce633493b-20230328T140127Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 04:04:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a logic error in 4950b2a2b5c (for-each-repo: run subcommands on
> configured repos, 2020-09-11). Due to assuming that elements returned
> from the repo_config_get_value_multi() call wouldn't be "NULL" we'd
> conflate the <path> and <command> part of the argument list when
> running commands.
> 
> As noted in the preceding commit the fix is to move to a safer
> "*_string_multi()" version of the *_multi() API. This change is
> separated from the rest because those all segfaulted. In this change
> we ended up with different behavior.
> 
> When using the "--config=<config>" form we take each element of the
> list as a path to a repository. E.g. with a configuration like:
> 
> 	[repo] list = /some/repo
> 
> We would, with this command:
> 
> 	git for-each-repo --config=repo.list status builtin
> 
> Run a "git status" in /some/repo, as:
> 
> 	git -C /some/repo status builtin
> 
> I.e. ask "status" to report on the "builtin" directory. But since a
> configuration such as this would result in a "struct string_list *"
> with one element, whose "string" member is "NULL":
> 
> 	[repo] list
> 
> We would, when constructing our command-line in
> "builtin/for-each-repo.c"...
> 
> 	strvec_pushl(&child.args, "-C", path, NULL);
> 	for (i = 0; i < argc; i++)
> 		strvec_push(&child.args, argv[i]);
> 
> ...have that "path" be "NULL", and as strvec_pushl() stops when it
> sees NULL we'd end with the first "argv" element as the argument to
> the "-C" option, e.g.:
> 
> 	git -C status builtin
> 
> I.e. we'd run the command "builtin" in the "status" directory.
> 
> In another context this might be an interesting security
> vulnerability, but I think that this amounts to a nothingburger on
> that front.
> 
> A hypothetical attacker would need to be able to write config for the
> victim to run, if they're able to do that there's more interesting
> attack vectors. See the "safe.directory" facility added in
> 8d1a7448206 (setup.c: create `safe.bareRepository`, 2022-07-14).
> 
> An even more unlikely possibility would be an attacker able to
> generate the config used for "for-each-repo --config=<key>", but
> nothing else (e.g. an automated system producing that list).
> 
> Even in that case the attack vector is limited to the user running
> commands whose name matches a directory that's interesting to the
> attacker (e.g. a "log" directory in a repository). The second
> argument (if any) of the command is likely to make git die without
> doing anything interesting (e.g. "-p" to "log", there being no "-p"
> built-in command to run).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/for-each-repo.c  |  2 +-
>  t/t0068-for-each-repo.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> index 224164addb3..ce8f7a99086 100644
> --- a/builtin/for-each-repo.c
> +++ b/builtin/for-each-repo.c
> @@ -46,7 +46,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  	if (!config_key)
>  		die(_("missing --config=<config>"));
>  
> -	err = repo_config_get_value_multi(the_repository, config_key, &values);
> +	err = repo_config_get_string_multi(the_repository, config_key, &values);
>  	if (err < 0)
>  		usage_msg_optf(_("got bad config --config=%s"),
>  			       for_each_repo_usage, options, config_key);
> diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
> index 6b51e00da0e..4b90b74d5d5 100755
> --- a/t/t0068-for-each-repo.sh
> +++ b/t/t0068-for-each-repo.sh
> @@ -46,4 +46,17 @@ test_expect_success 'error on bad config keys' '
>  	test_expect_code 129 git for-each-repo --config="'\''.b"
>  '
>  
> +test_expect_success 'error on NULL value for config keys' '
> +	cat >>.git/config <<-\EOF &&
> +	[empty]
> +		key
> +	EOF
> +	cat >expect <<-\EOF &&
> +	error: missing value for '\''empty.key'\''
> +	EOF
> +	test_expect_code 129 git for-each-repo --config=empty.key 2>actual.raw &&
> +	grep ^error actual.raw >actual &&
> +	test_cmp expect actual
> +'

In this case the full error message looks like this:

  $ ./git -c empty.key for-each-repo --config=empty.key
  error: missing value for 'empty.key'
  fatal: got bad config --config=empty.key

  usage: git for-each-repo --config=<config> [--] <arguments>

      --config <config>     config key storing a list of repository paths

Having both an "error:" and a "fatal:" message seems redundant.


On a related note, according to the usage shown above (and the
synopsis in the man page), 'git for-each-repo' expects mandatory
<arguments>, but this doesn't seem to be enforced, and invoking it
without any arguments results in the usage of the main git command:

  $ ./git -c empty.key=. for-each-repo --config=empty.key
  usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
             [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
             [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
             [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
             [--config-env=<name>=<envvar>] <command> [<args>]
  
  These are common Git commands used in various situations:
  
  start a working area (see also: git help tutorial)
  [...]

This is misleading, because without any hints as to what was wrong I
thought that the problem is with the options of the main git command,
not with the (lack of) arguments of the 'for-each-repo' command.


