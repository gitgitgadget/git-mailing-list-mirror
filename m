Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A281FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbcLMGj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 01:39:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60435 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbcLMGjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 01:39:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 864B159FA2;
        Tue, 13 Dec 2016 01:39:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+2Z30iYng0m1jV+qJyA31xqg+F4=; b=FvvcIW
        ZyCNWPmTU+Jd39NwLaaU0S9dutfHdz9awivpjnu8UemxAdROZsABefp/hh1dWU0X
        Xw1UTh301JESIwUkuIWz3HTGGqu+2K/oB88m6FtYJo+ZaSKVkmfJAlDEF30+7t2f
        TwjzKmX2P4Rs2AngN1p+fMo1Wblt7n4Evqlq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aMmSpYJv/yUkzadMKvH6Uhnfa1bMRVsf
        qWtgliV8n6Kij5owQ+BCnz9VLxx3orqI60ZSt/YdLYClONX1dHr/WLRy8clauqyF
        FL37ewRjCQOK3kjbOuS4HZ83HZQjrS5lcexbDh54dPD4vADjFB4COMkTP7KBpVHn
        UEb00Qhbrcs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DE4E59FA1;
        Tue, 13 Dec 2016 01:39:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFDDB59FA0;
        Tue, 13 Dec 2016 01:39:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/4] real_path: have callers use real_pathdup and strbuf_realpath
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-5-git-send-email-bmwill@google.com>
        <xmqqzik07pin.fsf@gitster.mtv.corp.google.com>
        <xmqqfuls7lri.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbYAyGwTb7AkymoaMo+TPGVRiv8kn00fXGS=S_ZVFG0Jw@mail.gmail.com>
        <20161213011529.GC193413@google.com>
Date:   Mon, 12 Dec 2016 22:39:52 -0800
In-Reply-To: <20161213011529.GC193413@google.com> (Brandon Williams's message
        of "Mon, 12 Dec 2016 17:15:29 -0800")
Message-ID: <xmqq7f7472o7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4ADAE98-C0FE-11E6-833D-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 12/12, Stefan Beller wrote:
>> On Mon, Dec 12, 2016 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Junio C Hamano <gitster@pobox.com> writes:
>> >
>> >> Brandon Williams <bmwill@google.com> writes:
>> >>
>> >>> Migrate callers of real_path() who duplicate the retern value to use
>> >>> real_pathdup or strbuf_realpath.
>> >>
>> >> Looks good.
>> >
>> > This has small non-textual conflicts with Stefan's embed^Wabsorption
>> > topic; please holler if you spot my mismerge.  Thanks.
>> 
>> 5f6a003727 (Merge branch 'bw/realpath-wo-chdir' into jch)
>> looks good to me.
>
> Looks good to me as well.

Thanks.
