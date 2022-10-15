Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0586C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJOShV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOShU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:37:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0424D4D1
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:37:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 655161C504F;
        Sat, 15 Oct 2022 14:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U0IDXyZyCxZrqQkXMDZw+Ll0oGt+LrzZ55NUPb
        VnXU4=; b=asnyF9n0pL01cdfymUKbdL9V15/KMXyj1a0KotIIiKfrYrblNxE38o
        gOS2CLFx9c84jvzfktK7x8PUo8QankyUBpc85rz/s6EmwN7ZrUJFm1L9jrEJm01W
        Cc/dH83dcUSkJSEk5Io/Y2l9dhvMz7xZBmO0iVZ7QnT5eokPQm1mA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5281C1C504E;
        Sat, 15 Oct 2022 14:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 717421C504D;
        Sat, 15 Oct 2022 14:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
        <xmqqilkl54wp.fsf@gitster.g>
        <Y0r6iAv1OVUVYNGc@coredump.intra.peff.net>
Date:   Sat, 15 Oct 2022 11:37:15 -0700
In-Reply-To: <Y0r6iAv1OVUVYNGc@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 15 Oct 2022 14:23:04 -0400")
Message-ID: <xmqq35bp53xg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64A823B8-4CB8-11ED-9D2D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> We could mimic "find" and make "foreach" that has no action default
>> to an equivalent of "echo" that is done internally without forking.
>
> That would be reasonable to me, though I wonder what the output format
> should be. Just name, or name/oid? Once you start having options, you
> might as well just add a separate "git submodule list" that can take
> them.

Users of "find" seem to be happy with "-print" being the default, so
whatever we were doing with the internal "helper --list" would be
appropriate here.  Folks who want different output can feed their
own action.
