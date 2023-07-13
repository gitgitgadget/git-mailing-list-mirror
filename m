Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35804C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 16:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjGMQOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMQOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 12:14:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1F26B2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 09:14:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 464731A9721;
        Thu, 13 Jul 2023 12:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Czj1/nCmr/g4F5+jadlvyoqNASHGTLdzkb0vl
        3joF0=; b=FxRaUvLtyMFUFJdI+cUxU3WbD4DMY41+N4mtmKY4AypV5LBQCbnl+L
        CjfYEbnCU/WJZnGlA0/5A11SiZ/Uq7UCdzwZGWc8kOe/BezKQNCrA5NrP/djS7zE
        zmK0EPr5uQk8+LliFBrOq0c/miNeAhyjPZaLpla6JKMUZruPjaNQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 381381A9720;
        Thu, 13 Jul 2023 12:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B6A21A971E;
        Thu, 13 Jul 2023 12:14:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
References: <cover.1689205042.git.me@ttaylorr.com>
        <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
        <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
Date:   Thu, 13 Jul 2023 09:14:05 -0700
In-Reply-To: <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com> (Phillip Wood's
        message of "Thu, 13 Jul 2023 09:21:55 +0100")
Message-ID: <xmqqttu7rdpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AFE0288-2198-11EE-93E8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> -		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
>> +		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
>
> p->crc_offset is a uint32_t so we're still prone to truncation here

Good eyes.  Thanks.
