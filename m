Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0449C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 19:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiG1TcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG1TcS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 15:32:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0C5A2E6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:32:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9ADC19DC3C;
        Thu, 28 Jul 2022 15:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fr8J2p7uBfCSOi4m32Ml7bcUR8KBkCugKH5z0h
        AYKwg=; b=oU9snUIhPIARYZgR2TutxWhOo/ybuK5+4KyRgfoaUdE8bytjCMExKG
        8+z1wcGp5ienNQzeZtO1sDS6Z7Bh94RLrXrS6ES5n4ViwlTf6fi9f8S8RrqOpQT0
        OtXmBwMYLRAoi/ERQfBQgxByxUemFgPFyCQUWPK6Zm38KyOKJGBVs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C14B019DC39;
        Thu, 28 Jul 2022 15:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59E4219DC38;
        Thu, 28 Jul 2022 15:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v6 0/4] Add support for mailmap in cat-file
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
        <20220718195102.66321-1-siddharthasthana31@gmail.com>
        <xmqqpmht3tq1.fsf@gitster.g>
        <CAP8UFD0U8hQ+gyN1=7M4oYEhX6=z_1LS4JaLjqdPG52BELRqtg@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:32:12 -0700
In-Reply-To: <CAP8UFD0U8hQ+gyN1=7M4oYEhX6=z_1LS4JaLjqdPG52BELRqtg@mail.gmail.com>
        (Christian Couder's message of "Thu, 28 Jul 2022 21:07:28 +0200")
Message-ID: <xmqqh731av9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB221218-0EAB-11ED-BC23-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jul 25, 2022 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>>
>> > Changes in v6:
>> > - The function rewrite_ident_line() returns the difference between the
>> >   new and the old length of the ident line. We were not using this
>> >   information and instead parsing the buffer again to look for the line
>> >   ending. This patch set starts using that information to update the
>> >   buf_offset value in commit_rewrite_person().
>> > - This patch set also tweaks the commit_rewrite_person() so that it is
>> >   easier to understand and avoids unnecessary parsing of the buffer
>> >   wherever possible.
>> >
>> > Siddharth Asthana (4):
>> >   revision: improve commit_rewrite_person()
>> >   ident: move commit_rewrite_person() to ident.c
>> >   ident: rename commit_rewrite_person() to apply_mailmap_to_header()
>> >   cat-file: add mailmap support
>> >
>> >  Documentation/git-cat-file.txt |  6 +++
>> >  builtin/cat-file.c             | 43 +++++++++++++++++++-
>> >  cache.h                        |  6 +++
>> >  ident.c                        | 74 ++++++++++++++++++++++++++++++++++
>> >  revision.c                     | 50 ++---------------------
>> >  t/t4203-mailmap.sh             | 59 +++++++++++++++++++++++++++
>> >  6 files changed, 190 insertions(+), 48 deletions(-)
>>
>> I haven't seen any comments or objections to this round.  Are people
>> happy about it going forward?  I am planning to merge it to 'next'
>> and down to 'master' soonish.
>
> I am biased, but I am happy with the current state of this patch
> series. During the last versions of this patch series there were only
> comments related to the first patch in the series (revision: improve
> commit_rewrite_person()). It seems to me that they were all properly
> taken into account, and that the code in that patch is now correct and
> relatively simple to understand.

Thanks, let's move it forward.
