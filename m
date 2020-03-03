Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CEAC3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D852083E
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZskQgUym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgCCOQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:16:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51896 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCCOQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:16:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F0CBC4751;
        Tue,  3 Mar 2020 09:16:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G9+S2O8veHKHvP9BZTqoNCa5Bps=; b=ZskQgU
        ymh7mYY1o6xsd70dysHyTVBTgd2IYYVZwWLWRDK44J6t+Y4HRRSRKSy6v/yRZ/15
        /8YMPBtYRNqvsMMDtFst0raJmpFrSo6WC7iICMD5xnLtG1xEwVMa08Xf1u8z5N29
        mbQmhSGzpuYW5iAmGeV0GfhNlGRTK7jbPPPXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qzpjL0cRm+JP7fSkhRZeXNVYekmMyU4N
        3qwOvPae+ykc4VxOwkaPwppR3U4TBptie437m55LvqqfTHp3XKDVZp3FhWYs7143
        wXSVy2VjsuD3vlG8uXhPTrXvNbP5cCN5/u6OPlgg3qobtCi0QBQS+Ojl+Th4F213
        LFqNZQs+muM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 376EAC4750;
        Tue,  3 Mar 2020 09:16:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 261EFC474D;
        Tue,  3 Mar 2020 09:15:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v7 3/4] advice: revamp advise API
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
        <a4673803eaf881f7caa25d97e432c0ff0d065060.1583179320.git.gitgitgadget@gmail.com>
        <xmqqblpebhae.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 03 Mar 2020 06:15:57 -0800
In-Reply-To: <xmqqblpebhae.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 02 Mar 2020 13:03:53 -0800")
Message-ID: <xmqqlfoha5ia.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8157EE72-5D59-11EA-AEEF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +static struct {
>> +	const char *key;
>> +	int enabled;
>> +} advice_setting[] = {
>> +	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
>
> It would be nicer to future developers to flip the polarity, as we
> do not have to write 1 all over the place, especially if we plan to
> extend the structure over time and to use designated initializers
> for only certain fields...

Just to avoid needless churn, I think this does not matter in the
longer term, so .enabled is OK as-is.  The reason I say so is
because, even though renaming to .disabled to allow initializers to
default it to 0 is nicer for those who write the initializers
manually, and it especially is true when we have more fields in the
struct (we may add descriptive text so that we can issue an on-line
help, for example), but I expect that would happen much later than
we start generating these parts of the source code in two places
(the initializer for advice_setting[] and the advice_type enum) from
a single source by mechanical process.  And the auto-generation will
eliminate the burden of writing 1 manually.
