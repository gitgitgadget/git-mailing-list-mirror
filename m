Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860BC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDBB221FE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jWnR7Uj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgJHR6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:58:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHR61 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 13:58:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 616527EA7D;
        Thu,  8 Oct 2020 13:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=idcWkAFYzFTd3WStuOPkNfhR5Zc=; b=jWnR7U
        j82GTbFIM2CJ1RU4dBbTi1v9wcV0raPxa2pYuT++Rj2meeF9GohlAw2rwMhyPmua
        R0YwjPQGTSYmho4NpcZbT75gBWPbBaj4p/o75Tg2T5iNUxRVxwkIO9w82o/I1UA8
        b8Ew2WRIckuGhgG5Zsz8kpYF8hRpZwCbSfm5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N0tEOeJ0SAs/Vz13RIkrHxGPUECXKV3c
        ShJaMX6sOEw1A1zbc98NKhEFf56H1e+QeIYk5dtUoO4oK+fWZmoWxWwtBBmi5sbi
        kgVEkwQa0ih77r5dJTjud/eDOPEYSZQChBPQ404G+okMAJDB5/SJAIPyLub305Kl
        1hxaDXWYmjM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58BA47EA7C;
        Thu,  8 Oct 2020 13:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D22AA7EA7B;
        Thu,  8 Oct 2020 13:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Karszniewicz <avoidr@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] log: add log.showStat configuration variable
References: <20201008162015.23898-1-avoidr@posteo.de>
Date:   Thu, 08 Oct 2020 10:58:22 -0700
In-Reply-To: <20201008162015.23898-1-avoidr@posteo.de> (Robert Karszniewicz's
        message of "Thu, 8 Oct 2020 18:20:15 +0200")
Message-ID: <xmqq1ri8y4zl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB46BE94-098F-11EB-BB90-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Karszniewicz <avoidr@posteo.de> writes:

> Changes default behaviour of `git log` and `git show` when no
> command-line options are given. Doesn't affect behaviour otherwise (same
> behaviour as with stash.showStat).
> ---
> I've wanted to have `show` and `log` show --stat by default, and I
> couldn't find any better solution for it. And I've discovered that there
> is stash.showStat, which is exactly what I want. So I wanted to bring
> stash.showStat to `show` and `log`.

I would be happy if I can configure my "git show" to 

 - show not just patch but stat by default;
 - keep showing nothing when told to be silent with "git show -s"

independently what happens to my "git log".  Specifically, I do not
want to see a configuration that I use to tweak "git show" the way I
want (see above) to make my "git log" to become "git log --stat".

And why is "stat" so special?  I am sure there are people who want
to do --numstat or --summary or combinations of these by default,
so I doubt that a new bit in rev_info structure is a good way to go.

> So far, setting log.showStat affects behaviour as described in the
> commit message.
> But it does so for `show` and `log` at the same time. I think they
> should be configurable separately. (log.showStat and show.showStat)

Absolutely.

> Before I do all the work, please tell me if this is the right approach
> so far, and if the feature - when ready - would be accepted. (I'm aware
> that documentation and tests are missing.)

Nobody will get such a guarantee.  A good test to see if a topic is
worth spending the reviewers' time on is if the authors are willing
to spend their time whether it will be in the official relesae or it
will have to be kept in a private fork for the authors' own use.  If
it is not good enough that the authors won't keep a fork of Git just
to use it for themselves, it is hard to imagine that it would be
good enough for public consumption.

In short, make it so useful that we'd come to you begging for it ;-)

> diff --git a/revision.h b/revision.h
> index f6bf860d19..e402c519d8 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -204,6 +204,7 @@ struct rev_info {
>  			show_merge:1,
>  			show_notes_given:1,
>  			show_signature:1,
> +			show_stat:1,
>  			pretty_given:1,
>  			abbrev_commit:1,
>  			abbrev_commit_given:1,

The change to the code we saw in builtin/log.c, e.g.

> +	if (!rev->diffopt.output_format) {
> +		/* Turn --cc/-c into -p --cc/-c when -p was not given */
> +		if (rev->combine_merges)
> +			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
> +
> +		if (rev->show_stat)
> +			rev->diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
> +	}

hints us that this new bit belongs to the group that the
combine_merges bit belongs to, not here, no?

But again, I am not sure if a new bit in rev_info structure is a
good way to proceed---after all, when a diff (in various forms, like
"patch", "stat only", "patch and stat", "patch, stat, and summary")
is shown, how exactly they are shown is not controlled by bits in this
structure (rather, that comes from the diffopt field).

Thanks.
