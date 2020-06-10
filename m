Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B1EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399E12072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZyQjG7to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFJRiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:38:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55511 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgFJRiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:38:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D831F5B1B3;
        Wed, 10 Jun 2020 13:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LHgsj2x83H2yoMgLqlOjXCQD6JU=; b=ZyQjG7
        toPFn3GWbil7o+CZTmLf+wu2WlZ4ldWDFxncAIZ/iyJikW6eHuAi5qBM7P9BbKT4
        rkU/k/Mgcq0GuZnslY54XwCZP73ggA7vTSrzACnfmDCNFJeWVB2pt5jn4MYuvp0c
        DESVQ6I166A8vU9iO2epxnBj7QLIEOZEGmM38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QYB8gzKO8UtSPzXZvWEp04wDU+wXr/oS
        Rob7gXhsJzOJG+iCeY65k2AHPlnM1Ov0h/3hGD532yosAZz2iUMq30AheI9pDSdm
        e4c9vVAZxVorKpvrqb5/Dgjia1E+g8Ap2RMYAZP7/icJFO792RrEg8jUBLrODjDV
        zWpxaNMdBRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D14115B1B2;
        Wed, 10 Jun 2020 13:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D7655B1B1;
        Wed, 10 Jun 2020 13:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwenn@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "hanwen\@google.com" <hanwen@google.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
        <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com>
        <xmqqimfyg84j.fsf@gitster.c.googlers.com>
Date:   Wed, 10 Jun 2020 10:38:18 -0700
In-Reply-To: <xmqqimfyg84j.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Jun 2020 10:09:48 -0700")
Message-ID: <xmqq5zbyg6t1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C615A26-AB41-11EA-B32A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not offhand know we also use fdopendir() elsewhere.  I strongly
> suspect we do not.  Perhaps some platforms do POSIX.1-2001 but not
> ready for POSIX.1-2008 or something silly like that?

Searching "macos fdopendir" gives a few hits from other projects,
all saying that before macOS 10.10 they did not have fdopendir()
and their code failed to build on macs.



