Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73882C4320A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5886660FC0
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbhHZQec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:34:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51247 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbhHZQe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:34:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38783D366B;
        Thu, 26 Aug 2021 12:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=K47ulhz77BxSj7ut0yD4LDWURyDWremWVNkUKR8o/+o=; b=nYKZ
        u0cJerL3tQsFyvykaOsdhCGayLPAaBWL/lJkrHeEn3ZHfIe90pOH9cVfdACMVO/V
        bC6ICE+4xSqMTvVM3RV0JlgggDZmKPHwaxLva93zGWiTwa59A82Fm767te3WHEBD
        4BliZoiZ/zb1jwrfXDx+WAo47nCaNXCiCanzT1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30323D3668;
        Thu, 26 Aug 2021 12:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB615D3667;
        Thu, 26 Aug 2021 12:33:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 1/2] pkt-line: add packet_fwrite
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
        <20210826100648.10333-1-jacob@gitlab.com>
Date:   Thu, 26 Aug 2021 09:33:38 -0700
Message-ID: <xmqqilzsf9nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DE57B8A-068B-11EC-8CBF-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> This adds a new function packet_fwrite which works like packet_write,
> except it writes to a stdio stream.
>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  cache.h        |  1 +
>  pkt-line.c     | 16 ++++++++++++++++
>  pkt-line.h     |  1 +
>  write-or-die.c |  6 ++++++
>  4 files changed, 24 insertions(+)


I wonder if our readers are all proficient enough not to require
some comment to warn them about the care that must be taken when
packet_fwrite() and packet_write() are mixed together (i.e. stdio
flushing, etc.), but other than that, this sounds quite
straight-forward.

