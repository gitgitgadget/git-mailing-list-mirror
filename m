Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1071F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeJXLdP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:33:15 -0400
Received: from avasout03.plus.net ([84.93.230.244]:60044 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:33:15 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id F7CwgClcdO2g2F7CxgfDNU; Wed, 24 Oct 2018 01:39:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=NAlvWSa_ue1A2K8AzHQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 2/3] reset: add new reset.quiet config setting
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peff@peff.net,
        sunshine@sunshineco.com
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181023190423.5772-1-peartben@gmail.com>
 <20181023190423.5772-3-peartben@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
Date:   Wed, 24 Oct 2018 01:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023190423.5772-3-peartben@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBxJhqUYEl8rKuNjkcfvfMP6p8onU8m4q0B/DgPtLOUw2gx8+8x3PdyJFQ0XARMq6fCu/vIpDc9wzkHxQbsrgwgMXYVUv2qZ4TWjVcYOTHytrPluW/cT
 bwYcjMuRfp0c8ti/w0u5Fd0lm2yfrWp0aKw+VwxlD5Ii0DRnbdObj5E35jd9zkQOe8b7MN+q+V9Owg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/10/2018 20:04, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>

Sorry for the late reply, ... I've been away from email - I am
still trying to catch up.

> 
> Add a reset.quiet config setting that sets the default value of the --quiet
> flag when running the reset command.  This enables users to change the
> default behavior to take advantage of the performance advantages of
> avoiding the scan for unstaged changes after reset.  Defaults to false.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Documentation/config.txt    | 3 +++
>  Documentation/git-reset.txt | 5 ++++-
>  builtin/reset.c             | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f6f4c21a54..a2d1b8b116 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2728,6 +2728,9 @@ rerere.enabled::
>  	`$GIT_DIR`, e.g. if "rerere" was previously used in the
>  	repository.
>  
> +reset.quiet::
> +	When set to true, 'git reset' will default to the '--quiet' option.

Mention that this 'Defaults to false'?

> +
>  include::sendemail-config.txt[]
>  
>  sequence.editor::
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 1d697d9962..2dac95c71a 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -95,7 +95,10 @@ OPTIONS
>  
>  -q::
>  --quiet::
> -	Be quiet, only report errors.
> +--no-quiet::
> +	Be quiet, only report errors. The default behavior is set by the
> +	`reset.quiet` config option. `--quiet` and `--no-quiet` will
> +	override the default behavior.

Better than last time, but how about something like:

 -q::
 --quiet::
 --no-quiet::
      Be quiet, only report errors. The default behaviour of the
      command, which is to not be quiet, can be specified by the
      `reset.quiet` configuration variable. The `--quiet` and
      `--no-quiet` options can be used to override any configured
      default.

Hmm, I am not sure that is any better! :-D

Also, note that the --no-option is often described separately to
the --option (in a separate paragraph). I don't know if that would
help here.

[The default behaviour is _not_ set by the configuration, if no
configuration is specified. :-P ]

Not sure if that helps!

ATB,
Ramsay Jones

>  
>  
>  EXAMPLES
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 04f0d9b4f5..3b43aee544 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -306,6 +306,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	git_config(git_reset_config, NULL);
> +	git_config_get_bool("reset.quiet", &quiet);
>  
>  	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
>  						PARSE_OPT_KEEP_DASHDASH);
> 
