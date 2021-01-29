Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2EDC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 02:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2E364DFA
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 02:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhA2Cnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 21:43:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60437 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhA2Cnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 21:43:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 899D4999E5;
        Thu, 28 Jan 2021 21:42:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cVKXo8so3hbTcHcd9L2xk1wlKYU=; b=iPdHAC
        /nUKilQlnZRPZqUcyT5PkKG8G2OjG6YVoIbJx2alzUcPrQRZpn9vQaoZQkDnkDFx
        eIjsqv/F5AoC7DkpsKKSx7VixVLWWD+Vn0cYxq4SBx8W08m4U+lIcvZa1UseDrE4
        e5bjPGk1F7ADppue8O7mNDd/bhBldDd1kkfH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BUG0uTbUDswDAPn8eNkJoyFCS8w7l8/Y
        dMz/xVFknJjHqNEeRxahAdScE2ApTnrVJA4Jzw1bTYrBNwKEaT3/DVLKI7D1m7EV
        ow6WFO1uBcdqbG9JPBlTD3Q6Zg6ZSPsFmtNWvu6rQvrgKJvicMaY44TWIo0CXZXz
        FrtyKaoclxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81F4F999E4;
        Thu, 28 Jan 2021 21:42:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 102E1999E2;
        Thu, 28 Jan 2021 21:42:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 07/10] t: prepare for GIT_TEST_WRITE_REV_INDEX
References: <cover.1610129989.git.me@ttaylorr.com>
        <cover.1611617819.git.me@ttaylorr.com>
        <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com>
        <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
Date:   Thu, 28 Jan 2021 18:42:46 -0800
In-Reply-To: <YBNasXXZc1BEkMxH@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Jan 2021 19:45:37 -0500")
Message-ID: <xmqqsg6ktqe1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABAB7DC4-61DB-11EB-862B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
>> -	ls http_child/.git/objects/pack/* >filelist &&
>> -	test_line_count = 6 filelist
>> +	ls http_child/.git/objects/pack/*.pack >packlist &&
>> +	ls http_child/.git/objects/pack/*.idx >idxlist &&
>> +	test_line_count = 3 idxlist &&
>> +	test_line_count = 3 packlist
>>  '
>
> Hmm. Too bad we can't rely on shell brace expansion, as:
>
>   ls http_child/.git/objects/pack/*.{pack,idx}
>
> would be more readable. You could still do it in a single "ls" by
> writing out both arguments manually, but it's probably not that
> important.

This part looks a bit familiar as I had to fix the interaction with
Jonathan's topic, IIRC.  We need to update the comment.  It is not
ensuring "exact 6"---it merely is interested in having three
pack/idx pair, and carefully expressing that by preparing for the
presence of other cruft in objects/pack/ directory other people may
create (like ".rev", but we may gain more).

I wonder if we even _care_ about .idx.  Why not just count .pack, to
prepare for a possible distant future where we do not even write .idx
but append to existing multi-pack-index as we download a new pack
stream and store it in a .pack, or something?

>> -	ls .git/objects/pack | sort >existing_packs &&
>> +	ls .git/objects/pack/pack-*.pack | sort >existing_packs &&
>>  	test_commit "$(test_oid obj3)" &&
>>  	test_commit "$(test_oid obj4)" &&
>>  
>>  	git gc --auto 2>err &&
>>  	test_i18ngrep ! "^warning:" err &&
>> -	ls .git/objects/pack/ | sort >post_packs &&
>> +	ls .git/objects/pack/pack-*.pack | sort >post_packs &&
>>  	comm -1 -3 existing_packs post_packs >new &&
>>  	comm -2 -3 existing_packs post_packs >del &&
>>  	test_line_count = 0 del && # No packs are deleted
>> -	test_line_count = 2 new # There is one new pack and its .idx
>> +	test_line_count = 1 new # There is one new pack
>>  '
>
> This one is making the test a bit looser (it would miss a case where we
> somehow failed to generate the .idx). That seems like an unlikely bug,
> but I wonder if we can keep the original behavior. I guess:
>
>   ls .git/objects/pack/*.pack \
>      .git/objects/pack/*.idx |
>      sort >post_packs
>
> would work?

I guess we are looking at the same issue from opposite angle.  I
suspect that it might even be a good thing to only care about .pack
and ignore everything else in the longer run.
