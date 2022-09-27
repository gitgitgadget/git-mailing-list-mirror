Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DAC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 04:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiI0EbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 00:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiI0Ea7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 00:30:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00082746
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 21:30:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 063081A8393;
        Tue, 27 Sep 2022 00:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/0zcVcf4N/NidOewqR5Sc4GeHuS4ykW1PrhBD5
        Ke6JU=; b=uQZRkASZPC6jJuB6i41EYTENrrdxg80f4y5iQGidKPt/xgIGVAfFAG
        s5pC8DTTPr1rWNoq+1s5Kr6IaB7mrz29mjUzMihAr3IiE9Kj5XKgkXYc+VKbM2vR
        aIusXV1RA7J7gUBQt1PlYJ7EMYcBCD/rXErsS+qrlS0/qBxJ3Vd64=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1DF21A8392;
        Tue, 27 Sep 2022 00:30:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1D1A1A8391;
        Tue, 27 Sep 2022 00:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
        <xmqqwn9qox1z.fsf@gitster.g>
        <CABPp-BFo_0MaBfyhDBfRby4CSHy8brjMY_8nif2S_Aogn-NqUg@mail.gmail.com>
Date:   Mon, 26 Sep 2022 21:30:52 -0700
In-Reply-To: <CABPp-BFo_0MaBfyhDBfRby4CSHy8brjMY_8nif2S_Aogn-NqUg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 26 Sep 2022 20:05:28 -0700")
Message-ID: <xmqqedvxa16r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C50968E-3E1D-11ED-AD0C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> "am" is about recording what is in the patch as a commit.
>
> Does that mean it should behave like "apply --index"?  Or more like
> cherry-pick?

It should behave like a manual edit (after widening the area of
interest by adjusting sparsity specification, if needed) followed by
"git add" followed by "git commit".

> The command
>     $ edit path/outside/sparse/specification
> doesn't make sense to me; the file (and perhaps also its leading
> directories) are missing.  Most editors will probably tell you that
> you are editing a new file, but then it's more of a "rewrite from
> scratch" than an "edit".

If it is a new file, read it with "mkdir -p $(dirname $that_file)"
prefixed.  If it is an existing file, then "checkout $that_file"
instead.  And then adjust your sparsity specification so that the
path is now within your area of interest.

> Typically, we'd expect users who want to edit such files to do so by
> first running the `add` or `set` subcommands of sparse-checkout to
> change their sparse specification so that the file becomes present.
> But then it's no longer outside the sparse specification.  So, I'm not
> sure how this angle could help guide our direction.

The fact that you accept and attempt to apply and make it into a
commit already indicates your intention that the paths touched by
the patch are now in your area of interest, just like whichever
paths you decide to manually edit and record the changes you made,
so it would be the most user friendly to automatically adjust the
sparsity specification to allow them do exactly that, I would think.

That is how I look at the "am" command, anyway.

