From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs`
 config option
Date: Tue, 10 Nov 2015 23:21:05 +0100
Message-ID: <56426DD1.6090904@web.de>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
 <1446597434-1740-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 23:21:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwHI5-00073Q-SI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 23:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbbKJWVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 17:21:22 -0500
Received: from mout.web.de ([212.227.17.11]:62297 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbKJWVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 17:21:20 -0500
Received: from [192.168.178.41] ([79.211.101.61]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LwYnz-1aU8iq35nb-018Lib; Tue, 10 Nov 2015 23:21:08
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1446597434-1740-9-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:/En+ExHu2RaX4AP+nFK9YqjxdBquCI8zZ6nTX4mm5/6MeKkO0pU
 BGG8iXuuWi93tODs8yatk2txxWFQsYWFpvhp6zmcM0t49CzPpsqYyQHugnG5lnDqijfx2n4
 3e4ng7S5agCBDn17V7eUAmLBgvf1qL5MEhkKxt7ORGLmA0nhyqQ0doZ8MrqIHM0EKlxk9jC
 +fYHsTirdJWynhoO4wX7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GwctspX3D4Y=:B3p/skX2KUqXGKzfSkHeJ7
 OdKuNUR1A0ebgIuPR8HSAnoRft9TZktIT8GnYT04+kV7dy2WJNB7PbPYUwErlTYYSeUfwvFnW
 K7uDD7EWgqJRFLtpG6TjHYNWNsD9FJaZ8ou7KxlCyCepcQIB0a0bYMYuG0De+XLVccq58Rc1X
 5GK+WubFc+Gedm/J4LVJ6AcyzGsI+2mpDj5w05OfQ5l7XZl6ZpEbhyX/y/NUTMY5dnM/Eu9T3
 TZogJ4HvpKZR0raDEIEhHIefKv2JXgUZixaQU9yb3LO/QwBVe3ZpH1Kd5zFHmxmQ32gECnHq8
 gHH9JIu19GzNX+S85BReNH7qyKH/wY8cFfoyMzm9y7Sz2tbrpIAtpYccDYZVvw5A4r0knD574
 /kqpkR+ZcyI6cS0FuFIh8ehtKaJ/XBiKPk4/heKOz6jqCTCtONxKaSz1o6L9QezRypDTjk01G
 wcH/NbHDl5QfIVaa840DEeSJ2YvogBply2dVe+25TQcdYxOMK2RxTg/fjxO+hyUFNhl5X1I1L
 06EnyTatOJny7oTcZhHeU8uF/gOdmRNy55PRcxGQaaxmer3rnyJ7kF4uRTJBoBLy11qlt7mk+
 xO2Puba/5+KCkTINsajRjdU5nP5DwWB74tCAzkxgAm7OCqhdmTYcNC8XWNAkbDPtDgfG6UEoa
 PpWZbusf4D+2c2Gl6dyjpqU+4ZM943fT/2Qy59sMwspToBJQdgSXHrKyhaq2WtXBnPPIT6/QP
 tOPNV0YH7W2eucEY6vimJ+XGbhpRZUOuaaUT4cD0eMZy/GyDgV7D7VPdIQqeEGmRFrUF9s42 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281136>

Am 04.11.2015 um 01:37 schrieb Stefan Beller:
> This allows to configure fetching and updating in parallel
> without having the command line option.
>
> This moved the responsibility to determine how many parallel processes
> to start from builtin/fetch to submodule.c as we need a way to communicate
> "The user did not specify the number of parallel processes in the command
> line options" in the builtin fetch. The submodule code takes care of
> the precedence (CLI > config > default)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   Documentation/config.txt    |  7 +++++++
>   builtin/fetch.c             |  2 +-
>   submodule-config.c          | 15 +++++++++++++++
>   submodule-config.h          |  2 ++
>   submodule.c                 |  5 +++++
>   t/t5526-fetch-submodules.sh | 14 ++++++++++++++
>   6 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 391a0c3..70e1b88 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2643,6 +2643,13 @@ submodule.<name>.ignore::
>   	"--ignore-submodules" option. The 'git submodule' commands are not
>   	affected by this setting.
>
> +submodule.jobs::
> +	This is used to determine how many submodules can be operated on in
> +	parallel. Specifying a positive integer allows up to that number
> +	of submodules being fetched in parallel. This is used in fetch
> +	and clone operations only. A value of 0 will give some reasonable
> +	configuration. It defaults to 1.
> +

Just curious (and sorry if this has already been discussed and I missed
it, but the volume of your output is too much for my current git time
budget ;-): While this config is for fetching only, do I recall correctly
that you have plans to do submodule work tree updates in parallel too?
If so, would it make sense to have different settings for fetching and
updating?

>   tag.sort::
>   	This variable controls the sort ordering of tags when displayed by
>   	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 9cc1c9d..60e6797 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
>   static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>   static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>   static int tags = TAGS_DEFAULT, unshallow, update_shallow;
> -static int max_children = 1;
> +static int max_children = -1;
>   static const char *depth;
>   static const char *upload_pack;
>   static struct strbuf default_rla = STRBUF_INIT;
> diff --git a/submodule-config.c b/submodule-config.c
> index 29e21b2..475551a 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -32,6 +32,7 @@ enum lookup_type {
>
>   static struct submodule_cache cache;
>   static int is_cache_init;
> +static int parallel_jobs = -1;
>
>   static int config_path_cmp(const struct submodule_entry *a,
>   			   const struct submodule_entry *b,
> @@ -239,6 +240,15 @@ static int parse_generic_submodule_config(const char *key,
>   					  const char *value,
>   					  struct parse_config_parameter *me)
>   {
> +	if (!strcmp(key, "jobs")) {
> +		parallel_jobs = strtol(value, NULL, 10);
> +		if (parallel_jobs < 0) {
> +			warning("submodule.jobs not allowed to be negative.");
> +			parallel_jobs = 1;
> +			return 1;
> +		}
> +	}
> +
>   	return 0;
>   }
>
> @@ -482,3 +492,8 @@ void submodule_free(void)
>   	cache_free(&cache);
>   	is_cache_init = 0;
>   }
> +
> +int config_parallel_submodules(void)
> +{
> +	return parallel_jobs;
> +}
> diff --git a/submodule-config.h b/submodule-config.h
> index f9e2a29..d9bbf9a 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -27,4 +27,6 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
>   		const char *path);
>   void submodule_free(void);
>
> +int config_parallel_submodules(void);
> +
>   #endif /* SUBMODULE_CONFIG_H */
> diff --git a/submodule.c b/submodule.c
> index 0257ea3..188ba02 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -752,6 +752,11 @@ int fetch_populated_submodules(const struct argv_array *options,
>   	argv_array_push(&spf.args, "--recurse-submodules-default");
>   	/* default value, "--submodule-prefix" and its value are added later */
>
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = config_parallel_submodules();
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = 1;
> +
>   	calculate_changed_submodule_paths();
>   	run_processes_parallel(max_parallel_jobs,
>   			       get_next_submodule,
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 1b4ce69..5c3579c 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -470,4 +470,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>   	test_i18ncmp expect.err actual.err
>   '
>
> +test_expect_success 'fetching submodules respects parallel settings' '
> +	git config fetch.recurseSubmodules true &&
> +	(
> +		cd downstream &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
> +		grep "7 children" trace.out &&
> +		git config submodule.jobs 8 &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch &&
> +		grep "8 children" trace.out &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
> +		grep "9 children" trace.out
> +	)
> +'
> +
>   test_done
>
