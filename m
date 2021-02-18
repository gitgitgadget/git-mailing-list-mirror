Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3063BC43332
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F291D64E22
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhBRTdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:33:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56466 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhBRT1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:27:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74CC199277;
        Thu, 18 Feb 2021 14:26:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgaXcpD2MoqX7fXghI58ZoXj33I=; b=KfenjL
        X5/xsMDZfPqNUWXBgegaDqnG1CQLZKqCV82TqDNLqq88XRAM18vZXKjH0B9CesiP
        lBq6rOwH/mIaFkfeHkMuZ3gc81H/wPi/smE4YH5sy+Df6EoAE+pmyxnXUXtC8BcM
        9HL6tKJuHbtrVqayoLSkRkQkXxF+Jd0u9mb0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M9gcKVtb/80CUL6gDyWSLPfuhcwXQndc
        8dcC8iCPMeJIkRVd1lpjbk9i4Ll6MJW/QG6cHQO81zarF33r2mKPWpyF3b7lIKS9
        dS/+SY/G7SwITxmpi3hPdoLCw74nYQoOQ/nLigU+vkF9JD+FRFNFAP/ORHAL/lGv
        Sj1aBe6CsqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C95E99276;
        Thu, 18 Feb 2021 14:26:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDA9F99275;
        Thu, 18 Feb 2021 14:26:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/6] t7500: add tests for --fixup[amend|reword] options
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-4-charvi077@gmail.com>
        <xmqqsg5ujwi2.fsf@gitster.g>
        <CAPSFM5cjJ_b510wx+RtVkyxHk-aFDpOHaFRWqQuMuDf=73nBiA@mail.gmail.com>
Date:   Thu, 18 Feb 2021 11:26:41 -0800
In-Reply-To: <CAPSFM5cjJ_b510wx+RtVkyxHk-aFDpOHaFRWqQuMuDf=73nBiA@mail.gmail.com>
        (Charvi Mendiratta's message of "Thu, 18 Feb 2021 15:45:34 +0530")
Message-ID: <xmqqh7m9fa8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3ABC0E72-721F-11EB-A1B5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

>> > +test_expect_success '--fixup=reword: -F give error message' '
>> > +     echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
>> > +     test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
>> > +     test_cmp expect actual
>> > +'
>>
>> Why?  If you can use -m msg, you should be able to use -F msgfile,
>> too, no?
>
> Earlier I was thinking to let the `--fixup=amend:`  use the same options as of
> current `--fixup=` . But yes I agree that there should be  -F option
> also with `amend`
> and `reword`.

Hmph, I was actually imagining the opposite---a context that does
not want to take -c/-C/-F would not want to take -m, either.

Why is -m so special, and a lot more importantly, what would a user
want to achieve by using "-m more-text" combined with this
"--fixup=reword:<commit>" or "--fixup=amend:<commit>" feature?
