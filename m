Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7C2C4320A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E05A60E74
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhGVSQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 14:16:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhGVSQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 14:16:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 426E513022D;
        Thu, 22 Jul 2021 14:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QOllk+TPFulyjy29B79yCHpnrQ7k0CClUchteZbbM6Q=; b=Uu0M
        oX/v9sEyFLPcQBPFozmr/hURhvcf25dd8cKQmL9RiLasAj+jHdeyQ3iAN1U+FF0O
        bFtaVFVQp6B+Me1Kp2qoAttoH7A6BcIsPCqG4NWMSG43p8OusTSMtUA/16x+xmlk
        vssIaEwc0YjxKvJslwQE1dnisqa//pr9sbzP6JM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BEA513022C;
        Thu, 22 Jul 2021 14:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D5D513022B;
        Thu, 22 Jul 2021 14:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: pull.rebase config vs. --ff-only on command line
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
        <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
        <60f1b7853b8a2_ade9208c1@natae.notmuch>
        <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
        <60f1c9378d5a1_3302085c@natae.notmuch>
        <fa757764-db25-849d-d8d5-e28908059f6b@aixigo.com>
Date:   Thu, 22 Jul 2021 11:57:16 -0700
Message-ID: <xmqq7dhi9nxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A33F2A1A-EB1E-11EB-BD29-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:

> If my assumption were true, and every explicit (cli given) option
> would overwrite implicitly given ones (i.e. configured options),
> wouldn't
>
>  * git -c pull.ff=only pull, do a fast-forward (or merge)

This should fast-forward if it can or otherwise fail if it cannot,
right?

>  * git -c pull.ff=only pull --merge, force a merge commit

This would fast-forward if it can or otherwise create a merge.
Unlike "pull --no-ff", this should not "force" a merge commit.

>  * git -c pull.ff=only pull --rebase, force rebase

This would rebase (we may not have our own commits on top of theirs,
in which case it would end up fast-forwarding plus rebasing 0
commits).

I do not think the phrase "force rebase" makes much sense, though.
