Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C0FC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C6123B5F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgLIBSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:18:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61442 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLIBSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 20:18:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9241597352;
        Tue,  8 Dec 2020 20:17:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7/C/iEFbI0ScM9ZJAC5HpXq+4Yw=; b=Amn83N
        19ykAU/ZktcHZBu4RmyDK1z7C9Nw4zf5w7jsE6pmFFtOC12iBdgen19meeEIQ/8z
        u2IC/KLNr0Bywv+5WllwQkEHmpotGIjJSZPvHSItQe7SdIiCUAP7j0Am+5KN8o8F
        /GOwET0zQiqM+PK+7iseDvtdaM3C36somLY6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ooKz4GydDkxwp/We8+poDi9bfKur6Swv
        3s7hf3Nw2dmE/anEJxmjQptSjTy+QnLFZeXzImyZoQiaDcgJkQtXZ+hhOhi2IU+1
        g3xpGiaaD2dOzj2bly9lQCq2/MshGatTU/uB2FoGgLYMgaY3I6LEAPoEQoXraDCa
        pGGHZZEB8fw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88CA897351;
        Tue,  8 Dec 2020 20:17:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E14F97350;
        Tue,  8 Dec 2020 20:17:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
Date:   Tue, 08 Dec 2020 17:17:27 -0800
In-Reply-To: <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 15:11:36 -0800")
Message-ID: <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D6FD60C-39BC-11EB-8DE7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ... I guess I'm not sure why one would ever
> want to see diffs for merges and not for normal commits.  Even in the
> unusual case someone did, couldn't they just pass --merges (to strip
> out the normal commits entirely)?

Giving "--merges" would skip the single-strand-of-pearls commits
entirely, not even showing their log messages, so it won't be an
equivalent substitute.

> Honestly, I find it a little surprising that despite the fact that log
> -p shows nothing for merge commits, that when I add --first-parent to
> see a subset of commits I suddenly get weird, huge diffs shown for the
> merges (yeah, yeah, I learned recently that it's documented behavior,
> so it's not surprising anymore, just weird).

I view "--first-parent" as telling "git log" to pretend all merges
are single-parent commits (as if you did squash merges), and it is a
natural consequence if "log --first-parent -p" showed each commit
with its first parent, whether it is a merge or a single-parent
commit.
