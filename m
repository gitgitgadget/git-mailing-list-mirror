Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE4C433E1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5036197E
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 20:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSU4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:56:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhCSUzr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 16:55:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5459BBE3C;
        Fri, 19 Mar 2021 16:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=suDsCLV6Zr+v6X+hzpTmRUI2SWI=; b=ExQIlW
        gCT3aZ4I20inq08iBP4MYVfuBAPmFGOOGaqlEU6YyOD02/f3IAuQ0OD04xWhTTR2
        buG9/dwMn9u5gH7S21Omz+T5JcyU2v5XMbSPC9Bg8TL01j0PQmrW4rtgwbjDoP74
        oxV3XY5b5RHvdvQxYzrBPT53n9MkRYPqC2XRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aVFY3oUzKdmcF8RtnIcwHFGx/OZwDM21
        Hli8/ZdrewGVFQJGlB7RfZ4zbFdZQaZhGLh286UQ75vCWda3NJJKVZ7MlpY8e33D
        6iETcBgf2eG2jw3jlrAMQGumoY5kBQPBkdd6jxj75707lPQ5ohG915XpDN+bCRx3
        zBS7VVkRNMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA10BBBE3B;
        Fri, 19 Mar 2021 16:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23CCABBE3A;
        Fri, 19 Mar 2021 16:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] builtin/pack-objects.c: ignore missing links with
 --stdin-packs
References: <815623da67d283e8509fc4ac67e939c6140fc39a.1616168441.git.me@ttaylorr.com>
        <xmqqim5nm2g0.fsf@gitster.g>
        <YFT8LqAcCqpG2wyl@coredump.intra.peff.net>
Date:   Fri, 19 Mar 2021 13:55:45 -0700
In-Reply-To: <YFT8LqAcCqpG2wyl@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 19 Mar 2021 15:31:58 -0400")
Message-ID: <xmqq1rcan9ri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A174B4E-88F5-11EB-A253-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If they are truly unreachable, then it is not strictly wrong to delete
> them (i.e., we are not corrupting a repository unless it was already
> corrupted), but:
>
>   - if the repository _is_ already corrupted, we are definitely making
>     things worse

Yes, that is a reason enough not to eject a commit whose tree is
incomplete.
