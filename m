Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3CC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7296A20771
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r4f4yzix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHKSiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:38:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54040 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSiO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:38:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EDBDF25AC;
        Tue, 11 Aug 2020 14:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S1gANu0jVkuENjx+gKc+Ys4P5s8=; b=r4f4yz
        ixj0mQwHBG9F/eu9ufD542DGwOZIzF4CfjadgJA/kXYWuERTEs4vfyLJ/QcWfDZr
        zM+hWFht9gfxnwxJZxfUP4AmyvFLxnV+CjbOJ2CkVuPKYqbhHBxlIxnWebze/VUe
        XkVy7MQcawRliOBdsZVlNhwyEEoErWDpZiXDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u3e7wp/jHthOjnNwdi52tvph1TCyjhTr
        zxo2jPjZWSzDR1JG8s6S9zEKPTw4VuJUf6ExewjCEL+deGA4WSb3XfdKN2LDXD6T
        Zm6kVUCw9tyKFHBB24JrrJdtH55aaQH7oxgUFM0ybpebglpprRIjGV4DZ+JLB1YB
        UzWqklZM9S8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27290F25AB;
        Tue, 11 Aug 2020 14:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67B7DF25AA;
        Tue, 11 Aug 2020 14:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
        <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
        <xmqqh7tjv6hb.fsf@gitster.c.googlers.com>
        <xmqq1rklrhle.fsf@gitster.c.googlers.com>
        <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
        <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
        <CAFQ2z_OgNQKZ23gNB9=LqPn2M=WKL2vPQQpxm3drRWeN1sxH_A@mail.gmail.com>
        <xmqqk0y6cwst.fsf@gitster.c.googlers.com>
        <CAFQ2z_NMH75mewQyvN=NnjYR059ut3jfJLH_GPuiMA0ehyzBrQ@mail.gmail.com>
Date:   Tue, 11 Aug 2020 11:38:06 -0700
In-Reply-To: <CAFQ2z_NMH75mewQyvN=NnjYR059ut3jfJLH_GPuiMA0ehyzBrQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 11 Aug 2020 12:49:59 +0200")
Message-ID: <xmqq5z9pav01.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD39499A-DC01-11EA-9949-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Aug 10, 2020 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Han-Wen Nienhuys <hanwen@google.com> writes:
>>
>> > Dealing with FETCH_HEAD generically isn't possible unless we extend
>> > the API of the ref backend: the generic ref_store instance doesn't
>> > offer a way to get at the path that corresponds to FETCH_HEAD, so we
>> > can't handle it in refs_read_raw_ref(). In the current reftable
>> > series, FETCH_HEAD is dealt with in the backends separately.
>>
>> I am not sure what the best way would be, but I do not think any
>> existing code writes into it using the refs API at all, even though
>> it may be read only for the first object name using the refs API.
>>
>> And I am not sure if we want to extend the write side API so that
>> the callers can express the full flexibility of that single file.
>
> That's not what I am getting at. I am just interested in how to handle
> FETCH_HEAD in refs_read_raw_ref.
>
>> So perhaps the best way forward would be to ensure that anybody who
>> tries to read from FETCH_HEAD using the ref API reads the first
>> object name in it from $GIT_DIR/FETCH_HEAD file as we've always done
>> since the beginning of time, regardless of what ref backend is used,
>
> Right, but how do we get at the value of $GIT_DIR given a struct
> ref_store? We can either push that out to the ref store backend,
> because each backend knows what $GIT_DIR is, or we can make $GIT_DIR a
> property of the generic ref_store.
>
> I suppose it's cleaner to make the latter API extension.

Yup.  Sounds like the right direction to go.

Thanks.
