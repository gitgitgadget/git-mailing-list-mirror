Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EEC433E6
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A03A20872
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WoB70W5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgH0Xgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:36:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61916 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0Xgr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 19:36:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9E1375EF1;
        Thu, 27 Aug 2020 19:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qqiE6+6YuwA5l8eHon0ZMspKOqA=; b=WoB70W
        5ctK6k1ZIn2EMcs166yUWtyPVSmcHFcyugUTgOcNp0qT/ADt+5cgtskVO6YXUK6f
        srgsiT3GIUWqtdaJwckRaaG4LyagXheXCYlB2naZNY+P8oNlpDsIHfRTCBotPDYG
        wai7NrB7L8rh4vmxUNDP7ur0grOl25m2kT958=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s03vWIPe4JwFBIwVAO2DQMCBGBLKI7Cy
        gRjSDQY1Rdvs0Xeg0mwpjgSkNVr15eUH4I7m39RvHWzC4qXRZkEtT/FINtrUfrSP
        UDvAiIkkPr+7oh782sdxc4C7bU0UeYb2qImfgUO1Z+l77vApzcOWKV5ffeyApA9y
        fcUSUC1HZ0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1DCC75EF0;
        Thu, 27 Aug 2020 19:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6798175EEF;
        Thu, 27 Aug 2020 19:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
        <20200827233454.GA3973432@coredump.intra.peff.net>
Date:   Thu, 27 Aug 2020 16:36:43 -0700
In-Reply-To: <20200827233454.GA3973432@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Aug 2020 19:34:54 -0400")
Message-ID: <xmqqzh6foe44.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A9A0692-E8BE-11EA-9DDB-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 27, 2020 at 02:43:02PM -0700, Junio C Hamano wrote:
>
>> * tb/repack-clearing-midx (2020-08-26) 1 commit
>>   (merged to 'next' on 2020-08-27 at a465875cbb)
>>  + builtin/repack.c: invalidate MIDX only when necessary
>> 
>>  When a packfile is removed by "git repack", multi-pack-index gets
>>  cleared; the code was taught to do so less aggressively by first
>>  checking if the midx actually refers to a pack that no longer
>>  exists.
>> 
>>  Will merge to 'master'.
>
> This seems to break t7700 when run with midx support:
>
>   $ git checkout e08f7bb093
>   HEAD is now at e08f7bb093 builtin/repack.c: invalidate MIDX only when necessary
>
>   $ make && (cd t && GIT_TEST_MULTI_PACK_INDEX=1 ./t7700-repack.sh -i)
>   [...]
>   + git repack -a -d
>   Enumerating objects: 10, done.
>   Counting objects: 100% (10/10), done.
>   Delta compression using up to 16 threads
>   Compressing objects: 100% (5/5), done.
>   Writing objects: 100% (10/10), done.
>   Total 10 (delta 1), reused 10 (delta 1), pack-reused 0
>   fatal: error preparing packfile from multi-pack-index
>   error: last command exited with $?=128
>   not ok 6 - packed obs in alt ODB are repacked when local repo has packs
>   #	
>   #		rm -f .git/objects/pack/* &&
>   #		echo new_content >>file1 &&
>   #		git add file1 &&
>   #		test_tick &&
>   #		git commit -m more_content &&
>   #		git repack &&
>   #		git repack -a -d &&
>   #		test_no_missing_in_packs
>
> I didn't look into whether it's a bug in the actual code, or just a
> weird interaction with the way GIT_TEST_MULTI_PACK_INDEX triggers
> git-repack to write a midx. But either way we should figure that out
> before it graduates.

Thanks for stopping us ;-)
