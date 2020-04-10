Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F0C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6699C20936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ua/Vg5ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDJUh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:37:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60808 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgDJUh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 16:37:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17B1049AAE;
        Fri, 10 Apr 2020 16:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M3kzqXJ+i7jVv3YZaOHTlRfBjnc=; b=Ua/Vg5
        adt6R7r4oLVVhdKqIM3CP+/yFoKgGs72tR31R2aQwuHuwBvsgcW68G/m4rldZ6ko
        de4825F4UgKNX2Y6W1PQddiS0s6jAmaKEe5HEiAhXP+hpUH+eXnWDB0j+SKuArPG
        sdO6AHjpNAVcgpwwg1X7FIsDsKbidKDn7/6rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JAUaVik995Gpg4egvEfUiALqOnfhsnbj
        Hn+rgqFVzVN1Al9c6lfEdVkaDyf6unl+PJUHh6t9Z6BTDn8BBMDEwMXj5JLZ1Fwf
        kMdIGDwtWj975uMmAyeQ5lUXLt+5M+YxRdXYfjyy/rHqLDwYnOPOkIxb5+CwqVmJ
        X8U4+RGGu7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F65449AAD;
        Fri, 10 Apr 2020 16:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91F7049AAC;
        Fri, 10 Apr 2020 16:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/3] rebase: reinstate --no-keep-empty
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 13:37:56 -0700
In-Reply-To: <e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 10 Apr 2020
        17:51:33 +0000")
Message-ID: <xmqqtv1rhyaj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28E76DDC-7B6B-11EA-94FB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> That commit viewed this, though as
> turning that flag into a no-op.

Sorry, but I do not understand this sentence.

> Provide users a way to drop commits which start empty using a flag that
> existed for years: --no-keep-empty.  Interpret --keep-empty as
> countermanding any previous --no-keep-empty, but otherwise leaving
> --keep-empty as the default.

But everything after that sentence down to here was very clear.

> This might lead to some slight weirdness since commands like
>   git rebase --empty=drop --keep-empty
>   git rebase --empty=keep --no-keep-empty
> look really weird despite making perfect sense (the first will drop
> commits which become empty, but keep commits that started empty; the
> second will keep commits which become empty, but drop commits which
> started empty).

That is true.  Do we leave it to others (or our later selves) to
think about the UI further?  That is fine by me, but in that case we
may want to add " We may want to rethink the option names later",
perhaps?

> +--no-keep-empty::
>  --keep-empty::
> +	Do not keep commits that start empty before the rebase
> +	(i.e. that do not change anything from its parent) in the
> +	result.  For commits which become empty after rebasing, see
> +	the --empty and --keep-cherry-pick flags.

keep-cherry-pick will appear later, not here, right?

Thanks.
