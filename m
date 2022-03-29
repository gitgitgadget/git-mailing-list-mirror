Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F21EC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiC2PvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiC2PvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 11:51:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8262BDC
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 08:49:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C73A108BE3;
        Tue, 29 Mar 2022 11:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ETZy8rWTj4cX
        LeHBNG/vsSTB5xUoUfjdpeycqpqawmw=; b=x72N6i/cu2IXm7G+tFi8Xz+uNXnh
        JJhsmjO1NysYF0hYXtLQbYhEi8WmiOv/Wh1OYavd3zle0VeZUYfOFsEQw6+MkNCv
        +1hNhWt7pA/ABwXo/buaCnVF+flSvo0hvkge7MOpbuFv0cX7aHvyLTwVMSErW4YM
        Oc5JhPZX2DUx9Ys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54070108BE1;
        Tue, 29 Mar 2022 11:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEA51108BE0;
        Tue, 29 Mar 2022 11:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v4] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
        <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 08:49:33 -0700
In-Reply-To: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Tue, 29 Mar 2022 11:26:48
        +0000")
Message-ID: <xmqqh77gyd0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D4C5CD8C-AF77-11EC-9627-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> The error "not tracking: ambiguous information for ref" is raised
> when we are evaluating what tracking information to set on a branch,
> and find that the ref to be added as tracking branch is mapped
> under multiple remotes' fetch refspecs.
>
> This can easily happen when a user copy-pastes a remote definition
> in their git config, and forgets to change the tracking path.
>
> Add advice in this situation, explicitly highlighting which remotes
> are involved and suggesting how to correct the situation.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     tracking branches: add advice to ambiguous refspec error
>    =20
>     I believe this third version incorporates all =C3=86var's suggestio=
ns, and
>     might be usable. Removed "RFC" prefix.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%=
2FTaoK%2Fadvise-ambiguous-tracking-refspec-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/Tao=
K/advise-ambiguous-tracking-refspec-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1183
>
> Range-diff vs v3:
>
>  1:  22ffe81ac26 =3D 1:  ac6c782f566 tracking branches: add advice to a=
mbiguous refspec error
>
>
>  Documentation/config/advice.txt |  4 +++
>  advice.c                        |  1 +
>  advice.h                        |  1 +
>  branch.c                        | 44 +++++++++++++++++++++++++++++----
>  4 files changed, 45 insertions(+), 5 deletions(-)

Sent a wrong version?

The patch text seems to be identical to that of v3 message archived at
https://lore.kernel.org/git/pull.1183.v3.git.1648450268285.gitgitgadget@g=
mail.com/
