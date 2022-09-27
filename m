Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A458C6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiI0PrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiI0Pqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 11:46:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713B36873
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 08:43:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12BBC1CCD92;
        Tue, 27 Sep 2022 11:43:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cB+HmtzY84lV7TMRcdoD31eSTRb/UgfFaHIy6J
        XE1t0=; b=pOUBC3Uk+tpHl52Qn652bxFhSDGCLbKEhrtqBiVrRfndLIGAbTbN/u
        bD43qYo5tPriuPmbt2pCeFdLL+PJYAlnYZbSbkBeek7f4cjKs/5cvB0a9DGYdZWI
        bnh2vo0/3Dy+BzKZpZLSttDnWHB06JRz/QpPn04Anni5MIlWXFrdk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BBF61CCD91;
        Tue, 27 Sep 2022 11:43:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9B511CCD8E;
        Tue, 27 Sep 2022 11:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 08:43:52 -0700
In-Reply-To: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sun, 25 Sep 2022 00:09:48
        +0000")
Message-ID: <xmqqczbg9613.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30D843BA-3E7B-11ED-9143-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +  * Does the name --[no-]restrict sound good to others?  Are there better options?

Everybody in this thread are interested in sparse checkout, which
unfortunately blinds them from the fact that "restrict to", "limit
to", "focus on", etc. need not to be limited to the sparse checkout
feature.  We must have something that hints that the option is about
the sparse checkout feature.

As to the verbs, I do not mind "restrict to".  Other good ones I do
not mind choosing are "limit to" and "focus on".  They would equally
convey the same thing in this context.  And the object for these
verb phrases are the area of interest, those paths without the
skip-worktree bit, the paths outside the sparse cone(s).

Or we could go the other way.  We are excluding those paths with the
skip-worktree bit, so "exclude" and "ignore" are natural candidates.

These two classes are good if the "restrict" behaviour will never be
the default.  When it is the default, the option often used will
become "--no-restrict", which is awkward.

	Personally I am slightly in favor of "focus on" (i.e.
	"--focus" vs "--unfocus") as that meshes well with the
	concept of "the areas of the working tree paths that I am
	interested in right now", which may already hint that the
	option is about the sparse checkout feature (i.e. "I am
	focusing on these areas right now") and can stay short.  But
	this is just one person's opinion.

> +      * `--sparse`, as used in add/rm/mv, is totally backwards for
> +	grep/log/etc.  Changing the meaning of `--sparse` for these
> +	commands would fix the backwardness, but possibly break existing
> +	scripts.  Using a new name pairing would allow us to treat
> +	`--sparse` in these commands as a deprecated alias.

I actually am in favor of this, even though the appearance of
breaking backward compatibility may be big, but ...

> +      * There is a different `--sparse`/`--dense` pair for commands using
> +	revision machinery, so using that naming might cause confusion

... that is a good reason to avoid these two words.

