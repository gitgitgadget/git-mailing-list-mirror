Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C27C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FD723E54
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403933AbgLKCzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404668AbgLKCzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 21:55:17 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47666C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:54:37 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id q25so6988771otn.10
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJ417GVKvrTmfLXZGXD02k3cdU82VRXW3fofvQoP4Ss=;
        b=HUbyGssvI/NyLWFJ283A9YBEastIX4o1xZLB9CeiPe1VrUUMncs35pw+8XgyXlzxIT
         rkWMjTEO0UCSNekYFXEjhEDTfZhN/OtnpO4VBTPEDz4JCw9Cxx91H0BN9L2bIvhvpbGj
         i2Y+sSSGI3P7tWdp2r8ZmqeS0iypRl39IEhhNv+0IXlvBKnH26/jUbfe0ZxqDn4pFXqy
         YTlaEVYFX6TTJq1KfjzGhLq5xRL/9EafFEYMdIdqDp71Y0F07u5KGYA80/rmmMG+Ghqs
         wxLxoBPVaamTm/gZD4N8U6d2aCimyGxZODAOhu8u0zuZNWgKbNaK+HoAl7ayv5baX2EU
         3G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XJ417GVKvrTmfLXZGXD02k3cdU82VRXW3fofvQoP4Ss=;
        b=jNS40MAVE5j2ZcGyHxXcq6A28pvKtAwz39s5FJRZtv+2fi5HPR3UGDiF3nhwKvjjOk
         qgvxB1o2ymRJYh6ycQOX80cqpULsla7muzY7t0skFF517pgZHWpKAvwxWvjyhjlyu4C6
         niXhRzMOnp1rwDG7eqiMLVnkl5xjVAon59w9glSUZPew+dm3oxZi+qVy8l1+2mdWhq03
         zzOLUgEmfjCYXp4fCg2vq+KLSU4f8h0gQnpI3I9hiXf8dclwfEbiu+hAZGav0UDCBF8f
         A2PSu+QtsnSZx85S/tpk/QMkZGoNtwHqWezxJllu7GgAReyUMXd1V6LfU5RHaKdYmhXw
         d4CQ==
X-Gm-Message-State: AOAM530OwV3ewBZzBVnVgAZYkvbObERZyQTzuOhMJtAzrWwwHQZy9dGA
        n+CluQlGBBY03G76HPE9ZVKVvrZdY4AUQg==
X-Google-Smtp-Source: ABdhPJzlbQh2XA21KYCy5kpuWAGLG95Fqqc4FA0q108YeKc7JFe33t3tA+ySUDk8dKmpnu3S9ye4AQ==
X-Received: by 2002:a9d:7c82:: with SMTP id q2mr8158899otn.205.1607655276449;
        Thu, 10 Dec 2020 18:54:36 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id b28sm1482659oob.22.2020.12.10.18.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 18:54:35 -0800 (PST)
Subject: Re: [PATCH 03/11] merge-ort: implement detect_regular_renames()
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <ba30bc8686ef11115b369d351b4447c75a7bb9b5.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <59863009-1a11-ba74-fdd3-6271977b6ec9@gmail.com>
Date:   Thu, 10 Dec 2020 21:54:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <ba30bc8686ef11115b369d351b4447c75a7bb9b5.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Based heavily on merge-recursive's get_diffpairs() function.

(You're not kidding, and I should have looked here before making
some comments below.)

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 92b765dd3f0..1ff637e57af 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -634,7 +634,33 @@ static void detect_regular_renames(struct merge_options *opt,
>  				   struct tree *side,
>  				   unsigned side_index)
>  {
> -	die("Not yet implemented.");
> +	struct diff_options diff_opts;
> +	struct rename_info *renames = opt->priv->renames;
> +
> +	repo_diff_setup(opt->repo, &diff_opts);
> +	diff_opts.flags.recursive = 1;
> +	diff_opts.flags.rename_empty = 0;
> +	diff_opts.detect_rename = DIFF_DETECT_RENAME;
> +	diff_opts.rename_limit = opt->rename_limit;

I assume that opt->rename_limit has been initialized properly
against merge.renameLimit/diff.renameLimit in another location...

> +	if (opt->rename_limit <= 0)
> +		diff_opts.rename_limit = 1000;

(I made the following comments before thinking to look at
get_diffpairs() which behaves in an equivalent way with this
"1000" constant limit. I'm not sure if there is a reason why
this limit is different from the _other_ limits I discovered,
but it might still be good to reduce magic literal ints by
grouping this "1000" into a const or macro.)

...and this just assigns the default again. Why is this done
here instead of inside the diff machinery? Also, wouldn't a
diff.renameLimit = 0 imply no renames, not "use default"?

I notice that the docs don't make this explicit:

diff.renameLimit::
	The number of files to consider when performing the copy/rename
	detection; equivalent to the 'git diff' option `-l`. This setting
	has no effect if rename detection is turned off.

but also too_many_rename_candidates() has this strange
default check:

	/*
	 * This basically does a test for the rename matrix not
	 * growing larger than a "rename_limit" square matrix, ie:
	 *
	 *    num_create * num_src > rename_limit * rename_limit
	 */
	if (rename_limit <= 0)
		rename_limit = 32767;

this is... a much larger limit than I would think is reasonable.

Of course, diff_rename_limit_default is set to 400 inside diff.c.
Should that be extracted as a constant so we can repeat it here?

> +	diff_opts.rename_score = opt->rename_score;
> +	diff_opts.show_rename_progress = opt->show_rename_progress;
> +	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> +	diff_setup_done(&diff_opts);
> +	diff_tree_oid(&merge_base->object.oid, &side->object.oid, "",
> +		      &diff_opts);
> +	diffcore_std(&diff_opts);
> +
> +	if (diff_opts.needed_rename_limit > opt->priv->renames->needed_limit)
> +		opt->priv->renames->needed_limit = diff_opts.needed_rename_limit;
> +
> +	renames->pairs[side_index] = diff_queued_diff;
> +
> +	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> +	diff_queued_diff.nr = 0;
> +	diff_queued_diff.queue = NULL;
> +	diff_flush(&diff_opts);
>  }
>  
>  /*
> @@ -1379,6 +1405,10 @@ void merge_switch_to_result(struct merge_options *opt,
>  			printf("%s", sb->buf);
>  		}
>  		string_list_clear(&olist, 0);
> +
> +		/* Also include needed rename limit adjustment now */
> +		diff_warn_rename_limit("merge.renamelimit",
> +				       opti->renames->needed_limit, 0);

I suppose this new call is appropriate in this patch, since you assign
the value inside detect_regular_renames(), but it might be good to
describe its presence in the commit message.

Thanks,
-Stolee

