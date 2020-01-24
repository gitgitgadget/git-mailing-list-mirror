Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABFC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4732075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xl/Romek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbgAXSt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:49:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51758 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbgAXStz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:49:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 925569D771;
        Fri, 24 Jan 2020 13:49:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=seDXSX4rqSINJKtMrjVamao3H7c=; b=Xl/Rom
        ekSFvP5vYtu1FQjGfnCLRFL5k+M67I6oGPByNnfPtj0y8DW5TxispvNkAtB2k3SP
        IRukwOTf+7DCCkDLm8RTDl6XnJjY/P/Ujda+2FNLD/k56Ia2mUWoozsYCe+jCxva
        EfnuVBEo1nGt1P5PKS7Y9DTe79+yPnvt8c+pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kZAkUQuiAlEMDxm44fCRu5jJDPmBotvE
        aAKgfOfHZrvb4s1dlI1iO12RBEjHq0LHG7WNV9whAbUIOZsTd2z0v/Wt8P2tm/Nk
        d6DlC2h8deSylOvW3YIV6EOIr+p0GRpUWyzIOcRAXUZX9wgLY7AvpOMQwjPxp/2O
        W6kjUkMPdho=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A4AD9D770;
        Fri, 24 Jan 2020 13:49:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9062D9D73C;
        Fri, 24 Jan 2020 13:49:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4 4/6] config: split repo scope to local and worktree
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <9f160e281a984ea7578f8fbe244adc77c6585e44.1579825267.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 10:49:47 -0800
In-Reply-To: <9f160e281a984ea7578f8fbe244adc77c6585e44.1579825267.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 24 Jan 2020
        00:21:04 +0000")
Message-ID: <xmqq1rro1ygk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C88E162-3EDA-11EA-B64E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> Previously when iterating through git config variables, worktree config
> and local config were both considered "CONFIG_SCOPE_REPO".  This was
> never a problem before as no one had needed to differentiate between the
> two cases, but future functionality may care whether or not the config
> options come from a worktree or from the repository's actual local
> config file.  For example, the planned feature to add a '--show-scope'
> to config to allow a user to see which scope listed config options come
> from would confuse users if it just printed 'repo' rather than 'local'
> or 'worktree' as the documentation would lead them to expect.  As well
> as the additional benefit of making the implementation look more like
> how the documentation describes the interface.
>
> To accomplish this we split out what was previously considered repo
> scope to be local and worktree.
>
> The clients of 'current_config_scope()' who cared about
> CONFIG_SCOPE_REPO are also modified to similarly care about
> CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  config.c               | 7 ++-----
>  config.h               | 3 ++-
>  remote.c               | 3 ++-
>  t/helper/test-config.c | 4 +++-
>  t/t1308-config-set.sh  | 2 +-
>  upload-pack.c          | 3 ++-
>  6 files changed, 12 insertions(+), 10 deletions(-)

Nicely done.

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 7b4e1a63eb..90196e2862 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -259,7 +259,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-repo
>  	origin=file
>  	name=.git/config
> -	scope=repo
> +	scope=local
>  
>  	key=foo.bar
>  	value=from-cmdline

OK.

