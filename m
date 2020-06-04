Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF66EC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14AA20C09
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gAiuNhud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgFDRVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:21:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57886 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgFDRVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:21:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64C00BFDA8;
        Thu,  4 Jun 2020 13:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FR6/7l05A+iLdiyaEz4QpV3SUrA=; b=gAiuNh
        udTTIsI1nD34NJVrlaVXzd4O2sDLAjMEF+qRbXAYlLLHo4fY1XM/a4Mqmt6Tg723
        r1tBseT8GRCJWPw1u/MYJTsGhqzzqE18m6CcUqkQjh41HG/E3L4JToVUeD3km4bR
        6uAL2ZdGGIJ04B6bh/zEfp7lx8MejGDH4cqRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I7bzP9c852UvfdN6FdekZkEb41qv1WCi
        pWUUoAJRhcriH85B7Xj5L5sKazTCY8S9oPWzzawTodV2tTH6ebUegSwfQP3xsDSM
        8xJ9q+D/xgIo5OszMy36oSCjfw4AZG4VmrUvEI7aruI0VWZwLRyY1BUy2YS3ZovT
        l2CE+fDOmH0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DD76BFDA6;
        Thu,  4 Jun 2020 13:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9B07BFDA5;
        Thu,  4 Jun 2020 13:21:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Shaun Case <warmsocks@gmail.com>
Subject: Re: [PATCH] sparse-checkout: avoid staging deletions of all files
References: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com>
        <7c34da8e-87b8-5236-4536-4d8fbc3f1e80@gmail.com>
        <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
        <xmqqsgfapx5i.fsf@gitster.c.googlers.com>
Date:   Thu, 04 Jun 2020 10:21:08 -0700
In-Reply-To: <xmqqsgfapx5i.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 04 Jun 2020 10:18:33 -0700")
Message-ID: <xmqqo8pypx17.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C828C48A-A687-11EA-8018-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>     list_files() {
>             # Do not replace this with 'ls "$1"', as "ls" with BSD-lineage
>             # enables "-A" by default for root and ends up including ".git" and
>             # such in its output. (Note, though, that running the test suite as
>             # root is generally not recommended.)
>             (cd "$1" && printf '%s\n' *)
>     }

An unrelated tangent, but it took me more time than necessary to
find where these "macros" are defined because

	git grep 'check_files () {'

found no matches.  That is why I prefer to stress about styles (no,
looking for "check_files *()" is not a solution).
