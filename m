Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BBC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 05:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E50206FB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 05:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WrCm9gjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgKDFln (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 00:41:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgKDFln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 00:41:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A0269E12F;
        Wed,  4 Nov 2020 00:41:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ZRvsFOg5MPbYl4ou/qvPV6HGtc=; b=WrCm9g
        jykf9sO4ZCp4alB1d4yvgQ1MT6sfKxiFFdTc1LsezSTqBJ7cYhcZttCMRJ5x0yMM
        rFg75zeBmpvGeSCYOTGEecEnQUfxXB5klx6Q/ZhZFUvlozNylzvworvfegZU+l7k
        e9y6m0gWYebm7i29zyHT05fJCkXu3/dR2wBP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ceru0vGZ8a2qxQX5lfW6Oa3SgVL8Wk0x
        JiVOoWAw8kj7+M1GftmEHu6Lk1HYp8EJCTrOdybllH+cTIwPtYlGIWuvk3dZu2V1
        YbSxrNvnvswFYpuNBQOWUuKe0JM4sa1VMxmYm1jZWrGghXoKoTIbZghaMiBgh3V9
        57ZOrBIedTU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7281B9E12E;
        Wed,  4 Nov 2020 00:41:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1DB89E12D;
        Wed,  4 Nov 2020 00:41:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: support comma-separated fetch specs list?
References: <CAKkAvaxrG0aYw-wo_WW7zSkX=mjU8ABgXGbbPCFOhMBa4WTJ+Q@mail.gmail.com>
Date:   Tue, 03 Nov 2020 21:41:41 -0800
In-Reply-To: <CAKkAvaxrG0aYw-wo_WW7zSkX=mjU8ABgXGbbPCFOhMBa4WTJ+Q@mail.gmail.com>
        (ryenus@gmail.com's message of "Wed, 4 Nov 2020 11:11:42 +0800")
Message-ID: <xmqq1rh9ptka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AA8CD04-1E60-11EB-BFCD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ryenus <ryenus@gmail.com> writes:

> It's nice to have negative ref spec support with 2.29 release, so now
> we can have
>
> ```
> [remote "origin"]
>   fetch = +refs/heads/*:refs/remotes/origin/*
>   fetch = ^refs/heads/gh-pages
> ```
>
> What about having all the fetch specs put together in one comma-separated list?
> Like this:
>
> ```
> [remote "origin"]
>   fetch = +refs/heads/*:refs/remotes/origin/*,^refs/heads/gh-pages
> ```

I thought comma was a valid character that you can have in refnames,
so no, I do not think it would fly without breaking existing users.

What problem are you trying to solve?
