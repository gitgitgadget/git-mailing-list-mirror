Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D03C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6650823EAF
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391993AbgLKCko (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391267AbgLKCkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 21:40:25 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD5C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:39:45 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id a109so6983821otc.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4NMIp7wwmkiUDsokQ04TTy3005pwA9dYGT2M+gBdypA=;
        b=U0OMXmKseytjpB9hkPwybryyO0CVvCdaLrVyJQV3Zg04p37DmhD/EWmC08YveXccJw
         VVla/ORcnU1LDE/47lM8mB5qLzQ2lAYp0ZTWLpTnf8XC4p+aQZG+MbUdeaYbSMlX23sj
         WDfwTqCS44A7gLrkYJPOn5iJYIj88zbuDIaHk8ysY3TRsQcQPAlJGoPYyaKJmiaeLkP7
         qgd6PvGXruqjnqGdHwMPvDAKDq5u/5iD6zZGtd45TYhDGuQqfHU1muL0evld0uIF6rue
         ziY/dHSoG8Sev8N4fOLXG/r/CEWjZWae45gGdcZXeueSMiECmx3abuasPdn5QmTfXpsd
         no1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NMIp7wwmkiUDsokQ04TTy3005pwA9dYGT2M+gBdypA=;
        b=AWLSSjU1S4yn73qyyngEAA4gZ2wPoY3Xdnoao4j819vOXofuk0OZ0cvb25k+XldByy
         +tHWz03dfTSylkiQoLlDrSXDsOc8Y+va4mNUGYK/H3qK1in4swAX1+wxXu0HZAjelD8v
         iPlv+3gqX+5BWS2nkolZmQcTKhdTQ0WNXuXbyu5JT3QQzW8wvaD/CWQL54wsmBLoT+Nx
         KSHIS5RSeWaVnEVDGSOMDVLe6OLRo5Iejcw5YZiEhX3VxTnzV43q8rTUrU9xOjnwiMC/
         CVaN7ol2EuYPCg2+P0eV0Mta+2Tbc771wSZCiBRwm9jkCYAyNOFs8OYyWCb5NDXzOgv2
         5zdw==
X-Gm-Message-State: AOAM531Rc5r1hiMWXO9bfIY3hTZJDkhKHgDctcSx8t0YtW+W1hZlMand
        OhM3unMVrjdnlaRpJuwgDD0=
X-Google-Smtp-Source: ABdhPJwU8jy1sfhKxDNZtLcjBx3YA9Nz4coFGppIPhPQwLrLfNMH5WWoiJuZFtB8M9ZwA264MqyRWA==
X-Received: by 2002:a9d:6188:: with SMTP id g8mr8187023otk.299.1607654384643;
        Thu, 10 Dec 2020 18:39:44 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id m81sm1474766oib.37.2020.12.10.18.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 18:39:43 -0800 (PST)
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename
 detection
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com>
Date:   Thu, 10 Dec 2020 21:39:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 90baedac407..92b765dd3f0 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -617,20 +617,72 @@ static int handle_content_merge(struct merge_options *opt,
>  
>  /*** Function Grouping: functions related to regular rename detection ***/
>  
> +static int process_renames(struct merge_options *opt,
> +			   struct diff_queue_struct *renames)
> +static int compare_pairs(const void *a_, const void *b_)
> +/* Call diffcore_rename() to compute which files have changed on given side */
> +static void detect_regular_renames(struct merge_options *opt,
> +				   struct tree *merge_base,
> +				   struct tree *side,
> +				   unsigned side_index)
> +static int collect_renames(struct merge_options *opt,
> +			   struct diff_queue_struct *result,
> +			   unsigned side_index)

standard "I promise this will follow soon!" strategy, OK.

>  static int detect_and_process_renames(struct merge_options *opt,
>  				      struct tree *merge_base,
>  				      struct tree *side1,
>  				      struct tree *side2)
>  {
> -	int clean = 1;
> +	struct diff_queue_struct combined;
> +	struct rename_info *renames = opt->priv->renames;

(Re: my concerns that we don't need 'renames' to be a pointer,
this could easily be "renames = &opt->priv.renames;")

> +	int s, clean = 1;
> +
> +	memset(&combined, 0, sizeof(combined));
> +
> +	detect_regular_renames(opt, merge_base, side1, 1);
> +	detect_regular_renames(opt, merge_base, side2, 2);

Find the renames in each side's diff.

I think the use of "1" and "2" here might be better situated
for an enum. Perhaps:

enum merge_side {
	MERGE_SIDE1 = 0,
	MERGE_SIDE2 = 1,
};

(Note, I shift these values to 0 and 1, respectively, allowing
us to truncate the pairs array to two entries while still
being mentally clear.)

> +
> +	ALLOC_GROW(combined.queue,
> +		   renames->pairs[1].nr + renames->pairs[2].nr,
> +		   combined.alloc);
> +	clean &= collect_renames(opt, &combined, 1);
> +	clean &= collect_renames(opt, &combined, 2);

Magic numbers again.

> +	QSORT(combined.queue, combined.nr, compare_pairs);
> +
> +	clean &= process_renames(opt, &combined);

I need to mentally remember that "clean" is a return state,
but _not_ a fail/success result. Even though we are using
"&=" here, it shouldn't be "&&=" or even "if (method()) return 1;"

Looking at how "clean" is used in struct merge_result, I
wonder if there is a reason to use an "int" over a simple
"unsigned" or even "unsigned clean:1;" You use -1 in places
as well as a case of "mi->clean = !!resolved;"

If there is more meaning to values other than "clean" or
"!clean", then an enum might be valuable.

> +	/* Free memory for renames->pairs[] and combined */
> +	for (s = 1; s <= 2; s++) {
> +		free(renames->pairs[s].queue);
> +		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
> +	}

This loop is particularly unusual. Perhaps it would be
better to do this instead:

	free(renames->pairs[MERGE_SIDE1].queue);
	free(renames->pairs[MERGE_SIDE2].queue);
	DIFF_QUEUE_CLEAR(&renames->pairs[MERGE_SIDE1]);
	DIFF_QUEUE_CLEAR(&renames->pairs[MERGE_SIDE2]);

> +	if (combined.nr) {
> +		int i;
> +		for (i = 0; i < combined.nr; i++)
> +			diff_free_filepair(combined.queue[i]);
> +		free(combined.queue);
> +	}
>  
> -	/*
> -	 * Rename detection works by detecting file similarity.  Here we use
> -	 * a really easy-to-implement scheme: files are similar IFF they have
> -	 * the same filename.  Therefore, by this scheme, there are no renames.
> -	 *
> -	 * TODO: Actually implement a real rename detection scheme.
> -	 */
>  	return clean;

I notice that this change causes detect_and_process_renames() to
change from an "unhelpful result, but success" to "die() always".

I wonder if there is value in swapping the order of the patches
to implement the static methods first. Of course, you hit the
"unreferenced static method" problem, so maybe your strategy is
better after all.

Thanks,
-Stolee
