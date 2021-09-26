Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B63C433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F80603E7
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhIZPSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 11:18:08 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:5548 "EHLO
        ext-mx-out001.mykolab.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232009AbhIZPSE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Sep 2021 11:18:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id E46E1B00;
        Sun, 26 Sep 2021 17:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1632669385; x=1634483786; bh=XM2ikgDTRAkMjW9XVfp
        whRI/cnqSivgxqJVRmd0f/cs=; b=B0LZgnFqv1zwRxYJEYhUBqhTmtietHIBoYd
        nZrOsJwUBKeqZK5ooXyOcTHtLfgxrUohTlral5YyxLl2wkVNdNLzrVJQRjw3oJUm
        P+m/wuzkG1C4VN39W0faeX+WHSxCmVKUtgAZxX+nh+0rn7532ffoXP3w0zotLM2r
        lZOhcPEMMOg6ED03qkkP40enGRC03NWD02YPMWjGinBm492VbOizYy/N+V6GrJeO
        4/TgAvfFp2t9hJQ3R9pWlbyuo4cX2BJh/fV7viq/R9F7Sc5jvVKYvGwzrC79lvYm
        gsVfFob5mIkfnnm+Mm4bMEGLMguztlImYvYFVqgDSj0IB0LfyNSbH6F6JD24I/7B
        vFmiKL0ZfnI+xRNa5QIqezat9efqlfm3tNG6BmbTqXCNgNpTisr9qV0t1WYGjPyx
        0fhrSkyfTYx7yRDhGEUldFkqyv/4O8EkGQC5BTPkXOIFhWX7tckonETAU/Mwhqpv
        JzbEt9gaaG0lrUMZHReibXB8T6LQ4KlMpmdolL63BI1HWA8D8RpJfrERfd1mUAjj
        U2bpu4eQf9FXofNZVrfKXRDsNK4ma9q59d4xBoDen3y87mH2rCryA2YujemPaALe
        LsvSegXSN0SNJWs3FYtUkwt7TqrROr/Lz2DDmYbw4fjgOJU08bBjW3PiXHwqkIwb
        oHYLlsMk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from ext-mx-out001.mykolab.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UePWknF2HKjc; Sun, 26 Sep 2021 17:16:25 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 46513443;
        Sun, 26 Sep 2021 17:16:25 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 6296E8BA;
        Sun, 26 Sep 2021 17:16:24 +0200 (CEST)
Subject: Re: [PATCH] connect: also update offset for features without values
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <xmqq4kabyoo3.fsf@gitster.g> <YUzzwCwlR9AwSeOD@coredump.intra.peff.net>
 <xmqqr1dfx8lm.fsf@gitster.g> <YUz5dPB6/jFmdSRU@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <e1395ff2-e697-83b2-082b-d5468b7a11ac@ahunt.org>
Date:   Sun, 26 Sep 2021 17:16:22 +0200
MIME-Version: 1.0
In-Reply-To: <YUz5dPB6/jFmdSRU@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/09/2021 00:02, Jeff King wrote:
> On Thu, Sep 23, 2021 at 02:52:53PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> I think the problem is that our fake upload-pack exits immediately, so
>>> ls-remote gets SIGPIPE. In a v0 conversation, ls-remote expects to say
>>> "0000" to indicate that it's not interested in fetching anything (in v2,
>>> it doesn't bother, since fetching would be a separate request that it
>>> just declines to make).
>>
>> Ah, Makes sense---the usual SIGPIPE problem ;-)
> 
> Yes, though it definitely took some head-scratching for me to see where
> it was. ;)
> 
> Doing: "./t5704-* --stress" made it pretty clear. It fails almost
> immediately, and mentions SIGPIPE (well, exit code 141, but by now I
> have that one memorized).
> 
>>> This seems to fix it:
>>>
>>> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
>>> index 34538cebf0..0983c2b507 100755
>>> --- a/t/t5704-protocol-violations.sh
>>> +++ b/t/t5704-protocol-violations.sh
>>> @@ -40,7 +40,7 @@ test_expect_success 'bogus symref in v0 capabilities' '
>>>   			test-tool pkt-line pack-raw-stdin &&
>>>   		printf "0000"
>>>   	} >input &&
>>> -	git ls-remote --upload-pack="cat input ;:" . >actual &&
>>> +	git ls-remote --upload-pack="cat input; read junk;:" . >actual &&
>>>   	printf "%s\tHEAD\n" "$oid" >expect &&
>>>   	test_cmp expect actual
>>>   '
>>
>> Yup.  In the original thread there was some further back-and-forth
>> about further improving the test, if I recall correctly; has the
>> issue been settled there, or is everybody happy with the above
>> version?
> 
> I think the change I showed earlier (to use ls-remote --symref) is worth
> doing. There was lots of discussion about how to format a tab, but in
> the end I don't think it really matters.
> 
> So here's that patch again, with this race fix on top, which could be
> squashed in, and then I hope we can call it good.

Thanks again for doing the actual work - I'll send out a V2 with your 
changes squashed in, along with an attempt at improving the commit 
message (as discussed in reply to Taylor's comments).

> 
> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
> index 34538cebf0..bc393d7c31 100755
> --- a/t/t5704-protocol-violations.sh
> +++ b/t/t5704-protocol-violations.sh
> @@ -35,13 +35,15 @@ test_expect_success 'extra delim packet in v2 fetch args' '
>   test_expect_success 'bogus symref in v0 capabilities' '
>   	test_commit foo &&
>   	oid=$(git rev-parse HEAD) &&
> +	dst=refs/heads/foo &&
>   	{
> -		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
> +		printf "%s HEAD\0symref object-format=%s symref=HEAD:%s\n" \
> +			"$oid" "$GIT_DEFAULT_HASH" "$dst" |
>   			test-tool pkt-line pack-raw-stdin &&
>   		printf "0000"
>   	} >input &&
> -	git ls-remote --upload-pack="cat input ;:" . >actual &&
> -	printf "%s\tHEAD\n" "$oid" >expect &&
> +	git ls-remote --symref --upload-pack="cat input; read junk;:" . >actual &&
> +	printf "ref: %s\tHEAD\n%s\tHEAD\n" "$dst" "$oid" >expect &&
>   	test_cmp expect actual
>   '
>   
> 
