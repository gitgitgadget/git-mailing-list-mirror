Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C567C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0014661168
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEKUoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:44:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60094 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:44:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7707C120770;
        Tue, 11 May 2021 16:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7WcmGhlrChDpHMU3iO/oKl/YKgdsgwJvBRAYyF
        d/+O8=; b=L67sbbkQ4jMK55fFKiQ646OQd2CdkPeixMbsl6Kyj8LOAFkfpYlb0d
        8lH6F0thYvqzNgiOPvJaEpauFn2L4wwH/WJ/SxcCOB6q32Hjh2nqBSBtYRHrRI8G
        kLEudpcClc6mXN0TMayZ/VoL8Fz8WgM3VQJxGTmaJdJ8sPDp2Tp58=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FD5212076F;
        Tue, 11 May 2021 16:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A56E212076D;
        Tue, 11 May 2021 16:43:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
Date:   Wed, 12 May 2021 05:43:01 +0900
In-Reply-To: <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 May 2021 11:31:03 -0700")
Message-ID: <xmqqtun9knmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B844F40-B299-11EB-900A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, May 11, 2021 at 7:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>> ...
> I think --cc is a lot better than -m for helping you find what users
> changed when they did the merge, but I agree the format is somewhat
> difficult for many users to understand.  (--diff-merges=remerge, or
> --remerge-diff, fixes these problems, IMO.)  I think
> --diff-merges=first-parent, while fine when explicitly requested on
> the command line, would be wildly misleading as a default because it
> would attribute changes to a merge commit that were made elsewhere.
>
>> Overall, let's rather make -m give diff to the first parent by default.
>> Simple. Useful. Not confusing.
>
> I think it's confusing.

I do not think it is particularly confusing---after all, it shows
"here is a comparison between two trees" the users are familiar with
in a single strand of pearls.

But I do think that it is an utterly misleading option to show
merges in general.  When "log" is used with the "--first-parent"
traversal, "compare with the first parent to show everything the
side branch did" is an acceptable alternative, but even there, it is
far less suitable than the "remerge" or "cc", I would think, as the
default format.

Thanks.

