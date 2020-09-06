Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D4EC10DAA
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BCF207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZzBNvB1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIFVwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:52:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63028 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVwb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:52:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DD2479C69;
        Sun,  6 Sep 2020 17:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DIxEZTcT2ChUiAMXRw3xquOFfD4=; b=ZzBNvB1p8uh6kIWa3E3d
        qZ8Rimz6TvHdqX0jviT0ndRxXzHD9WJ4H+dPgZVCj4+g+wqVLCU87N2tMSQshPa7
        5P/BAlWDzbwGfsaFPAQGVIamEuoGnrVQP8rFZB8f2fpCpYuVZt9QNOA5ul3Hl53o
        fpRT6DB6pRVz0z4QYEJGYp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=CFzJ7ccrox93fddcLCAmD1p81vSKIYHKhd9LgcxaZY4ovF
        yZBNfFj9iSLEhhHj/TU1SDD+l+kVSKMt1bn0QZqBez8p+qswkDDYYMFzc5nNcv/L
        qB83k/iZLg504fmaWpnigRTPzM8io8SFapmyMLgkap70Rxe7eV/illAqHxXEI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95F7179C68;
        Sun,  6 Sep 2020 17:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D966D79C67;
        Sun,  6 Sep 2020 17:52:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Toni <victor.toni@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Aborting git rebase --edit-todo
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
        <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
        <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
        <xmqqtuwe8t5s.fsf@gitster.c.googlers.com>
        <CAG0OSgdT+ZCT0dN29A89XhWi65SFepwyGA0SoS22TYGrvNnWqw@mail.gmail.com>
Date:   Sun, 06 Sep 2020 14:52:28 -0700
Message-ID: <xmqqft7u4lpf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4225A544-F08B-11EA-A900-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Toni <victor.toni@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>
>> Victor Toni <victor.toni@gmail.com> writes:
>>
>> > Personally I would like to see your approach (1,2,3) implemented
>> > because it is not destructive. If the user wants to achieve something
>> > different he can retry.
>>
>> Obviously I agree that the approach would be nicer than the status
>> quo.  It would not be as trivial as a microproject, but would be a
>> good bite-sized starter-task for those aspiring developers who want
>> to dip their toes in the water to start hacking on the codebase ;-)
>>
> Nice try ;)

For the record I didn't try _you_.

I was writing for general audience, among which there are aspiring
developers seeking a starter-task.  Whether you are part of that
audience was immaterial (even though it would have been nice if you
were) ;-).

Thanks.



