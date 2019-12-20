Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31320C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4212146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SY+Gucul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfLTWO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:14:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59921 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLTWO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:14:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DE609ABF9;
        Fri, 20 Dec 2019 17:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sbCbjp5MrdXt
        eUdqcabbsMw4zp8=; b=SY+GuculjjrDrZhuQD1WQGL3+STbGnFN3EOwZ+rVSOq3
        rpG1QLWFFxDQRdP9wzxcibq5vKNy4ruXi+D9AWtUKJsgpzQu0MhNg7C8ZAIvs2R2
        /keVZyzUIETou1haeswfMeNhs7LW/3Cm86XusOc2POE4u+Gn/TRWf/AfDO7GDEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fMlZ8T
        Hn0E0p4ErA+Q29V5eIotmhMOKcRk+5uxJFAlCfnOgAASc5Dh5I+kGOVKFzSqryQp
        fXFxIdX3fs2mwdbycaUyUWCY3tGWIY7673wU4aAfPY9sE9AKYjefOBK8VGHLjpyT
        CAgRoTISg2Tbh67lFqK7mwkehmRPlT09mlNlM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 955A49ABF8;
        Fri, 20 Dec 2019 17:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6971C9ABF6;
        Fri, 20 Dec 2019 17:14:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 14:14:19 -0800
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com> (Garima Singh
        via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:11 +0000")
Message-ID: <xmqq5zia8x1g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 12AA4410-2376-11EA-954A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Adopting changed path bloom filters has been discussed on the list befo=
re,
> and a prototype version was worked on by SZEDER G=C3=A1bor, Jonathan Ta=
n and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] a=
nd
> presents an updated and more polished RFC version of the feature.=20

;-)
