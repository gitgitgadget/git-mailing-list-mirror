Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5327C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 03:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8710861153
	for <git@archiver.kernel.org>; Tue,  4 May 2021 03:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhEDDTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 23:19:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52977 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhEDDTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 23:19:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74CCF142AFF;
        Mon,  3 May 2021 23:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q87fPuM1pWZMHlPacpsxg3SoZk7O2C38urqqSy
        gGOtE=; b=LcM3keuUTNpfLij1lZF6a4MxnUkCWesOms99uV1GIixfUuc7FaoELX
        JYTKguJC6iueUfs87UmcUK71hkPowZ13TpclXfvekenSaj6el5WYrsxoU4+OadV7
        XZqGvn4+nAws1oZGZGYhDyHpnMZ7uXEIxaruCbVVtQQmXyYh4kAJk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E06D142AFE;
        Mon,  3 May 2021 23:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA5D1142AFD;
        Mon,  3 May 2021 23:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sardorbek Imomaliev via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
Subject: Re: [PATCH v2] work around zsh comment in
 __git_complete_worktree_paths
References: <pull.943.git.1619685833872.gitgitgadget@gmail.com>
        <pull.943.v2.git.1620059347674.gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 12:18:09 +0900
In-Reply-To: <pull.943.v2.git.1620059347674.gitgitgadget@gmail.com> (Sardorbek
        Imomaliev via GitGitGadget's message of "Mon, 03 May 2021 16:29:07
        +0000")
Message-ID: <xmqqlf8v6vbi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B4A5DB8-AC87-11EB-9BA3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sardorbek Imomaliev via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 49e76e9d08cd..73f9fcf493c4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3268,9 +3268,10 @@ _git_whatchanged ()
>  __git_complete_worktree_paths ()
>  {
>  	local IFS=$'\n'
> +	# Generate completion reply from worktree list skipping the first
> +	# entry: it's the path of the main worktree, which can't be moved,
> +	# removed, locked, etc.
>  	__gitcomp_nl "$(git worktree list --porcelain |
> -		# Skip the first entry: it's the path of the main worktree,
> -		# which can't be moved, removed, locked, etc.
>  		sed -n -e '2,$ s/^worktree //p')"
>  }

Makes sense.  Thanks, will queue.
