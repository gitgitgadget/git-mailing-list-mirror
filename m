Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EC8C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190E3241A6
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FXOdWEQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502356AbgJUWXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:23:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51643 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440925AbgJUWXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:23:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27281FF102;
        Wed, 21 Oct 2020 18:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=adGh835xkg7MUtMiMneVP1b8cOw=; b=FXOdWE
        QRNXcfKlBvGdDQEpRXOUGerG+VryD9LUSboeLspH6NT8uM/eIuAKH2WxsCOmO8fd
        hVsm5SuDq8b9/QHbNZxY7Fs9rJlP6z1HovT2DXpNSy5Mcd0094kfaC9yYPvDPnjO
        VsFqKFg2SigOu/dUK0feLr6Oni46YKoBoPyAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wt5X1f73epPD8H5T2VX7f2UPd0ZQWfcc
        lt8Y3qb8Omo/8kM2vJlotb2Z1xL+VHLh0i+O6/EwloOUUUtPHvWWi5XhLes5AhrP
        xdyH64RoExMGSLZQoMuetRZhzJLNWPUZM/zO3H+3AifhkNLz3Glb6ZP8R/jI1u3r
        aYogOCLRHWY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F34DFF101;
        Wed, 21 Oct 2020 18:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6920AFF0F9;
        Wed, 21 Oct 2020 18:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/10] t4013: prepare for the new default branch name
 "main"
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <baeb01f70646ce0c7564f1a1f820fb011e124d97.1603135902.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:23:45 -0700
In-Reply-To: <baeb01f70646ce0c7564f1a1f820fb011e124d97.1603135902.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:35 +0000")
Message-ID: <xmqqtuun43ri.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 166DFF1C-13EC-11EB-BDEA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This patch is a bit involved, mainly because the default branch name is
> not only hard-coded in the script `t4013-diff-various.sh` itself, and
> not only in the support files in `t/t4013/`, but also in the _file
> names_ in `t/t4013/`.

There are some stuff in flight; let's hold this step before they
graduate to avoid clashing.
