Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A252C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 23:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2E16138C
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 23:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhDDXKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 19:10:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61677 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhDDXKi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 19:10:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D357AA0CF5;
        Sun,  4 Apr 2021 19:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QpQzXDQL5gz10ziPOf6bhzn2Mw0=; b=gQYiLh
        wYRr+yV/jm0GtFHcvoejAm9bckw2xRVIbymVvd/QwcpnWR7cOnRThkMU9ecOITQm
        7TluSgVfwF7/EtEL2pqyR0plYRgXIe+UzUwf4zSZ7mk/bHM4iczgmWETCqWjvC7v
        r1yJ/kR4o3Q7xFMKCTyy8KWsaWnayICYLvNes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QBVHDY/VvUoxCl0uMym90OcGsUflTaqF
        /TYI7UF5UKjXZJ9gJAoUTFxsEgxcsSZL6gbcl0Gom4bW11NNdxj1GPaXIXrKyRIp
        u2W/I/gso1MEAGWXz0PIQfu8z84KwUy6l/8tvf7/ktBhrENgl1qrpWmBwsO+SBjh
        up3Fd/YyirQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB3B4A0CF1;
        Sun,  4 Apr 2021 19:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E4AEA0CF0;
        Sun,  4 Apr 2021 19:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
        <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
        <xmqq8s613gqa.fsf@gitster.g>
        <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
        <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
        <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
        <xmqq1rbs4c6t.fsf@gitster.g>
        <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com>
Date:   Sun, 04 Apr 2021 16:10:31 -0700
In-Reply-To: <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com> (Derrick
        Stolee's message of "Sun, 4 Apr 2021 16:25:44 -0400")
Message-ID: <xmqqft057ijc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F47996E2-959A-11EB-AE42-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> I do not recommend unparsed refspec and textually munging, by the
>> way.  Doesn't
>> 
>> 	git fetch master:remotes/origin/master
>> 
>> first parse to normalize the src/dst sides to turn it into
>> 
>> 	git fetch refs/heads/master:refs/remotes/origin/master

I tried to jug my memory in this area a bit by reading the relevant
code.  For non-wildcard refspec, e.g. with

    [remote "origin"]
	url = ../git.git/
	fetch = master:remotes/origin/master
	tagopt = --no-tags

you'd get

    $ git fetch -v
    From ../git
     * [new branch]            master     -> origin/master
    $ git for-each-ref
    2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48 commit	refs/remotes/origin/master

It all happens inside remote.c::get_fetch_map(), I think.

Thanks.
