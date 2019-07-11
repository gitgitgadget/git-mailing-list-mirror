Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431B21F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfGKSYN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:24:13 -0400
Received: from mail-gateway-shared14.cyon.net ([194.126.200.67]:52322 "EHLO
        mail-gateway-shared14.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727956AbfGKSYN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 14:24:13 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared14.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1hldjk-00048j-Np
        for git@vger.kernel.org; Thu, 11 Jul 2019 20:24:10 +0200
Received: from [10.20.10.233] (port=36836 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1hldjj-0003GE-Ip; Thu, 11 Jul 2019 20:24:07 +0200
Subject: Re: [PATCH v2 2/3] log: add --no-use-mailmap option to complement
 --use-mailmap option
To:     Ariadne Conill <ariadne@dereferenced.org>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20190711172626.16480-1-ariadne@dereferenced.org>
 <20190711172626.16480-3-ariadne@dereferenced.org>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <91cdd139-1dac-e7b5-c51a-ea057c0c31ca@drbeat.li>
Date:   Thu, 11 Jul 2019 20:24:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711172626.16480-3-ariadne@dereferenced.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.07.19 19:26, Ariadne Conill wrote:
> When mailmap is enabled by default or by configuration, it may be
> useful to override the default behaviour.  Previously, it was
> possible to enable the mailmap feature when it was disabled by
> default or in the configuration, but it was not possible to disable
> the mailmap feature when it was enabled by default or by the
> configuration.
> 
> The --no-use-mailmap option equalizes this by allowing the user to
> explicitly enable or disable the mailmap feature according to their
> requirements.
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  Documentation/git-log.txt | 5 +++++
>  builtin/log.c             | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index b02e922dc3..50bc8f7da2 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -54,6 +54,11 @@ OPTIONS
>  	addresses to canonical real names and email addresses. See
>  	linkgit:git-shortlog[1].
>  
> +--no-use-mailmap::
> +	Do not use the mailmap file to map author and commiter names
> +	and email addresses to canonical real names and email addresses.
> +	See linkgit:git-shortlog[1].
> +
>  --full-diff::
>  	Without this flag, `git log -p <path>...` shows commits that
>  	touch the specified paths, and diffs about the same specified
> diff --git a/builtin/log.c b/builtin/log.c
> index 3d2ce8fa3d..a9195bcb34 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -167,6 +167,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  		OPT__QUIET(&quiet, N_("suppress diff output")),
>  		OPT_BOOL(0, "source", &source, N_("show source")),
>  		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
> +		OPT_NEGBIT(0, "no-use-mailmap", &mailmap, N_("Do not use mail map file"), 1),

This works already. OPT_BOOL automatically handles the negation. You
just have to add "[no-]" to the documentation of --use-mailmap.

>  		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
>  				N_("pattern"), N_("only decorate refs that match <pattern>")),
>  		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
> 

Cheers,
Beat
