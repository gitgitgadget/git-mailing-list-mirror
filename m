Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFF020798
	for <e@80x24.org>; Thu, 12 Jan 2017 06:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750719AbdALGVJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 01:21:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60687 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750698AbdALGVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 01:21:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F104E5C823;
        Thu, 12 Jan 2017 01:21:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CnjpW7BE4Huw6muYqVxZWfvjd8c=; b=SRsyt9
        mN09hPnFWF9x4H0A9baUvR55H+yVvjKCvfYNFim+rGHo6CCF3QFFfNng6WP3W2k7
        FCJzgNvKiiPlS08hKQw0hcAOrQzuZlAxzRYVcDzvkFsh0ilzadnREmTvYlwo1R+p
        6SSRtxSwZBofRKg0KxlYFMuUE4dmAxCZbgrW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d2HDD+xcnl0a53L3B6C+U60fQZFZcl9x
        Y1crw/WZ/j+YWkZbUmxiIBAwI5YQat4fKTZFKLLYpZg/vopIN2agpimjGNFgOB0w
        JFtm8VfZvfDnLyx1da8Qt8UWCwJRx137yvwEM7ujLRDvFOY4h7hZE6Xe6plk5L7l
        ON/ZyJJooVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D98345C822;
        Thu, 12 Jan 2017 01:21:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41D4B5C81F;
        Thu, 12 Jan 2017 01:21:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pat Pannuto <pat.pannuto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Use env for all perl invocations
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
Date:   Wed, 11 Jan 2017 22:21:05 -0800
In-Reply-To: <20170112055140.29877-1-pat.pannuto@gmail.com> (Pat Pannuto's
        message of "Thu, 12 Jan 2017 00:51:38 -0500")
Message-ID: <xmqqa8awn6i6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D757EDC-D88F-11E6-8B5B-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pat Pannuto <pat.pannuto@gmail.com> writes:

> I spent a little while debugging why git-format-patch refused to believe
> that SSL support was installed (Can't locate Net/SMTP/SSL.pm in @INC...)
> Turns out that it was installed for my system's preferred /usr/local/bin/perl,
> but not for git-format-patch's hard-coded /usr/bin/perl; changing the shebang
> allowed git format-patch to work as expected.

Isn't that an indication that you are not building correctly?
Perhaps

    $ git grep 'Define PERL_' Makefile
    $ make PERL_PATH=/usr/local/bin/perl

would help?
