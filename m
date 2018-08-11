Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521871F404
	for <e@80x24.org>; Sat, 11 Aug 2018 21:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeHLAHu (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 20:07:50 -0400
Received: from avasout06.plus.net ([212.159.14.18]:42000 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeHLAHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 20:07:50 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id obUffyAGMWLW2obUgfN3yQ; Sat, 11 Aug 2018 22:32:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=6BI5EkrGOznw42jKiScA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCHv2 3/6] Move definition of enum branch_track from cache.h
 to branch.h
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net
References: <20180811043218.31456-1-newren@gmail.com>
 <20180811205024.11291-1-newren@gmail.com>
 <20180811205024.11291-4-newren@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4e582f99-dc0b-bd02-bc1f-d5bc84ab98d3@ramsayjones.plus.com>
Date:   Sat, 11 Aug 2018 22:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180811205024.11291-4-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIaFJL/i7r7v5IGW4FFjSArFN610TIA1VB22WjcUEPxuHIOgxquu0LwCr/dMCn5R4lxPY+9zcf7G0HAAfRGRxLh2A+F3NTRfIaZ9lgctlM6VtN1b+EoL
 2FNKs0NrxH5FV2FKl/iJ9E/xACASt7+bbj+NnG2lYtMw+rURKQdYoFub2rOg3H/KJVRiGZbrlkGxoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/08/18 21:50, Elijah Newren wrote:
> 'branch_track' feels more closely related to branching, and it is
> needed later in branch.h; rather than #include'ing cache.h in branch.h
> for this small enum, just move the enum and the external declaration
> for git_branch_track to branch.h.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  branch.h      | 11 +++++++++++
>  cache.h       | 10 ----------
>  config.c      |  1 +
>  environment.c |  1 +
>  4 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/branch.h b/branch.h
> index 7d9b330eba..5cace4581f 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -3,6 +3,17 @@
>  
>  struct strbuf;
>  
> +enum branch_track {
> +	BRANCH_TRACK_UNSPECIFIED = -1,
> +	BRANCH_TRACK_NEVER = 0,
> +	BRANCH_TRACK_REMOTE,
> +	BRANCH_TRACK_ALWAYS,
> +	BRANCH_TRACK_EXPLICIT,
> +	BRANCH_TRACK_OVERRIDE
> +};
> +
> +extern enum branch_track git_branch_track;
> +
>  /* Functions for acting on the information about branches. */
>  
>  /*
> diff --git a/cache.h b/cache.h
> index 8dc7134f00..a1c0c594fb 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -919,15 +919,6 @@ enum log_refs_config {
>  };
>  extern enum log_refs_config log_all_ref_updates;
>  
> -enum branch_track {
> -	BRANCH_TRACK_UNSPECIFIED = -1,
> -	BRANCH_TRACK_NEVER = 0,
> -	BRANCH_TRACK_REMOTE,
> -	BRANCH_TRACK_ALWAYS,
> -	BRANCH_TRACK_EXPLICIT,
> -	BRANCH_TRACK_OVERRIDE
> -};
> -
>  enum rebase_setup_type {
>  	AUTOREBASE_NEVER = 0,
>  	AUTOREBASE_LOCAL,
> @@ -944,7 +935,6 @@ enum push_default_type {
>  	PUSH_DEFAULT_UNSPECIFIED
>  };
>  
> -extern enum branch_track git_branch_track;
>  extern enum rebase_setup_type autorebase;
>  extern enum push_default_type push_default;
>  
> diff --git a/config.c b/config.c
> index 66645047eb..b60d7c0308 100644
> --- a/config.c
> +++ b/config.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) Johannes Schindelin, 2005
>   *
>   */
> +#include "branch.h"

git-compat-util.h, cache.h or builtin.h _must_ be the first
header file #included in a C file, so this new #include of
the "branch.h" header should be moved ...

>  #include "cache.h"

... after here.

>  #include "config.h"
>  #include "repository.h"
> diff --git a/environment.c b/environment.c
> index 6cf0079389..920362900c 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -7,6 +7,7 @@
>   * even if you might want to know where the git directory etc
>   * are.
>   */
> +#include "branch.h"

ditto

>  #include "cache.h"
>  #include "repository.h"
>  #include "config.h"
> 

ATB,
Ramsay Jones
