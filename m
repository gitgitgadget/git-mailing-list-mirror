Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B698C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4AC64F95
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhBEBIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 20:08:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59733 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhBEBIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 20:08:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF5C012501C;
        Thu,  4 Feb 2021 20:07:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NidRMgfUaPqE6O6oFyA1rrvr2Co=; b=Ws72G2
        jdCeOo8edzrqDW2plapWgoFJe/6vpDBwxsrJchytYfciNUgK1p/LQyhn4xM1aWfz
        hX9dLy+q8smb6/rCNF4fnvJYVdfk7BQxKue8ojV338fVJmZH1kzuPkx/tCYfqy7P
        GNLwe5nqDhis7Oq5t5WIzWf/AgWggbLqfTZjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HyynCm/76CLp1GIkp2VDkqLdb7kPB6Ct
        GW1eY8oMFH4HTWCvKYRCUs34XBpeUKCP/ao7V7coLgFW20qSKpRTuZ/WloE8ogYq
        YYhpdto/bFdqqlMDbWhR3UiiC5rToOg9z4TX+/8P2h29WOQvWCy1V6NOaaQ/bNxv
        oZBStnHcivs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A685812501B;
        Thu,  4 Feb 2021 20:07:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA2BD125019;
        Thu,  4 Feb 2021 20:07:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
References: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
        <04b5d75adbc3d80e9f9cf9cd380294949e7c68e8.1612481392.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 17:07:27 -0800
In-Reply-To: <04b5d75adbc3d80e9f9cf9cd380294949e7c68e8.1612481392.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Feb 2021
        23:29:51 +0000")
Message-ID: <xmqqmtwj2ugg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 844E43F6-674E-11EB-BF7D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	init_revisions(&revs, NULL);
> +	if (setup_revisions(3, argv, &revs, 0) == 1)
> +		for (i = 0; i < revs.pending.nr; i++) {
> +			struct object *obj = revs.pending.objects[i].item;
> +
> +			if (obj->flags & UNINTERESTING)
> +				negative++;
> +			else
> +				positive++;
> +			if (obj->type == OBJ_COMMIT)
> +				clear_commit_marks((struct commit *)obj,
> +						   ALL_REV_FLAGS);

Ah, I didn't think of adding this inside the same loop.  As long as
the pending objects are independent, this should work, but it is
unsafe, I think.  Imagine what happens if revs.pending[0].item can
reach the object revs.pending[1].item?  By the time the loop wants
to inspect the latter, its flags may have been cleared already
because we clear flags in objects that are reachable from the
former.

Let's do this as a post-processing for safety (or correctness).

	int negpos = 0;

	if (setup_revisions(3, argv, &revs, 0) != 1)
		goto cleanup;
	for (i = 0; i < revs.pending.nr && negpos != 3; i++) {
		struct object *obj = revs.pending.objects[i].item;
		negpos |= (obj->flags & UNINTERESTING) ? 01 : 02;
	}

	for (i = 0; i < revs.pending.nr; i++) {
		struct object *obj = revs.pending.objects[i].item;
                if (obj->type == OBJ_COMMIT)
			clear_commit_marks((struct commit *)obj, ALL_REV_FLAGS);
	}

    cleanup:
> +	free(copy);
> +	object_array_clear(&revs.pending);
> +	return negative > 0 && positive > 0;
>  }

or something like that.

> +test_expect_success 'A^{/..} is not mistaken for a range' '
> +	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
> +	test_i18ngrep "not a commit rang" error
> +'

s/rang/range/, I would think.

Thanks.
