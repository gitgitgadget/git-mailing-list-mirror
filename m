Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230872082F
	for <e@80x24.org>; Tue, 18 Jul 2017 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdGRTib (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:38:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751443AbdGRTia (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:38:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D712479743;
        Tue, 18 Jul 2017 15:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZP0PJ+0M3Iap6JuociBrK/eUvTE=; b=xqB+ml
        M9vTPeouzIhg4VQ/7hPX7g8DDgowi7JsrJhqGmukTtTh4gtBiS1H/eDOp6MNTKel
        etAKnvR53LQCRD7uH0T6WhcSFbGJ5DZsgn8jJdQyk/0R67dxdoy+Vl6je4xFxKIU
        J5q/zaJ30HLLXeYfcfSg/AdJ9BV8WIGsy3u+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xpo59HmY8PkPoug146y7ZVm4NucpBQfD
        Y0OLzwSWIfUOx8MFU0d4Dym6V5691xPfWTXfjSZ0lCr1HYuuQx6HNRNY4baVePMN
        mRovUongXRX6fC093e1FgSMjtIzJ8S+LN6/JPvvlXd8PKBM+7zv5eNGm9KKEEZfj
        92VlTwHYlko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D022E79742;
        Tue, 18 Jul 2017 15:38:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14A0779740;
        Tue, 18 Jul 2017 15:38:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] t8008: rely on rev-parse'd HEAD instead of sha1 value
References: <20170718002020.14309-1-sbeller@google.com>
        <xmqqwp75o8qi.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbTQ=eSoDCRFTt_B3kjDbWZDkcPwc3fMvhd8dEKPWr-8A@mail.gmail.com>
Date:   Tue, 18 Jul 2017 12:38:21 -0700
In-Reply-To: <CAGZ79kbTQ=eSoDCRFTt_B3kjDbWZDkcPwc3fMvhd8dEKPWr-8A@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Jul 2017 12:22:35 -0700")
Message-ID: <xmqqk235o7rm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9122D4A-6BF0-11E7-BA50-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jul 18, 2017 at 12:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Remove hard coded sha1 values, obtain the values using 'git rev-parse HEAD'
>>> which should be future proof regardless of the hash function used.
>>
>> Don't hardcoded lengths of the hashes defeat this future-proofing
>> effort, though?  It shouldn't be too hard to do the equivalent of
>> the auto computation of abbreviation in this script, which would be
>> true future-proofing, I guess.
>
> It depends on the definition of future proofing.
> My definition here only included the change of the hash function,
> not the change of display length in git-blame for a small artificial repo
> with 2 commits . These seem to be unrelated, so in case we'd change
> the length of the abbreviated displayed hash, we'd still want to have
> a test to tell us?

The thing is that depending on how these 2 commits hash and share
prefixes, the length needed to disambiguate changes.
