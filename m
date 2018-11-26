Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0991B1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 05:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeKZQXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 11:23:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55500 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 11:23:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81CDF11233B;
        Mon, 26 Nov 2018 00:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fU81IcfJh8GlggqF9Px5pFbvJzw=; b=aA0HCB
        v9O47nwoB/2LbaZNwk3hst93/beHiPbGOrhutwfgxShR6PQklPUWSrSP66RjRB17
        s0pTZT2O4eahP5yYNeLQ4fqWSNVBp94RVaQJAfq/l2Tcn3q02Rd3UeKFnvkFsNc9
        qGFeBEnEcmlGCNxazfs9dK1fi3BM+Wfv2OcVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h5mVs7MMuHArZDaVaaEyUerCIEPVZZfh
        JcPm/+hJYrFFu0beMPXKvPBCAHlOTYURQTVKg+f8l2BuBisbVSUWL/XHkOpwLVPx
        NW6HjXNWcSa5pkolIsnT0QEWQdLUVSPxQAUO4q15apwmD9vm1GpSfYAd1wWG7llb
        bm6tCe9a7+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 785EA11233A;
        Mon, 26 Nov 2018 00:30:32 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBCCD112339;
        Mon, 26 Nov 2018 00:30:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v11 20/22] stash: convert `stash--helper.c` into `stash.c`
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
        <de2ebf96ee5f94a1cdadee67e436f5bd1b0fb6a5.1542925164.git.ungureanupaulsebastian@gmail.com>
Date:   Mon, 26 Nov 2018 14:30:30 +0900
In-Reply-To: <de2ebf96ee5f94a1cdadee67e436f5bd1b0fb6a5.1542925164.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Fri, 23 Nov 2018 01:05:40
        +0200")
Message-ID: <xmqqefb8z9qh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 645F8A94-F13C-11E8-8501-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> The old shell script `git-stash.sh`  was removed and replaced
> entirely by `builtin/stash.c`. In order to do that, `create` and
> `push` were adapted to work without `stash.sh`. For example, before
> this commit, `git stash create` called `git stash--helper create
> --message "$*"`. If it called `git stash--helper create "$@"`, then
> some of these changes wouldn't have been necessary.
>
> This commit also removes the word `helper` since now stash is
> called directly and not by a shell script.
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  .gitignore                           |   1 -
>  Makefile                             |   3 +-
>  builtin.h                            |   2 +-
>  builtin/{stash--helper.c => stash.c} | 157 +++++++++++++++------------
>  git-stash.sh                         | 153 --------------------------
>  git.c                                |   2 +-
>  6 files changed, 92 insertions(+), 226 deletions(-)
>  rename builtin/{stash--helper.c => stash.c} (91%)
>  delete mode 100755 git-stash.sh

Seeing the recent trouble in "rebase in C" and how keeping the
scripted version as "git legacy-rebase" helped us postpone the
rewritten version without ripping the whole thing out, I wonder if
we can do the same here.

Also, the remaining two patches should be done _before_ this step, I
would think.  I can understand it if the reason you have those two
after this step is because you found the opportunity for these
improvements after you wrote this step, but in the larger picture
seen by the end users of the "stash in C" and those developers who
follow the evolution of the code, the logical place for this "now we
have everything in C, we retire the scripted version" step to happen
is at the very end.

Thanks.
