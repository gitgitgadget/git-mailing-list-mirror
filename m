Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D65C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BDB61394
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhDEUrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:47:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57659 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhDEUrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 16:47:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62AF5B0EA4;
        Mon,  5 Apr 2021 16:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qidp0KJWL3MNLKG+bdRZ3NZ2P6E=; b=Ja79eX
        EOray+YWA9wmVXImu0JSfYYEsg8UnixdRYkeNS5HnMzDDHnqb01MMJecg/5vLM4q
        n5mXhDtcUy56uu/OPRsPeeTXxl65/V3gNhgK+UJ7dWE+TBY/9FRg+l05+iLoYsQV
        DNso28nGgBkxtNFR0hzXf2Lai4t7KntY5C+VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=liUIUPhwZxzMDQy2cl2NEWCqwduspwbd
        07r1lexjQW7lX+wZWs4GMgJ6HCtaRP+BHwMCbB0m+SJRQJfBi4kgno9uClwRJ757
        IQYoa2AXQto4JMH17yREw96pEKtZCwTzYcQ1NV07htaU0DpgI4aDvPO4sqiBfjnp
        43mz+6qMnT0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A827B0EA3;
        Mon,  5 Apr 2021 16:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E20E4B0EA2;
        Mon,  5 Apr 2021 16:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
References: <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
        <xmqq8s613gqa.fsf@gitster.g>
        <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
        <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
        <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
        <xmqq1rbs4c6t.fsf@gitster.g>
        <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com>
        <xmqqft057ijc.fsf@gitster.g>
        <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com>
        <xmqqr1jo5zzb.fsf@gitster.g>
        <20210405203832.x275fqoinfsw5gik@dhcp-10-154-153-195.vpn.oracle.com>
Date:   Mon, 05 Apr 2021 13:47:09 -0700
In-Reply-To: <20210405203832.x275fqoinfsw5gik@dhcp-10-154-153-195.vpn.oracle.com>
        (Tom Saeger's message of "Mon, 5 Apr 2021 15:38:32 -0500")
Message-ID: <xmqq5z105uia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 176B6E04-9650-11EB-AB2C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Saeger <tom.saeger@oracle.com> writes:

> $ git config --local --get-regexp "pr-924"
> remote.pr-924.url https://github.com/gitgitgadget/git
> remote.pr-924.fetch +refs/tags/pr-924/derrickstolee/maintenance/refspec-v1
>
> Seems legal, fetch even works

Yes.  For a ref that is one-shot use (like PR tags), this does not
make much sense, but

    [remote "submaintainer1"]
	url = ... repository of submaintainer #1 ...
	fetch = master
	tagopts = --no-tags

is a reasonable thing to have for those who regularly work with
submaintainer(s) of their project.  They'd do

	$ git pull submaintainer1

to accept the work their submaintainers have done.
