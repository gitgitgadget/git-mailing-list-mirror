Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29802C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiBXW4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBXWz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:55:59 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCDB20A94A
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:55:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C28918416C;
        Thu, 24 Feb 2022 17:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OahmJ4tMGmzocVtSJzem/MQp27EowP3pE3a26/
        /iL98=; b=l63z23VNdnR8YY3ZrnuXXzQkZeRIvBdp7jG64iqKCgpFyxZkM9UckR
        erhD+nb8BhP4kJIRvZTPLwrgj6ytdR9eoTw3AraGUYfHQfaLm4cRp2a00RxA/bLU
        xMKHkMdgZPOdgJeaqbwzWz5njL35d8ibZh07kgyU/mfPXzgAQ92yI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9288518416A;
        Thu, 24 Feb 2022 17:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08640184169;
        Thu, 24 Feb 2022 17:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 14:55:23 -0800
In-Reply-To: <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 24 Feb 2022
        20:38:34 +0000")
Message-ID: <xmqq5yp3kh7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9B873F2-95C4-11EC-8FCE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The corrected commit date was first documented in 5a3b130ca (doc: add
> corrected commit date info, 2021-01-16) and it used an optional chunk to
> augment the commit-graph format without modifying the file format
> version.
>
> One major benefit to this approach is that corrected commit dates could
> be written without causing a backwards compatibility issue with Git
> versions that do not understand them. The topological level was still
> available in the CDAT chunk as it was before.
>
> However, this causes a different issue: more data needs to be loaded
> from disk when parsing commits from the commit-graph. In cases where
> there is no significant algorithmic gain from using corrected commit
> dates, commit walks take up to 20% longer because of this extra data.
>
> Create a new file format version for the commit-graph format that
> differs only in the CDAT chunk: it now stores corrected commit date
> offsets. This brings our data back to normal and will demonstrate
> performance gains in almost all cases.

OK.
