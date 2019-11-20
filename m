Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8EC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7246C22449
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSDDWoaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKTAhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:37:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59196 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfKTAhS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:37:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2457C95D13;
        Tue, 19 Nov 2019 19:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j5rZDnesQmCqrlzwflxqa13Qang=; b=OSDDWo
        aC7NVy/gWajR7Ypv8eCZ12YVhHk8zcHvmyJOK8BWQzwMWlhuoIGZkADMmgi+H28h
        FlnTpubz4LSNXBodhxW+q6F1s57alRZOLHiEQxf7N3C/fnW2aNC78QfhSPQVWQQu
        TWmDyRgTzdO4GGjGgmWQ/6PvfUTAxWWEydrsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qilCUE5XyIUfTGFCqhxT0YFxyIvR2tUU
        4VSTtkUoH5vWMOPdJQRreITtpF1NEHDEgkmlGxvc3/nAxhcHoDacFTaOkQOxCMcB
        X9G1iXxtfvzmfjeXXg6+PgkcTjbBeUtyVgS/rjyDPI9udqzYuegph6/lOt+QwIdL
        4YmKZZvBoGw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C45795D12;
        Tue, 19 Nov 2019 19:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A6E195D11;
        Tue, 19 Nov 2019 19:37:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
References: <20191025025129.250049-1-emilyshaffer@google.com>
        <20191025025129.250049-2-emilyshaffer@google.com>
        <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
        <20191119202542.GB36377@google.com>
        <nycvar.QRO.7.76.6.1911200018470.15956@tvgsbejvaqbjf.bet>
Date:   Wed, 20 Nov 2019 09:37:11 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911200018470.15956@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 20 Nov 2019 00:24:44 +0100
        (CET)")
Message-ID: <xmqq4kyzfknc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E517F1D8-0B2D-11EA-AD6C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I disagree with the idea that a tiny built-in command like
> `bugreport` would "bloat" the main `git` binary.
>
> In contrast, I think that stand-alone commands _do_ bloat. Look here:

I probably should have clarified that "bloat" in the context of this
discussion is not about on-disk space.  It is about resources needed
to run "git status/diff/etc" that are everyday local commands that
are expected to be lightweight, i.e. the same criteria applied when
making the networking part (which the user expects to be coffee time)
separate from them.

