Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249271FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbcH2RHS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:07:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53020 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753500AbcH2RHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:07:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3010E37B9C;
        Mon, 29 Aug 2016 13:06:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m+HW5uTHCLnrmMfJa/dqzI1vEX0=; b=pGYXf4
        wfK+kfpGdZd9OjtT8JIXtuSSBmF/g1g5ZGm7y7EimASxbBj5OtoqoMkV24RWnrs4
        2QiMXg0KMXs0WkIU5Te5JtbmJTulUZV2XHTCA8PJ7zSZxbzd1AGjOZzvzA9GMdsE
        jsx6FIfkHNu1/hRg9LU9jidEJ5EIh4KwruGz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RDcPPYW+gAvq+kAeM5dh1sCMwty9hvk8
        ydNsJIidmYLtgK6wgZBDp7ZoZ6KFScGkZtbHMT7BiQdXXL1egpogHoN6OTMsm4gy
        0i6oUWo3ajgRbAQb0ATOwzBENBNL6NEWZRxmlHOzWbId5Noil2jIKiNrEECREC2r
        o8Ad4yhbkhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 279FE37B9B;
        Mon, 29 Aug 2016 13:06:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9335137B9A;
        Mon, 29 Aug 2016 13:06:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 07/27] bisect--helper: `bisect_reset` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe69a-13136cfb-4daa-4f5d-9b56-537adf2c6942-000000@eu-west-1.amazonses.com>
        <xmqq4m69q3b2.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPPfXvLUtcBR6cYAP2dT8FAePFPjDSnVm8BhpLN9cfR1uw@mail.gmail.com>
        <xmqqshtrijdn.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPMBy0Ovcq-pUJkhoLiVF+uvm5fC0PD0RGPKobZ83Ciy3A@mail.gmail.com>
Date:   Mon, 29 Aug 2016 10:06:46 -0700
In-Reply-To: <CAFZEwPMBy0Ovcq-pUJkhoLiVF+uvm5fC0PD0RGPKobZ83Ciy3A@mail.gmail.com>
        (Pranit Bauva's message of "Sat, 27 Aug 2016 16:22:23 +0530")
Message-ID: <xmqqpoorcxnd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8E9B200-6E0A-11E6-ABC2-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>> with the original
>>
>>     case $# in
>>     0)  reset to the branch ;;
>>     1)  reset to the commit ;;
>>     *)  give usage and die ;;
>>     esac
>>
>> and took the difference and reacted "ah, excess parameters are not
>> diagnosed in this function".
>>
>> Your caller does complain about excess parameters without giving
>> usage, and that is what I missed.
>>
>> I am not sure if you intended to change the behaviour in this case
>> to avoid giving the usage string; I tend to think it is a good
>> change, but I didn't see it mentioned in the proposed commit log,
>> which also contributed to my not noticing the test in the caller.
>
> I could include this in the commit message.

Nah, it was something anybody could notice with 2 more minutes of
reading and pondering from the patch text alone.  Not worth spending
more time on the log message on this one.

Thanks.
