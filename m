Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87477C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AC52073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M16UVy14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfLDTr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:47:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57512 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 14:47:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 810A78ECC7;
        Wed,  4 Dec 2019 14:47:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t12zv/PRGreozYt+waaMWMfRS7w=; b=M16UVy
        14xLB3dNyr1BBTf3PMnuQe03UN6pq4kWO6Kw59UxH3/mSe9ksgPA3JzyJuCGDlYZ
        4qRtqX1iAp3Elf1SlJRXlQy0LwW3jHMXdrRLM0jktjXsIg2uuvb48YFgffzl1VZh
        yRo7ReVTx9jFU48TNosUmMWqVKDKwZq00lMiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k399EVY3a5uhFEuL5Dox1IKb8zgApfSl
        xyUWVh/yEkAzL8zi2ufHL3zaj1rJg+bsDdRt+eCgCuipkqPsADIZSw37hnYp64MT
        YUK3HSSczinZjExA4suPgGnkCD47YzaPH/Eb9lqbHv/zil/FsFRDsP7PwGK/Fk1C
        roT7tpQyVYI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7888F8ECC5;
        Wed,  4 Dec 2019 14:47:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BFE98ECC4;
        Wed,  4 Dec 2019 14:47:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] revision: free topo_walk_info before creating a new one in init_topo_walk
References: <20191122083704.29267-1-mh@glandium.org>
        <20191122083704.29267-2-mh@glandium.org>
        <46c47a21-d0e1-296f-5563-ae29597f995c@gmail.com>
        <xmqqsgm4yq0m.fsf@gitster-ct.c.googlers.com>
        <ba4095d7-e142-c9a4-ea41-04789be84d0b@gmail.com>
Date:   Wed, 04 Dec 2019 11:47:23 -0800
In-Reply-To: <ba4095d7-e142-c9a4-ea41-04789be84d0b@gmail.com> (Derrick
        Stolee's message of "Wed, 4 Dec 2019 13:55:20 -0500")
Message-ID: <xmqq7e3b50vo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E564DB5E-16CE-11EA-BE26-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/1/2019 11:22 AM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>>> In general I like this change. I'm happy that this was split into a
>>> method instead of crammed into the block of the "if" below.
>>>
>>>> +	clear_author_date_slab(&info->author_date);
>>>
>>> The only issue I have is that the author_date slab should not be
>>> cleared. That is used by more than the topo-walk AND the values for
>>> author dates will not change between subsequent revision walks. Just
>>> drop that line and we should be good to go!
>> 
>> Hmph, isn't this merely a performance thing, or would a slab that
>> was once cleared never repopulate upon its second use (i.e.
>> affecting correctness)?
>
> Yes, this is only a performance thing. If you think it is safest to
> clear it here, then it can stay.

Let's keep what is already in 'next' ;-) and possibly follow-up with
a separate patch to remove this line, justfying the change as
performance improvement.

Thanks.
