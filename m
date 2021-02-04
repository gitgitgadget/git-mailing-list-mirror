Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF029C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9638464F9C
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBDWlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:41:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50136 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBDWlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 17:41:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA177124080;
        Thu,  4 Feb 2021 17:40:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZOgUJz0tWKuPJAusmvjKpzo9oAo=; b=G/M6Oz
        SRle5w0Zk5Ou3f3pObSBR6E1Db65g6Opx/SpYZ8SaBYIoFvUgA+DQcI6/nfnhVNF
        L1PrviX/Ra/Hd1myonxjmVgbjOR04x96iB24BbhRKuGUzwN6pNdwqdsGqZbMhVO1
        eAJ4pNHkHIA6BlL7GIocoSIHBUb60iLXYTDrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TLbed0ui+mFHI3Fx0rkq5xrR5pOUDjFs
        ZAnE7ZtZnulyh9lNTstKsfR4UQRrZn+E2gOwruRGpgGlgYijj6OQx/6DWAeVhxJp
        s4iUNg29nhoUv3WJxUjq1+KAZ9YWi8RROg3ILtPEkMSYNS47lSn3cAvVW845ulMv
        /RluZ2B8c1I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C448012407F;
        Thu,  4 Feb 2021 17:40:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1768412407B;
        Thu,  4 Feb 2021 17:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 02/17] chunk-format: create chunk format write API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <814512f216719d89f41822753d5c71df5e49385d.1611759716.git.gitgitgadget@gmail.com>
        <xmqq5z375xxf.fsf@gitster.c.googlers.com>
Date:   Thu, 04 Feb 2021 14:40:20 -0800
In-Reply-To: <xmqq5z375xxf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 04 Feb 2021 13:24:12 -0800")
Message-ID: <xmqq1rdv5uej.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F71597FA-6739-11EB-88B1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +void add_chunk(struct chunkfile *cf,
>> +	       uint64_t id,
>> +	       chunk_write_fn fn,
>> +	       size_t size);
>
> Shouldn't this match the order of members in chunk_info struct?

Nah.  Unless there are other reasons to touch numerous add_chunk()
calls that have already been written (like we find a need to add a
new parameter to the call), I do not think this matters too much.

Thanks.
