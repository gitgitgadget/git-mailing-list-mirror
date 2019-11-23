Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7868BC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1262E2070E
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="waqTaNAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKWA26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:28:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60618 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWA26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:28:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 019E198BF1;
        Fri, 22 Nov 2019 19:28:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PxCyuLh9zWBTHzt5UZEVAs4A3bI=; b=waqTaN
        AVLnm5aAO0tvFLbPIHZam/BLT3MeeTKbTCj9l21l4JXMAcklQoziKcSIerromQ7U
        TiRi5RVT4/Ixp7Y+lTmkCMRDGnzz3+lPkLMgwkI8s1+a4MNWFXWG4KmD0HOd9drE
        eCBy5sP7C7JyW4QvVjrvQyAAlpmkHHjiEFKfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFxfACBqVfSHXjWH76M47CjxeeQHVzbF
        gjGn+ebKAnahiAmEvmwgpsSmRnSTIWVQHMgTFMUYJhDrAhGXusVmaFUbIFh+vrZ2
        zQyAVjv5BSbc+qYWHFnaM8hW6AF8F587xv60Am8RPdZHvfDPNckKnLJRCXmKCnPT
        j8ZrYmtSuNI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF1B298BEF;
        Fri, 22 Nov 2019 19:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2439E98BEE;
        Fri, 22 Nov 2019 19:28:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
References: <20191122011646.218346-1-emilyshaffer@google.com>
        <20191122021419.GA52557@generichostname>
        <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
        <20191122220241.GA56020@google.com>
Date:   Sat, 23 Nov 2019 09:28:50 +0900
In-Reply-To: <20191122220241.GA56020@google.com> (Emily Shaffer's message of
        "Fri, 22 Nov 2019 14:02:41 -0800")
Message-ID: <xmqqsgmf3071.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A376AD4-0D88-11EA-B792-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> In this situation - where it is not a related fixup for a branch in
> next, but the topic does rely on that branch - should I send a series
> which is based on 'next'? How do I make the dependency clear to you via
> emailed patch?

If you need to use a particular new feature from a topic (or two),
not depending on 'next' but either building on

 (1) directly that topic, or

 (2) a local merge you create across the 'master' branch and the
     topic(s) you want to depend on

would be good.  Whichever way you go, leaving a note either on the
cover letter or after the three-dash line to say what you did would
always be helpful to the reviewers.

In this particular case, I think (1) would work better for you, as
the topic you want to use builds directly on the latest release so
you won't be missing anything that is not yet on that topic but
already in 'master' at this point.

Thanks.
