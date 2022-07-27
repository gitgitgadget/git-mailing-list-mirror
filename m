Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40CBC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 14:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiG0Ou5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiG0Ouz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 10:50:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD253ED58
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 07:50:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A06FB144773;
        Wed, 27 Jul 2022 10:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FXWz9mxcxSh6UA07wvcT+rsBoHo3beLG0BsfvvKbASc=; b=ybGS
        wEpsgP4bpXsOGPGxyESHmoAYjLjK2P/thgYNBE5qy3strROr6IRlSWuVL02LlqR8
        NnF1j3jFgmNMSdxViirsZqr0Ywo1/g0pftoEbI07b2OboHfDGlU2dDCw+2tYfVVs
        vuveIBNvHVa6kZOyYq/dvMalz8fEj+iRqOykisA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97E02144772;
        Wed, 27 Jul 2022 10:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF7EB144771;
        Wed, 27 Jul 2022 10:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] log: add default decoration filter
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Jul 2022 07:50:51 -0700
Message-ID: <xmqqczdqtxro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 833A0D5A-0DBB-11ED-BF8E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When a user runs 'git log', they expect a certain set of helpful
> decorations. This includes:
>
> * The HEAD ref

OK.

> * Branches (refs/heads/)

OK.

> * Notes (refs/notes/)

Questionable.  None of the notes commits are on the primary history,
so it is unlikely to be even used for decoration, so it would not
hurt to have them as part of possible decoration sources, but on the
other hand, the value of using them is dubious.

> * Stashes (refs/stash/)

Questionable, for the same reason as 'notes'.

> * Tags (refs/tags/)

Abolutely useful.

> * Remote branches (refs/remotes/)

Ditto.

>  --decorate-refs=<pattern>::
>  --decorate-refs-exclude=<pattern>::
> -	If no `--decorate-refs` is given, pretend as if all refs were
> -	included.  For each candidate, do not use it for decoration if it
> +	For each candidate reference, do not use it for decoration if it
>  	matches any patterns given to `--decorate-refs-exclude` or if it
>  	doesn't match any of the patterns given to `--decorate-refs`. The
>  	`log.excludeDecoration` config option allows excluding refs from
>  	the decorations, but an explicit `--decorate-refs` pattern will
>  	override a match in `log.excludeDecoration`.
> ++
> +If none of these options or config settings are given, then references are
> +used as decoration if they match `HEAD`, `refs/heads/`, `refs/notes/`,
> +`refs/remotes/`, `refs/stash/`, or `refs/tags/`.
>  
>  --source::
>  	Print out the ref name given on the command line by which each

OK.

Thanks.

