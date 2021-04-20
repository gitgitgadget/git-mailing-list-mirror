Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF92C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22974613C7
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhDTWcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:32:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63046 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTWcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:32:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7DB7B9CC7;
        Tue, 20 Apr 2021 18:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3Ksz7NEd5IyD
        MiXKHLAnmE1Q3Ag=; b=Jk5w6aeze8SfVAaf/u+YmIddNjNoayMbreko24g/KbTt
        jb3B/9CaDBg87CVzci8mzpDLj5nKEnN1bP+CzvHITryYEVBibxILOz+OnMAoF57M
        xA12wlLLFz89cwCUhLqr6eMBHk7IM58ZmpQ3ga1jPWaWx3Su50onoat0VIjzmzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GhhXN8
        CoLzo3Uw1tFh7xEVBv7ewWNpkapsZdTw31vuz7JViwHSm2V3b8JsKoHGsRvmY5L8
        0MPZ5+RB5hW9F7Kp5v+yH+X+r+Kguh5iiuhK/b6q32mk4yQ23leSzE+D0wKWMiEH
        w0y5+zcx3ganTTLMKw3DtO9V5VArdBQIXJEaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6592B9CC6;
        Tue, 20 Apr 2021 18:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11B15B9CC5;
        Tue, 20 Apr 2021 18:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] git-completion.bash: rename to $__git_cmd_idx
References: <cover.1618910364.git.liu.denton@gmail.com>
        <7c7d6de380d1aaa860e86627778bef6c0c78ca08.1618910364.git.liu.denton@gmail.com>
        <xmqqr1j44r5g.fsf@gitster.g> <20210420211432.GA3842406@szeder.dev>
Date:   Tue, 20 Apr 2021 15:31:47 -0700
In-Reply-To: <20210420211432.GA3842406@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Tue, 20 Apr 2021 23:14:32 +0200")
Message-ID: <xmqqo8e837vw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31AFACB0-A228-11EB-9FA4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The completion functions for git commands having subcommands usually
> start like this:
>
>     _git_remote ()
>     {
>         local subcommands=3D"
>                 add rename remove set-head set-branches
>                 get-url set-url show prune update
>                 "
>         local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>         if [ -z "$subcommand" ]; then
>
> __git_subcommand_idx holds the index of the word "remote", not the
> index of "add/rename/etc.", so in the context of the completion script
> that name is misleading.

OK.  As subsubcommands would be a mouthful, calling "stash" etc. as
"cmd" would be fine.
