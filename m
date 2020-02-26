Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A900C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EC524653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 22:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bk+u+vdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgBZWWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:22:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57901 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgBZWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 17:22:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 805B43B821;
        Wed, 26 Feb 2020 17:22:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6CBU/IJtjqE7Jkna8AuEoqt+aiE=; b=bk+u+v
        di/xlmCmL8na50+dOAp5dyIgHBImDb4aRTVJIihAA4Fr96kEKbhTuH1/5Wnz4Iez
        Go1roIyE8vGjXs6ojFYxUBfMG6or5k1SIwT9UdMxvyDeyYKNcGo6TysUc5w624wu
        H+DT/TjplCr7oj/3aag3kBcXCwPRsHiH0WJ4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PxfxqEksLysWx6jml9kllo8ZEb/oJC93
        InS/ZrcggkZljl43polWSE3m/oARuiO4423b1VsFlWWdUPtxefUJUGaRDd/MYmEr
        FajJ0nSH4PLcbwgNpbdfe6rW0Kmep4nkQrxLIW1iCMv/0fz11ovUSq/xuO3Z0De3
        22yb+rMC0qc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7776F3B820;
        Wed, 26 Feb 2020 17:22:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9F193B81F;
        Wed, 26 Feb 2020 17:22:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
        <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
        <xmqqimjthz8e.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 26 Feb 2020 14:22:10 -0800
In-Reply-To: <xmqqimjthz8e.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Feb 2020 12:26:09 -0800")
Message-ID: <xmqqsgixgfal.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F2B9946-58E6-11EA-9DAC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
>> index 9e16512fe31..4f10057e9f1 100755
>> --- a/t/t5537-fetch-shallow.sh
>> +++ b/t/t5537-fetch-shallow.sh
>> @@ -237,7 +237,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
>>  	git -C "$REPO" config protocol.version 2 &&
>>  	git -C client config protocol.version 2 &&
>>  
>> -	git -C client fetch --depth=2 "$HTTPD_URL/one_time_sed/repo" master:a_branch &&
>> +	git -C client fetch --depth=2 "$HTTPD_URL/one_time_perl/repo" master:a_branch &&
>>  
>>  	# Craft a situation in which the server sends back an unshallow request
>>  	# with an empty packfile. This is done by refetching with a shorter
>> @@ -246,13 +246,13 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
>>  	printf "$(test_oid sed)" \
>
> Hmm, shouldn't the test-oid token "sed" whose value is set up in the
> setup section of this test script also be renamed to "perl"?  Or, if
> we are actively taking advantage of the fact that the syntax of the
> replacement operator is the same between the languages, perhaps "sed"
> is better renamed to something more language agnostic and reflects
> the purpose/reason why we extend the packet header by two bytes with
> the one-time munging process?
>
>>  	       "$(git -C "$REPO" rev-parse HEAD)" \
>>  	       "$(git -C "$REPO" rev-parse HEAD^)" \
>> -	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
>> +	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
>
> Other than that, this step looked quite sensible.  Thanks.

Hmm, is it because you wanted to backport this down to 'maint'
(otherwise, your tests will start failing in a month) that you left
the "test_oid sed" thing untouched?  If so, that makes sort-of
sense.

I expect that the series will be rerolled, if only for s/BSD/macOS/
mentioned elsewhere in the thread, but in the meantime, I'll rebase
them on 'maint' "as a practice" while queuing.

