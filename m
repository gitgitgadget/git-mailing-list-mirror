Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6A5C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02272216FD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLZcS10w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEGTdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:33:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61164 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGTd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:33:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80D24530F9;
        Thu,  7 May 2020 15:33:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ScE01gMIBGvEur+paYRwcy2jWDY=; b=TLZcS1
        0w/sI4KVhv8D/lRhCJ5hj5VCv82nejDbteuhqjNTL2ayD09ZsyaykxD6wlnBL9AG
        O4c9t9GNeZxAdo9weAJxH04qdT5QCRDsuQeQeGbHp9lFxLItHxJ5fG3hpQlqJbhL
        uGaoybv4nZwxwhUKhXFDPUruxhkR9eTTLMTyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KHIGoVN0KqFt94vtvYsE6/sz8WTQs51j
        2aHmFTCOrUqCuVA91q53kdCLTVBTZesLyR0sHA2M4rIXxjUy3KfzTi/iOMp/oQfe
        JkFzh0m5k/bXO/0N2Pr4XsM2mQFIeP28urH2rfam4ILH2PJ8w7WgwPjJby2HGJ3t
        LPX9aOzRXrc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7627F530F8;
        Thu,  7 May 2020 15:33:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04BEE530F7;
        Thu,  7 May 2020 15:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <20200506004612.GE927@danh.dev>
        <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
        <20200506142500.GA2429@danh.dev>
        <xmqqa72l81pe.fsf@gitster.c.googlers.com>
        <20200507122549.GB3057274@coredump.intra.peff.net>
        <xmqqeerv4n0q.fsf@gitster.c.googlers.com>
        <20200507185405.GA23736@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 12:33:24 -0700
In-Reply-To: <20200507185405.GA23736@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 14:54:05 -0400")
Message-ID: <xmqq1rnv4k1n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E6A2B7E-9099-11EA-921C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In the patch I sent out a few hours ago I just caved and made
> refs/heads/ci-config the magic ref, in order to avoid complexity.
>
> But it also wouldn't be too bad to say "look, you can store this however
> you like in refs/heads/ or not at all, but install it into place with
> git push <remote> HEAD:refs/ci/config". The audience is git.git
> developers (and even advanced ones whose workflows involve tweaking
> their CI config), so I'd like to think they could figure it out.
>
> I have a feeling that fewer than 5 people in the world will end up using
> this feature either way. ;)

Yeah, let's not spend too much time and too many cycles to
overengineer it.

Thanks.
