Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A188C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F0C20781
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nLAHeLw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbgFXQRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:17:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50399 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404431AbgFXQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:17:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F8BB60776;
        Wed, 24 Jun 2020 12:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0FxtF04vEPdu13oJ+NVCMXTFRI8=; b=nLAHeL
        w3hHCVlCjK13fCbDUgCvfHyf1KdqhZ0myzWfZEZarX4MKw/cID/j2V6f+sPMjtUe
        qNOf9Zer8+XhFSw/N0QdAleqZAX8qo2b2Qvpgj/7dt6I5wacUgot5a67TLsmfjMY
        PgYy2Bom5z2le249fpWYKd556mewwzu87FILM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j34skqml2Rw+NzlN+GXKK1B+38m6Ln84
        Af8K5H31RcCfjbej66caX0G26qx8nSKn8rhhvnqJXyOqY8syevfdZLn5IvhssAKs
        Ad/DaDK+coWxgqFuFNU6q+ro20y+1c5mSP9pN7Ptjg5iuTyRnRpCrRYA9z/4xcZa
        LjANxpgwtWU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26E0960775;
        Wed, 24 Jun 2020 12:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A066A60773;
        Wed, 24 Jun 2020 12:17:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/9] submodule: fall back to remote's HEAD for missing remote.<name>.branch
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
        <54563642dbf96fcb36993c2c2d36ebefaf220cce.1593009996.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 09:17:35 -0700
In-Reply-To: <54563642dbf96fcb36993c2c2d36ebefaf220cce.1593009996.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 24 Jun 2020
        14:46:30 +0000")
Message-ID: <xmqqv9jg780w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37137EE0-B636-11EA-B38D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Even so, it should be okay to fix this behavior without anything like a
> longer transition period:
>
> - The `git submodule update --remote` command is not really common.
>
> - Current Git's behavior when running this command is outright
>   confusing, unless the remote repository's current branch _is_ `master`
>   (in which case the proposed behavior matches the old behavior).
>
> - If a user encounters a regression due to the changed behavior, the fix
>   is actually trivial: setting `submodule.<name>.branch` to `master`
>   will reinstate the old behavior.
>
> Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Well explained.  Thanks.
