Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B0C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 23:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiCPXJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 19:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiCPXJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 19:09:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495813F8C
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 16:08:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16B3B121479;
        Wed, 16 Mar 2022 19:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kBC0Ce/wJ2nuRHbrrnlCGPSW0T6FKevZ2HuB85
        OiuTk=; b=ROcZjly2UfkPAeFh++BGHiGhRrhstwnCxzk6K/OZKn7r+pPbu3ZCSX
        G5gkeXMAngeTq8yOW45Bw4ZhRD80/kfGZOEyil9aHTS/j9JssMX8ID+Zck5mRQjf
        ktN2PIcEheteR9TI3h+RV4YVBG98ObcsldNR6KhuxEo24DtJSDYV8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EAE7121478;
        Wed, 16 Mar 2022 19:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F92E121476;
        Wed, 16 Mar 2022 19:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220304005757.70107-1-chooglen@google.com>
        <20220308001433.94995-1-chooglen@google.com>
        <xmqqr17dp8s9.fsf@gitster.g>
        <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqfsnrkkhd.fsf@gitster.g>
        <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k46nae4.fsf@gitster.g>
        <kl6lzgly4vz3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6la6dplfts.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqfsnhk0x7.fsf@gitster.g>
        <kl6l7d8tle24.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 16 Mar 2022 16:08:27 -0700
In-Reply-To: <kl6l7d8tle24.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 16 Mar 2022 15:37:07 -0700")
Message-ID: <xmqqa6dpjy1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD891C64-A57D-11EC-BBF1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Perhaps squashing in a NEEDSWORK comment into [PATCH v5 09/10] will
> suffice? I can also resend this series if preferred.

It should work.  Let me try it in the last integration cycle of
today.

> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> diff --git a/submodule.c b/submodule.c
> index 6e6b2d04e4..93c78a4dc3 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -795,6 +795,21 @@ static const char *default_name_or_path(const char *path_or_name)
>   * superproject commit that points to the submodule, but this is
>   * arbitrary - we can choose any (super_oid, path) that matches the
>   * submodule's name.
> + *
> + * NEEDSWORK: Storing an arbitrary commit is undesirable because we can't
> + * guarantee that we're reading the commit that the user would expect. A better
> + * scheme would be to just fetch a submodule by its name. This requires two
> + * steps:
> + * - Create a function that behaves like repo_submodule_init(), but accepts a
> + *   submodule name instead of treeish_name and path. This should be easy
> + *   because repo_submodule_init() internally uses the submodule's name.
> + *
> + * - Replace most instances of 'struct submodule' (which is the .gitmodules
> + *   config) with just the submodule name. This is OK because we expect
> + *   submodule settings to be stored in .git/config (via "git submodule init"),
> + *   not .gitmodules. This also lets us delete get_non_gitmodules_submodule(),
> + *   which constructs a bogus 'struct submodule' for the sake of giving a
> + *   placeholder name to a gitlink.
>   */
>  struct changed_submodule_data {
>  	/*
