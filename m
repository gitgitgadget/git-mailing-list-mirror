Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721741F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJKEOF (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:14:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53166 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfJKEOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:14:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F8CA98C7D;
        Fri, 11 Oct 2019 00:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VsY7G6XBStj7JX6b2pY/jvM5DAQ=; b=PFfQkX
        M7zJlJ/MKc0dKgpxFRUman/n17zF98JbYw2BpozL2ObEiMqSKm1zPw/q5hbTSSlD
        vnjUxtT18AF68v/7sTFzRZryVB6d5bPuGNMJlBiA+LfzkOFjc6tYXVMNo3qoO4kg
        JeLAWZrPyIC+hrfO8fri9t+R7sr1wXoMlkaWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b4IXzKR4QytmZs8p2JuxhAQZp/A2DSEP
        /008j5f0UJGUUkXAnvAzpXMO4we9zvwfKOpHK3LrVW5DTP0vODCLJYkGTXzVHDZF
        ve+6WeI+D+/w43XabYcewIRjyIhFh2Xe6iB8vZKkTN7RkvsmqBn5xhjuuwja+UEa
        j7hu9KfXNDA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98A4098C7C;
        Fri, 11 Oct 2019 00:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C492E98C77;
        Fri, 11 Oct 2019 00:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     wambui.karugax@gmail.com, git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined constants to enums
References: <20191010115230.10623-1-wambui.karugax@gmail.com>
        <20191010184439.94173-1-jonathantanmy@google.com>
Date:   Fri, 11 Oct 2019 13:13:59 +0900
In-Reply-To: <20191010184439.94173-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 10 Oct 2019 11:44:39 -0700")
Message-ID: <xmqqsgnzj4vs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E3D1628-EBDD-11E9-B802-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> -	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
>> -	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
>> +	if ((opt & BLAME_COPY_HARDEST)
>> +	    || ((opt & BLAME_COPY_HARDER)
>
> Any reason why the names are renamed to omit "PICKAXE_"? In particular,
> these names are still global, so it is good to retain the extra context.

Absolutely.  Removing them is wrong, I would have to say.

>>  #define BLAME_DEFAULT_MOVE_SCORE	20
>>  #define BLAME_DEFAULT_COPY_SCORE	40
>>  
>> +enum pickaxe_blame_action {
>> +	BLAME_MOVE = 01,
>> +	BLAME_COPY,
>> +	BLAME_COPY_HARDER = 04,
>> +	BLAME_COPY_HARDEST = 010,
>> +};

We had a bit of discussion recently about using (or rather, not
abusing) enum for set of bits on a different topic.

> Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> line but that is not necessary.

That is absolutely necessary; it is not like "we do not care what
exact value _COPY gets; it can be any value as long as it is _MOVE
plus 1", as these are used in set of bits (and again, I do not think
it is such a brilliant idea to use enum for such a purpose).

Thanks.
