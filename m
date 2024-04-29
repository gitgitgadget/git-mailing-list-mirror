Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36671944D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714364142; cv=none; b=oxdb35NIrCKy93dmCR9HIx44AwVfXk5Y9B1U2XofRyNZ+8Z6lvmkyPPjYrHfSXg4Xr22QGzivgf9Ro5YlaK18hN81NvLxgoW1PL1bQB3qGOh0s3dk+NfKFO26J0h9K3rM1Rx6jDmT7QgkP8Qaey4uO4yKANGy4wJOTKwX9A/Qgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714364142; c=relaxed/simple;
	bh=iDD7VGHpiqJb8ilBFhEF1n+ZBZYu2NwPytFz2KMIKlM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dH5kQNafoOxn7Ex5m4GPdtGNJWAujWCalM20FEujWog8dAiLCiBcNHTkCOPo7TqYqLGS9dzepsjx158RJiRo9iO97TDY78ISwFpDadpFQnsYeaeoawlH5zUbf+YLjquF7lZOZYe7LcpMYynfaFGaSOjBSmkwWER7UG9FKi1fbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Fdlp4t4r; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Fdlp4t4r"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714364135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXex2bWPj8LvFvMUB4BFVEvOWSq73J64bLVAOJSo1XU=;
	b=Fdlp4t4rudw1lLRezfl0qBwgvSDSmFTYLTz66iwlnN8Oc9SMNBV7LyivEU7vtpKD0TobJW
	WIa9bMhGGfQhLTQFwV+SBllruy1xkqyCpmuYRtLLVOt5KGFUOzLo5Q7vOvobK+WLw/Ny5/
	2Z+Eq6YARy8vPSfFTAJoAdAYhhFayMRUmrdkxrbzPHTQnTlIrPhwhehIrKoNhsB97yZ/bc
	JJ6cs2BeGpx3imXxUZpvsXzDo7/QNt+ASesYZU5ge9KRPryMl5RxEQZ+GK40ToAwuowE/6
	h5hGOAH9D+HE8MHdOaTMI4KNAdKZJJMnzUgx45iLBa5ebgIocR+oY1a4IaH9gg==
Date: Mon, 29 Apr 2024 06:15:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <20240429010925.93205-2-james@jamesliu.io>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
Message-ID: <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello James,

Please see my comments below.

On 2024-04-29 03:09, James Liu wrote:
> Advice hints must be disabled individually by setting the relevant
> advice.* variables to false in the Git configuration. For server-side
> and scripted usages of Git where hints aren't necessary, it can be
> cumbersome to maintain configuration to ensure all advice hints are
> disabled in perpetuity. This is a particular concern in tests, where
> new or changed hints can result in failed assertions.
> 
> Add a --no-advice global option to disable all advice hints from being
> displayed. This is independent of the toggles for individual advice
> hints.
> 
> Signed-off-by: James Liu <james@jamesliu.io>
> ---
>  Documentation/git.txt |  5 ++++-
>  advice.c              |  8 +++++++-
>  environment.h         |  1 +
>  git.c                 |  6 +++++-
>  t/t0018-advice.sh     | 20 ++++++++++++++++++++
>  5 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7a1b112a3e..ef1d9dce5d 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>      [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
>      [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
> -    [--config-env=<name>=<envvar>] <command> [<args>]
> +    [--config-env=<name>=<envvar>] [--no-advice] <command> [<args>]

After having a more detailed look at the Git documentation,
I think that adding support for "--advice" at the same time
would be the right thing to do.  That option would override
all "advice.<hint>" options that may exist in the configuration
(and would override the GIT_NO_ADVICE environment variable,
if we end up supporting it), similarly to how "--paginate"
overrides all "pager.<cmd>" in the configuration, which would
be both consistent and rather useful in some situations.

>  DESCRIPTION
>  -----------
> @@ -226,6 +226,9 @@ If you just want to run git as if it was started
> in `<path>` then use
>  	linkgit:gitattributes[5]. This is equivalent to setting the
>  	`GIT_ATTR_SOURCE` environment variable.
> 
> +--no-advice::
> +	Disable all advice hints from being printed.
> +
>  GIT COMMANDS
>  ------------
> 
> diff --git a/advice.c b/advice.c
> index 75111191ad..f6282c3bde 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -2,6 +2,7 @@
>  #include "advice.h"
>  #include "config.h"
>  #include "color.h"
> +#include "environment.h"
>  #include "gettext.h"
>  #include "help.h"
>  #include "string-list.h"
> @@ -126,7 +127,12 @@ void advise(const char *advice, ...)
> 
>  int advice_enabled(enum advice_type type)
>  {
> -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
> +	int enabled;
> +
> +	if (getenv(GIT_NO_ADVICE))
> +		return 0;

Huh, I was under impression that having an environment
variable to control this behavior was frowned upon by
Junio? [1]  To me, supporting such a variable would be
a somewhat acceptable risk, [2] but of course it's the
maintainer's opinion that matters most.

[1] https://lore.kernel.org/git/xmqqfrva3k9j.fsf@gitster.g/
[2] 
https://lore.kernel.org/git/462de4ec1fb1896fa7f26b3515deca57@manjaro.org/

> +
> +	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
> 
>  	if (type == ADVICE_PUSH_UPDATE_REJECTED)
>  		return enabled &&
> diff --git a/environment.h b/environment.h
> index 05fd94d7be..30c2684269 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -56,6 +56,7 @@ const char *getenv_safe(struct strvec *argv, const
> char *name);
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> +#define GIT_NO_ADVICE "GIT_NO_ADVICE"

If we eventually end up supporting new "GIT_NO_ADVICE"
environment variable, which I actually doubt, the new
macro above should be named "GIT_NO_ADVICE_ENVIRONMENT"
instead, for consistency.

> 
>  /*
>   * Environment variable used in handshaking the wire protocol.
> diff --git a/git.c b/git.c
> index 654d615a18..ffeb832ca9 100644
> --- a/git.c
> +++ b/git.c
> @@ -38,7 +38,7 @@ const char git_usage_string[] =
>  	   "           [--exec-path[=<path>]] [--html-path] [--man-path]
> [--info-path]\n"
>  	   "           [-p | --paginate | -P | --no-pager]
> [--no-replace-objects] [--bare]\n"
>  	   "           [--git-dir=<path>] [--work-tree=<path>] 
> [--namespace=<name>]\n"
> -	   "           [--config-env=<name>=<envvar>] <command> [<args>]");
> +	   "           [--config-env=<name>=<envvar>] [--no-advice]

Obviously, additional new configuration option "--advice"
would be also added here, mutually exclusive with "--no-advice",
and into the source code below.

> <command> [<args>]");
> 
>  const char git_more_info_string[] =
>  	N_("'git help -a' and 'git help -g' list available subcommands and 
> some\n"
> @@ -337,6 +337,10 @@ static int handle_options(const char ***argv, int
> *argc, int *envchanged)
>  			setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
>  			if (envchanged)
>  				*envchanged = 1;
> +		} else if (!strcmp(cmd, "--no-advice")) {
> +			setenv(GIT_NO_ADVICE, "1", 1);
> +			if (envchanged)
> +				*envchanged = 1;
>  		} else {
>  			fprintf(stderr, _("unknown option: %s\n"), cmd);
>  			usage(git_usage_string);
> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index 0dcfb760a2..2ce2d4668a 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -29,4 +29,24 @@ test_expect_success 'advice should not be printed
> when config variable is set to
>  	test_must_be_empty actual
>  '
> 
> +test_expect_success 'advice should not be printed when --no-advice is 
> used' '
> +	cat << EOF > expect &&
> +On branch master
> +
> +No commits yet
> +
> +Untracked files:
> +	README
> +
> +nothing added to commit but untracked files present
> +EOF
> +
> +	git init advice-test &&
> +  test_when_finished "rm -fr advice-test" &&
> +  cd advice-test &&
> +  touch README &&
> +  git --no-advice status > ../actual &&
> +  test_cmp ../expect ../actual
> +'
> +
>  test_done

There should also be a new test that checks how the new
"GIT_NO_ADVICE" environment variable affects the execution,
but I doubt it will eventually be supported.

Of course, an additional test should be added to check the
mutual exclusivity between the above-proposed "--advice"
and "--no-advice" options.
