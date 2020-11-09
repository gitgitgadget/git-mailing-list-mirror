Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD6C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E812074F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FgW78DWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgKIVUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:20:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60010 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbgKIVUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:20:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4C88FE81B;
        Mon,  9 Nov 2020 16:20:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C0X1e5IFQW5KRmOfAddO6AsFUSY=; b=FgW78D
        WrR9CV2ytS46qiYoceS1+/Yc5sGpp/C0csH1aYzi0Ua0RBxEcj4fGOdZzxskrrJq
        w3oBFiJk7c4zMY9y/h9LCfBazYUciqZR4yPf83Oi/VazivkVP0ElMcWGuV9QUpLK
        nUBviX9X1yBialUsilOv1JK3E4IUomj6gOeHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vPodqpknf5BSB7E6lAiR6r7sK+oG/2tc
        tRdZQMY2mgJhv/xObYlxuwZl+OZ9k2puCPWh7YDZrR2QPFjhUmkNDu6QT53m0vAw
        04HfBtch0LvasI5/IsMyqP8DYjJRV1qtatI0Fs+ltABNmiKDbsbJgTYegZmGGlZ3
        MEWlvzWG+yE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE01AFE81A;
        Mon,  9 Nov 2020 16:20:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D00AFE819;
        Mon,  9 Nov 2020 16:20:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, jrnieder@gmail.com, git@vger.kernel.org,
        newren@gmail.com, stolee@gmail.com
Subject: Re: [PATCH 4/4] Doc: push with --base
References: <xmqqft5qs5qs.fsf@gitster.c.googlers.com>
        <20201109195630.2511149-1-jonathantanmy@google.com>
Date:   Mon, 09 Nov 2020 13:20:14 -0800
In-Reply-To: <20201109195630.2511149-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 9 Nov 2020 11:56:30 -0800")
Message-ID: <xmqq8sbab52p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C997DCE-22D1-11EB-9B32-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> People expect that a single repository at their hosting sites can be
>> used as the central meeting point for the project, just like CVS/SVN
>> servers were in older world.  "git push" would need to accept that
>> reality and start common ancestor discovery eventually.
>
> Thanks for your reply (and everyone else's). I was thinking that a more
> rudimentary form of the feature would suffice, since I wasn't expecting
> much more need in the future, but looks like this isn't the case. I'll
> be thinking of a more comprehensive idea.

I said "eventually", meaning that we may not have to solve it
immediately, but judging from the need for ad-hoc workarounds like
sending older commits that are not necessarily at the tip of
anything from the receiving end as if they are tips and then another
ad-hoc workaround like this one, it seems that the need is real.

Would the earlier refactoring of the negotiation part into a
separate negotiator module help, or did the refactor not remove the
deep assumption that it is only about the fetch/upload-pack traffic
and we need a design for push/receive-pack from scratch?

Thanks.
