Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1660C48BDF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8857261059
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFNBGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 21:06:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50004 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhFNBGY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 21:06:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDEDB132933;
        Sun, 13 Jun 2021 21:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gp8EyCo97g4SDJCJ+USkCZnjFPfn+1Swu/u2cJ
        DCF44=; b=t9YRt3KS1EKkdT5eGQT5/R0fOt2+W8y4k1i/QCmPmnjbYgTgKLeIq2
        0kUsssrNBru/f7SEcJ11prho5UZmvripnt/5P/7ZyHVgSrO2uqj3mzckxIMulmZd
        zPO38MOrsmmt56mzaZfNkTMrusk/s7ofxI1Hn0iPza73Gseg+SkWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5FB9132932;
        Sun, 13 Jun 2021 21:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 106EA13292D;
        Sun, 13 Jun 2021 21:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 3/3] builtin/checkout--worker: memset struct to avoid
 MSAN complaints
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
        <cd1e1f6985c77d21ec869e53dc5eb79673caf491.1623343713.git.gitgitgadget@gmail.com>
        <CAPx1GvfF7NZD4RMWWZCfny2gQOt1GY=TUm1HxvC+kwwDsc4Rgw@mail.gmail.com>
        <xmqq7dj0530s.fsf@gitster.g>
        <5a7a57d8-3704-4531-44f5-4d0d48ec376c@ahunt.org>
Date:   Mon, 14 Jun 2021 10:04:18 +0900
In-Reply-To: <5a7a57d8-3704-4531-44f5-4d0d48ec376c@ahunt.org> (Andrzej Hunt's
        message of "Fri, 11 Jun 2021 17:37:40 +0200")
Message-ID: <xmqqk0mx1ckt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73011E02-CCAC-11EB-B756-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Hunt <andrzej@ahunt.org> writes:

> (At the time I wasn't aware that this would include all members and
> padding, but I've learned more since reading the clang developer's 
> discussion around padding and brace intialisation :) :
> https://reviews.llvm.org/D61280 . )

Thanks for a pointer ;-)
