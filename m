Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06778211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 02:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeK3Nqu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 08:46:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55713 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeK3Nqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 08:46:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89695111513;
        Thu, 29 Nov 2018 21:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WQjoLMhKWWAsLXc2Fjblz7ZcTzA=; b=bCADab
        /mfFtQYhszg/9/5RcWV3GfzPLSiIE6xNC55qXWIw4br+Pe83GaQlIBefUmG2SE73
        9U2vde7Xt+AUEn7Vd5Jj8YtOGBG+1XvXSJdiaF4ZxTz4UWGCjjRmBli/43z89HNJ
        3ICIpSPduVauL2ice5spfRbWSVREqp6EyVNaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7pBq8mPBKcb32Z1QQUj92Nrq9+bTQvb
        mSSgIAYIjvdJnkJu6unyOl+lSzAQdveAtqrYOeWBD29Jb4q6aiZw6DaPq8GmP6SD
        lObTEmKF87EjjNXI6+uWTCIV5eErS5Wp55ZgAjPV8fcFk0Nt3dypR+NjZbxAMS8B
        VPcxWWsXYmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F3C111512;
        Thu, 29 Nov 2018 21:39:06 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7CF011150F;
        Thu, 29 Nov 2018 21:39:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] pack-objects: add --sparse option
References: <pull.89.git.gitgitgadget@gmail.com>
        <9d6b8f6d0602e85652b2a748c58eeed4cbf4359e.1543441960.git.gitgitgadget@gmail.com>
        <CAGZ79kbVGyX=Ky9HvmUGWPoHdLJYqnPTNda2kT3aC8XuHnH3+A@mail.gmail.com>
        <1e9d4d2d-561e-fcbc-48cf-374dcb9ce009@gmail.com>
Date:   Fri, 30 Nov 2018 11:39:04 +0900
In-Reply-To: <1e9d4d2d-561e-fcbc-48cf-374dcb9ce009@gmail.com> (Derrick
        Stolee's message of "Thu, 29 Nov 2018 09:20:29 -0500")
Message-ID: <xmqq36rjmgqf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B1F7028-F449-11E8-92FF-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> You're right that having this hidden as an opt-in config variable
> makes it hard to discover as a typical user.
>
> I would argue that we should actually make the config setting true by
> default, and recommend that servers opt-out. Here are my reasons:
>
> 1. The vast majority of users are clients.
>
> 2. Client users are not likely to know about and tweak these settings.
>
> 3. Server users are more likely to keep an eye on the different knobs
> they can tweak.
>
> 4. Servers should use the reachability bitmaps, which don't use this
> logic anyway.
>
> While _eventually_ we should make this opt-out, we shouldn't do that
> until it has cooked a while.

I actually do not agree.  If the knob gives enough benefit, the
users will learn about it viva voce, and in a few more releases
we'll hear "enough users complain that they have to turn it on,
let's make it the default".  If that does not happen, the knob
does not deserve to be turned on in the first place.

The same applies to many shiny new toys people are discussing
recently on this list (e.g. precious vs expendable and non-overlay
checkout are the ones that immediately come to my mind).

Having said that, I won't be commenting on this shiny new toy before
the final.  I want to see more people help tying the loose ends and
give it final varnish to the upcoming release, as it seems to have
become rockier and larger release than we originally anticipated.
