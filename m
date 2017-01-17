Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B330A20756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdAQT6O (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:58:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750924AbdAQT6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:58:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC1C961DD9;
        Tue, 17 Jan 2017 14:58:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ru92lxod4CW3nlZ2zdW3B4zIeeI=; b=sFOWhZ
        Tl3akv7/dqeJXoAdFQq2OJlUU3mxf6phpmEbXF/ate+G37yJY69qqgef3uqgEbmI
        0JkV9prKAo5sxG/9qItEpKoSh/Kh8fgvo8bpNpEWupGDEGChPB2bH5Eapo1ctoxG
        yj5+ofhzf/g1eBOtVDvRPn0Tozyl6XiDNW7IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bjOMt9dzfyh6w6V8DW0AQBn7Q8Yik07d
        Lqfm/okBQeh1Itng0s/GwhqkVf/wZ4WfczV4chZV5b/2RSFdxz+/WneUO3palFdT
        mMQ8/pe2jxUzc+E/bhKEmW+rqP69h80+jU54aoe3WXLKSdFD3O0/u2lHnegX8hz7
        XaWW9v05DfM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1E1761DD8;
        Tue, 17 Jan 2017 14:58:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C3B161DD6;
        Tue, 17 Jan 2017 14:58:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Manuel Ullmann <ullman.alias@posteo.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation/bisect: improve on (bad|new) and (good|bad)
References: <20170113144405.3963-1-chriscool@tuxfamily.org>
        <xmqqinpihiwz.fsf@gitster.mtv.corp.google.com>
        <vpqfukjpdnp.fsf@anie.imag.fr>
Date:   Tue, 17 Jan 2017 11:58:10 -0800
In-Reply-To: <vpqfukjpdnp.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
        16 Jan 2017 10:17:14 +0100")
Message-ID: <xmqq37ghfoh9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46A5CE72-DCEF-11E6-A189-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> But what if bad-A and bad-B have more than one merge bases?  We
>> won't know which side the badness came from.
>>
>>                           o---o---o---bad-A
>>                          /     \ / 
>>     -----Good---o---o---o       / 
>>                          \     / \
>>                           o---o---o---bad-B
>>
>> Being able to bisect the region of DAG bound by "^Good bad-A bad-B"
>> may have value in such a case.  I dunno.
>
> I could help finding several guilty commits, but anyway you can't
> guarantee you'll find them all as soon as you use a binary search: if
> the history looks like
>
> --- Good --- Bad --- Good --- Good --- Bad --- Good --- Bad
>
> then without examining all commits, you can't tell how many good->bad
> switches occured.
>
> But keeping several bad commits wouldn't help keeping the set of
> potentially guilty commits small: bad commits appear on the positive
> side in "^Good bad-A bad-B", so having more bad commits mean having a
> larger DAG to explore (which is a bit counter-intuitive: without
> thinking about it I'd have said "more info => less commits to explore").
>
> So, if finding all guilty commits is not possible, I'm not sure how
> valuable it is to try to find several of them.

The criss-cross merge example, is not trying to find multiple
sources of badness.  It still assumes [*1*] that there is only one
event that introduced the badness observed at bad-A and bad-B, both
of which inherited the badness from the same such event.  Unlike a
case with a single/unique merge-base, we cannot say "we can start
from the merge-base, as their common badness must be coming from the
same place".  The badness may exist in the first 'o' on the same
line as bad-A in the above picture, which is an ancestor of one
merge-base on that line and does not break the other merge base on
the same line as bad-B, for example.

> OTOH, keeping several good commits is needed to find a commit for which
> all parents are good and the commit is bad.

Yes, that is correct.


[Footnote]

*1* The assumption is what makes "bisect" workable.  If the
    assumption does not hold, then "bisect" would not give a useful
    answer "where did I screw up?".  It gives a fairly useless "I
    found one bad commit whose parent is good---there is no
    guarantee if that has anything to do with the badness you are
    seeing at the tip".
