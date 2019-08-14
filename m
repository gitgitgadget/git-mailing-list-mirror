Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6831F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHNTSv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 15:18:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56034 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfHNTSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 15:18:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E59D969727;
        Wed, 14 Aug 2019 15:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=20Y/IVR+ukioOUIZrfqbq5hAvFA=; b=P3DLFM
        xrMQ5Gx8GNYr70r5l9IDOeOMd4n1oRzm5A5d0QPP+7U0RwwfhSFfgN1h9hPpIlgi
        k8xwCKY0s2wnhBRU2ACU5kgelf9y7RbaEeO25KsMVCpB+HUpo2wzFM7Nt7DDKbzi
        22Pqb0tvM7xNxZ46DkUggvBcfqW552l9nSfrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DerBc5Kdaj3csO0eVq6ctl0ciSdKZrge
        M0C2Gjwl5BgPFLTiA88PxOQA49WKvG8Bq8sT2PdOsPV5BG7R0q8ck/Xh3LipfUHA
        HFkLDGxlRtYkY4/2a6HeN1iB0w36cl5oQEwHf1agCUV+vm9aQ+f2hdSksiae+E+f
        rNrgG6uhjhY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE5B669726;
        Wed, 14 Aug 2019 15:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD9DF69725;
        Wed, 14 Aug 2019 15:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v4] documentation: add tutorial for revision walking
References: <20190806231952.39155-1-emilyshaffer@google.com>
        <xmqqwofohjgv.fsf@gitster-ct.c.googlers.com>
        <20190814183328.GA40797@google.com>
Date:   Wed, 14 Aug 2019 12:18:39 -0700
In-Reply-To: <20190814183328.GA40797@google.com> (Emily Shaffer's message of
        "Wed, 14 Aug 2019 11:33:28 -0700")
Message-ID: <xmqqd0h75ze8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53AAA06C-BEC8-11E9-97C8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > I think the tutorial itself is pretty much ready...
>> 
>> A few comments after skimming this round; none of them may be a show
>> stopper, but others may have different opinions.
>>  ...
> Hmmm. It sounds like you're saying:
>
> - This object covers walking objects, which is surprising since it's
>   titled about "revision walks". Revision walks are more about commits
>   ("git log").

Yes, the document does not duplicate what existing docs on "revision
walk" API would cover, which is a very good thing, as it is (or at
least "feels to be") primarly about walking objects.

> - Using grep on objects doesn't make any sense.

The grep filter works on commit's log messages, and does not even
look at other types of objects, so while that point is true, what I
was driving at was that skipping commits using grep filter would
mean showing trees and blobs related only to the chosen commits, and
while it can be explained as such (i.e. "trees and blobs contained
only in commits without these strings are excluded"), the practical
usefulness of such a "feature" is dubious (here I am imagining the
primary practical use of "object walk" is to feed pack-objects).

> - Other filters (like pathspecs) which do make sense for object walks
>   aren't covered.

Yup.  For example, "trees and blobs that appear only outside of this
directory hierarchy are excluded" would be useful to enumerate
objects necessary for a narrow commits (again, to feed pack-objects).

> - Apply the grep filter to the commit walk, and apply a more interesting
>   object filter to the object walk.
>
> Or,
>
> - Choose a different kind of filter which is interesting when applied to
>   commits alone _and_ all objects.
>
> In the interest of covering more ground with this kind of tutorial, I'd
> lean more towards the former.

Sorry, I do not have enough imagination to cheer for either of these
two options---these may be "interesting" in the same way as "trees
and blobs contained only in commits without these strings are
excluded" enumeration, but I fail to see practical usefulness
(i.e. the reason why a user may be tempted to learn how to achieve
it).

In any case, that was my personal take and not a strong request to
change anything, as I said upfront.  The document just gave me an
impression that it was teaching coding exercise that may be
interesting but of dubious utility.

