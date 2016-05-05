From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Thu, 05 May 2016 09:59:15 -0700
Message-ID: <xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
	<CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
	<20160505012219.GA15090@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 18:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayMcd-0007BL-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 18:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757727AbcEEQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 12:59:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757425AbcEEQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 12:59:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AC2E18DB8;
	Thu,  5 May 2016 12:59:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4/z1yAKs70XIZBD/1QDLdjflzhY=; b=GNOH90
	a4c4DvbRDmFwYVdx9qrzMsdbr2+tLjoCwxn0Y5t8GTEt5K6asgfF5TlVKyl3jFHw
	1ZK9Ehxjm9pOFPGfjlymRwcpOLdTiWW5PF1NGD2HikfI27BNOguYMlHshtTczMRv
	mXSIWFvOVJ5g4zlSBoJt/ySm5vzWIyQ7p+5WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=suwDMU5AZR62kXQsinRw9mBWwe1YG9Vo
	yIvaKFvXWBR/g0XV/QZ9jb+RbINj4c1OEGiEAnt8M3CJAAj6ZbotvwDQP1D7f/eZ
	XkDM83MvVF7Am8C85zqJ5z1pGNB/J7Q0JpZd1YjlqPfkFtx9lEEArMKP5bVbZq+f
	cqsEHjfgDfA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 022C218DB6;
	Thu,  5 May 2016 12:59:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70E0218DB5;
	Thu,  5 May 2016 12:59:17 -0400 (EDT)
In-Reply-To: <20160505012219.GA15090@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 21:22:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B417D004-12E2-11E6-AC68-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293652>

Jeff King <peff@peff.net> writes:

> Here's a version of my patch that should apply for you (no
> semantic changes, just differences in the surrounding context):

Sorry for the trouble.

I queued jk/submodule-c-credential to be mergeable to 'maint', as it
could be argued two ways.  We can say that not propagating -c down
is a bug and the series is a bugfix.  Or it is merely a known
limitation and the series is a new feature.  I was leaning towards
the former, but I was also willing to declare that is a known bug
that will left unfixed in the maintenance track.

If I knew the 5 patches on jk/submodule-config-sanitize-fix was what
we would eventually agree to be the right change, I would have
applied them directly on top of jk/submodule-c-credential instead of
forking a separate branch for them.  That way, either the "bugfix"
would all go to 'maint', or the "feature" wouldn't, and we do not
have to worry about making a mistake to merge only half-done state
(i.e. jk/submodule-c-credential that passes only the credential.*
configuration) that nobody would want to 'maint'.

But when I picked up jk/submodule-config-sanitize-fix, I didn't have
enough time to think things through or carefully read the discussion
to convince myself that we already had a list concensus, so I queued
it separately only to make sure I won't lose track of it--I can come
back to it later that way.

It probably is a good time to merge jk/submodule-config-sanitize-fix
into jk/submodule-c-credential (i.e. a mere fast-forward), remove
that "-fix" branch, and apply this patch directly on top of the
resulting jk/submodule-c-credential.  That will make the whole thing
a 13-patch series, consisting of:

 7 patches up to the current jk/submodule-c-credential
  d1f8849 git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
  14111fc git: submodule honor -c credential.* from command line
  e70986d quote: implement sq_quotef()
  7dad263 submodule: fix segmentation fault in submodule--helper clone
  717416c submodule: fix submodule--helper clone usage
  08e0970 submodule: check argc count for git submodule--helper clone
  d10e3b4 submodule: don't pass empty string arguments to submodule--helper clone
 
 5 patches up to the current jk/submodule-config-sanitize-fix
  c12e865 submodule: use prepare_submodule_repo_env consistently
  4638728 submodule--helper: move config-sanitizing to submodule.c
  860cba6 submodule: export sanitized GIT_CONFIG_PARAMETERS
  455d22c t5550: break submodule config test into multiple sub-tests
  1149ee2 t5550: fix typo in $HTTPD_URL

 1 patch (this one)
  4e6706a submodule: stop sanitizing config options

whose early 7 patches have already been merged to 'master' (and none
has been merged to 'maint').

> -- >8 --
> Subject: [PATCH] submodule: stop sanitizing config options
>
> The point of having a whitelist of command-line config
> options to pass to submodules was two-fold:
>
>   1. It prevented obvious nonsense like using core.worktree
>      for multiple repos.
>
>   2. It could prevent surprise when the user did not mean
>      for the options to leak to the submodules (e.g.,
>      http.sslverify=false).
>
> For case 1, the answer is mostly "if it hurts, don't do
> that". For case 2, we can note that any such example has a
> matching inverted surprise (e.g., a user who meant
> http.sslverify=true to apply everywhere, but it didn't).
>
> So this whitelist is probably not giving us any benefit, and
> is already creating a hassle as people propose things to put
> on it. Let's just drop it entirely.
>
> Note that we still need to keep a special code path for
> "prepare the submodule environment", because we still have
> to take care to pass through $GIT_CONFIG_PARAMETERS (and
> block the rest of the repo-specific environment variables).
>
> We can do this easily from within the submodule shell
> script, which lets us drop the submodule--helper option
> entirely (and it's OK to do so because as a "--" program, it
> is entirely a private implementation detail).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/submodule--helper.c  | 17 -----------------
>  git-submodule.sh             |  4 ++--
>  submodule.c                  | 39 +--------------------------------------
>  t/t7412-submodule--helper.sh | 26 --------------------------
>  4 files changed, 3 insertions(+), 83 deletions(-)
>  delete mode 100755 t/t7412-submodule--helper.sh
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 16d6432..89250f0 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -260,22 +260,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static int module_sanitize_config(int argc, const char **argv, const char *prefix)
> -{
> -	struct strbuf sanitized_config = STRBUF_INIT;
> -
> -	if (argc > 1)
> -		usage(_("git submodule--helper sanitize-config"));
> -
> -	git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
> -	if (sanitized_config.len)
> -		printf("%s\n", sanitized_config.buf);
> -
> -	strbuf_release(&sanitized_config);
> -
> -	return 0;
> -}
> -
>  struct cmd_struct {
>  	const char *cmd;
>  	int (*fn)(int, const char **, const char *);
> @@ -285,7 +269,6 @@ static struct cmd_struct commands[] = {
>  	{"list", module_list},
>  	{"name", module_name},
>  	{"clone", module_clone},
> -	{"sanitize-config", module_sanitize_config},
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 91f5856..b1c056c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -197,9 +197,9 @@ isnumber()
>  # of the settings from GIT_CONFIG_PARAMETERS.
>  sanitize_submodule_env()
>  {
> -	sanitized_config=$(git submodule--helper sanitize-config)
> +	save_config=$GIT_CONFIG_PARAMETERS
>  	clear_local_git_env
> -	GIT_CONFIG_PARAMETERS=$sanitized_config
> +	GIT_CONFIG_PARAMETERS=$save_config
>  	export GIT_CONFIG_PARAMETERS
>  }
>  
> diff --git a/submodule.c b/submodule.c
> index c18ab9b..d598881 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1098,50 +1098,13 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>  	strbuf_release(&rel_path);
>  	free((void *)real_work_tree);
>  }
> -/*
> - * Rules to sanitize configuration variables that are Ok to be passed into
> - * submodule operations from the parent project using "-c". Should only
> - * include keys which are both (a) safe and (b) necessary for proper
> - * operation.
> - */
> -static int submodule_config_ok(const char *var)
> -{
> -	if (starts_with(var, "credential."))
> -		return 1;
> -	return 0;
> -}
> -
> -int sanitize_submodule_config(const char *var, const char *value, void *data)
> -{
> -	struct strbuf *out = data;
> -
> -	if (submodule_config_ok(var)) {
> -		if (out->len)
> -			strbuf_addch(out, ' ');
> -
> -		if (value)
> -			sq_quotef(out, "%s=%s", var, value);
> -		else
> -			sq_quote_buf(out, var);
> -	}
> -
> -	return 0;
> -}
>  
>  void prepare_submodule_repo_env(struct argv_array *out)
>  {
>  	const char * const *var;
>  
>  	for (var = local_repo_env; *var; var++) {
> -		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> -			struct strbuf sanitized_config = STRBUF_INIT;
> -			git_config_from_parameters(sanitize_submodule_config,
> -						   &sanitized_config);
> -			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> -			strbuf_release(&sanitized_config);
> -		} else {
> +		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>  			argv_array_push(out, *var);
> -		}
>  	}
> -
>  }
> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> deleted file mode 100755
> index 149d428..0000000
> --- a/t/t7412-submodule--helper.sh
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) 2016 Jacob Keller
> -#
> -
> -test_description='Basic plumbing support of submodule--helper
> -
> -This test verifies the submodule--helper plumbing command used to implement
> -git-submodule.
> -'
> -
> -. ./test-lib.sh
> -
> -test_expect_success 'sanitize-config clears configuration' '
> -	git -c user.name="Some User" submodule--helper sanitize-config >actual &&
> -	test_must_be_empty actual
> -'
> -
> -sq="'"
> -test_expect_success 'sanitize-config keeps credential.helper' '
> -	git -c credential.helper=helper submodule--helper sanitize-config >actual &&
> -	echo "${sq}credential.helper=helper${sq}" >expect &&
> -	test_cmp expect actual
> -'
> -
> -test_done
