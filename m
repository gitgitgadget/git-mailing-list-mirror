Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACEC433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E5E619AA
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhC2UsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 16:48:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54702 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhC2UrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 16:47:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75CCFB84E0;
        Mon, 29 Mar 2021 16:47:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PYQ7KXcAz80UEmd73dJCMt/UAqc=; b=a8jNwb
        pZpP0In/pgIzqyi3vUrFlG4sgkyvrKgACBeL9lLlZ11KmnuZ5T7b449oBNvp5oaY
        oEOq1Gp0dlpIqhdbWERMXfhykq/StFyPXz2LvyrPi9CILHXybdFPGJbLX69SWi4f
        do6U6uDnYqSlftEjglC8owFLr8AnS7n/11aiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z5zPTnyllZ9dTb7z6lwoOR+FG9WNwEbC
        HXgDuG1WH/W5PqL1c9t1qyCVesGFG8qeF+lTLn0HcwEwva0QTW81ACjbjZmyTgNo
        4yjO/r1Cpdc1QUEj5YDUSl0E66omj+TBnrUJI1UicxL+J3rd3+umlyaBbc2lrcJI
        1xyiG+/i11I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D6A0B84DF;
        Mon, 29 Mar 2021 16:47:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8035B84DE;
        Mon, 29 Mar 2021 16:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
        <xmqq5z1cqki7.fsf@gitster.g>
        <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com>
        <xmqqft0fm9uu.fsf@gitster.g>
        <562DCDA0-EAE6-408F-97D7-127689DE5559@gmail.com>
Date:   Mon, 29 Mar 2021 13:47:17 -0700
In-Reply-To: <562DCDA0-EAE6-408F-97D7-127689DE5559@gmail.com> (Atharva
        Raykar's message of "Mon, 29 Mar 2021 13:42:22 +0530")
Message-ID: <xmqq1rbxk7qi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3DE7E52-90CF-11EB-BDC5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

>> Having said that, two further points.
>> 
>> - the "anything but whitespaces and various forms of parentheses"
>>   set would include backslash, so 'component\new' would be taken as
>>   a single word with "[^][()\\{\\} \t]+", wouldn't it?
>> 
>> - how common is the use of backslashes in identifiers?  I am trying
>>   to see if the additional complexity needed to support them is
>>   worth the benefit.
>
> I have refined the regex, and now it is much simpler and does all of what
> I want it to:
>
> 	"([^][)(}{[:space:]])+"

OK, [:space:] is already used elsewhere, so it would be OK.

In practice, the only difference from "[ \t]" (which is used in many
other patterns in the same file) is that [:space:] class includes
form-feed (\Ctrl-L); nobody would write vertical-tab in the code,
and the matching is done one line at a time, so the fact that LF (or
CRLF) is in the [:space:] class does not make a difference anyway.

> I did not have to escape the various parentheses, so I avoided the need to
> handle backslashes separately. The "\\t" was causing problems as well because

If you spelled "\\t" that would have caused a problem of your own
making ;-)

I think what I gave in the message you are responding to was a
single backslash followed by a 't', to let the compiler turn them
into a single HT character, and that wouldn't have had such a
problem---in fact "[ \t]" is used in many other existing rules in
the same file.

Thanks.

