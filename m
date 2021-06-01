Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B900BC47092
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983AF61008
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFAJ4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:56:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55063 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFAJ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 05:56:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36CEDB1898;
        Tue,  1 Jun 2021 05:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CpPNrb77IZGax7y1Z/Ge9rW4+qceqOfOz6t650i2Oik=; b=HmCV
        LsOe1J38ln6hW5yVRkNMoK/DvUZVdCpQMtt61WPOGg8jQAIwjjg4HMMiC7xdn8Iq
        6MnVNvfT/rGdJ8QaUAfBxmiu6wmBM1NemLRcx+KEuWLqWw6IV6LS10TZZncbIFB2
        QAhvaR8kn5fSi2UKwnbp5VuZjwwtt9Ee8VWfqS4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C626B1897;
        Tue,  1 Jun 2021 05:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9EADCB1895;
        Tue,  1 Jun 2021 05:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
        <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
        <xmqqh7ij20l8.fsf@gitster.g>
        <CAOLTT8REM7tF6ojdmnsJt7-RE6a8oX4RFXVcL215YnYTx6b62w@mail.gmail.com>
Date:   Tue, 01 Jun 2021 18:54:51 +0900
Message-ID: <xmqqa6o9ucyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6956D80C-C2BF-11EB-B071-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>>     ... because the host language may not support a NUL in the variables
>>     of its string type.
>>
>
> I agree. But host language not only support NUL but also some Non-ASCII
> character and Non-UTF-8 code:

Yup, rephase with "a NUL" with "arbitrary binary data" and you got
what I meant.  Thanks.

>> > +     const char *s = buf->buf;
>> > +     size_t cur_len = 0;
>> > +
>> > +     while ((cur_len != buf->len) && (isspace(*s) || *s == '\0')) {
>> >               s++;
>> > +             cur_len++;
>>
>> Is NUL treated the same as a whitespace letter for the purpose of
>> determining if a line is empty?  WHY?
>
> Well, there seems to be no correction here. But is it true that memory
> like "\0abc" is considered empty?

That sample has 'a' or 'b' or 'c' that are clearly not part of an
"empty" string and irrelevant.  After all, a string " abc" is not
treated as empty in the original implementation, either.

You are treating a block of memory with e.g. " \000 " (SP NUL SP) as
an "empty line" just like you do for "   " (SP SP SP), but I think we
should treat it more like " \001 " or " \007 ", i.e. not an empty
string at all.
