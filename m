Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079FE1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 17:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdC0RPr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 13:15:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751413AbdC0RPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 13:15:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B99E37BD85;
        Mon, 27 Mar 2017 13:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z0Ekv800sfSlhMfzN+N7h6OK7+c=; b=f9jtKd
        WGmkmkeshT4SuH2erGw1aVJrWqEzKRrnjGcWxzoLEzEqPE2S8/8HeH8L0rIiPH9t
        GHRrAeIvrjy2YsxLYBI/zk4heTXPFZP4d7HWVdJTojizJFacZ4KFsSo5tjkwIF6k
        sRKSs6CMC8hZesoZOwJFNcquVg9Wct5ysQjAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sPFnQmx4su1W7ZUyTDn7OuHN9VDolH84
        wjdFjPewtf/iPcKieQ3hKrETAEPPBx387pKfkyiGqJxpBNiyYoH+WRc1TMLFGODH
        RYS7w0OJBCrEjjj9Wr3xhLe7UfrUcwZ8HxGmE4c4PQi/Q+NWw2WZZMDsiglT4KFP
        vHjKiip+5Hk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B32567BD84;
        Mon, 27 Mar 2017 13:15:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D63B7BD83;
        Mon, 27 Mar 2017 13:15:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
        <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net>
        <xmqqinmv4ojt.fsf@gitster.mtv.corp.google.com>
        <20170327011140.icqfc4lqlarvae6l@sigill.intra.peff.net>
        <xmqqbmsn2qyh.fsf@gitster.mtv.corp.google.com>
        <20170327070909.26ojhkhagf6pq3wp@sigill.intra.peff.net>
Date:   Mon, 27 Mar 2017 10:15:07 -0700
In-Reply-To: <20170327070909.26ojhkhagf6pq3wp@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 27 Mar 2017 03:09:09 -0400")
Message-ID: <xmqqy3vq1w10.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEA05F64-1310-11E7-A398-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I think we can assume it will be possible with SHAttered levels of
> effort. An attacker can use it to create a persistent corruption by
> having somebody fetch from them twice. So not really that interesting an
> attack, but it is something. I still think that ditching SHA-1 for the
> naming is probably a better fix than worrying about SHA-1 collisions.

Yes, I agree with that part.  

Our trailer checksum happens to be SHA-1 mostly because the code was
available, not because they need to be a crypto-strong hash.  It can
safely be changed to something other than SHA-1 that is much faster,
if that is desired, when it is used only for bit-flip detection of
local files like the index file.

I also agree that changing the naming scheme (e.g. use the "hash" as
a hash to choose hash-bucket but accept the fact that hashes can
collide) is a better solution, if this "packname can collide" were
to become real problem.

Thanks.

