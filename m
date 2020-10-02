Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43047C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E06206DB
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uN79Bn9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJBVgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:36:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60626 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJBVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 17:36:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9304E414C;
        Fri,  2 Oct 2020 17:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N18fPKEu+f7+ZOOb6qVDMzzP2II=; b=uN79Bn
        9x46xgr4oXSgqfofB5eSI0lI2eE1Kbu6vME+qvqwXzFm+CtbKRQ/5QK1i85uZJXd
        Mj+BExiAKtEjUSBzvmK4G4O04+SBQdn7psKqkZl+7sebUfkQxc3NBfl4TvQQRBR9
        DiEW0OTw2fDmKnY3ni1sobET69Cfz4N7GjDXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nu186S2OlCMUv7jTePb7gJP26qwkK+Jq
        YcNN8X146l9wjwq/UoId44FRUMe+cyluuhI4nt+tfxrLhjzQIjeERyW7hT5d556m
        BL4q1Q5XvZ5Gz240czifEX6jvkRAhje1YlbQLq3NVk331hgqyZWBVEGOsrOztI+5
        Byep4K2COZ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1E00E414B;
        Fri,  2 Oct 2020 17:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1184DE414A;
        Fri,  2 Oct 2020 17:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
        <20201002150710.GA54370@mail.clickyotomy.dev>
        <xmqqft6wa8dc.fsf@gitster.c.googlers.com>
        <20201002193906.GA78209@mail.clickyotomy.dev>
        <xmqqmu148jxu.fsf@gitster.c.googlers.com>
        <20201002205830.GD78209@mail.clickyotomy.dev>
Date:   Fri, 02 Oct 2020 14:36:01 -0700
In-Reply-To: <20201002205830.GD78209@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Sat, 3 Oct 2020 02:28:30 +0530")
Message-ID: <xmqqd0208g5a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 454A3A48-04F7-11EB-8870-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Alright, I will add those changes in the next set. Also, I saw in the
> other thread that you tested commit-graph fix on this series and the
> tests are passing -- thanks for checking.

What I pushed out on 'seen':

 - starts building sk/force-if-includes topic on 6c430a647cb99 (at
   the tip of master sometime ago)

 - merges Derrick's fix ds/in-merge-bases-many-optim-bug topic

 - and then applies the previous three patches on top

 - and finally have the SQUASH??? fix-up.

Rebuilding your series on top of this commit

    aed0800ca6 Merge branch 'ds/in-merge-bases-many-optim-bug' into sk/force-if-includes

would be the most appropriate.

Thanks.


