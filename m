Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D02EC433E6
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB27F64ED7
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448832AbhCCGgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:36:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60574 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355204AbhCCG1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 01:27:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80F10B8DF6;
        Wed,  3 Mar 2021 01:26:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JJWAAz6177pyW3D1j8C0hV79C6s=; b=BU4OrT
        SUfi5FVSKhrHRvd+3jaH7x5gTPYBVApV/0sH/jQU6pbXYNQNoTfgQlp8ffPCynY0
        eb/4Fi1KzqWMhK/zGkH66aCN3PqYWBg+FbLJRhDv7oIh1RYovlgcMRaz65UNyM6W
        TBHrZpNtAYFHmhiUjX/ejxXyISqFZ/lUaQKQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DKskMIEcNW9/ZrQx90MocdjFS+GsB4dk
        HLoFnYWVcA/Qd/tENSNIKanJuJMzdwTI08xBqL1s0b0irmVqn3QE5jiNfVoWkZa8
        gZdPGBAYINsZqMkK0/xhbwJYNaKJZab2argKPDA4e4law6Mrol04ZohFhxvbYurd
        ar744h9AYrk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 685D8B8DF4;
        Wed,  3 Mar 2021 01:26:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8220B8DF3;
        Wed,  3 Mar 2021 01:26:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/6] sequencer: export subject_length()
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-2-charvi077@gmail.com>
        <CAPig+cSaZ+i+2P0x67BiHLxAGZaggNFK=dHxLJkmOfY8uafS5g@mail.gmail.com>
Date:   Tue, 02 Mar 2021 22:26:24 -0800
In-Reply-To: <CAPig+cSaZ+i+2P0x67BiHLxAGZaggNFK=dHxLJkmOfY8uafS5g@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 1 Mar 2021 15:25:23 -0500")
Message-ID: <xmqqv9a8lpm7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 618B139E-7BE9-11EB-AEBC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>> This function can be used in other parts of git. Let's move the
>> function to commit.c.
>>
>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>> ---
>> diff --git a/commit.h b/commit.h
>> @@ -165,6 +165,9 @@ const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
>> +/* Return length of the commit subject from commit log message. */
>> +size_t subject_length(const char *body);
>
> Now that this function is public, is the name too generic? Most other
> functions in this header have "commit" in the name. So,
> commit_subject_length() might be one possibility (assuming the current
> name is too generic).

Thanks for being a careful reviewer, as always.
