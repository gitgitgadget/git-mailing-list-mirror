Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F991F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 04:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLEnP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 23:43:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59480 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLEnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 23:43:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEFD719922;
        Mon, 11 Nov 2019 23:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=erz8vU1PWc/knpUWwPJZWMSwN+Y=; b=WBlWeA
        J7SlYYkbcESmLASakjZij2SiKM9XZyhOMkRRUM6VeF2mFJkqeQwS70kFu8VAS+Gn
        VgOqeum8uxbkJ6pl+AspETDa3/qlLKVcxAk+x2njEY2vPmVGW3u63CZXxAqm5OXp
        phjXRN+VHRBY+8OUrd1swaNwyehUhrOJCSxEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wjgZoJgzNmElq6Lb7Zs1rNimDV0kgyUD
        TjylxrnAJ2oGjtpA1gF98g3OPPLaGErjF9EFRsnbwGassuGG56sb4QmbWSNFfhTv
        Yj2fuBksToncv3WXbmAfZBjNinSbBCJQ7xone/z3P7BKJoY7FGXe2UZ/Le3h6/+H
        3XQB5qw9eMk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B524919921;
        Mon, 11 Nov 2019 23:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BD5619920;
        Mon, 11 Nov 2019 23:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Josh Holland <anowlcalledjosh@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] userdiff: support Python async functions
References: <20191111010148.2812-1-anowlcalledjosh@gmail.com>
        <f8a729c6-7b27-cac8-815e-b5c02a5c7b44@kdbg.org>
Date:   Tue, 12 Nov 2019 13:43:10 +0900
In-Reply-To: <f8a729c6-7b27-cac8-815e-b5c02a5c7b44@kdbg.org> (Johannes Sixt's
        message of "Mon, 11 Nov 2019 18:27:24 +0100")
Message-ID: <xmqqtv79g0wx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEB9CF5E-0506-11EA-9D07-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> ...
>> @@ -0,0 +1,4 @@
>> +def RIGHT(pi: int = 3.14):
>> +    while True:
>> +        break
>> +    return ChangeMe()
>
> Thank you for providing test cases for Python.
>
> I have one gripe with this set of test, though: They do not demonstrate
> that the Python-specific pattern is better than the default pattern. In
> fact, if you remove the Python patterns from userdiff.c, you will
> observe that these tests still pass.
>
> The one thing that the language specific pattern would do better than
> the default is that it picks up indented text. Could we have a test case
> or two that show that it indeed does?

Good point.  A method "def" inside a "class" would be one level
indented; I am not sure if it is a kosher style to have "if" at the
unindented top-level, whose body conditionally defines a "class",
but such a class definition would also be indented, I guess.

Thanks.

