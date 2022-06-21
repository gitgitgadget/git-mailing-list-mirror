Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC86C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiFUQTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiFUQTo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 12:19:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3592899D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 09:19:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 608A213371C;
        Tue, 21 Jun 2022 12:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cTmvY59y9628yrdXWQ+Zw84We+W28/2SOMisIH
        VQa6Q=; b=KaBv1GOQiJVdMKo/CyvqQbOzR6aZzEfPbSP/zqkhcie0K2mYgSInRy
        75z7qvXfdQJSwqtpdocf8xQExVTxDU7ctRdkP07gkuZZJMHCy21XO/JwvnJIEAyK
        u1iKS/HXrfcN2CcLlKxXvEbFcENHO0wWLe8AbVqyenjlk5fHHXhPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A5A13371B;
        Tue, 21 Jun 2022 12:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAD1413371A;
        Tue, 21 Jun 2022 12:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] rev-parse: documentation adjustment - mention remote
 tracking with @{u}
References: <pull.1265.git.1655697671724.gitgitgadget@gmail.com>
Date:   Tue, 21 Jun 2022 09:19:40 -0700
In-Reply-To: <pull.1265.git.1655697671724.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Mon, 20 Jun 2022 04:01:11 +0000")
Message-ID: <xmqqbkumhtur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F48F02BC-F17D-11EC-A863-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
>    The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
> -  refers to the branch that the branch specified by branchname is set to build on
> -  top of (configured with `branch.<name>.remote` and
> -  `branch.<name>.merge`).  A missing branchname defaults to the
> -  current one. These suffixes are also accepted when spelled in uppercase, and
> -  they mean the same thing no matter the case.
> +  refers to the remote branch that the branch specified by branchname
> +  is set to build on top of (configured with `branch.<name>.remote` and
> +  `branch.<name>.merge`).

Let's refrain from inventing confusing new phrases that are not
defined in "git help glossary".

What is a "remote branch"?  I think this is better left as "the
branch", to avoid confusion with remote-tracking branch we keep
locally.  I think a version with a slight tweak, e.g.

        ... refers to the name of the branch (configured with
        `branch.<name>.merge`) at the remote (configured with
        `branch.<name>.remote`) that the branch is set to build on
        top of.

would be OK, though.

> ... As `branch.<name>.merge` is the branch path on the
> +  remote, it is first converted to a local tracking branch (i.e., something in
> +  `refs/remotes/`).

Let's correct it to "remote-tracking branch".

But more importantly, the order of explanation feels a bit
backwards. Something like...

    A branch B may be set up to build on top of a branch X
    (configured with `branch.<name>.merge`) at a remote R
    (configured with `branch.<name>.remote`).  B@{u} refers to the
    remote-tracking branch for the branch X taken from remote R,
    typically found at `refs/remotes/R/X`.

... to cover both of the above, perhaps, may flow more naturally?

> ... A missing branchname defaults to the current one. These
> +  suffixes are also accepted when spelled in uppercase, and they mean the same
> +  thing no matter the case.

>  '[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
>    The suffix '@\{push}' reports the branch "where we would push to" if
>    `git push` were run while `branchname` was checked out (or the current
> -  `HEAD` if no branchname is specified). Since our push destination is
> -  in a remote repository, of course, we report the local tracking branch
> -  that corresponds to that branch (i.e., something in `refs/remotes/`).
> +  `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
> +  the local tracking branch that corresponds to that remote branch.
>  +
>  Here's an example to make it more clear:
>  +
>
> base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
