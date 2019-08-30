Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2630F1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfH3T5g (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:57:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfH3T5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:57:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8BD9165C2D;
        Fri, 30 Aug 2019 15:57:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iat1uCS/TJVm7jAzkJXx3Pd50as=; b=oLhUVA
        SQoTdmWM+tAq37uzXJfrDLFstAJb6g2msPG/ndSan4C1dXPHfEZWecCvu1cwWMSc
        VtrJ0UXeKiIHIwOwTYPMnLkQ3if6UfovF9afgVw2utR4QsSVNgoBaJ7iwZ0NfS0L
        DMwPLVYJ4fVS97+CNjaHKLXGLMqRfMp4kLyfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hywim86DFvwwVl3j/UGP4EEAhPv/XawK
        nWyFyWnnkgdvTF4tAoAllH5fxJNs0rlanVTitBrBRSTktgWliPwb5k4BO5GHSWN6
        ++8PSTl2xA4EDpoZPz/CXG+THdFSWrn93a6ipuykCAL/mVynbU3o1l3+z7tOUzHk
        HW8kgs8H0jY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFD73165C2C;
        Fri, 30 Aug 2019 15:57:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 071A1165C29;
        Fri, 30 Aug 2019 15:57:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3] merge-options.txt: clarify meaning of various ff-related options
References: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
        <20190828225712.20041-1-newren@gmail.com>
Date:   Fri, 30 Aug 2019 12:57:28 -0700
In-Reply-To: <20190828225712.20041-1-newren@gmail.com> (Elijah Newren's
        message of "Wed, 28 Aug 2019 15:57:12 -0700")
Message-ID: <xmqq7e6uxw7r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6606004A-CB60-11E9-BD00-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 79a00d2a4a..ed3804650b 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -40,20 +40,26 @@ set to `no` at the beginning of them.
>  	case of a merge conflict.
>  
>  --ff::
>  --no-ff::
>  --ff-only::
> +	Whether to prefer resolving the merge as a fast forward (only
> +	updating the branch pointer to match the merged branch and not
> +	creating a merge commit), to never allow it (always creating a
> +	merge commit), or to only allow fast forward updates.  The
> +	default is `--ff`, except when merging an annotated (and
> +	possibly signed) tag that is not stored in its natural place
> +	in the `refs/tags/` hierarchy (in which case `--no-ff` is
> +	assumed).
> ++
> +With `--ff`, resolve the merge as a fast-forward when possible (when the
> +merged branch contains the current branch in its history).  When not
> +possible, create a merge commit.
> ++
> +With `--no-ff`, create a merge commit in all cases, even when the merge
> +could instead be resolved as a fast-forward.
> ++
> +With `--ff-only`, resolve the merge as a fast-forward when possible.
> +When not possible, refuse to merge and exit with a non-zero status.

I cannot shake the feeling that the above redundantly repeats the
same thing twice.

If we want to dedicate one paragraph for each of these options, we
can and should make the introductory paragraph lighter by saying
something like

	Specifies how a merge is handled when the merged-in history
	is already a descendant of the current history.  `--ff` is
	the default unless merging an annotated or signed tag that
	is not stored in the `refs/tags/` hierarchy, in which case
	`--no-ff` is the default.

Alternatively, we could sprinkle the actual option name in the first
paragraph and drop the last three paragraphs, while fattening the
description as necessary, e.g.

	Whether to prefer resolving the merge as a fast-forward and
	update the branch pointer to match the merged branch without
	creating an extra merge commit (`--ff`), never allow fast-forward
	and always creating an extra merge commit (`--no-ff`), or to
	only allow fast forward updates and reject when a merge
	commit needs to be created (`--ff-only`).  The default is ...

I think either approach shown above would reduce the redundancy.  I
do not care too deeply which one of these approaches is used myself,
but the redundancy feels a bit disturbing.

Thanks.
