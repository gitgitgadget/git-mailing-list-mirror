Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94131C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiBWXvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiBWXvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:51:20 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC25C84D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:50:52 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0E8B18C2DD;
        Wed, 23 Feb 2022 18:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QCK3SC57h22S/d2+fjZR95ZTeYUhWJY/mGPncR
        AvrRU=; b=KtB92knLbL4kS6wVGioKsTdBKu5ix01npgWLM1oyS5ldAP6cJCJEi9
        uwcEa4s7UXFxjiAtP4WA0QpCrYuIkx+ank1qIMLts6VLMit25Kljmg21fiwQt/LD
        kcEGquNrQ6Ig16p2ij6DyDpE/F3rRQRoi7nz0C+i/HdYrGkS9aLxg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7B2C18C2DC;
        Wed, 23 Feb 2022 18:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E846418C2DB;
        Wed, 23 Feb 2022 18:50:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
        <220223.864k4q6jpr.gmgdl@evledraar.gmail.com>
        <xmqqbkyxqjrq.fsf@gitster.g>
        <272D2409-1CAE-4203-96F7-9B104F7E5D4D@gmail.com>
Date:   Wed, 23 Feb 2022 15:50:47 -0800
In-Reply-To: <272D2409-1CAE-4203-96F7-9B104F7E5D4D@gmail.com> (John Cai's
        message of "Wed, 23 Feb 2022 18:12:51 -0500")
Message-ID: <xmqqczjdp2g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C842CFC-9503-11EC-A073-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> Yes, this is true but that doesn't seem to test the --rewrite functionality.
> I could be missing something, but it seems that the reflog --rewrite option
> will write the LHS old oid value in the .git/logs/refs/stash file. When
> --rewrite isn't used, the reflog delete still does the right thing to the
> RHS entry.
>
> I couldn't find any way to check this LFS value other than reaching into the
> actual file. If there is a way that would be preferable.

Ah, that one.

As 2b81fab2 (git-reflog: add option --rewrite to update reflog
entries while expiring, 2008-02-22) says, the redundant half of the
reflog entry only matters to "certain sanity checks" and would not
be even visible to normal ref API users.  I wonder why we need to
even say "--rewrite" in the first place.  Perhaps we should
implicitly set it always and eventually deprecate that option.



