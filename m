Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F921C7EE2D
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 16:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCCQqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 11:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCCQqO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 11:46:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B031B2886E
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 08:45:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so3248906plr.9
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxHN2asDLluW+IERG3hdN0Q65DajrItslwjL6x2FYtI=;
        b=EwxEScv7/7uPjbD/G6WGq6ruQEsHnUerSpNbTXwXDUWUt8H6V9h3rN/1+qpjDO3rso
         qv6WSX1lGodX7Nz87Fkk9xl28ThCzLcdcWvnnNonmKFGHImQM6+9tTUCFrxHPqJM7zmU
         /hleAJstxt67lSJ4vgtDATuOLNbrf9IXVJEePj9cEvY+wv4GpW2Ud68r8z4A1IfxYLyq
         d94jhjXAuz/TIPLrvX4/84Mr4pz6ljxFY8mbf13FH5IjsuKbzHdEKJ6lBRTUuUWu1/bf
         YBZ52ipabEA6ujEBscyKu9vZMDEysU1EKHjfT4+aNfC2UYKMImn52SFH72myf2OF3Cpc
         7Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uxHN2asDLluW+IERG3hdN0Q65DajrItslwjL6x2FYtI=;
        b=IEYfuOZwRPjSe8NryIV8t/j886LkSkm6F3VGBL3SxLhVOgE2bVhA1pydy701fmHcGO
         pBMIry3C0RgKkVR0Sj5lPwsSug6ajbPQNmDn+PVPqEC3vxs+1M0pc5U6c+5YkeYb7LNY
         uf3xgVDgw6AUU4+K3Z+VdTa4+Pm8BUvWgmdsbR04amiAA8bBmaxcqw8zDwQEL205dk0u
         hWcagMkPIii4G5gz4qUIENAqdV6b9GwuUiBuEp2AtkC+mLPcP+7TfrOYZNN4Z+sSLuT3
         +/4AeDCU9YNOZ9tc7IsEJBCP2Ki2zh+1+rDDkoFgogc018L31g3dn3WxsvgRA20is9co
         89Mg==
X-Gm-Message-State: AO0yUKU/TfN60HLEJz+Dh8zT0JP+6dNGRq7VM3m8soNbw4WVDhe+9+sq
        mvhSKowrkbZSoyhTUKqZJKU=
X-Google-Smtp-Source: AK7set8cmpLAQ+pLO74U8fFM+yMcLNJVSUwzYi65OpYXux/aVLgV/SDzqcvB5kVE18pPWvuBSpYkUw==
X-Received: by 2002:a05:6a20:a111:b0:cc:d386:ec1a with SMTP id q17-20020a056a20a11100b000ccd386ec1amr3164410pzk.2.1677861933876;
        Fri, 03 Mar 2023 08:45:33 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q10-20020a63504a000000b004fcda0e59c3sm1745558pgl.69.2023.03.03.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:45:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
References: <20230303145311.513960-1-eantoranz@gmail.com>
Date:   Fri, 03 Mar 2023 08:45:32 -0800
In-Reply-To: <20230303145311.513960-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Fri, 3 Mar 2023 15:53:11 +0100")
Message-ID: <xmqqcz5phjgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> When rebasing merge commits and dealing with conflicts, having the
> original merge commit as a reference can help us avoid some of
> them.
>
> With this patch, we leverage the original merge commit to handle the most
> obvious case:
> - HEAD tree has to match the tree of the first parent of the original merge
>   commit.
> - MERGE_HEAD tree has to match the tree of the second parent of the original
>   merge commit.
> - At least one tree in the merge bases of HEAD/MERGE_HEAD has to match
>   a tree in the merge bases of the parent commits of the original merge
>   commit.

The first two conditions look a bit too restrictive for the purpose
of reusing previous conflict resolution, while I am not sure ...

> If all of those conditions are met, we can safely use the tree of the
> original merge commit as the resulting tree of this merge that is being
> attempted at the time.

...if the "at least one" in the last condition is a safe and
sensible loosening; if it introduces a mismerge by ignoring bases
that are different from the original, then it is a bit too bold to
declare that we can safely use the tree of the original.

What was the motivating usecase behind this new feature?  Was it
more about reusing the structural merge conflict resolution, or
about the textual merge conflict resolution?  For the latter, after
doing the usual three-way file-level merge and seeing a conflicted
textual merge, requiring the match of the blob objects for only these
conflicted paths and taking the previous merge result may give you a
safe way to raising the chance to find more reusable merges.

> +static void load_tree_oids(struct oid_array *oids, struct commit_list *bases)
> +{
> +	struct commit_list *i;
> +	for (i = bases; i; i = i->next)

Using 'i' for a pointer looks novel.  Don't.

> +static int find_oid(const struct object_id *oid,
> +		void *data)

The result of unfolding these two lines would not be overly long, I suspect?

> +{
> +	struct oid_array *other_list = (struct oid_array *) data;
> +	int pos = oid_array_lookup(other_list, oid);
> +	return pos >= 0 ? 1 : 0;

That's an unusual way to say 

	return pos >= 0;

or even

	return 0 <= oid_array_lookup(other_list, oid);

without otherwise unused variable.

> +static int run_tms_merge(struct tms_options *options)
> +{
> +	struct commit *head, *merge_head, *tip;
> +	struct commit_list *i;
> +
> +	head = lookup_commit_reference_by_name("HEAD");
> +	merge_head = lookup_commit_reference_by_name(options->merge_head);
> +	tip = lookup_commit_reference_by_name(options->tip);
> +
> +	if (!(head && merge_head && tip)) {
> +		return 2;
> +	}

Unnecessary {} around a single statement block.

> +	if (commit_list_count(tip->parents) != 2)
> +		return 2;
> +
> +	for (i = tip->parents; i; i = i->next)
> +		parse_commit(i->item);
> +	if (!oideq(get_commit_tree_oid(head),
> +		   get_commit_tree_oid(tip->parents->item)))
> +		return 2;
> +	if (!oideq(get_commit_tree_oid(merge_head),
> +		   get_commit_tree_oid(tip->parents->next->item)))
> +		return 2;
> +
> +	if (!base_match(tip, head, merge_head))
> +		return 2;
> +
> +	if (restore(tip))
> +		return 2;

I somehow thought that reverting the trashed working tree and the
index to their original state was not the responsibility for a merge
strategy but for the caller?  Shouldn't this restoration be on the
caller's side?

Oh, has this code even touched anything in the working tree and the
index at this point?  It looks more like everything we did above in
order to punt by returning 2 was to see if the condition for us to
reuse the resulting tree holds and nothing else.

Ah, "restore()" is misnamed, perhaps?  I thought it was about "oh,
we made a mess and need to go back to the state that was given to us
before failing", but is this the real "ok, the condition holds and
we can just reuse the tree from the previous merge"?  Then it makes
sense for the code to attempt to check out that tree and return 2
when it fails.  Only the function name was misleading.

> +	if (!opts->strategy || !strcmp(opts->strategy, "tms")) {
> +		rollback_lock_file(&lock);
> +		ret = try_tms_merge(opts, commit, to_merge->item);
> +		if (ret) {
> +			discard_index(r->index);
> +			if (repo_read_index(r) < 0) {
> +				ret = error(_("could not read index"));
> +				goto leave_merge;
> +			}
> +			goto ran_merge;
> +		}
> +		// regain lock to go into recursive

No // comments here.

> +		if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
