Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A12E1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbcLJWLt (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 17:11:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59458 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752942AbcLJWLs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 17:11:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E82CA556A9;
        Sat, 10 Dec 2016 17:11:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uI9wc1M0CBG2WeyMUlUNRf5GWj0=; b=DZ3Apc
        zWH7hbAPOR2CKifFGFmXeFlg/+eVASNlDPa2ZrHecCYL7Rnk0MUv/ZzFZLekWECN
        le9c69CFjTaZXSMxkWtRTPoY5RbU9pkLTpfigciNrL565Lf7BE8VfCAT1S/ZF6o9
        BH6MWVv3RTgZQStKQFrXujGbPmGL0l2e2YMzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PYnCgEmpmGNh5MuOpFj2VaCjrO4wIrLJ
        kG2fYbNMMzJjAl+QoaUBgYwsFUQAMJuF45yaPVnTZZZi9Tx9y7AZUx08fhwb+7Np
        oC/9Zna8CymbuygWXtvVwBzvkmAGtgxJsSICwdQMILv6jSy9SFjEuMo5R2y3VBTS
        phXczh2KY3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF1E1556A8;
        Sat, 10 Dec 2016 17:11:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54E5B556A7;
        Sat, 10 Dec 2016 17:11:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
References: <20161209203449.17940-1-sbeller@google.com>
        <xmqqfulwraq2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaqw=XqrNF5+Ta8CwcD7FyA853UQUdMxHmBAaMHPMHrXg@mail.gmail.com>
        <xmqqshpwpsn8.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZKify7VLfNp3FXXvc4UOGjdXfUaspNaeW0t5+hWc+cpw@mail.gmail.com>
Date:   Sat, 10 Dec 2016 14:11:46 -0800
In-Reply-To: <CAGZ79kZKify7VLfNp3FXXvc4UOGjdXfUaspNaeW0t5+hWc+cpw@mail.gmail.com>
        (Stefan Beller's message of "Fri, 9 Dec 2016 15:56:17 -0800")
Message-ID: <xmqqtwabo2n1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A45CAEEC-BF25-11E6-9FA8-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Dec 9, 2016 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> So you are suggesting to
>>> * have the check later in the game (e.g. just after asking
>>>    "Send this email? ([y]es|[n]o|[q]uit|[a]ll): " as then other information
>>>   such as additional @to @cc are available.
>>
>> Yeah, probably before the loop starts asking that question for each
>> message.  And hook does not necessarily need to cause the program to
>> die.  The question can be reworded to "Your hook says no, but do you
>> really want to send it?",
>
> You could, but...

Yes, "does not necessarily need to die" is different from "hence you
must avoid dying".  Running the hook before you start the loop to
ask for each message merely makes it possible to avoid dying.
