Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D3C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6064560F9B
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 22:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhG0W4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:56:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53165 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhG0W4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 18:56:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 770BED18AA;
        Tue, 27 Jul 2021 18:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OZVvBIG4o6dZT+iybShPfuSkdRy3Gb5jGO5ioX
        Q6jhI=; b=gU044YPpN6LXBqKE6lbr7prlZ5qAeisiyLex9cKOk8x+5lWxswSo+/
        py1y88gOQf8zqS49g5/Ucu2dvHQWA7y9D/IuaAX2wAuzomGUXFbdGf73uhFJ+qo/
        P8Xhkd+otOYonuWSbgZUVNB8yiiUO1aWB1TXKKRk1AIB2ZBzhmUQs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E3EDD18A9;
        Tue, 27 Jul 2021 18:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED607D18A8;
        Tue, 27 Jul 2021 18:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
        <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
        <xmqqh7gghgtd.fsf@gitster.g>
        <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
Date:   Tue, 27 Jul 2021 15:56:47 -0700
In-Reply-To: <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de> (Fabian
        Stelzer's message of "Tue, 27 Jul 2021 09:57:48 +0200")
Message-ID: <xmqqfsvzcqmo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC2CF0F0-EF2D-11EB-8724-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>> I think Fabian's "ssh signing" is not as ready as this topic, and it
>> can afford to wait by rebasing on top of this topic.  By the time
>> "ssh signing" gets into testable shape (right now, it does not pass
>> tests when merged to 'seen'), hopefully the "expand install-prefix"
>> topic may already be in 'next' if not in 'master'.
> I think the test problem is not due to my patch.

I've been seeing these test failers locally, every time
fs/ssh-signing topic is merged to 'seen' (without the reftable
thing).

Test Summary Report
-------------------
t5534-push-signed.sh                             (Wstat: 256 Tests: 13 Failed: 2)
  Failed tests:  8, 12
  Non-zero exit status: 1
t7528-signed-commit-ssh.sh                       (Wstat: 256 Tests: 23 Failed: 2)
  Failed tests:  13, 17
  Non-zero exit status: 1

When reftable thing is merged, either compilation fails or t0031
fails, and I suspect that these are not due to the ssh signing
topic.

