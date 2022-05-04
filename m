Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A9AC433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 14:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbiEDOii (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbiEDOig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 10:38:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298C20F5D
        for <git@vger.kernel.org>; Wed,  4 May 2022 07:34:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A6B11ABC8;
        Wed,  4 May 2022 10:34:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3tYxjKLlSzm4tkz6jF7dYS2D7dxsqB8lSEmJ5e
        bBn2g=; b=AXd67eFcVdU4DhIWb0n0X9GnWTSvlAQmXajMlVJOIyPBfIMN3yu+aX
        xfVXj7w0fH53QBKKSEFMp1pdgUFuIO8LAMKuyZcn+r8Csfqbee4ujcn0B9Dl4hZ8
        G3KS/dx8mLX03yAsJ4q7B2qP9w2jFIiUOghgYNUAof8DFs1dXVids=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E32911ABC5;
        Wed,  4 May 2022 10:34:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF74B11ABC4;
        Wed,  4 May 2022 10:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] http: add custom hostname to IP address resolves
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
        <xmqqfslrycvp.fsf@gitster.g>
        <CAP8UFD0hWUudP6pZVGS5yOVCjbBCm1LdK_EbrsQp9KiVPPMCyA@mail.gmail.com>
Date:   Wed, 04 May 2022 07:34:56 -0700
In-Reply-To: <CAP8UFD0hWUudP6pZVGS5yOVCjbBCm1LdK_EbrsQp9KiVPPMCyA@mail.gmail.com>
        (Christian Couder's message of "Wed, 4 May 2022 12:07:59 +0200")
Message-ID: <xmqqzgjxnz73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F24E034-CBB7-11EC-BAD2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> The above is a reasonable summary of CURLOPT_RESOLVE documentation
>> that is appropriate to have here for those of us who are not
>> familiar with it.  For those of us who may want to learn more, it
>> would help to have an URL to the canonical documentation page, e.g.
>> https://curl.se/libcurl/c/CURLOPT_RESOLVE.html but it is not
>> required.  People should be able to find it easily.
>
> Yeah, I also thought that it wasn't required, but I will add it
> anyway, as I agree it could be useful and hopefully it doesn't change
> very often.

Ah, I didn't consider the URL going stale at all.  Forcing readers
to look for the keyword certainly is a way to avoid it, but they
will do that once they realize URL went stale, so there is not a
strong incentive to avoid recording the now-current URL, I would
think.

>> > +http.hostResolve::
>>
>> Is "host" a good prefix for it?
>>
>> In the context of HTTP(s), if there is no other thing than host that
>> we resolve, "http.resolve" may be sufficient.  For those who are
>> looking for CURLOPT_RESOLVE equivalent, "http.curloptResolve" may
>> make it easier to find.
>
> I am Ok with just "http.resolve". I think using "curlopt" is perhaps
> going into too many details about the implementation of the feature,
> which could theoretically change if we ever decided to use something
> other than curl.

You may want to step back a bit and rethink.

Even if we decide to rewrite that part of the system not to depend
on cURL, end-user facing documented interface, i.e. how the mappings
are given to the system, will stay with us, and it is clear that it
was modeled after CURLOPT_RESOLVE---well, it was stolen from them
verbatim ;-).

So we may wean ourselves off of cURL, but CURLOPT_RESOLVE will stay
with us for this particular feature.

>> I am wondering if we want to mention the expected use case here
>> as well, something like
>>
>>     This is designed to be used primarily from the command line
>>     configuration variable override, e.g.
>>
>>         $ git -c http.resolve=example.com:443:127.0.0.1 \
>>             clone https://example.com/user/project.git
>>
>> perhaps?  Not a suggestion, but soliciting thoughts.
>
> I am also interested in others' thoughts about this. If no one thinks
> that a config option could be useful, I am Ok with making it a
> "--resolve" command line option that can be passed to any Git command
> similar to "-c <name>=<value>":
>
> git --resolve=... <command> [<args>]

Absolutely not.

"git [push|fetch|clone|ls-remote] --dns-pre-resolve=..." that is
*NOT* git wide, but is only for transport commands might be a
possibility, but even then, you'd need to invent a way to do the
same for non cURL transports (we want to be able to pin the IP when
going over SSH to a certain host, for the same reason) if we promote
it to an officially supported command line option.

Unless we do that, it is probably better to leave it as an obscure
configuration meant to help server operators.  At least, with the
name of the configuration variable prefixed with http.*, we have a
valid excuse when somebody complains "the feature does not do
anything for git:// transport".

Thanks.
