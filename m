Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20CDC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC9E60F50
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 17:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhHGRBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 13:01:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54949 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhHGRBL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 13:01:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58A4FF5229;
        Sat,  7 Aug 2021 13:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xG1ro0g+yARC5eBAal1HfpwEEwUxE1XxncvhbJ
        n87eU=; b=ZuU9KOw8nF2kH22Ylt6J3EyyYf8aYJn+A2SeokOn4pQzcAK1JDc04b
        K2Gzy/sKErZnWgRW9RrZLnRZxGwl48hVrqLJ0ASKafqdUG88oYCbzMtHuMS7OVfk
        jGSYMSdHO0X8VG59EYr6s2jBOdLy+L74LwQo+3ssqBhRnKk/TH7fo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DAA6F5228;
        Sat,  7 Aug 2021 13:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9249F5227;
        Sat,  7 Aug 2021 13:00:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Sergey Organov <sorganov@gmail.com>,
        Jeff King <peff@peff.net>,
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
        <xmqqh7g2ij5q.fsf@gitster.g> <YQ3n9Z2nH35429mC@google.com>
        <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
        <YQ6P0OWPPksWG5Hf@google.com>
Date:   Sat, 07 Aug 2021 10:00:51 -0700
In-Reply-To: <YQ6P0OWPPksWG5Hf@google.com> (Jonathan Nieder's message of "Sat,
        7 Aug 2021 06:51:12 -0700")
Message-ID: <xmqqv94hi3zw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06101DE6-F7A1-11EB-AF25-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> More generally, we've been able to make changes to porcelain commands
> that don't hurt our ability to act as a platform for scripts, and I
> want us to continue to be able to do that.  "Do not break any script"
> is certainly not the standard I think we should apply, as illustrated
> by my thoughts upthread when I thought '-m' in this Rust example was a
> typo.
>
> But by now it's very clear to me that it was not a typo.

This is a tangent that does not change the conclusion, because the
use of "-m" in "stash list" was not a typo but a deliberate attempt
to allow "-p" from the end-users to do what they wanted to do, and
it was clearly broken by this change (as you said, the need to hide
the breakage in the same series should have ringed a loud bell for
us).

But I didn't see how you think your Rust thing is not a typo, and I
still don't.  Unless you think Rust folks expected "-m" to do what
"-m" was not designed to do, that is, and I do not think that
"people thought it did something entirely differently, when it was a
no-op, so we shouldn't suddenly make it not a no-op" is a good
rationale that affects how we choose the evolution path for our
tools.

THanks.
