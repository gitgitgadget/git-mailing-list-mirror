Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B84DC433E5
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4896961A31
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCYS0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:26:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55580 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYSZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 14:25:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 322FAC65C2;
        Thu, 25 Mar 2021 14:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oqKrNZGdVigDCIzTInowd1remAQ=; b=dT1iTy
        sVyBq7AeO7dPlq6a5BlHqLPJVXPvylRB8dCfzGUfuelx3owuLAo0TixN5DifnN6f
        nOyNaPJbONIsAaOaieXJhqeFEutj7uZFTA+mB86josn1NsXiBTstlBdtaKGW8ECE
        CYiVDuZKVAVwQjYN4xAoVa+OyI58Gcb/LakHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k54eIpe7hRGGwRmeErMgU5O8wWqufj4R
        IcO6lRcQU3zXtwys/2yEXaCwBVcLZqArTXvLJEHxxCI2RVpjYruvDsDeYzG0hKmk
        C04xLui5GFNsHwmWoeGDeCJtUQocUXG9lJFQ1ncKdTkAYHSCazmHPCrSEuzpTeoQ
        Y/H48k5docM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2954FC65C1;
        Thu, 25 Mar 2021 14:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A19D2C65C0;
        Thu, 25 Mar 2021 14:25:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-format-patch: Document format for binary patch
References: <20210324123027.29460-1-bagasdotme@gmail.com>
        <20210324123027.29460-3-bagasdotme@gmail.com>
        <xmqqa6qszbdv.fsf@gitster.g>
        <678c0fa9-8ae5-f8ae-b93a-3d68c7c11c8f@gmail.com>
Date:   Thu, 25 Mar 2021 11:25:48 -0700
In-Reply-To: <678c0fa9-8ae5-f8ae-b93a-3d68c7c11c8f@gmail.com> (Bagas Sanjaya's
        message of "Thu, 25 Mar 2021 13:22:37 +0700")
Message-ID: <xmqqft0jw0nn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85A67E84-8D97-11EB-82AD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 25/03/21 00.53, Junio C Hamano wrote:
>> I do not think this is all that useful; it clutters the description
>> for a reader who is not interested in reimplementing an encoder or a
>> decoder from the document.
>> And it is way too insufficient for a reader who wants to reimplement
>> an encoder or a decoder.  For example,
>>   - It does not say anything about what the delta is and how it is
>>     computed.
>>   - The 'z' is redundant; the more important is to say that the
>> first
>>     byte signals how many bytes are on that line and it is a mere
>>     artifact that we cram up to 52 bytes on a line.
>>   - It does not say anything about how the binary patch ensures that
>>     it is reversible (i.e. can be given to "git apply -R").
>> Thanks.
>> 
> Hmmm...
>
> I write this patch from "naive" observation of git format-patch's
> behavior when given binary files in the commit.
>
> Perhaps someone which is more familiar in base85 {en,de}coder and binary
> patch in general can write better documentation than what I send here.

I do not mind reviewing an update to an existing document or a new
document in Documentation/technical/ somewhere, if somebody is
motivated enough to write the details to a degree that would allow
reimplementation of the encoder and the decoder.  I just do not think
it belongs to the end-user-facing document of "format-patch", whose
target is users of the "format-patch" command, not reimplementors of
the command.


