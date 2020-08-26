Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F2AC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8770F20679
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LkpXkUXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHZX4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:56:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZX4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 19:56:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09F026C277;
        Wed, 26 Aug 2020 19:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yIIUUxI9rqA1vW1XkgXoNKfABBA=; b=LkpXkU
        XxWWttMq8gbBY+mZw2zn67b980OZBjd9MaDM4cfIcSU/Xa/YS8G7Qy2IuOXqZt01
        8o7l1aR+f/ZbLWCROY6f1h44/n+Pa1RtGdpFS2SSlQCTpy1vDn75VscBCZ3qSD3L
        1/lDatBxhF+U9U4jmvIMEl2iIzV2yDTkBdSt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gX+k8B2Im31O40hRjIDz4NI3ppTLRPgc
        e6RQhWQKtX64q5CdSRAn19j1cJrxvft1wVlUAKmdnfH9vo7vlBWp6RoSuM2tkqdd
        RhEZ/cQqBzIgbe9ycbrR1xAkNjoEnHsJ8q+UAQLExWQEpE/uyFaYFocsOEiEhf/r
        ifehiBrdiJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFFB46C274;
        Wed, 26 Aug 2020 19:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 596A16C273;
        Wed, 26 Aug 2020 19:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, derrickstolee@github.com, dstolee@microsoft.com
Subject: Re: [PATCH v3 10/11] maintenance: add auto condition for commit-graph task
References: <4c3115fe3522bee47ba1f8f5e847e99ad7e56d40.1598380427.git.gitgitgadget@gmail.com>
        <20200826230252.1445841-1-jonathantanmy@google.com>
Date:   Wed, 26 Aug 2020 16:56:37 -0700
In-Reply-To: <20200826230252.1445841-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 26 Aug 2020 16:02:52 -0700")
Message-ID: <xmqqblixt0zu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7D6357E-E7F7-11EA-AFB4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> From: Derrick Stolee <dstolee@microsoft.com>
>> 
>> Instead of writing a new commit-graph in every 'git maintenance run
>> --auto' process (when maintenance.commit-graph.enalbed is configured to
>> be true), only write when there are "enough" commits not in a
>> commit-graph file.
>> 
>> This count is controlled by the maintenance.commit-graph.auto config
>> option.
>> 
>> To compute the count, use a depth-first search starting at each ref, and
>> leaving markers using the PARENT1 flag. If this count reaches the limit,
>
> PARENT1 -> SEEN
>
> Other than that, all the 11 patches look good.

Thanks.
