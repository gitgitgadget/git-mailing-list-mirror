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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDCC1B0E3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15DAC23ECF
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395054AbgLKDZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395047AbgLKDZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 22:25:06 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBBCC0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:24:26 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id o11so7057575ote.4
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O87wd2QX08iwAWe1lzTIed95TTsjTKyG2gBWchcIMqA=;
        b=MSyfGcvHqE1ccHWkLPJC+Km5Xrfdo1GAMji4RcPF84V9mBjrEgx1mShyTMoGcT6bza
         fBLJlGiJzVfC42FX+LRTN4tDKpD3GyvfFhN7HCu5dXN0IWCu8OY6a+L/Dtm6nUUL1ocl
         EcGeqkawsCjXFGsd7maqczQ/0o9K7+8HJbnoGb0+5Y+6B5304eZfNWVp1aLdG7HUE+ky
         ohQAsVSBwRwS7Sh4cELYzl0434o7WeMstVqmpmL2dGJ7eGa2TBqaHpTak0q+zt0iTPj8
         m1Bz4vy09iS9qVTo/ZcYsCsnrodkpXXGgciGK+yHFSfxerGOBhf23Wrdsz7FWWsBreF+
         tQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O87wd2QX08iwAWe1lzTIed95TTsjTKyG2gBWchcIMqA=;
        b=Ctd9HaucmLjajUw0W/9JBpWbYveXw6wYly72HeQYziB9iQ18l4d/L8rd1qTH3xZSLi
         fm8BD7cw5zj1DsVtgGyrrHLzLO1VR+av34OPOhVKsOxD1skvMltb3PJCZvGR+f021XSC
         gu7nq90TseXqNZU8+xMxgzNTXby4ozvYai+Fdp8aCLzfo6H8aaBxp/6ZvkP33eNejEbZ
         HGN/RHkjS+RxkaN65BGSzqk/HOmOOE3pFAfvbL4sjwQx14XOUlazlBVDyMuOwOUjKTdw
         oymk7xltydJ5gUF4tgv5NuGD7crdT/1ChJPmQGV3W/63hSiLeeeMeracefayqN5F9eRS
         tV5g==
X-Gm-Message-State: AOAM533Sce5FgrTCER6Xr5Cn3/vglQv3xeIsYuJbsQvKIjqmg+jze61g
        u7e5NOT8hGkuuXzTxJXkkHY=
X-Google-Smtp-Source: ABdhPJztL2NKu9l8isH07GLiS0kqWJBjGK0LP9JnF7qJJSErxBTwTbtFksZKFQMQQvIdMD4eH8eNGQ==
X-Received: by 2002:a05:6830:1493:: with SMTP id s19mr8413495otq.175.1607657065277;
        Thu, 10 Dec 2020 19:24:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id k3sm1258832oof.31.2020.12.10.19.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 19:24:24 -0800 (PST)
Subject: Re: [PATCH 05/11] merge-ort: add basic outline for process_renames()
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <35b070b9b7c495caed758362dcdaa61b724c1644.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3691e3f1-8840-9b19-5fff-02fcb846de70@gmail.com>
Date:   Thu, 10 Dec 2020 22:24:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <35b070b9b7c495caed758362dcdaa61b724c1644.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Add code which determines which kind of special rename case each rename
> corresponds to, but leave the handling of each type unimplemented for
> now.  Future commits will implement each one.
> 
> There is some tenuous resemblance to merge-recursive's
> process_renames(), but comparing the two is very unlikely to yield any
> insights.  merge-ort's process_renames() is a bit complex and I would
> prefer if I could simplify it more, but it is far easier to grok than
> merge-recursive's function of the same name in my opinion.  Plus,
> merge-ort handles more rename conflict types than merge-recursive does.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 3cdf8124b85..faec29db955 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -620,7 +620,103 @@ static int handle_content_merge(struct merge_options *opt,
>  static int process_renames(struct merge_options *opt,
>  			   struct diff_queue_struct *renames)
>  {
> -	die("Not yet implemented.");
> +	int clean_merge = 1, i;
> +
> +	for (i = 0; i < renames->nr; ++i) {
> +		const char *oldpath = NULL, *newpath;

This "= NULL" is not necessary, since you initialize it to
old_ent->key unconditionally.

> +		struct diff_filepair *pair = renames->queue[i];
> +		struct conflict_info *oldinfo = NULL, *newinfo = NULL;

These, too.

> +		struct strmap_entry *old_ent, *new_ent;
> +		unsigned int old_sidemask;
> +		int target_index, other_source_index;
> +		int source_deleted, collision, type_changed;
> +
> +		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
> +		oldpath = old_ent->key;
> +		oldinfo = old_ent->value;
> +
> +		new_ent = strmap_get_entry(&opt->priv->paths, pair->two->path);
> +		newpath = new_ent->key;
> +		newinfo = new_ent->value;

This is moving data around. I wonder if there is any possibility that
old_ent or new_ent could be NULL here, and we should check for that?
(The "any possibility" is probably "is there a chance of a bug in the
earlier logic that didn't cause a failure yet, but would cause a SEGFAULT
here?".)

> +		/*
> +		 * diff_filepairs have copies of pathnames, thus we have to
> +		 * use standard 'strcmp()' (negated) instead of '=='.
> +		 */
> +		if (i+1 < renames->nr &&

nit: I tend to prefer "i + 1".

> +		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
> +			/* Handle rename/rename(1to2) or rename/rename(1to1) */
> +			const char *pathnames[3];
> +
> +			pathnames[0] = oldpath;
> +			pathnames[1] = newpath;
> +			pathnames[2] = renames->queue[i+1]->two->path;
> +
> +			if (!strcmp(pathnames[1], pathnames[2])) {
> +				/* Both sides renamed the same way. */
> +				die("Not yet implemented");
> +
> +				/* We handled both renames, i.e. i+1 handled */
> +				i++;
> +				/* Move to next rename */
> +				continue;
> +			}
> +
> +			/* This is a rename/rename(1to2) */
> +			die("Not yet implemented");

Interesting that you chose to do some internal logic to split this
case, but have both die(). Perhaps that is wise, but also this could
have been a die() at the start, along with the pathnames[] initialization
in a later patch that implements the 1to1 case (leaving the 1to2 case
to die()).

> +			i++; /* We handled both renames, i.e. i+1 handled */
> +			continue;
> +		}
> +
> +		VERIFY_CI(oldinfo);
> +		VERIFY_CI(newinfo);
> +		target_index = pair->score; /* from append_rename_pairs() */

Hm. I don't see append_rename_pairs() anywhere else in the codebase.
Do you mean record_rename_pair()? But in that case, I don't understand
the following assertion:

> +		assert(target_index == 1 || target_index == 2)> +		other_source_index = 3-target_index;

nit: "3 - target_index"

> +		old_sidemask = (1 << other_source_index); /* 2 or 4 */
> +		source_deleted = (oldinfo->filemask == 1);

This oldinfo->filemask check made me go to the declaration to find

	/*
	 * For filemask and dirmask, see tree-walk.h's struct traverse_info,
	 * particularly the documentation above the "fn" member.  Note that
	 * filemask = mask & ~dirmask from that documentation.
	 */
	unsigned filemask:3;
	unsigned dirmask:3;

Perhaps I've missed my window to complain about this comment pointing to
a comment in another struct definition instead of something like:

	/*
	 * The ith bit corresponds to whether the ith entry is a file
	 * (filemask) or a directory (dirmask). Thus, filemask & dirmask
	 * is always zero and filemask | dirmask == 7 always.
	 */

And of course, looking at this struct provides the justification for
using "1" and "2" for the "sides" and wasting the 0th value, because
it is consistent with the three entries here, using 0 as the base.

Thus, the comment about not using the 0 position could use a reference
to these triples. I still think that using an enum would help here.

Coming back to the line in question, "filemask == 1" _does_ mean that
the file exists only in the base. Deleted indeed.

> +		collision = ((newinfo->filemask & old_sidemask) != 0);
> +		type_changed = !source_deleted &&
> +			(S_ISREG(oldinfo->stages[other_source_index].mode) !=
> +			 S_ISREG(newinfo->stages[target_index].mode));
> +		if (type_changed && collision) {
> +			/* special handling so later blocks can handle this */
> +			die("Not yet implemented");
> +		}
> +
> +		assert(source_deleted || oldinfo->filemask & old_sidemask);
> +
> +		/* Need to check for special types of rename conflicts... */
> +		if (collision && !source_deleted) {
> +			/* collision: rename/add or rename/rename(2to1) */
> +			die("Not yet implemented");
> +		} else if (collision && source_deleted) {
> +			/* rename/add/delete or rename/rename(2to1)/delete */

How did we get to three actions here? I'll probably learn when
it is implemented.

> +			die("Not yet implemented");
> +		} else {
> +			/* a few different cases... */
> +			if (type_changed) {
> +				/* rename vs. typechange */
> +				die("Not yet implemented");
> +			} else if (source_deleted) {
> +				/* rename/delete */
> +				die("Not yet implemented");
> +			} else {
> +				/* normal rename */
> +				die("Not yet implemented");
> +			}
> +		}
> +
> +		if (!type_changed) {
> +			/* Mark the original as resolved by removal */
> +			oldinfo->merged.is_null = 1;
> +			oldinfo->merged.clean = 1;
> +		}
> +
> +	}
> +
> +	return clean_merge;

I'm glad you separated out this case organization from the implementations.
It's still a big dense, so I'll probably need to revisit as I see you fill
in the rest.

Thanks,
-Stolee
