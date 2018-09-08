Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FE61F404
	for <e@80x24.org>; Sat,  8 Sep 2018 03:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeIHIMs (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 04:12:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56266 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeIHIMs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 04:12:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A21D117E46;
        Fri,  7 Sep 2018 23:28:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=rd/K2FzH8VPzP
        l2w1p0maR0g8SQ=; b=LLoxl82qBY0IfS3cWvk1ltrx2vWb3cg/cuFnI4vua4ndb
        +GQl+0fSwcC+Hjr6CKYrutc4SMwJrw943M82g2mQGnloA8iCLNnSgDV9eyuFEjHZ
        eUeaybDJJQz5KAZ9HQ8vhiiJYantcdO8Wzou35p7AEnjbHyUBri8W/RefbSFvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=OSx6sLI
        hGAp2a8weDAwmxkAuIa5JF8/+OeELfJ5OTQx8NIdOxBckRXdbxUpebqJ59+53MbX
        afILqTd56SPzot2wFQi1uAvJX4rTeKv2L72dCm3TkJ6L+qj25BBrZgaV57tTSoIa
        mAnlWlTky2hgOiGV/UaMBWempeAB7n3OHjcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FAD5117E45;
        Fri,  7 Sep 2018 23:28:44 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [96.240.145.194])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B215E117E44;
        Fri,  7 Sep 2018 23:28:43 -0400 (EDT)
Date:   Fri, 7 Sep 2018 23:28:41 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
Message-ID: <20180908032841.GK7192@zaya.teonanacatl.net>
References: <20180907232205.31328-1-tmz@pobox.com>
 <20180907235508.GB32065@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180907235508.GB32065@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Pobox-Relay-ID: 49C0C026-B317-11E8-A72B-BFB3E64BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Sep 07, 2018 at 07:22:05PM -0400, Todd Zullinger wrote:
>=20
>> With curl-7.61.1 cookies are sorted by creation-time=B9.  Sort the out=
put
>> used in the 'cookies stored in http.cookiefile when http.savecookies
>> set' test before comparing it to the expected cookies.
>>=20
>> =B9 https://github.com/curl/curl/commit/e2ef8d6fa ("cookies: support
>>   creation-time attribute for cookies", 2018-08-28)
>=20
> According to that commit message, the creation-time sort is only for
> cookies of the same length. But it's not clear to me if that just means
> on-the-wire, and curl always stores by creation-time in the cookie file=
.

Yeah, I didn't dig into the curl code deeply to try and
understand it.  I did test with the only the curl package
downgraded to 7.61.0 to confirm the test worked without
sorting.  And I saw that the curl commit updated existing
tests to sort the test data.

> Either way, though, I guess it wouldn't matter for us as long as we
> choose some arbitrary re-ordering for what curl produces (i.e., the
> output of `sort`) and then make sure our "expect" output is in the same
> order. Which is basically what your patch does. One question, though:
>=20
>> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
>> index 771f36f9ff..538656bfef 100755
>> --- a/t/t5551-http-fetch-smart.sh
>> +++ b/t/t5551-http-fetch-smart.sh
>> @@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookie=
file when http.savecookies set
>>  	git config http.cookiefile cookies.txt &&
>>  	git config http.savecookies true &&
>>  	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
>> -	tail -3 cookies.txt >cookies_tail.txt &&
>> +	tail -3 cookies.txt | sort >cookies_tail.txt &&
>>  	test_cmp expect_cookies.txt cookies_tail.txt
>>  '
>=20
> We pick the bottom 3 before sorting. How do we know those are the three
> we want to see?
>=20
> ...Ah, OK. The lines we are skipping are not actually cookies at all,
> but just header cruft. I wonder if:
>=20
>   grep "^[^#]" cookies.txt
>=20
> would be a better way of doing that, but that is certainly not somethin=
g
> new.
>=20
> So this fix looks fine. It might be worth a comment above the creation
> of expect_cookies.txt to mention it must be in sorted order (of course
> anybody modifying it would see a test failure).

I thought about running the expect_cookies.txt file through
sort as well.  That would ensure that both files were using
the same sorting.  Whether that's needed on any platform
now, I don't know.  Maybe that would be a useful way to
protect against future edits to the expect_cookies.txt file
catching the editor?

I thought there might be a test function to sort the output,
but I was (incorrectly) thinking of check_access_log() which
G=E1bor added in e8b3b2e275 ("t/lib-httpd: avoid occasional
failures when checking access.log", 2018-07-12).

Perhaps it would be useful to have a test_cmp_sorted() to do
the simple dance of sorting the actual & expected.  I
haven't looked through the tests to see how often such a
function might be useful.

>> The in-development version of Fedora updated to the recently
>> released curl-7.61.1 in the past few days.  This isn't
>> breakage from the 2.19.0 cycle, but if the fix looks good to
>> everyone it would be nice to include it.  That way other
>> distributions and users who update git and curl to the most
>> recent releases won't run into this test failure.
>>=20
>> I tested this against Fedora 30 (curl-7.61.1) as well as
>> previous releases from RHEL/CentOS 6/7 (7.19.7/7.29.0) and
>> Fedora 27/28/29 (7.55.1/7.59.0/7.61.0).
>=20
> You're pretty late in the 2.19 cycle, since the release is tentatively
> scheduled for Sunday. Though since this is just touching the test
> script, and since it looks Obviously Correct, I'm not opposed.

Yep, I knew the final was coming very soon.  I would not
have been surprised to see it land tonight while I was
finishing my testing of this patch. :)

I'm certainly covered for the Fedora packages.  It's hard to
say whether there are many other users/packagers who might
upgrade both git and curl and run into this.  So it may not
be worth even a small risk of making the change at this
point.

On the other hand, the change only affects one test and may
be safe enough to apply.  I'll leave that choice in the
capable hands of our maintainer and the good folks here.

Thanks for a thoughtful review, as always.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
That which seems the height of absurdity in one generation often
becomes the height of wisdom in the next.
    -- John Stuart Mill (1806-1873)

