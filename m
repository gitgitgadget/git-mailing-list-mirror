Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E264C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF2C20814
	for <git@archiver.kernel.org>; Fri, 29 May 2020 17:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PfvxoaRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgE2RTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 13:19:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64289 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgE2RTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 13:19:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D61DD5FBF;
        Fri, 29 May 2020 13:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gXeIIKehwIyR+5X6Tz3Smoja2jE=; b=Pfvxoa
        RStjppn7XKoeTWP1h7kFSkuNPMmOAkmba3aaRKXmWfFzfEFPnWT0KtWf6pLWjHt2
        dbn0U8q2af3/SNTmzfX3ktr+MouvcCg0WGTTMB20rJ9vnyodhSj2PXUN0SRG1wdr
        gRG4yOpeCNspnQftwNZdnr5xzIKONH71KUZyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YrKIN5OR7fPyYVreRORIGWmz0M9kC+rj
        JRpPTRAa5a7KSYnfi4Be4kHFFy08mPX9PPWsvIdTxqTb3JQSCNLWD5FvKOhNc4Aa
        4y6tH3rFDtL9j+CfH+36qLJ/GT5AI/xT86dIWOQSBO7dCw+MKsfi7NPc1IJnEDVX
        oYaas03Ma0g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14C35D5FBE;
        Fri, 29 May 2020 13:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40BAAD5FBD;
        Fri, 29 May 2020 13:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: add new --date-format=raw-permissive format
References: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
        <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
        <20200529061346.GB1294228@coredump.intra.peff.net>
Date:   Fri, 29 May 2020 10:19:40 -0700
In-Reply-To: <20200529061346.GB1294228@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 29 May 2020 02:13:46 -0400")
Message-ID: <xmqqwo4uzmj7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95913B30-A1D0-11EA-8F1C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 28, 2020 at 08:40:37PM +0000, Elijah Newren via GitGitGadget wrote:
>
>>      * Instead of just allowing such timezones outright, did it behind a
>>        --date-format=raw-permissive as suggested by Jonathan
>
> Thanks, I like the safety this gives us against importer bugs. It does
> mean that people doing "export | filter | import" may have to manually
> loosen it, but it should be rare enough that this isn't a big burden
> (and if they're rewriting anyway, maybe it gives them a chance to decide
> how to fix it up).
>
>>  fast-import.c          | 15 ++++++++++++---
>>  t/t9300-fast-import.sh | 30 ++++++++++++++++++++++++++++++
>
> Would we need a documentation update for "raw-permissive", too?

Good eyes.  I somehow thought this was an internal option but it
does need to be known by end-users who use the fast-import tool.

>> @@ -1929,7 +1931,8 @@ static int validate_raw_date(const char *src, struct strbuf *result)
>>  		return -1;
>>  
>>  	num = strtoul(src + 1, &endp, 10);
>> -	if (errno || endp == src + 1 || *endp || 1400 < num)
>> +	out_of_range_timezone = strict && (1400 < num);
>> +	if (errno || endp == src + 1 || *endp || out_of_range_timezone)
>>  		return -1;
>
> It's a little funny to do computations on the result of a function
> before we've checked whether it produced an error. But since the result
> is just an integer, I don't think we'd do anything unexpected (we might
> just throw away the value, though I imagine an optimizing compiler might
> evaluate it lazily anyway).

True, but if it is easy to make it kosher, we should.

	if (errno || endp == src + 1 || *endp || /* did not parse */
	    (strict && (1400 < num)) /* parsed a broken timezone */
	   )

perhaps?

>> +test_expect_success 'B: accept invalid timezone with raw-permissive' '
>> +	cat >input <<-INPUT_END &&
>> +	commit refs/heads/invalid-timezone
>> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
>> +	data <<COMMIT
>> +	empty commit
>> +	COMMIT
>> +	INPUT_END
>> +
>> +	test_when_finished "git update-ref -d refs/heads/invalid-timezone
>> +		git gc
>> +		git prune" &&
>
> We check the exit code of when_finished commands, so this should be
> &&-chained as usual. And possibly indented like:
>
>   test_when_finished "
>     git update-ref -d refs/heads/invalid-timezone &&
>     git gc &&
>     git prune
>   " &&
>
> but I see this all is copying another nearby test. So I'm OK with
> keeping it consistent for now and cleaning up the whole thing later.
> Though if you want to do that step now, I have no objection. :)

Sure.  Another alternative is to make it right/modern for only this
added test---that makes the inconsistency stand out and gives
incentive to others for cleaning up after the dust settles when the
patch gets merged to the 'master' branch.

> I also also suspect this "gc" is not useful these days. For a small
> input like this, fast-import will write loose objects, since d9545c7f46
> (fast-import: implement unpack limit, 2016-04-25).
>
> TBH, I think it would be easier to understand as:
>
>   ...
>   git init invalid-timezone &&
>   git -C invalid-timezone fast-import <input &&
>   git -C invalid-timezone cat-file -p master >out &&
>   ...
>
> and don't bother with the when_finished at all. Then you don't have to
> wonder whether the cleanup was sufficient, and it's fewer processes
> to boot (we'll leave the sub-repo cruft sitting around, but a single "rm
> -rf" at the end of the test script will wipe them all out).

Nice.

