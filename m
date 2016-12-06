Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA54C20259
	for <e@80x24.org>; Tue,  6 Dec 2016 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbcLFRx5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 12:53:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52801 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751845AbcLFRx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 12:53:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15CC253A00;
        Tue,  6 Dec 2016 12:53:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jkohksuyi2hinZz8tT+/KBcCtAA=; b=ZbGjbJ
        dAUzCzW6nwaVY7RlZI4I6gKg7GaXXAqHdRwOxyduI6Apx0mw0kMoHX/jh2/7O6xe
        5irpfeTPFPIUHi9KRE3VpmgMjaRVDSBuoHujUs4cQceOnh8jp86OR2J0hbTeQK4z
        pd0E7LVRgoaOk3+C4kaA30WlKkncil0JVVfHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kwC8kQdwLAQHXQ77LQaxQtOsdXv3j9yZ
        cVy+tUsPneLfZvHgd+gzxyW4J/7ZBxAsZRjr7YH9lqIA/Jb5kyv3FSOxbhIgD/Um
        V3C51LqMHp02Ll37ixIId8pjanvz/fqjtfPhVR/4bi6302bLBpjxPxS0fWrtU31g
        B3DRTwyq3SA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CB9C539F8;
        Tue,  6 Dec 2016 12:53:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C13D539F7;
        Tue,  6 Dec 2016 12:53:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to is_transport_allowed
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
        <1480623959-126129-1-git-send-email-bmwill@google.com>
        <1480623959-126129-5-git-send-email-bmwill@google.com>
        <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
        <20161201230738.GJ54082@google.com>
        <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
        <20161201235856.GL54082@google.com>
        <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
        <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 09:53:53 -0800
In-Reply-To: <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Dec 2016 08:51:13 -0500")
Message-ID: <xmqq60mx2bbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F437C8BC-BBDC-11E6-99C6-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't know if that makes things any easier. I feel funny saying "no,
> no, mine preempts yours because it is more maint-worthy", but I think
> that order does make sense.
>
> I think it would be OK to put Brandon's on maint, too, though. It is a
> refactor of an existing security feature to make it more featureful, but
> the way it is implemented could not cause security regressions unless
> you use the new feature (IOW, we still respect the whitelist environment
> exactly as before).

I think I merged yours and then Brandon's on jch/pu branches in that
order, and the conflict resolution should look OK.

I however forked yours on v2.11.0-rc1, which would need to be
rebased to one of the earlier maintenance tracks, before we can
merge it to 'next'.


