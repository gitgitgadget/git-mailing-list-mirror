Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D9C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC02208A9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d5xFQTxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKBVg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:36:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53951 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBVg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 16:36:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F6BC8F11D;
        Mon,  2 Nov 2020 16:36:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=IzVO5fnWSGPoC0z3MFcODA/f3C4=; b=d5xFQTxvvIRzRjRkIVPt
        P2MpQxV5w743tFDAq3z3ldaVtKU5qhvzYgWBvaFAf3/dVm3RDopW8iqGaCnifWk1
        owz1ZLBzAE1rvbx6VHzKCdSpd1Vh873I4yqUmPlYic63TVc49dJ5Ab+0jQBO7LAc
        sfgm4OmRd5hyTgezK6fmocg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=WoMijzaTx/4bVoHlOpuyCkGDItLodKghI8w3e9sol6AE58
        vnGQdhaKTtDb5uzzZa3OwM2psKGKFZiDNlQpNqXYAuZtT+9ECyyAoM1vLgipzLwJ
        BO8HcCvU9tvRfyneM27mdo69iK5CzgTFAucCUxexAmSvfVcA7Lt/ZZFDCiLT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55C5A8F11C;
        Mon,  2 Nov 2020 16:36:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD8AD8F11B;
        Mon,  2 Nov 2020 16:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: ag/merge-strategies-in-c, was Re: What's cooking in git.git
 (Oct 2020, #04; Tue, 27)
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011020333440.18437@tvgsbejvaqbjf.bet>
Date:   Mon, 02 Nov 2020 13:36:56 -0800
Message-ID: <xmqqv9ensao7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8825E244-1D53-11EB-A869-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 27 Oct 2020, Junio C Hamano wrote:
>
>> * ag/merge-strategies-in-c (2020-10-06) 11 commits
>>  - sequencer: use the "octopus" merge strategy without forking
>>  - sequencer: use the "resolve" strategy without forking
>>  - merge: use the "octopus" strategy without forking
>>  - merge: use the "resolve" strategy without forking
>>  - merge-octopus: rewrite in C
>>  - merge-recursive: move better_branch_name() to merge.c
>>  - merge-resolve: rewrite in C
>>  - merge-index: don't fork if the requested program is `git-merge-one-file'
>>  - merge-index: libify merge_one_path() and merge_all()
>>  - merge-one-file: rewrite in C
>>  - t6027: modernise tests
>>
>>  The resolve and octopus merge strategy backends have been rewritten
>>  in C.
>
> From where I sit, this is ready for `next`.

I just went back to the thread.

https://lore.kernel.org/git/20201005122646.27994-1-alban.gruin@gmail.com/

It seems that the topic saw quite a few comments and help by Phillip
Wood in its earliest iteration, but I didn't see any review from
those other than myself on the last iteration v3, and the review
comments on the iteration haven't been acted upon yet.

That was why I threw the topic in "needs review" bucket.  The later
half of the series got no comments (I lost steam after reviewing the
earlier half) and I suspect they would have be adjusted for fixes
and improvements done to polish the earlier parts, so I am not sure
where your "ready for 'next'" comes from.

Thanks.
