Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC9AC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71C4208A9
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 15:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnw3mRMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgHDPT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:19:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57385 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgHDPTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 11:19:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FF8BD399F;
        Tue,  4 Aug 2020 11:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+l4wyBFLuCZIfHeZLLA3NxHwWno=; b=fnw3mR
        MREcMWMj5gl7v1Cgs8FlKztmGqxLMl66PlUpC8u3JCos+9rrojYpEZoUVeSkMB7s
        6C0Ygk1WWJi40WOG2rLnGhTUEIhp07CP98gHeO9Vw1GbiYobEwNGEWChkHl1+m8S
        Da5r8MyF+06YdKFv8P3EDPE+F14+Y8XCGK+yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MDiM7EIACGILrXsOB1vYWojknqwMKu9n
        YjBa/tUm7FF13pANMbSBI3QZO9aOI4wdwK06m1t5T3pCQ7hQgCkQ5xPosgmCespO
        VM2zzomYKZE4FRziv7pIZUQXZ5bzWxRIw0ZjLBqjOEY2n3rv9sKayvn/yftSqEoI
        GD0oGXeOTpQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 767D2D399E;
        Tue,  4 Aug 2020 11:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2F9DD399D;
        Tue,  4 Aug 2020 11:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Amir Yalon" <amiryal-mljwnltxmo@yxejamir.net>
Cc:     git@vger.kernel.org
Subject: Re: git blame --ignore-rev to accept tree objects
References: <9e184f84-9658-4562-88ea-50039b19aea7@www.fastmail.com>
Date:   Tue, 04 Aug 2020 08:19:19 -0700
In-Reply-To: <9e184f84-9658-4562-88ea-50039b19aea7@www.fastmail.com> (Amir
        Yalon's message of "Tue, 04 Aug 2020 10:40:16 +0300")
Message-ID: <xmqq4kpitp54.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF788D2E-D665-11EA-AE1A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Amir Yalon" <amiryal-mljwnltxmo@yxejamir.net> writes:

> How practical would it be to implement this feature? How bad could it be, if some unrelated commits with the same tree would be skipped unintentionally by git-blame as a result?

I would say it would be horrible, if the instruction to skip a wrong
commit is baked into the commit object and cannot be corrected
without rewriting history.
