Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49119C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A57221E2
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgLAXDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:03:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63581 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLAXDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:03:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E217E115A53;
        Tue,  1 Dec 2020 18:02:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xniagKoxWZsf5883N1faTcrZkgQ=; b=RWplJG
        BC6jjnriubvgP0V0I8PDSeTvDpNhOkTtuNnn7ZC8UK1WyARkFWvAnazJ3AHyYXFu
        V0hkMBpUNJHqdDP8zN0MU4nE9qDTZ08zky+Bn2MQSAqRRPhGYXBoy9+fpn3Tisk8
        wpHuEKh/Om6ImHYeTF7+WOHhhOgimwQMzcHUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q30STpBxclEpnxekGqzc6Q3Od9iytJM0
        HHWJ1QIDRgAabEkp0GvMQO67PSIeB090p7wvAvcborHO5N+UZqm0C5E190Kcpi3m
        FUQTBM0dTn5Ejczkm761iA8Fbb55400CZZcNgk1pm6Z4RDrkMr+TEBUaOAebVymy
        F0ekTWxI5HY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8599115A52;
        Tue,  1 Dec 2020 18:02:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B1DE115A51;
        Tue,  1 Dec 2020 18:02:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        dstolee@microsoft.com, Elijah Newren <newren@gmail.com>,
        chris.torek@gmail.com
Subject: Re: [PATCH v2 2/3] stash: remove unnecessary process forking
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
        <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
        <1fa263cf3c3d1b0c20ad89e6454a7b903a07f193.1606861519.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Dec 2020 15:02:32 -0800
In-Reply-To: <1fa263cf3c3d1b0c20ad89e6454a7b903a07f193.1606861519.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 01 Dec 2020
        22:25:17 +0000")
Message-ID: <xmqqr1o9m8on.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C22CF68-3429-11EB-9DDE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     git diff-index --cached --name-only --diff-filter=A $CTREE >"$a"
>     git read-tree --reset $CTREE
>     git update-index --add --stdin <"$a"
>     rm -f "$a"

This is orthogonal to what this patch does, as this is supposed to
be just bug-for-bug compatible rewrite.

But I wonder if the above sequence, whether it is done as a series
of plumbing invocations or subroutine calls, is a relic dating back
in the days before i-t-a existed.  If we want to revert the changes
to the index for working tree files for removed or modified ones, I
do not offhand see a good reason why we would want to keep the
contents to new paths---if i-t-a were available when the sequence
was designed, I suspect we would just have added the path as i-t-a
in order to keep track of the presence of the path but not
necessarily the contents in it.
