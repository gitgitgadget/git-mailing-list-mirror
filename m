Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E297C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351713AbiCPTkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbiCPTkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 15:40:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C553E01
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:39:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 565891280A8;
        Wed, 16 Mar 2022 15:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=71tg80srtXlv1MGBPgykKJOGTD1vDNOymAkSCk
        BmcfE=; b=atBiICPJ1ypdYgiPJ4pjIpChoxm9xw1GKlY4uWbv0WJ7DU+Q31agr/
        utvwRFwbAgcMIvNNmYDs6EvWQcPe8paAEFu+4IZIo2/9vwXdJRYbgl8ma1gj/rFA
        bCE+A/M58pIKpWbDcJPgnAAXlANZGWi1AHZkezTVFOR1A3sUOwr+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 402451280A7;
        Wed, 16 Mar 2022 15:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27ACA1280A5;
        Wed, 16 Mar 2022 15:39:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Zhang <zhgdrx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: understand Diff Formatting --cc flag?
References: <CAJcwCMMMm=ZnkV3Xxbf+CpJqhRGx1KrdUzh90W-9dEPJ+i40xg@mail.gmail.com>
        <xmqq8rt9opd1.fsf@gitster.g>
        <CAJcwCMN67UMjSNqf2wbb5ZhK1QGicn7+ihneOc1XxJsdDVtvTw@mail.gmail.com>
Date:   Wed, 16 Mar 2022 12:39:03 -0700
In-Reply-To: <CAJcwCMN67UMjSNqf2wbb5ZhK1QGicn7+ihneOc1XxJsdDVtvTw@mail.gmail.com>
        (Andy Zhang's message of "Thu, 17 Mar 2022 03:00:26 +0800")
Message-ID: <xmqqk0ctlmaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDD975A4-A560-11EC-BDDA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Zhang <zhgdrx@gmail.com> writes:

>> Among 5 parents, perhaps parent#1 and parent#2 had the same contents,
>> and parent#4 and parent#5 had the same contents, different from what
>> parent#1 and parent#3 had.  You have 3 variants (parent#1's, #3's
>> and #4's; parent#2 has the same contents as #1, parent#5 has the
>> same contents as #4).
>>
>
> [Andy wrote:] as per your comments, The 3 variants are indeed into the
> following 3 groups.
> My question is: why can #1 appear inside multiple groups? A and B.
>    <group-A> parent#1, #3, #4;
>    <group-B> parent#2, #1;
>    <group-C> parent#5, #4;

The three variants in my sample scenario were (A) used by #1, (B)
used by #3, and (C) used by #4.  #2 uses (A) and #5 uses (C).

The contents of #1 does appear twice, in #1 itself and also in #2.
That is what "#2 has the same contents as #1" means.

> [Andy wrote:] can I explain  "--cc" flag as:
> "--cc lists only either hunks which were modified from all parents, or
> hunks which were modified from at least two parents and they had
> different variants"

I do not have time to see if that matches the official explanation
found in "git diff --help", which I just re-read and I think it
gives the right definition.
