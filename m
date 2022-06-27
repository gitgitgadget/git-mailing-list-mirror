Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33EDC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 22:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiF0WN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiF0WN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 18:13:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3846163
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 15:13:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB4541A569F;
        Mon, 27 Jun 2022 18:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KFrVaM/zq4S7CPuytqjiFFFbPExkDAjHWI3bje
        PB3dI=; b=B+EMaJxRIZzUo5su8nHj3xojSwoMl/+fClDqanG/t7ObjZNO8t9gZW
        /ytOoIh6e+8r/31KG7D8KPQ3ixr9fRNjJDOurz9+xc9vg3dJ37YrL1aEMHy9PF4V
        0TAXSOtVTTsyyZJP4XjIVYvTUQoPQYRUsARRjcBX0Bqyy6H4LEOyU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEF111A569D;
        Mon, 27 Jun 2022 18:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 478051A567A;
        Mon, 27 Jun 2022 18:13:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 14/16] Turn `git bisect` into a full built-in
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <378d6d227372405326112fee03c377f1aff386fc.1656354677.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 15:13:52 -0700
In-Reply-To: <378d6d227372405326112fee03c377f1aff386fc.1656354677.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 27 Jun 2022
        18:31:15 +0000")
Message-ID: <xmqqsfnpn49r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DEE6A8E-F666-11EC-895C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Now that the shell script hands off to the `bisect--helper` to do
> _anything_ (except to show the help), it is but a tiny step to let the
> helper implement the actual `git bisect` command instead.
>
> This retires `git-bisect.sh`, concluding a multi-year journey that many
> hands helped with, in particular Pranit Bauna, Tanushree Tumane and
> Miriam Rubio.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile                               |  3 +--
>  builtin.h                              |  2 +-
>  builtin/{bisect--helper.c => bisect.c} |  2 +-
>  git-bisect.sh                          | 37 --------------------------
>  git.c                                  |  2 +-
>  5 files changed, 4 insertions(+), 42 deletions(-)
>  rename builtin/{bisect--helper.c => bisect.c} (99%)
>  delete mode 100755 git-bisect.sh

Good.

