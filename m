Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5327CC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170CD20792
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Py0lh3yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFKSS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:18:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50367 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgFKSS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 14:18:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5337AD1DDD;
        Thu, 11 Jun 2020 14:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DXA4DLO107h1oH5r6qpI/73WJ64=; b=Py0lh3
        yVnORoBpSADb0cXRu9jdtWH7UwgonUl2BXv/7HFhUERR9pZorq/Nu3GQIdxtR3DF
        76bxv7Eorn4Bs+d7xuiqKGRoONqE29LNDipFytTUFtB6M1Ldu4+EKALRmw20o875
        ykcfdQH2ZfnfE6EmLSQ4xTSoFBD7K0CQds7FU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tRGgjdbDwSbUB0cA4F0QfZCUv1ElrRas
        Jw3rqo915Jwm0qfF/0RGjDGlg412pcpP/4eWN+PmJmyzPLCcHRy/HMMHgmM5ZEfm
        pOaOnEfSCqT+02Rw1Uh8Xwk3FZZPuHgwpG4EgH4pDHZlGNMZHWbzte/NWB/RfUUQ
        FCxkkgwJVb8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C83ED1DDC;
        Thu, 11 Jun 2020 14:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 168D8D1DDB;
        Thu, 11 Jun 2020 14:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <xmqqtuzha6xn.fsf@gitster.c.googlers.com>
Date:   Thu, 11 Jun 2020 11:18:17 -0700
In-Reply-To: <xmqqtuzha6xn.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 11 Jun 2020 09:44:20 -0700")
Message-ID: <xmqqimfxjwk6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED214270-AC0F-11EA-A49F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index 85868162ee..a306a60d25 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -497,7 +497,7 @@ static void *anonymize_ref_component(const void *old, size_t *len)
>>  {
>>  	static int counter;
>>  	struct strbuf out = STRBUF_INIT;
>> -	strbuf_addf(&out, "ref%d", counter++);
>> +	strbuf_addf(&out, "ref%d", ++counter);
>>  	return strbuf_detach(&out, len);
>>  }
>>  
>> @@ -522,7 +522,7 @@ static const char *anonymize_refname(const char *refname)
>>  	 * anything interesting.
>>  	 */
>>  	if (!strcmp(refname, "refs/heads/master"))
>> -		return refname;
>> +		return "ref0";
>
> This is obviously wrong.  It should return "refs/heads/ref0".
> ...
> So, I guess we should just fix the patch I am responding to to
> return "refs/heads/ref0" instead of "ref0", and queue it as one of
> the preparatory steps.

... and the follow-up step to become part of the series you are
working on to allow customing what the primary branch is called
would turn the second hunk to

	-	if (!strcmp(refname, "refs/heads/master"))
	+	if (!strcmp(refname, get_primary_branch_name(0)))
			return "refs/heads/ref0";

By the way, with your "two variables" approach to make both the
"default" (for 'init' and 'clone') and the "primary" (for
'fmt-merge-msg' and 'fast-export') configurable, we'd need accessor
function(s) for the primary branch name for the given repository.
The get_primary_branch_name() helper function might want to take a
"struct repository *" argument in addition to "please give me an
abbreviated refname" boolean, given the recent push to pass the
struct to everybody.


