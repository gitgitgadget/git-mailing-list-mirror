Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61380C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45C2207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyMg6hUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKKTvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:51:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3EC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:51:15 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l3so1743311ply.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SQC3LhwbCD0BaiqhguGYERY6KLlyOz6pid0xFAnLYLQ=;
        b=HyMg6hUptHAEV4z2jYNipsbFj1KQ0tX/DQmXCIjwZ3/uQR6tiWiEJNecMma6w6MBYK
         sMxzgxnUvuRQurrSVjb7tFk95nf3LMjDKrBxVN7ZlWS8UqaKqjylQ5BJ4gX5s11rJL3z
         2FjzwT7VjT4v/5v2z2ofmR2GDktgqi2CjdS9zxCGiXA3kNMRtLcTY6R5CnQl7Txel9Gy
         bECwehwQe3/o7FWu/hxt+mUkesv/jPY+tfCXrKgZuk0sSvcb0qrXhSb3gP0H23KRVAB3
         YwK2iQYHk9QwBnzZ/3Oe9UXcQBObjFc5J7SInMLaac9ehmIHqGeUQtGh6rJ0nJ4IVCbf
         jK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SQC3LhwbCD0BaiqhguGYERY6KLlyOz6pid0xFAnLYLQ=;
        b=gWpBUsrAZ9FepkpP6TIgzHDBXX+jem779wfGtLC8xS/TtL8aKT3JSMpOjDTKBAhlP7
         bwjqbA7OkG1wFARmbGnWaiZDwsuJL856tXski6Q7E9PZLR4a8QC05PW+frf+h1SnqkJD
         5g/FaUT20+YVcxfjGdRqt95WFR3TgZRe4wB+jP13ImjJdbio7fmORkdKion4dc7t9KeV
         GzhGDj4C+hY1zgcwiSvgtjneeTa7Cs9c6WOFDlFBM27gXQxIf9DvwRms++zjS1tfpAv1
         M4Jfvmd6ZVF/N94csWViGe3CBn0IWOik9LoYtgnWAdB5IqLwWVIKJjdj4nGie28nEHj/
         FALQ==
X-Gm-Message-State: AOAM530ZDYdMIH2QHmLN8K6MEg9cHLZd+z4T3tVnywKwdV4dkTAVTdYp
        RUWf2Hb3Rwe0hTmco0jAw3WDeILzsxkM5V4LGMm3
X-Google-Smtp-Source: ABdhPJz9IANAaWnGHkuGFyU9MMjJFCJEzY7qeZuBxRFuw/cMDTXSdbTPxkKE/+yraY8aowQUYJMBa5afVCMnLyVUtoD8
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8f13:0:b029:18b:db7a:8590 with
 SMTP id x19-20020aa78f130000b029018bdb7a8590mr20150478pfr.9.1605124275115;
 Wed, 11 Nov 2020 11:51:15 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:51:11 -0800
In-Reply-To: <20201102204344.342633-12-newren@gmail.com>
Message-Id: <20201111195111.3115407-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-12-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 11/20] merge-ort: add a preliminary simple
 process_entries() implementation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay...let me review patches 11-15. (Patches 16-20 deal with checkout
and might be better reviewed by someone who is already familiar with how
the existing merge performs checkout. If no one reviews it, I might come
back to it if I have time.)

> +/* Per entry merge function */
> +static void process_entry(struct merge_options *opt,
> +			  const char *path,
> +			  struct conflict_info *ci)
> +{
> +	assert(!ci->merged.clean);
> +	assert(ci->filemask >= 0 && ci->filemask <= 7);

I see below that this function doesn't handle ci->match_mask == 7 (and
it doesn't need to because, I believe, there is a function in one of the
earlier patches that optimizes the case wherein all 3 match with each
other). Maybe add an assert here for that too.

> +
> +	if (ci->filemask == 0) {
> +		/*
> +		 * This is a placeholder for directories that were recursed
> +		 * into; nothing to do in this case.
> +		 */
> +		return;
> +	}
> +
> +	if (ci->df_conflict) {
> +		die("Not yet implemented.");
> +	}
> +
> +	/*
> +	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
> +	 *       which the code goes through even for the df_conflict cases
> +	 *       above.  Well, it will once we don't die-not-implemented above.
> +	 */
> +	if (ci->match_mask) {
> +		ci->merged.clean = 1;

OK, looks straightforward so far. It's a clean merge if 2 match. (As I
said earlier, at this point in the code, it is not possible for 3 to
match.)

> +		if (ci->match_mask == 6) {
> +			/* stages[1] == stages[2] */
> +			ci->merged.result.mode = ci->stages[1].mode;
> +			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);

If OURS and THEIRS match, use one of them arbitrarily (because they are
the same anyway). OK.

> +		} else {
> +			/* determine the mask of the side that didn't match */
> +			unsigned int othermask = 7 & ~ci->match_mask;
> +			int side = (othermask == 4) ? 2 : 1;

BASE matches with either OURS or THEIRS, so use the side that doesn't
match. OK.

> +
> +			ci->merged.is_null = (ci->filemask == ci->match_mask);

This works (if the non-matching bit in filemask is set, the file exists;
the comparison will be false and therefore is_null is false - and
correctly false because the file exists), but seems unnecessarily
clever. Couldn't you just check nullness of the OID (or through the
mode, like the line below it) and set it here?

Admittedly, the way you wrote it also verifies that filemask is what we
expect. I don't think it is important to verify it, but if you think it
is important, I think it is this verification that should go in the
assert statement.

> +			ci->merged.result.mode = ci->stages[side].mode;
> +			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
> +
> +			assert(othermask == 2 || othermask == 4);
> +			assert(ci->merged.is_null == !ci->merged.result.mode);
> +		}
> +	} else if (ci->filemask >= 6 &&
> +		   (S_IFMT & ci->stages[1].mode) !=
> +		   (S_IFMT & ci->stages[2].mode)) {
> +		/*
> +		 * Two different items from (file/submodule/symlink)
> +		 */
> +		die("Not yet implemented.");

There are no matches, and OURS and THEIRS have different types. OK.

> +	} else if (ci->filemask >= 6) {
> +		/*
> +		 * TODO: Needs a two-way or three-way content merge, but we're
> +		 * just being lazy and copying the version from HEAD and
> +		 * leaving it as conflicted.
> +		 */
> +		ci->merged.clean = 0;
> +		ci->merged.result.mode = ci->stages[1].mode;
> +		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);

OK.

> +	} else if (ci->filemask == 3 || ci->filemask == 5) {
> +		/* Modify/delete */
> +		die("Not yet implemented.");
> +	} else if (ci->filemask == 2 || ci->filemask == 4) {
> +		/* Added on one side */
> +		int side = (ci->filemask == 4) ? 2 : 1;
> +		ci->merged.result.mode = ci->stages[side].mode;
> +		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
> +		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
> +	} else if (ci->filemask == 1) {
> +		/* Deleted on both sides */
> +		ci->merged.is_null = 1;
> +		ci->merged.result.mode = 0;
> +		oidcpy(&ci->merged.result.oid, &null_oid);
> +		ci->merged.clean = !ci->path_conflict;
> +	}

The rest is OK.

> +
> +	/*
> +	 * If still unmerged, record it separately.  This allows us to later
> +	 * iterate over just unmerged entries when updating the index instead
> +	 * of iterating over all entries.
> +	 */
> +	if (!ci->merged.clean)
> +		strmap_put(&opt->priv->unmerged, path, ci);
> +}
> +
>  static void process_entries(struct merge_options *opt,
>  			    struct object_id *result_oid)
>  {
> -	die("Not yet implemented.");
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +
> +	if (strmap_empty(&opt->priv->paths)) {
> +		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
> +		return;
> +	}
> +
> +	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
> +		/*
> +		 * WARNING: If ci->merged.clean is true, then ci does not
> +		 * actually point to a conflict_info but a struct merge_info.
> +		 */
> +		struct conflict_info *ci = e->value;
> +
> +		if (!ci->merged.clean)
> +			process_entry(opt, e->key, e->value);
> +	}
> +
> +	die("Tree creation not yet implemented");

The rest looks straightforward.
