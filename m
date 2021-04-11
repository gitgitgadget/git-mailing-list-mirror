Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE69C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 01:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0081610A8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 01:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhDKBgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 21:36:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60148 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhDKBgA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 21:36:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C355D12A79B;
        Sat, 10 Apr 2021 21:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fX6NXJjVl18HyajHZrO61WAvyVM=; b=HgeFds
        Wb0qaNHsVJCgEJcbMd0BHuwCT5lBc/5pvEwRqc4/BwkJOiHWQa1jIxTMF/WG9D6b
        cYfMWnyeArmUl3PJiBfmXU9TFEtRLKCR6A/vjRgYB65GkxyJgwGUzjF++0M3A3QC
        uMtBuN/C8Hni9JvA2GpXK+up8IQvx3hMei3zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rce+jNk3Jb9msrHYiQP7Z3DkBlHLOZmm
        7LWzMsOUZb0Wc0F7zegLTM04fVCn+XHv2yiRLpEOTy5bmMddoBEhBADrbcegpgBq
        Tp0/lWnJFyNcxIDP58VAK5e1dEdiARfDGz/5bTsQrdwzkIBl0F/gu6ETm/F19bWn
        QdlhhEXmyZc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAC6C12A79A;
        Sat, 10 Apr 2021 21:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 022BC12A798;
        Sat, 10 Apr 2021 21:35:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] Maintenance: adapt custom refspecs
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
        <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 18:35:40 -0700
In-Reply-To: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Sat, 10 Apr 2021 02:03:42
        +0000")
Message-ID: <xmqqtuodiowj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A4AECBE-9A66-11EB-8193-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * The fix is almost completely rewritten as an update to 'git fetch'. See
>    the new PATCH 2 for this update.

I do agree that it gives us the most flexibility there with nice
encapsulation.  Nobody other than "git fetch" needs to know how it
computes which remote refs are fetched given the real pathspec, and
the only thing the caller with "--prefetch" is interested in is that
the prefetch operation would not contaminate the remote-tracking
refs.

Great idea.  I wish I were the one who thought of it first ;-)
