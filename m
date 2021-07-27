Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C1C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582B46124D
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 08:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhG0IpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:45:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62691 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbhG0IpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 04:45:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C01DC130B6D;
        Tue, 27 Jul 2021 04:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6JePM7c4OCggxvNAMl6HQZOgTnBt1uLwvK6NhydHbq8=; b=DPD6
        ptfeXah+WvFC2kuM0WCI+NGTE2pZa87GvVajL324fUfmG6C4DadGoGiFL/VN9yb4
        +K+lh4+7qp9sTpHxRS2IMQxrJQuSP2gp2xi1bLPnK1l3LRhmq0OrvvX4TIIPqr5n
        KuJVc7tllrX/oNKB3dQmD7nDgVw0UW9dvC7xT+Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC75B130B6C;
        Tue, 27 Jul 2021 04:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E93F5130B69;
        Tue, 27 Jul 2021 04:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: [PATCH v2] pull: introduce --merge option
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
        <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
        <xmqqeebregns.fsf@gitster.g>
        <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
Date:   Tue, 27 Jul 2021 01:45:15 -0700
Message-ID: <xmqqwnpcdu1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F78EC15C-EEB6-11EB-9971-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Junio, would you be willing to accept adding -m without adding --merge also?

My gut feeling is that "-m" without "--merge" in the context of
"pull" is extremely unlikely to fly well.

As "git pull" is a "git fetch" followed by a "git merge" (or "git
rebase"), it takes the union of common command line options from
both phases, and "git merge" takes "-m 'message'" which is an option
fairly familiar to users (since it comes from "git commit").  Even
if we are never going to pass "-m message" from "git pull" down to
underlying "git merge", squatting on short and common "-m" would be
a bad idea.
