Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E556C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 22:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B4A60720
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHQWLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:11:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHQWLb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 18:11:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B4F1CEED9;
        Tue, 17 Aug 2021 18:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r8vJG6ix1IdUsqal5D4t8hxL9gf/fC8gjIOzkc
        69YH4=; b=cp9Vv1WUU8WXiQSIav/hTteX1qs48ZOetlUKtXYq2JMkiWQsU6q5nP
        BH/fSJLIL0woLAVYM+XsEXq1j2TQ10Li0E8WpZqhCrlFWTvM8S2Nq5hCq6CT4VmO
        71b8H2V8/WfXemtCm/98h21pIXBPFi4/5/fP9BKKhVkKlGAlouNMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C501CEED8;
        Tue, 17 Aug 2021 18:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91945CEED6;
        Tue, 17 Aug 2021 18:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com> <xmqqeeb3hlcq.fsf@gitster.g>
        <87a6lgl9gq.fsf@osv.gnss.ru>
Date:   Tue, 17 Aug 2021 15:10:55 -0700
In-Reply-To: <87a6lgl9gq.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        17 Aug 2021 12:13:57 +0300")
Message-ID: <xmqqczqb7mds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEE80EC0-FFA7-11EB-8D9A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> So, do I get it right that there is actually no reason to use "log
> --first-parent -m" anymore, since the time the much older commit made
> --first-parent imply -m?

It was necessary for scripts to say

    git log --first-parent -m "$@"

if they wanted to optionally show a first-parent diff for a merge
when the user of the script passes "-p" in "$@" (and not to show
patch if the user does not pass "-p").  

That changed with 9ab89a24 (log: enable "-m" automatically with
"--first-parent", 2020-07-29).

After that commit, it no longer was needed, but it still was correct
to expect that no patch will be shown with "--first-parent -m",
unless you give "-p" at the same time.  The original change that the
patch under discussion reverted broke that expectation.

We need to note that the "-m" implied by "--first-parent" is "if we
were to show some comparison, do so also for merge commits", not the
"if the user says '-m', it must mean that the user wants to see
comparison, period, so make it imply '-p'".  The latter is what was
reverted.

> If so, I'd object against this particular patch as the pros of patch
> being reverted outweighs its cons, and the original patch never meant to
> be entirely backward compatible in the first place, when it was
> accepted.

I agree that we both (and if there were other reviewers, they too)
mistakenly thought that the change in behaviour was innocuous enough
when we queued the patch, but our mistakes were caught while the
topic was still cooking in 'next', and I have Jonathan to thank for
being extra careful.

Thanks.

