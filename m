Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A33D20323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964932AbdCVRCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:02:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934888AbdCVQ64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 12:58:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22ADA794E2;
        Wed, 22 Mar 2017 12:54:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xJ/ECD1pyWUBUFW41KAVuDIjHMo=; b=kLv1LY
        dKFveM0WQF2O0nOUfd+Hguv2INrgJSt/bmibTnC63RFnwKnBycN1sVDx2YQdDa5J
        UnpLchP97RmMiQAc0x52tabupBuPHExugstzGdhT/ibJbP5QwUQyo7e6Btt/6aXC
        075nLG3NeEZ1d0ltczaB58wFMPfEQJaI6ErD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B403+h4C2vJi1B5IouKJ805buOCXr08D
        P03re4K3w3gb7AgTeiKSsB6xvjAY0DyZK78inlSYrDLtHWi/+BT3LNU9+n5/x2PI
        1hVI54PbL5+ngswPiodVDDrL72d6E9Wj460OFeecs25VZRUIcRQn5jQEGz/Q7ecj
        GWBJAbOGqqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19F76794E1;
        Wed, 22 Mar 2017 12:54:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BC56794E0;
        Wed, 22 Mar 2017 12:54:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
        <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
        <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
Date:   Wed, 22 Mar 2017 09:54:32 -0700
In-Reply-To: <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
        (Alex Henrie's message of "Tue, 21 Mar 2017 23:47:23 -0600")
Message-ID: <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39717EAA-0F20-11E7-B023-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2017-03-21 16:28 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>>  test_expect_success 'log.decorate configuration' '
>>>> -    git log --oneline >expect.none &&
>>>> +    git log --oneline --no-decorate >expect.none &&
>>>>      git log --oneline --decorate >expect.short &&
>>>>      git log --oneline --decorate=full >expect.full &&
>>>
>>> This ensures that an explicit --no-decorate from the command line
>>> does give "none" output, which we failed to do so far, and is a good
>>> change.  Don't we also need a _new_ test to ensure that "auto" kicks
>>> in without any explicit request?  Knowing the implementation that
>>> pager-in-use triggers the "auto" behaviour, perhaps testing the
>>> output from "git -p log" would be sufficient?
>>
>> BTW,
>>
>>>
>>> +static int auto_decoration_style()
>>> +{
>>> +     return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
>>> +}
>>
>> FYI, I fixed this to
>>
>>         static int auto_decoration_style(void)
>>
>> while queuing to make it compile.
>
> No problem. Do I need to submit a second version of the patch with a
> test for `git -p log`?

You do want to protect this "without an option, we default to
'auto'" feature from future breakage, no?

Thanks.
