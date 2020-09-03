Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E99C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E46D206D4
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HD2lgnVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgICVIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:08:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61884 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgICVIu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:08:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CDAA88877;
        Thu,  3 Sep 2020 17:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9C8s3sg4UYxxU0/rOPZT46lQeT8=; b=HD2lgn
        VgXIs10QMrQRfXxO+N6a6iUscF8sAx3qsOI0C3bTTTCMl6OdEHzWNdOe9GjkwSc4
        97E13f8f3Dm0uDo9ppXBLGKIzq6QSj1E2X877HKtKc6OjGzblenJF8UqSRurL/nK
        vIpK+0rrZho3euw7ZXLhRNkb7WtwKoHkaao4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dL8uFMiSUOYSrO+GmPKqgDJvlNvUBl0d
        3cZpSo9asaLM7yg24Qlw9EGbiLKLFoYFozUs6OskavYshiRkNwMI9vEgtLh1tEzP
        V5YyzHIv/5xscHjS4CdMYBZcP+cxA/Q+cXoAYLGj2aO4KFUdTD/8c0s6MaJVDqQc
        38LUubgkMYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 945E788876;
        Thu,  3 Sep 2020 17:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 201A988875;
        Thu,  3 Sep 2020 17:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Toni <victor.toni@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Aborting git rebase --edit-todo
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
        <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
        <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
Date:   Thu, 03 Sep 2020 14:08:47 -0700
In-Reply-To: <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
        (Victor Toni's message of "Thu, 3 Sep 2020 21:32:09 +0200")
Message-ID: <xmqqtuwe8t5s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8D01A40-EE29-11EA-B66F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Toni <victor.toni@gmail.com> writes:

>> I think the implementor chose the first interpretation.  The "drop"
>> insn is a relatively recent invention, and back when it was missing
>> from the vocabulary, I do not think it was possible to say " discard
>> all the rest" without emptying the todo list, so that design is
>> understandable.
>>
>> Now we have the "drop" verb, the latter interpretation becomes
>> possible without making it impossible for the user to express the
>> former.  It might be a good idea to
>>
>>  (1) save away the original before allowing --edit-todo to edit,
>>
>>  (2) open the editor, and
>>
>>  (3) when getting an empty buffer back, go back to step (2) using
>>      the back-up made in step (1).
>>
>> Either way, the todo list editor buffer can have additional comment
>> instructing what happens when the buffer is emptied.
>>
> Personally I would like to see your approach (1,2,3) implemented
> because it is not destructive. If the user wants to achieve something
> different he can retry.

Obviously I agree that the approach would be nicer than the status
quo.  It would not be as trivial as a microproject, but would be a
good bite-sized starter-task for those aspiring developers who want
to dip their toes in the water to start hacking on the codebase ;-)
