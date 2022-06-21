Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62E9C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 20:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbiFUUQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiFUUQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 16:16:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444A1E3FC
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 13:16:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C3A219541F;
        Tue, 21 Jun 2022 16:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ODbu4HSI/E0ZnxKDail/H79jSpSLaWH5U3zV5D
        weL9w=; b=DLLAQEkOvYPLgtaKGk/prjI0eKfl3XWDwPTIl/untGsmO//4/U7OqI
        OtmFv6NLyXjpqsC8c1uI7ucgtx0QgZrHjtiCLw26Nl3d7CTJI5I4KRNzAmoRxiJh
        gQ4ptWxfMj3Kh0X0534VEC6O6D+WFp/ilIRSUTkX1ZWCL4mmIihUE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01E8E19541E;
        Tue, 21 Jun 2022 16:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5A5819541D;
        Tue, 21 Jun 2022 16:16:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqtu8x1fd4.fsf@gitster.g>
        <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
        <d4427adf-e3ef-a5cd-3016-687004dc5ae3@github.com>
Date:   Tue, 21 Jun 2022 13:16:08 -0700
In-Reply-To: <d4427adf-e3ef-a5cd-3016-687004dc5ae3@github.com> (Derrick
        Stolee's message of "Tue, 21 Jun 2022 15:34:14 -0400")
Message-ID: <xmqq8rpphiwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD3605C0-F19E-11EC-8246-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> The refs/bundles/ appear in the document only here, and it is
>>> unclear why we even want it (I am assuming this is against gc while
>>> "git clone" is still running) or how we are going to retire it, if
>>> ever.  If there are multiple bundle files involved in this "git clone",
>>> to anchor objects that are necessary against "gc", don't we need to use
>>> refs/bundles/<i>/* or something like that, where <i> is uniquely assigned
>>> number locally?
>> 
>> The real reason to keep them in refs/bundles/ is because then those
>> refs can be used in the incremental 'git fetch' after downloading the
>> bundles (in perpetuity) while not stomping refs/heads or refs/remotes/
>
> ...I completely ignored your "refs/bundles/<i>/*" suggestion, which is
> an interesting way to allow dropping refs from this space, allowing GC
> to clear up space over time.

FWIW, I wasn't thinking about GC and expiration.  If bundle URI
thing can say "you need this, that and that other bundle" and cause
you to fetch three bundles, I thought that there needs a way for you
to record the tips of these three bundles---these three bundles
should not have to compete for refs/bundles/master, for example.

