Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF04C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E282100A
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q1f//UbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgFSRoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:44:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63121 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbgFSRoj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:44:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C0EC801A;
        Fri, 19 Jun 2020 13:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4uYRf637NQiedMSY/iQgzDH1yBI=; b=q1f//U
        bWRc/R4kK/O4xkoWOz0rlvgxUkcXbaAacgNRbFDf1+Fk8NLLMiGC/a63S1FtQo0T
        nP4cxYNOFMhT2KzimK/HZcr7U2I36fF6AK+Tt5s28H6Cs2nxvkbpvDaYyxSRK/JV
        K79X1UIUC6egWEDxmEtPAwKg19vh3E+wNk/Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M23CCm84UhHRtqzpdOmqXx4ydwgFIQD7
        0XJNQ2x5v8BIwO5IMu879Bcx5IYtAtGGmFD6wD9F2c7TTi0Q4QMg38VNWZot5tQK
        C1J1T+k+I2j3/4Z6XjGcr4NA7Acpv1TwQHoWbLBvojZZaQUnOShurh+KUMS5Xc/o
        UgbkhB+O64c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB599C8015;
        Fri, 19 Jun 2020 13:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A515C8014;
        Fri, 19 Jun 2020 13:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        jnareb@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [GSOC Patch v4 0/4] Move generation, graph_pos to a slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200617091411.14650-1-abhishekkumar8222@gmail.com>
        <d5131361-2945-3daa-d91c-67761908b8ef@gmail.com>
Date:   Fri, 19 Jun 2020 10:44:32 -0700
In-Reply-To: <d5131361-2945-3daa-d91c-67761908b8ef@gmail.com> (Derrick
        Stolee's message of "Fri, 19 Jun 2020 09:59:38 -0400")
Message-ID: <xmqq7dw3hrwf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89873EAE-B254-11EA-B570-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/17/2020 5:14 AM, Abhishek Kumar wrote:
>> The struct commit is used in many contexts. However, members
>> `generation` and `graph_pos` are only used for commit graph related
>> operations and otherwise waste memory.
>> 
>> This wastage would have been more pronounced as we transition to
>> generation nuber v2, which uses 64-bit generation number instead of
>> current 32-bits.
>
> Thanks, Szeder (CC'd) for the quality review in the previous
> versions. I manually built and tested all of the patches here
> and verified they passed all tests.
>
> I think this series is in good shape.

Thank you to all who are involved in this topic.  Looking good.

