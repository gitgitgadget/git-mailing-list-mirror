Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67541C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1333620720
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F6OzJ3t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHUSe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:34:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53118 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgHUSe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:34:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FE13E3787;
        Fri, 21 Aug 2020 14:34:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ki3nGDTpIwYCha1B7KKZSWrR4OY=; b=F6OzJ3
        t3N4hQhEDtk2RtdRAi1y2GfCkp0Ci5P1bOBw8Rqes4L4pu1ZTUAeahPOviBNohCC
        i+Xu0wx8Cuwkq3z4GDZQbsEDr7QhhlTowYenkApbqeMPXf8l2sB4EIl4uHdk8zSq
        c0td8bwLvgEJv7tgxf239rSpzYSJsWoDgsFjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lHVNQ0R5gL+0nnFA2wL/0LE8c4Mx9U69
        fDnV2rgtDw2BIwZMoZimzAPnZsE8FFd8Nvy6f+mQ1opWl6hNpSicd6RvOtCJU7kl
        E1XWc0T9adkzNtFnTA5zEnggFsE2G5ig07HlFsHdDMdhTOT9ht0Ro8Y255ZyVpnO
        MAPlkofwVYQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 385E7E3786;
        Fri, 21 Aug 2020 14:34:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 682A3E3785;
        Fri, 21 Aug 2020 14:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/4] Use refs API for handling sundry pseudorefs
References: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
        <pull.706.v3.git.1598029177.gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 11:34:49 -0700
In-Reply-To: <pull.706.v3.git.1598029177.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Fri, 21 Aug 2020 16:59:33
        +0000")
Message-ID: <xmqq1rjzalva.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFEF9730-E3DC-11EA-8A62-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series changes the handling of CHERRY_PICK_HEAD and REVERT_HEAD to use
> the refs API, as a preliminary refactor for reftable. 
>
> No functional changes.
>
> Han-Wen Nienhuys (4):
>   refs: make refs_ref_exists public
>   sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
>   builtin/commit: suggest update-ref for pseudoref removal
>   sequencer: treat REVERT_HEAD as a pseudo ref

Thanks.
