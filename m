Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BA81FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 15:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbcJWPKm (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 11:10:42 -0400
Received: from avasout02.plus.net ([212.159.14.17]:60058 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbcJWPKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 11:10:41 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id z3Ae1t0030zhorE013Afe3; Sun, 23 Oct 2016 16:10:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=un5jjljYE1GsNFCYyasA:9 a=QEXdDO2ut3YA:10
 a=nJcEw6yWrPvoIXZ49MH8:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 28/36] attr: keep attr stack for each check
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-29-sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8a91d287-5413-3f8f-9d0e-edd67fb36557@ramsayjones.plus.com>
Date:   Sun, 23 Oct 2016 16:10:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161022233225.8883-29-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/10/16 00:32, Stefan Beller wrote:
> Instead of having a global attr stack, attach the stack to each check.
> This allows to use the attr in a multithreaded way.
> 
> 
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  attr.c    | 101 +++++++++++++++++++++++++++++++++++++++-----------------------
>  attr.h    |   4 ++-
>  hashmap.h |   2 ++
>  3 files changed, 69 insertions(+), 38 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 89ae155..b65437d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -372,15 +372,17 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
>   * .gitignore file and info/excludes file as a fallback.
>   */
>  
> -/* NEEDSWORK: This will become per git_attr_check */
> -static struct attr_stack {
> +struct attr_stack {
>  	struct attr_stack *prev;
>  	char *origin;
>  	size_t originlen;
>  	unsigned num_matches;
>  	unsigned alloc;
>  	struct match_attr **attrs;
> -} *attr_stack;
> +};
> +
> +struct hashmap all_attr_stacks;
> +int all_attr_stacks_init;

Mark symbols 'all_attr_stacks' and 'all_attr_stacks_init' with
the static keyword. (ie. these are file-local symbols).

ATB,
Ramsay Jones

