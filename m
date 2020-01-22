Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0219C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7261A21835
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+DhgDBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAVWKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:10:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58930 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 17:10:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85D373B3B2;
        Wed, 22 Jan 2020 17:10:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M3cT/LRP6YsQ
        G/hpqsBz8NR4BwQ=; b=E+DhgDBOQkD8eYkTfAlHzdpGweF4iD5hJS853hW1TW0x
        L2KlaW8/w3E6ii/DChHWDBUQae0E7n+bHiNZHmrSQFeFaAAiF4/jOeQfpkYGe9Vm
        eEd6E5HyLS0QTGQ8yLkh4RWoxkG7ZclDijHYEUPdNcqAeFs3I4ZUB3+/7ICgz1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pQUix3
        oOrISFG4G0vfN8TRM0ra1QIaMPtU6GsldkJfXSl3w1d3TFIgEA+nkTieWix0TGui
        ThWLuwNvWLYN8e9HjjRFk+40lIjYBnpMlGW2OmPj5Ksa92/SrEDcPwtltXkghb7h
        LlVOvqz6QftiIDyALDWwMoT5rXU4tYhesriHA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EC9E3B3B1;
        Wed, 22 Jan 2020 17:10:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECF253B3AF;
        Wed, 22 Jan 2020 17:10:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
Date:   Wed, 22 Jan 2020 14:10:28 -0800
In-Reply-To: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 21 Jan 2020 15:01:13 +0000")
Message-ID: <xmqqwo9j5ei3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00558F06-3D64-11EA-83D1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * revert the addition of a dash in "file1 updated" by correctly using =
the
>    'tag' argument of test_commit
>  * improve the commit message for the 3rd patch, as suggested by Eric
>  * fix spacing when redirecting into 'expect' and 'actual'
>  * harden the tests by echoing expected values into expect, as suggeste=
d by
>    Stolee (I did that in both tests)
>  * remove test_might_fail and use test_expect_code
>  * add the 'git log' test suggested by Stolee
>
> v1: This series fixes the behaviour of git checkout/reset/read-tree
> --recurse-submodules when they are called in a linked worktree (created=
 by=20
> git worktree add).=20
>
> Although submodules are cloned in $GIT_COMMON_DIR/worktrees/<name>/modu=
les=20
> upon issuing git submodule update in the linked worktree, any invocatio=
n of=20
> git checkout/reset/read-tree --recurse-submodules that changes the stat=
e of
> the submodule(s) will incorrectly operate on the repositories of the
> submodules in the main worktree, i.e. the ones at $GIT_COMMON_DIR/modul=
es/.=20
>
> The fourth patch fixes this behaviour by using get_git_dir() instead of=
=20
> git_common_dir() in submodule.c::submodule_move_head and=20
> submodule.c::submodule_unset_core_worktree to construct the path to the
> submodule repository.
>
> The first 3 patches are clean-up patches on t7410-submodule-checkout-to=
.sh
> (renamed to t2405-worktree-submodule.sh) to bring it up to date.

I've read these four patches a few times and did not spot any
remaining issues.  I however is hardly an expert on (nor a big fan
of) the "--recurse-submodule" feature, so a proper review by those
who are more familiar with it is surely appreciated.

Thanks.

> Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams=20
> bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan=20
> jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller=20
> stefanbeller@gmail.com [stefanbeller@gmail.com] Nguy=E1=BB=85n Th=C3=A1=
i Ng=E1=BB=8Dc Duy=20
> pclouds@gmail.com [pclouds@gmail.com] Eric Sunshine sunshine@sunshineco=
.com
> [sunshine@sunshineco.com] Derrick Stolee stolee@gmail.com [stolee@gmail=
.com]

This is somewhat unreadable wall of names X-< Is it a funny
rendering of what is originally in some mark-up format (perhaps
HTML???)

