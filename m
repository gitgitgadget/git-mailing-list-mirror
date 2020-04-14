Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78994C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3877B20767
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="quHYnDXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503453AbgDNSKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:10:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50402 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgDNSKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 14:10:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA845BC8E8;
        Tue, 14 Apr 2020 14:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HF2aMX9jqzfEQ+93+oR86TIdakQ=; b=quHYnD
        Xgtlx+2aQ5HKJETpb/+6s87xG1qfsfuhHFN5Sg3E2r11LkCYOtzG87/baHqHIhpe
        bc8ygrOD04FgJSTALVTUkM9D6l4MeXu8rqfX9Fulgr9/ebv5p0tbIDLMgSyfHzee
        GbBDwD/Va3AyIRvZj5F1WhrMe3XoY4zeMxZrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GVk6cxLsdx5jiOKTdqeHnrkYw0gt7xxZ
        SQpPoK3BRLNgx0hfRgqMPtG8j8M5FvCvMA1QB1zDE6x0lkyUTAVW11SDBeM7D+8t
        9P4sgS1Futu/lU1L4Ud39yGjgdxKlWTrYjCosaZOiQrw6Tqu6DVFtiZSlSSxxNDY
        55Jx1Saealo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2A0BBC8E7;
        Tue, 14 Apr 2020 14:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B76F9BC8E3;
        Tue, 14 Apr 2020 14:10:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] log: add log.excludeDecoration config option
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
        <xmqqeesq9e8p.fsf@gitster.c.googlers.com>
        <5c8cd2dc-f1e2-5c93-094c-e15e45e8543e@gmail.com>
Date:   Tue, 14 Apr 2020 11:10:02 -0700
In-Reply-To: <5c8cd2dc-f1e2-5c93-094c-e15e45e8543e@gmail.com> (Derrick
        Stolee's message of "Tue, 14 Apr 2020 13:49:47 -0400")
Message-ID: <xmqqtv1m7xc5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A855E3E-7E7B-11EA-B006-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  * Given that we have command line options to specify what patterns
>>    to include as well as to exclude, it feels somewhat asymmetric to
>>    have only the configuration to exclude.  Should we also have a
>>    configuration for including?
>
> I left the other side out for simplicity and because I didn't know
> the use case. It seems all refs are included by default.

It is a bit more subtle than that.  

Once you have an inclusion pattern, nothing is included by default.
Only the ones that match an inclusion pattern would be considered.
When there is no inclusion pattern, we behave as if there is a
match-all inclusion pattern.
