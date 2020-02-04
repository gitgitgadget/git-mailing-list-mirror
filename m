Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A224C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFF62082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OaS9e/MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDTEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:04:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53965 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBDTEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:04:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F58AA58ED;
        Tue,  4 Feb 2020 14:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6djxe9FuMXZKAp6pf9oMiv3QHvA=; b=OaS9e/
        MWNRCjBcWkGpsx4kLYUaEVaFvcpaQg49Zg08iqQ/G/s7a9kOzCf+QX9Nmwx4AxVj
        aojIktXQBdi3i7tiEKJORybqpMQgWTywcoC5hczAw+c8xIDHnjpuhTEt234P+Pdo
        9hSWyYD9DryzRc6gCg63ECrEA0nnRVN8Knahw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EsvKzI1HZrQS+4nz+xJC4GKsRu7i6k6K
        4lO40KybbOEnte5ThWUCAliC7rMSVJjWIgWGr+ld+pzpdWMNygZ5aEC4V37/4QEo
        NdO4JzZr25F4cfaJgwJS9joTNma8zdcBYUeZPu7VOnDtK2XAmdSbqxsuB1aVTcFX
        BxT4RWOTEUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F883A58EC;
        Tue,  4 Feb 2020 14:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27B00A58E8;
        Tue,  4 Feb 2020 14:04:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 13/15] bugreport: add packed object summary
References: <20200124033436.81097-1-emilyshaffer@google.com>
        <20200124033436.81097-14-emilyshaffer@google.com>
Date:   Tue, 04 Feb 2020 11:03:57 -0800
In-Reply-To: <20200124033436.81097-14-emilyshaffer@google.com>
        (emilyshaffer@google.com's message of "Thu, 23 Jan 2020 19:34:34
        -0800")
Message-ID: <xmqq4kw6899e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A0F2FFC-4781-11EA-9920-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emilyshaffer@google.com writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Alongside the loose object counts, it can be useful to show the number
> of packs and packed objects. This way we can check whether the repo has
> an appropriate ratio of packed to loose objects to help determine
> whether it's behaving correctly.

This step makes me wonder if we want to see the midx as well.
Didn't we have a bug that manifests only when midx is (or is not) in
use?

Similarly, I think use (or non-use) of the commit graph may also be
a useful information for diagnosing.



