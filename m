Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B6C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A552166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M2sUdoAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBDVot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:44:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62407 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgBDVot (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:44:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58F3052F86;
        Tue,  4 Feb 2020 16:44:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MPnW4ga0WjP6OIZBZ8FoFXma+5Q=; b=M2sUdo
        AJ7F56lduHKzbw68lcPOtCqVepnuxn6N4Q7nIxW0fBNrfU8xChau2Ya26ucVFeTY
        j7Mhw9kuI01HL59TsKJaHisbeu71uRnAsZRV2ZpBTc8kAEiJqgGY3QWOqf44RN0Y
        TTdrp9ZK2mDlELU2SjqvYPAQ9fhRiIrVIIWBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wpn0CF3VThigQ2DSw+9cASEaclWEXsWs
        UfA1YbYyGGAnMcgRwoVAqJAMMgC4JGAJF1rSkUsR7KcsXYvAQPT8EswcKWtvkjt9
        KlBjAYM9yWP1fsZCX3cPQqRgtxzJP7tFFs/YqpbAFGVcdVreNu4oGrW0+Y+WMQE4
        iTsetqXGrJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EE1552F85;
        Tue,  4 Feb 2020 16:44:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B25EF52F84;
        Tue,  4 Feb 2020 16:44:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        martin.agren@gmail.com
Subject: Re: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct write_commit_graph_context'
References: <d9819cfb33ad95d4206dd1bbf4b38b7fdf69130f.1580764494.git.me@ttaylorr.com>
        <5d3819180dbc9bc33a8fe4354e2320f497151fb4.1580795403.git.me@ttaylorr.com>
        <xmqqzhdy6sbx.fsf@gitster-ct.c.googlers.com>
        <20200204212833.GA42626@syl.local>
Date:   Tue, 04 Feb 2020 13:44:45 -0800
In-Reply-To: <20200204212833.GA42626@syl.local> (Taylor Blau's message of
        "Tue, 4 Feb 2020 13:28:33 -0800")
Message-ID: <xmqqa75y6n8y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FDD717E-4797-11EA-B0A6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Feb 04, 2020 at 11:54:58AM -0800, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > Whoops. In v2, this patch introduces 'find_odb()' as a function in
>> > 'builtin/commit-graph.c', but does not declare it static. This causes
>> > breakage in gcc with '-Wmissing-prototypes'. Here is a correct version
>> > of the patch that does not cause such breakage.
>> >
>> > -- 8< --
>> >
>> > Subject: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct
>>
>> What happened to the rest of the line ;-)?
>
> Heh. Your email made me chuckle since this wasn't the first time I've
> been asked about this today ;-). I manually yanked the 'Subject:' line,
> but not the continuation below it.
>
> I'd be happy to re-send a version of this patch to fix this, but if you
> don't mind slicing it up, that works too.
>
> Thanks,
> Taylor

Noneedtoresend. Thanks.
