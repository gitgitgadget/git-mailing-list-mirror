Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A32C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33371206A5
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tbqlbFd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIPW23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:28:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56656 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPW22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:28:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66DFFE75D5;
        Wed, 16 Sep 2020 18:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YBuPDVCcO6DO4aocokFJkatciS0=; b=tbqlbF
        d/y/oYA9hNPsDVwQk87pOAC1yG94xJhsDecYJF2k2Ig+wte8+ZdNUFI1lauPMwac
        9gWPGeau/lNi287MP41JLpgzjqLx5j0pAeeW14xIXNh6dn4kDFtWymxLxpaj77hQ
        TCBDryicoGLXhX+lwMWaLLg8wcFFPbZ55tZQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u4u+1H8y1I8SuOTQRembuv3qZR12Plxd
        bz8GG9dB1bXFj6hyt6+4GXq7e5Mufz+KPuyVfu6Tmcoc4Hdst/DQbmG+qCvR6g8f
        tDCpeZi0P+EJ86iC9WXslSQ7y4ZozLHkCqDm0/qU/O+9nvfQdTMylZW7+XifXbBy
        XBnKdvIWCug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F98EE75D4;
        Wed, 16 Sep 2020 18:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A41E6E75D3;
        Wed, 16 Sep 2020 18:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] t3200: avoid variations of the `master` branch name
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com>
        <20200916211150.GA617237@coredump.intra.peff.net>
Date:   Wed, 16 Sep 2020 15:28:21 -0700
In-Reply-To: <20200916211150.GA617237@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 16 Sep 2020 17:11:50 -0400")
Message-ID: <xmqqft7huzju.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE9FD780-F86B-11EA-ADAC-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm on the fence on whether this matters. It's a temporary
> inconsistency, assuming we eventually move to "main" as the default. We
> _could_ push this change off to that patch, too, but it does make it
> more noisy.

Another way to handle this is perhaps to teach test-lib.sh a way to
tell it that we want to live in the world where the initial default
branch name is 'main' and use that at the beginning of these select
test scripts like t3200.  Then we can do three related things in a
single patch to t3200, which are:

 - Declare that any "git init" in this test (including the initial
   one) uses 'main' as the default branch name;

 - rename 'master' used in the test to 'main'

 - rename 'master2' used in the test to 'main2'

and it would eliminate the awkwardness.

The change to test-lib.sh would likely to use init.defaultBranch
which also would be a good thing.

