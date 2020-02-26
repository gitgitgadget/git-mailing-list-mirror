Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A8C4BA09
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0831E21927
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uCP0JswB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgBZDLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:11:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56609 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgBZDLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 22:11:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD90C5326F;
        Tue, 25 Feb 2020 22:11:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MRBriJ5DIc/JPycOVx1x2w9N72Y=; b=uCP0Js
        wB59xKRBrn/pOkhL+1CEGkgTmc4/1Ge4DqQfeD6B6iKy1SBSoND/rgKSGObpYpsc
        pej7peTut9wzfPVi+8e77Fie+ZxRuGj/Q6EooMq6vDjt7LoNbkcGh6l8r9LPi+z3
        c1QswiRP6uzCrm6kCR6Mi2H6EuxdqlABurp/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UBVGi2uivEVIHdV5Tb+BWz+NAkaxK3wC
        YuPvPewncYHs8Yp3Um2CRIPAK1JWgODLW9GiV3EwHXWSdSND8ztz8xKnu35iPE5Z
        E/+t7GW90tO7RBsqHUr/OliEaEJIznu47rtIH2nd5vgfPEQq6PBpIj/tVQOTJKGp
        m30qJ1JiCRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D634F5326E;
        Tue, 25 Feb 2020 22:11:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4681C5326C;
        Tue, 25 Feb 2020 22:11:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing tags
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-19-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
        <xmqqh7zemptx.fsf@gitster-ct.c.googlers.com>
        <20200226030545.GD7911@camp.crustytoothpaste.net>
Date:   Tue, 25 Feb 2020 19:11:43 -0800
In-Reply-To: <20200226030545.GD7911@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 26 Feb 2020 03:05:45 +0000")
Message-ID: <xmqq4kvekpow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B81C5844-5845-11EA-A748-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I will likely not get to a reroll before Thursday at the earliest due to
> other commitments, so if it's more convenient for you to eject this from
> pu and just pick up v3 when I get around to it, please feel free.

Thanks, but I think a minimal SQUASH??? I added while queuing to
'pu' seems to have made it pass so that would have to do for now.
