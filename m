Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121FDC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABF222247
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qqVmSm3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409531AbgJTUhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:37:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53263 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409477AbgJTUhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:37:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06F09FA74D;
        Tue, 20 Oct 2020 16:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FolR1VX8cwInvU2OBoSx/KfgFvM=; b=qqVmSm
        3nrTVE9SaaXBSnJ5UrEMxRlQYmtr6sFCdenQNbY+UeCtsXjQgsyzpivA9DfxO0/a
        /zpJQ6HkFs++hGdsamSQFWrPM5volia6+oc+zcZWNscOp/pmwiDGHqst+y92gzOL
        e6e76HEhqF0vw2MK1gEMd8mMxFkvABcxe7qkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YHGhNttyCC9fLrxvrIcYLCQp16vEVxc0
        om+GPtdMWp1armYbohz7sdDtBL4PoXZHWAeJdNRfa3/BJOHdKM07yKxPIxpklxmp
        Sf+sYh8tVDFAib7EAdqzka3R3sX+TC3azcFG8jh8CRtZtLmnAdEH+qGEbON8RRCl
        YAjRDkSw+6M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 007B7FA74C;
        Tue, 20 Oct 2020 16:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A554FA749;
        Tue, 20 Oct 2020 16:36:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] sideband: add defense against packets missing a
 band designator
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:36:57 -0700
In-Reply-To: <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:35:42 +0000")
Message-ID: <xmqqsga8ab2u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 006FEC6C-1314-11EB-B484-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> While there is currently no instance of code producing this type of
> packet, if the `demultiplex_sideband()` would receive a packet whose
> payload is not only empty but even misses the band designator, it would
> mistake it for a flush packet.

Quite sensible.  Will queue all three.  Thanks.
