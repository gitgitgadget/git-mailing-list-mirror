Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E6DC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B8164E2E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBASpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:45:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59499 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhBASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:44:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECF3B11DE91;
        Mon,  1 Feb 2021 13:44:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JsBByIlv21hcPsU7eIzICKsHd9s=; b=VwlCn/
        AalHRkOveooWyYKLhBKyZ0q8Moe+2r1UNKd/FS0ovJqVvEvziSS+/NJboWzpZb0A
        WIYeFFzCiPK4nEKPN8P6OaNStTbjuzsZvSs6CjF0w8MbgMipDQ/vT9hbORf7dD+E
        drsSE4INWF0wLzmc7I30PDkiLDup3SMIX6Bow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jcoK37NiWXFS6V9GDhoslAsW6zTTkmr1
        FXlD/bJik0saTNUH4XOn7/qSkQdM2yG1PLHiEy59hmsQ89hZIlcrvTED9WIFLptD
        ajzNF67gmB2EFiS8Wv9ji9KhMG+x/GLMUSn8UiQ8iG7xcR77VN+j9ennn1tEGcLe
        98gmDyVU0Gs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E505011DE90;
        Mon,  1 Feb 2021 13:44:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2DB4511DE8F;
        Mon,  1 Feb 2021 13:44:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gister@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/5] commit-graph: always parse before
 commit_graph_data_at()
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <82afa811dffa3f7b3c371de5c220b0529d96ed87.1612199707.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 10:44:08 -0800
In-Reply-To: <82afa811dffa3f7b3c371de5c220b0529d96ed87.1612199707.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 01 Feb 2021
        17:15:04 +0000")
Message-ID: <xmqqzh0nljbb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78BAE032-64BD-11EB-8CE5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> It has been difficult to identify the issue here becaus it was so hard

"because" (will fix-up locally).

> to reproduce. It relies on this uninitialized data having a non-zero
> value, but also on specifically in a way that overwrites the existing
> data.
