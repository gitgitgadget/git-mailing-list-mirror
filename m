Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775CC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B456B206BE
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jY6Vwb/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHXSza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:55:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55981 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXSz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 14:55:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3839D3C9F;
        Mon, 24 Aug 2020 14:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQIGFwVrXyQch3jxuB5x96QoHb4=; b=jY6Vwb
        /loIDqDUNk8R/wfYfOqCbKyShEI3Jcrc6H5uCEQ612A2XiRmiq+zOQJqrBdWGRML
        fbviXr1Dzhs7MOqUV7RVTwOfNHTXLjdhIWYp0qtU0xO+1GXEFNSHmXrz+ParIx05
        EyslQmnZy6iFbo5K7n2ds8D1Qtgum1AsgOxCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FgrBBGQ3HBEcNaR1VFavO3WBUutaA/+I
        Q98UnS9VD2yk3TcwwSiT7U1+afP08lXEKzpjIJn1MT/Cgs3ASED/4znfmvKPms2k
        JMfIF3TnK4oIZDI77K/bbvUYTqGVG+kBdQycoj9pQIrEzxqdRGSW5QOLu3iDNhWZ
        jOm9ZaLWvN4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB2E6D3C9E;
        Mon, 24 Aug 2020 14:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29267D3C99;
        Mon, 24 Aug 2020 14:55:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 11:55:22 -0700
In-Reply-To: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 24 Aug 2020 15:37:57
        +0000")
Message-ID: <xmqqr1rv50x1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF287EC-E63B-11EA-A94C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Johannes Schindelin (3):
>   msvc: copy the correct `.pdb` files in the Makefile target `install`

Thanks---I was wondering what would happen to these files with
Peff's "trimmed down" topic.  My understanding is that we are still
waiting for a reroll of that topic but without the "drop all the .pdb"
step from it.

