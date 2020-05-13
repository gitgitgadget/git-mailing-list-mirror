Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DCEC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4E20575
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KpKTUt8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbgEMUXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:23:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62369 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbgEMUXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 16:23:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66828BCEAE;
        Wed, 13 May 2020 16:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jNOapf7J8Da6ZkrszQrSE4EOhcY=; b=KpKTUt
        8WUAiPV0lCgV5Kn+TXYHzexoNwjvWQSZQfCzvTnxVf73Srj9ZSsY3k+oxu9e22VC
        DziR6bMKwKt+/RM8mLlj6BZpIyv+Zy4ajFqf/H7UcE9kRT1px9RNGeQgjoQE+DtC
        WLeVtGh7IEpWQCI/eJ3gqnwqBQ57azloqUTJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rVdU58WVjZ9fWWEAQ+MFM8nWBJZkjV5o
        +64V9rH1xMdnr9YXvrLrwDNX/Wg19WobLJpnynDkE74PDfxuM7irkl0DRwg76Tjx
        E/KAA8ENdeJwBda40HAugQv74+TAOYOf7JJ2GnKceDWCLQho/Rg5Q5SVE3lYGo0N
        knYkzwJlvDo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E3A4BCEAB;
        Wed, 13 May 2020 16:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F509BCEAA;
        Wed, 13 May 2020 16:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 10/11] cmake: parse the makefile for the sources.
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <b0a321a714a766962456e2a9e8dd7d2be349e34d.1589302255.git.gitgitgadget@gmail.com>
        <xmqqk11gc1d5.fsf@gitster.c.googlers.com>
        <CAKiG+9Uc8Kc1F3wN7AoLkBR8Uk1up5sZXpgUperhQO6NVmBRxw@mail.gmail.com>
Date:   Wed, 13 May 2020 13:23:11 -0700
In-Reply-To: <CAKiG+9Uc8Kc1F3wN7AoLkBR8Uk1up5sZXpgUperhQO6NVmBRxw@mail.gmail.com>
        (Sibi Siddharthan's message of "Thu, 14 May 2020 01:27:50 +0530")
Message-ID: <xmqq1rnntwi8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92411502-9557-11EA-9B48-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> On a side note, why are we using SCRIPT_SH and SCRIPT_LIB separately?

I think _SH are commands to be installed as executable, while _LIB
are to be dot-included and installed as non-executable.  

There may be other differences; they (i.e. what the Makefile uses
these lists for, how the elements on these lists are treated, etc.)
are something you need to know before you can reimplement the logic
of building and installing used by the current system in a different
build system.

Thanks.
