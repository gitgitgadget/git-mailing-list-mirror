Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EAF12070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbcISSEJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:04:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751872AbcISSEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:04:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A035C3F755;
        Mon, 19 Sep 2016 14:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F2C/M+lvMU8IRTwUL9prWsGtdOg=; b=ekk2oG
        2pZuTiYARQi/qZPimEe9tK1K5GhUTNMvNWUJ9rmN3UXWZeaxu+SCsBBPmBsqNaiK
        8NlgG3ZubIdeaUOUuUhhBu5vVaqyZl7HQiFq8Hdp2AKOgbYppYCIdu54zm9yIXtT
        PZb2N+2t2RTfk6yYydOI1S7nanSBDmoowWX6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jncVmMtovDSVMLFEhjdISXrYExKrHs4y
        MahKUDnq2ON93y7YIOVVqFYmXJxb6QPoemWLwalyZLZ2I7Oa40vrBOVLNdqLIflu
        gfSXUtlJ0tp4ahU1dbnyoSmOcJh6Vk9vK/F50atF3r8/JqDyIpueZXJSkBT9qR+B
        fbozesMqVHw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 993053F754;
        Mon, 19 Sep 2016 14:04:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A91C3F753;
        Mon, 19 Sep 2016 14:04:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
        <1474073981-96620-1-git-send-email-bmwill@google.com>
        <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
        <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
        <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com>
        <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
Date:   Mon, 19 Sep 2016 11:04:04 -0700
In-Reply-To: <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
        (Brandon Williams's message of "Mon, 19 Sep 2016 10:26:27 -0700")
Message-ID: <xmqq1t0fg417.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 751891E6-7E93-11E6-A141-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> Again, what do we have in "name" and "item" at this point?  If we
>> have a submodule at "sub/" and we are checking a pathspec element
>> "sub/dir1/*", what is the non-wildcard part of the pathspec and what
>> is the "string"?  Aren't they "sub/dir1/" and "sub/" respectively,
>> which would not pass ps_strncmp() and produce a (false) negative?
>
> item will be the pathspec_item struct that we are trying to match against.

... which would mean "sub/dir1/" in the above example (which is
followed by '*' that is wildcard).

> name will be the file we are trying to match, which should already have the
> 'prefix' cut off (this is the prefix that is used as an optimization
> in the common
> case, which isn't used in the submodule case).  

... which would be "sub/" in the above example, because we disable
the common-prefix optimization.

So in short, the answer to the last questions in the first quoted
paragraph are yes, yes, and "no they do not pass ps_strncmp()"?

>> I am starting to have a feeling that the best we can do in this
>> function safely is to see if prefix (i.e. the constant part of the
>> pathspec before the first wildcard) is long enough to cover the
>> "name" and if "name" part [matches or does not match] ...
>> If these two checks cannot decide, we may have to be pessimistic and
>> say "it may match; we don't know until we descend into it".
>> ...
>> So I would think we'd be in the business of counting slashes in the
>> name (called "string" in this function) and the pathspec, while
>> noticing '*' and '**' in the latter, and we may be able to be more
>> precise, but I am not sure how complex the end result would become.
>
> I agree, I'm not too sure how much more complex the logic would need
> to be to handle
> all matters of wildcard characters.  We could initially be more
> lenient on what qualifies as
> a match and then later (or in the near future) revisit the wildmatch
> function (which is complex)
> and see if we can add better matching capabilities more suited for
> submodules while at the
> same time fixing that bug discussed above.

I think it is reasonable to start a function that is meant to never
have false negatives pessimistic and return "might match" from it
when in doubt.

Thanks.
