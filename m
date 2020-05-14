Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210DBC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D4E2065D
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bDvwrEB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgENVXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:23:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56642 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgENVXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:23:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D59735E8FB;
        Thu, 14 May 2020 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ut1N2dLS9Dym4zvR3jIW7JSWyc=; b=bDvwrE
        B/sQep4YI3ePKsrLSmqkej/ZVHaKTvVU+nrapwLJOAyr58+4KwUPgBYmlqMN1+H3
        Q8u2a6YbRbQlIQ6GoWzH8BMY8+aOZAFqIuXeXN3nSRAgJPNQdBk8JvqETuyi9sSZ
        1sJ9IrsS4WG2uxkMg8U+UI272+S1sIUl/IbcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ViCCmicpfgtFGl1rRyEEDKyt52iaLmP8
        LWKUO/1gzed+sPhufOCZ3qjGqHNphqcjynX5ecD4uwDiV0MiTyt5x4lw5sKXZbI4
        rneEFNbpXO+z4Hoar418nLUcrpUeUF8AfZeilh8LIy4bnO1s5HXPpSoANbaJVmWc
        GLYIfPV9t+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD1BB5E8FA;
        Thu, 14 May 2020 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D1295E8F7;
        Thu, 14 May 2020 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Caleb Gray <hey@calebgray.com>,
        git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
        <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
        <20200514210501.GY1596452@mit.edu>
        <20200514211040.a7hrirdzgkphx3la@chatter.i7.local>
Date:   Thu, 14 May 2020 14:23:44 -0700
In-Reply-To: <20200514211040.a7hrirdzgkphx3la@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Thu, 14 May 2020 17:10:40 -0400")
Message-ID: <xmqqr1vmp5wf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 314FE566-9629-11EA-B02F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I think something like git-caching-proxy would be a neat project, 
> because it would significantly improve mirroring for CI deployments 
> without requiring that each individual job implements clone.bundle 
> prefetching.

What are we improving with such a proxy, though?

Not bandwidth to the client, apparently.  I thought that with the
reachability bitmap on the server side with reusing packed object,
it was more or less a solved problem that the server end spends way
too much time enumerating, deltifying and compressing the object
data?
