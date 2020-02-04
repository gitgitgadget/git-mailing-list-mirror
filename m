Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF2CC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641E020674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q3pP1zCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBDTzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:55:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51864 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBDTzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:55:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3326A3C2A3;
        Tue,  4 Feb 2020 14:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n40vBdUoiyWOuZexSFHz12mKRS4=; b=q3pP1z
        ChXeGB1vndl5AnVLMCucJtOfztDCcuBZNsSx3NyORrlTw3/S94lh+WdHm35CWEqG
        Y1gCvJA702JylaMRzffJV53AEQhefyXKMnDHOv98Q1BygLx4M6/E61a4X6v8i7Vz
        lJtOhEGpW7oHo3G+Qd9XKna5l9Op5TS/tmPFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F9vm0pfg654yDwleJiBbv16gmiSpr9/9
        iTTToAtNBYEmJ8+m3EthpDguWUYx9bYydjyZbdiiJnpG/B/MhS3Rv/EpfhRO2Aad
        JgaY5K0bpkD3mzm0iLbDeRdU5RjML0qfzZqwJPCAmhZUblzvL5vnNUFSkS7AdFj+
        G2oX3R/jm6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBCCB3C2A0;
        Tue,  4 Feb 2020 14:55:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D02B3C29F;
        Tue,  4 Feb 2020 14:55:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        martin.agren@gmail.com
Subject: Re: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct write_commit_graph_context'
References: <d9819cfb33ad95d4206dd1bbf4b38b7fdf69130f.1580764494.git.me@ttaylorr.com>
        <5d3819180dbc9bc33a8fe4354e2320f497151fb4.1580795403.git.me@ttaylorr.com>
Date:   Tue, 04 Feb 2020 11:54:58 -0800
In-Reply-To: <5d3819180dbc9bc33a8fe4354e2320f497151fb4.1580795403.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 3 Feb 2020 21:51:50 -0800")
Message-ID: <xmqqzhdy6sbx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A05D4A8-4788-11EA-8778-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Whoops. In v2, this patch introduces 'find_odb()' as a function in
> 'builtin/commit-graph.c', but does not declare it static. This causes
> breakage in gcc with '-Wmissing-prototypes'. Here is a correct version
> of the patch that does not cause such breakage.
>
> -- 8< --
>
> Subject: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct

What happened to the rest of the line ;-)?
