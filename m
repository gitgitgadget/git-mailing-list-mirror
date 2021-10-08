Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35028C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B8D60FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbhJHXDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:03:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50813 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 19:03:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02083E4522;
        Fri,  8 Oct 2021 19:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9M+tyy6SxDTHxnOyz95U/MzVrzG/jOG4zU5SRV
        stuws=; b=I3qBrUPArVcNltWlIdYKTN5jLjeUm9IEC+Cxfhe6qLXyawN82XmXIZ
        zxrna7wFh3VUd/6jCRniHlMj5lCIbcQzf9ixLpDuK7ahNYbqG4Ierwv8mxzRT4bN
        XvOtBPDAwun+GJgfHW+Mk0UijAPrSRpijXJx5W56hBCuXGL3R/ncs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBB2DE4520;
        Fri,  8 Oct 2021 19:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5806CE451F;
        Fri,  8 Oct 2021 19:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <87v92lxhh4.fsf@evledraar.gmail.com> <xmqqilykliiz.fsf@gitster.g>
        <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain>
        <xmqq8rzgi8a7.fsf@gitster.g>
        <CANQDOddZ-KYTB4q0nYNDinis8aKktm6Ek6F+mJouTV-yRtTpUw@mail.gmail.com>
        <xmqq4k9spk8p.fsf@gitster.g>
        <CABPp-BE=7+XifO3mAzNB90Y0vatvhwk7wwM4ptBrg79BhiFqSg@mail.gmail.com>
Date:   Fri, 08 Oct 2021 16:01:44 -0700
In-Reply-To: <CABPp-BE=7+XifO3mAzNB90Y0vatvhwk7wwM4ptBrg79BhiFqSg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 7 Oct 2021 23:51:57 -0700")
Message-ID: <xmqq4k9ri0iv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B59753A4-288B-11EC-9DD8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I had looked over Neeraj's patches and they looked reasonable.  I
> thought there might be some tweaks that I could try out, but at this
> point, just take what he has and keep my topic as expecting an update.
> I'll circle back eventually.

Thanks.

I've fetched Neeraj's remerge-diff rebase, and structured three
topics: 

 . 'ns/tmp-objdir' topic is to hold the bottommost two tmp-objdir
   patches.

 . 'ns/batched-fsync' topic forks from 'master', merges
   'ns/tmp-objdir', and then applies its own patches.

 . 'ns/remerge-diff' topic forks from 'master', merges
   'ns/tmp-objdir', and then applies its own patches.

