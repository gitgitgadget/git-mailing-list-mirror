Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E69C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 16:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348718AbiDKRBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiDKRBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 13:01:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66682A7
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 09:58:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E74C18631E;
        Mon, 11 Apr 2022 12:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Z+dLyQcDmdQhiLff1Mk8dTUN7MCgQM3DBGxju
        XYdus=; b=pItXnCutm20v5VBJGb//xggweKD6JHgWzqFjmTABNRyR7Dg1nWih9Z
        ReqyRm4QXukWCm6tVykbkE+vsYxub0UjRRhARr28OPvuKN6Mp9W4Cal/duzv9g+5
        FsfL892LiwY4CjeZfUQa2Ic0OtJHGKkWJBh5uszIwzGPElhvE6tuQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98E3118631D;
        Mon, 11 Apr 2022 12:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E42218631C;
        Mon, 11 Apr 2022 12:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Miklos Vajna <vmiklos@vmiklos.hu>, Git <git@vger.kernel.org>
Subject: Re: git log --since to not stop after first old commit?
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
        <Yk8Gvf/fjVca9hDB@vmiklos.hu> <xmqqv8vkpara.fsf@gitster.g>
        <xmqqtub3moa0.fsf@gitster.g>
        <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
Date:   Mon, 11 Apr 2022 09:58:45 -0700
In-Reply-To: <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
        (demerphq@gmail.com's message of "Sat, 9 Apr 2022 06:02:44 +0200")
Message-ID: <xmqqilrfk14q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6CE845A-B9B8-11EC-9080-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

> On Sat, 9 Apr 2022 at 02:43, Junio C Hamano <gitster@pobox.com> wrote:
>
>> > Giving "--since" the "as-filter" variant sets a precedent, and
>> > closes the door for a better UI that we can extend more generally
>> > without having to add "--X-as-filter" for each and every conceivable
>> > "--X" that is a traversal stopper into a filtering kind.
>>
>> If we pursue the possibility further, perhaps we may realize that
>> there isn't much room for us to add too many "traversal stoppers" in
>> the future, in which case giving "as-filter" to a very limited few
>> traversal stoppers may not be too bad.  I just do not think we have
>> explored that enough to decide that "--since-as-filter" is a good UI
>> (and it is not a good timing for me to spend brain cycles on the
>> issue).
>
> When you do have the cycles perhaps it is worth considering whether
> splitting it up, so that --as-filter is a modifier for traversal stoppers,
> would avoid the problem of proliferating options.   Eg, instead of saying
> --since-as-filter you would say --since ... --as-filter. That way the
> stoppers where "filter like behavior" made sense could just check if the
> --as-filter flag was set.

Yes, that has exactly the opposite problem I wanted to warn us about
by sending an extra message (to which you are reponding to).  If we
have (or can have) very many traversal stopping option, it might
make sense to have --as-filter as a modifier and avoid doubling the
number of options, but if we only have very few (and fundamentally
cannot have more than very few), then giving each of these very few
--X its own --X-as-filter variant would probably make more sense.
Because end users would probably not know which ones are inherently
filters and will not be affected with --as-filter modifier, it would
help them understand if we give them independent --since-as-filter
option and document it separately, if there aren't many of them.

Besides, if we had very few but still multiple of them, --X and
--Y-as-filter can be combined to say "X stops as before, but Y is
applied as filter", which is strictly more expressive than a
separate --as-filter modifier.

So that is why I threw out the message for those interested in the
topic to first think about.  I know we agree that --since may be a
good candidate to have these two flavours of behaviour.  I do not
think anybody carefully thought about existing options to see if
there are many like --since that want two flavours, let alone
possible options we have said in the past that we may want to have
but not yet added.

Thanks.
