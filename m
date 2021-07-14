Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EC8C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D1561363
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhGNAuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:50:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65091 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhGNAuX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:50:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EC29144BB1;
        Tue, 13 Jul 2021 20:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1JuKk3xPs1ve13LBzKaGovHsuGkbyzHFMiZ8FL
        Tr3Ig=; b=QxbI6lPoPYnYJNmzxwpYMhJFQ9eSy0PdFI5UvxI2Fwtk3V9UCLvl5L
        E3AIGV2Bu3+GCPD9SRa0xYKjN7B4eFkWKXu96rKx8+rMpteAyZw/W+44sQ0gzmjn
        j/PlFT4gkZhKI4xYnMKRZYw8bifm6vgbs3hS6vw6Bti83yIV9chUE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07624144BB0;
        Tue, 13 Jul 2021 20:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F7B1144BAF;
        Tue, 13 Jul 2021 20:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit
 exceeded
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
        <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com>
        <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
Date:   Tue, 13 Jul 2021 17:47:28 -0700
In-Reply-To: <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Jul 2021 11:13:57 -0700")
Message-ID: <xmqqzgupzppb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11A911A2-E43D-11EB-AC42-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jul 12, 2021 at 8:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> Since the steps that find inexact renames without the quadratic
>> algorithm are heuristics, perhaps this portion could instead be
>> called "exhaustive rename detection" or even "expensive rename
>> detection"? It perhaps implies more directly that the limit exists
>> as a way to prevent an expensive operation.
>
> The name "exhaustive rename detection" seems reasonable to me.  I'll
> resubmit using that term and see what folks think.

Funny.  In a sense, since computing content similarity is _more_
precise way to find a pair that is a likely rename than the more
recent heuristics, the more expensive "exhaustive" one can be called
"more precise rename detection", even though it is tempting to use
"inexact" to call it, too ;-)
