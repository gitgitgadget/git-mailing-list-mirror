Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2705DC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA46E24178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bukiAKXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440229AbgJUViO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:38:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62598 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407812AbgJUViO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:38:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68E17FEB4A;
        Wed, 21 Oct 2020 17:38:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OMd5WCHW7PqQQ4aDNVdCJZVfnW0=; b=bukiAK
        XFD1G5XMC6cbmebzG0wkjJ81RB+3sRVSuYqHiubVDtLFq0jw4xFqGZFfPVKK25dL
        thR5+VeHESCxzoTzXqhPgWXlD4/LKQk2Febt/5t5eMVmTG5prH0MOMneqmey3O5M
        KHWqcAkNzvLLBxxgBosYHU0NO4OnBI3E2Isss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MLULijx70rJiKwX7OjVAnKIBj6pPUWxE
        1xB1eC4ZtrYtol8Ktd94G8Kw6NGUqiG5Af7xZUV+qPJKnxXKsYzZqasiQV6/f5C/
        YozNEL8bMC1wDyUWKAAPkmGtHCVMnFZ+LgQD/RUCUH1Zxg2VvMJyTF7yjlYL9syf
        ujsO+qBT6nk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 617D3FEB49;
        Wed, 21 Oct 2020 17:38:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD3E1FEB46;
        Wed, 21 Oct 2020 17:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid /
 _invalid
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
        <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
        <20201021205537.GB1270359@nand.local>
        <xmqqo8kv5l2x.fsf@gitster.c.googlers.com>
        <20201021213136.GA1877888@nand.local>
Date:   Wed, 21 Oct 2020 14:38:07 -0700
In-Reply-To: <20201021213136.GA1877888@nand.local> (Taylor Blau's message of
        "Wed, 21 Oct 2020 17:31:36 -0400")
Message-ID: <xmqqk0vj5kg0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B69F3084-13E5-11EB-A94F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Tangential to this discussion: are you still expecting a tree-wide
> change to start use extern everywhere?

I think before we start opening the tree for new topics is the best
time to do so, if we were to follow through, but after we have dealt
with brown-paper-bag fixes to the release.  The Makefile tweak for
the skip-dashed thing is the only one for 2.29, I think, so ...

Thanks.


