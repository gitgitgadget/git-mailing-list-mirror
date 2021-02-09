Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65EC43217
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40AC64E5A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhBIUyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:54:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50258 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhBIUtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38D5D98BE1;
        Tue,  9 Feb 2021 15:47:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urye03v9sUaaGEv57ZQoWSv27P8=; b=fEOmS5
        tOnSnKF3ctf31Axm/tpkU1zHuI4BV1tkRPVO0i75/k6JcTOp1x18W2M5HjCaghxJ
        fhc0yAu+9b2MzyKI7k405wwTs6IP607vK6DJl15sk4+tye4HT8ZlEgbESpqd3whD
        7CeWAnhrZ0adNza4bdbYSfgnIkv4R61xjhMo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FXbQlMuXw/OZAuSrh2tvlHzYygeg6oPN
        mJJ8KQzaKqVudmfYHdUWNjskgfGUNA0sMxxNfwurid6YFcNafxblc5/lAZe2Nn1X
        VbkNk93S6jYJTDsb+U+GNkEYcE6fUNmtgVxEGige/+vzl80Bn/BnX5BrKze3bYGz
        5ZepLSIT1Kc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E81598BE0;
        Tue,  9 Feb 2021 15:47:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91E3E98BDF;
        Tue,  9 Feb 2021 15:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 12/17] chunk-format: create read chunk API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
        <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
        <1278de82-417c-a6ee-a5fe-055fa0ef1903@gmail.com>
        <xmqqeehu1f1q.fsf@gitster.c.googlers.com>
        <xmqqh7mm42ml.fsf@gitster.c.googlers.com>
        <abd61648-c351-e849-9cf1-ddabff514743@gmail.com>
Date:   Tue, 09 Feb 2021 12:47:32 -0800
In-Reply-To: <abd61648-c351-e849-9cf1-ddabff514743@gmail.com> (Derrick
        Stolee's message of "Mon, 8 Feb 2021 20:33:29 -0500")
Message-ID: <xmqqlfbx0xzv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08375D66-6B18-11EB-B060-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> In future series, additional protections could be added, and
> I would expect that to be done by converting callers of
> pair_chunk() into callers of read_chunk() with appropriate
> callback functions.

I am perfectly OK with leaving the interface as-is, as apparently it
is sufficient for the current callers.  

It was just it looked insufficient for future callers that do not
want to use the callback interface, i.e. learn the <ptr, size> pair
with a single API call and then handle the data in that region
itself, instead of preparing a callback function and calling
read_chunk() on it.  As C does not have closures, it gets quickly
cumbersome if such a caller wants to share pieces of information
with the callback function that is given to read_chunk(), but a
caller that learns <ptr,size> from pair_chunk() and then works on
the region of memory itself do nto have to worry about that.

