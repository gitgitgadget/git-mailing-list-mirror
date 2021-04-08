Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B7AC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 11:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87559610CA
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 11:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhDHLsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:48:25 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30358 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhDHLsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 07:48:25 -0400
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lUT8u-0004aF-EI; Thu, 08 Apr 2021 12:48:12 +0100
Subject: Re: [PATCH 1/9] diff-merges: introduce --diff-merges=def
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210407225608.14611-2-sorganov@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <f6b25ea6-88b1-c167-7fd4-440be8782fcb@iee.email>
Date:   Thu, 8 Apr 2021 12:48:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407225608.14611-2-sorganov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 07/04/2021 23:56, Sergey Organov wrote:
> Introduce the notion of default diff format for merges, and the option
> "def" to select it. The default is "separate" and can't yet be
"def" feels a bit too short and sounds similar to "define" - why not
spell out in full?
> changed, so effectively "dev" is just a synonym for "separate" for
did you mean "def"?  i.e. s/dev/def/   (..spell out in full ;-)

--
Philip
> now.
>
> This is in preparation for introducing log.diffMerges configuration
> option that will let --diff-merges=def to be configured to any
> supported format.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index 146bb50316a6..0887a07cfc67 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -2,6 +2,8 @@
>  
>  #include "revision.h"
>  
> +typedef void (*diff_merges_setup_func_t)(struct rev_info *);
> +
>  static void suppress(struct rev_info *revs)
>  {
>  	revs->separate_merges = 0;
> @@ -19,6 +21,8 @@ static void set_separate(struct rev_info *revs)
>  	revs->separate_merges = 1;
>  }
>  
> +static diff_merges_setup_func_t set_to_default = set_separate;
> +
>  static void set_first_parent(struct rev_info *revs)
>  {
>  	set_separate(revs);
> @@ -66,6 +70,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>  		set_combined(revs);
>  	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
>  		set_dense_combined(revs);
> +	else if (!strcmp(optarg, "def"))
> +		set_to_default(revs);
>  	else
>  		die(_("unknown value for --diff-merges: %s"), optarg);
>  

