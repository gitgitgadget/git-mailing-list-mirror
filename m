Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9D01F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFCSQ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:16:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60235 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:16:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F386D6B9F6;
        Mon,  3 Jun 2019 14:16:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7KVWO8rQp98sH68LtrC0W0PEHHg=; b=HNz/HL
        7bMZBsIq3wbCABtVyoODx71IzwxO3FyC1cK78UU8px50r7IwwddyPok+4SVLF1Qo
        cqQfK1avCyigAm+bmKWJcmuRAYrLrUDSblOQP35QrmOKE0CHV33x2BiLaWWhp/Vl
        u1CjBaZSMvyzBWse6fI+amQ250ZJ3i0OJ+6h4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QNlQpoJoTIEAkRpRTl2VVlbiDcECDSBn
        KNCJZw3EbUkYzj+MS2eZxwP+dLmL3wVqVj6vGvc4a8CKul+In+19SxVrA/LwezD6
        0DoWhI0lermRVoCHumZYQ0gkz1VA1g/loCCsaVY8yPNOQ3jrFr9HICGugUDzuJpW
        5ASg/O5Grps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBDB06B9F5;
        Mon,  3 Jun 2019 14:16:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26DFC6B9F4;
        Mon,  3 Jun 2019 14:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Drew DeVault <sir@cmpwn.com>, git <git@vger.kernel.org>
Subject: Re: [Proposal] git am --check
References: <BUJFK0ZEKP5I.16DDFWUTXGJTE@homura>
        <CAP8UFD1W_tB34N-uAA85+QkHY6kmGWYYM47zceP3=5aTwxwvnQ@mail.gmail.com>
        <CACsJy8CUGfUwi15+ggOgRT4xotCkJVhGtCrjMa=4pdnDq25f4A@mail.gmail.com>
Date:   Mon, 03 Jun 2019 11:16:19 -0700
In-Reply-To: <CACsJy8CUGfUwi15+ggOgRT4xotCkJVhGtCrjMa=4pdnDq25f4A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 3 Jun 2019 16:35:01 +0700")
Message-ID: <xmqqblzev8jw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0575D58-862B-11E9-8D79-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jun 3, 2019 at 4:29 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> On Sun, Jun 2, 2019 at 7:38 PM Drew DeVault <sir@cmpwn.com> wrote:
>> >
>> > This flag would behave similarly to git apply --check, or in other words
>> > would exit with a nonzero status if the patch is not applicable without
>> > actually applying the patch otherwise.
>>
>> `git am` uses the same code as `git apply` to apply patches, so there
>> should be no difference between `git am --check` and `git apply
>> --check`.
>
> One difference (that still annoys me) is "git apply" must be run at
> topdir. "git am" can be run anywhere and it will automatically find
> topdir.
>
> "git am" can also consume multiple patches, so it's some extra work if
> we just use "git apply" directly, although I don't think that's a very
> good argument for "am --check".

Another is that "am" has preprocessing phase performed by mailsplit
that deals with MIME garbage, which "apply" will totally choke on
without even attempting to cope with.

I haven't carefully read the "proposal" or any rfc patches yet, but
would/should the command make a commit if the patch cleanly applies?

I wonder if a "--dry-run" option is more useful (i.e. checks and
reports with the exit status *if* the command without "--dry-run"
would cleanly succeed, but never makes a commit or touches the index
or the working tree), given the motivating use case is a Git aware
MUA that helps the user by saying "if you are busy you could perhaps
skip this message as the patch would not apply to your tree anyway".
