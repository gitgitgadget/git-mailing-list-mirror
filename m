Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87622EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjFTVq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTVq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:46:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6840CE
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:46:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44E1D2B93A;
        Tue, 20 Jun 2023 17:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vOwzaRPyOs5PWRjTZiKvRFcWjHW0CTng45Ar+V
        ohSTI=; b=mfl5Pcbseu7tWOgTjApMhtC6t5lck7pCypcVxlO7GvplkzOcMXHH+w
        HvsAef09golBhTXEAF9XrlKyxmNkYW88cg5XR7r7lCifLiLnY0WbTBf+KLZEBgYa
        8VAKFZMpj+BS+e5ol4K5Vbq9TAnNIRheSaNcLJkfR6jph8WJC0GN0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D5012B939;
        Tue, 20 Jun 2023 17:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B9012B938;
        Tue, 20 Jun 2023 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 12/12] config: pass source to config_parser_event_fn_t
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <484d553cc7da360b134e7cfcc02e587073b1f9fa.1687290233.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 14:46:50 -0700
In-Reply-To: <484d553cc7da360b134e7cfcc02e587073b1f9fa.1687290233.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 20 Jun 2023 19:43:51
        +0000")
Message-ID: <xmqqwmzxkdrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7144AD8-0FB3-11EE-AD40-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> ..so that the callback can use a "struct config_source" parameter
> instead of "config_reader.source". "struct config_source" is internal to
> config.c, so we are adding a pointer to a struct defined in config.c
> into a public function signature defined in config.h, but this is okay
> because this function has only ever been (and probably ever will be)
> used internally by config.c.
>
> As a result, the_reader isn't used anywhere, so "struct config_reader"
> is obsolete (it was only intended to be used with the_reader). Remove
> them.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  config.c | 77 ++++++++++----------------------------------------------
>  config.h |  6 +++++
>  2 files changed, 19 insertions(+), 64 deletions(-)

Together with the removal of current_* functions in earlier steps,
getting rid of the_reader interface makes the config API more easily
reused in other contexts, I guess.  Nicely done.
