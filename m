Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5ACC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D000F6136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhGNBN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:13:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62794 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbhGNBN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:13:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECF7E1574A8;
        Tue, 13 Jul 2021 21:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wb9YjdiPFrOmst0d+1nk4cge/+ICrJRhU6veb2
        cAYCc=; b=YWwtJxr9zmyx5y3vd3IspTD5scm8UzLd1EZFxi+N/NFh3iwrdOferi
        9AEGwOsPsRH167rZslGs+bR5K7oj4VZMi04Kp0/gKRHQlzKRl7Oa7NO0d0hmz9Pt
        HNeySDg7566Z77kpdbX/Vz6x1XOa+kjf2j0vA/r8l/Nf68ZWcDDV4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E568F1574A7;
        Tue, 13 Jul 2021 21:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6875C1574A6;
        Tue, 13 Jul 2021 21:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit
 exceeded
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
        <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com>
        <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
        <xmqqzgupzppb.fsf@gitster.g>
        <CABPp-BHdAZYPf0QPOTiekU914u6pNxUSRQEmdN0xOLGv5hdkzA@mail.gmail.com>
Date:   Tue, 13 Jul 2021 18:10:34 -0700
In-Reply-To: <CABPp-BHdAZYPf0QPOTiekU914u6pNxUSRQEmdN0xOLGv5hdkzA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 13 Jul 2021 18:06:06 -0700")
Message-ID: <xmqqim1dzomt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BB9C122-E440-11EB-AC21-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The exhaustiveness of the quadratic portion comes from comparing each
> file to more other files, not in using a different type of comparison.

Exactly.  By culling potential matches early with heuristics, we
make a trade-off of risking false-negatives but save a lot of cycles
while trying to find "renames with modifications (which is what we
called 'inexact rename')", and my comment equated  fewer false-negatives
with more precision.


