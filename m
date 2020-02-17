Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C809FC34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE39207FD
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JL7vSGYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBQR4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:56:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51511 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgBQR4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:56:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8320C54003;
        Mon, 17 Feb 2020 12:56:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GwYXAEswKlSGONCG0oDcOVQ1XCQ=; b=JL7vSG
        YIu21kQqKRsVCxcPWZVKv9c1s4KXW6bH6KhspaukQU7n2+tcKFn2GoeOlIOBofOV
        NOXL895MgowCm+BAcozpuUGQbEIA+JYdYBgC5H2u5upc9+/buS5Yhhl5xx8Bzq2g
        1fHK1gQ5rYINcZA1mg7qTRQhuJL00lUz8wN6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YR6BIruBdi4Oi1NliF44byyqRukA9NDS
        oRkFmGxL4OXKrkZ5gPXVdzjHRTwIQBqpTsfhcppPIOEOi6GQMARElWGRKta/6mhc
        Ukhh2oVEuCYBAIkW+f/rVC/6mjy76IxlBmEqWoYt2f1UT3UGF7vTZrsJ9BmPk/O6
        WPOXF2cHME8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BCCC54002;
        Mon, 17 Feb 2020 12:56:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E006A54000;
        Mon, 17 Feb 2020 12:56:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2] mingw: workaround for hangs when sending STDIN
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
        <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
        <CAPig+cQWMvBi4vkAFMjV7LWjKJudja08ZqVMNfLfALxbBfpzXg@mail.gmail.com>
Date:   Mon, 17 Feb 2020 09:56:34 -0800
In-Reply-To: <CAPig+cQWMvBi4vkAFMjV7LWjKJudja08ZqVMNfLfALxbBfpzXg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 17 Feb 2020 12:24:01 -0500")
Message-ID: <xmqqr1ytksh9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6DF8C62-51AE-11EA-A20C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... For instance, t1050-large.sh uses:
>
>     printf "%2000000s" X >large1 &&
>
> which is plenty portable and (presumably) doesn't have such demanding
> memory consumption.

Yes, I had the exact same reaction to echoing large string with
literal backslash-en in it ;-)  Thanks for reviewing and teaching.

