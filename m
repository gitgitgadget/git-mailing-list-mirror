Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F2EEAA69
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbjINTCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbjINTBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 15:01:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AF2119
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 12:01:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 881D8244A2;
        Thu, 14 Sep 2023 15:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=r3iOGbXl62MOrTT+Rm//WiNlXcaIvW4p7rzyCG
        ZFQlU=; b=Ak/xrNmKZniYZ6w6gP5QwRDnipWiX2B9Y8qFxyh5gOsVDxGhz36xMw
        sGMIANe3A35esf2iyI/oqHDpy3ShG6doJSpLJJhI97WHXxzT9e8//dpywp94ikXK
        UTUYEXN92Rl5vDQTeKJhQDW+WSLorQ5a0mpvgF/lgiXSsYt6+RF2U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FF62244A1;
        Thu, 14 Sep 2023 15:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07827244A0;
        Thu, 14 Sep 2023 15:00:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
In-Reply-To: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
        (Dragan Simic's message of "Thu, 14 Sep 2023 05:25:02 +0200")
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
Date:   Thu, 14 Sep 2023 12:00:54 -0700
Message-ID: <xmqqzg1oinq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08C19860-5331-11EE-9A8A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Mention in the documentation that --rebase defaults to false.

I am not quite sure if this is an improvement, though.

It is true that, if you do not have any of your own funny
configuration, your "git pull" will *not* rebase.  

But that is "if you do not give the --rebase option, you do not
trigger the rebase action".  Which is quite natural, but it is
different from what you wrote above, isn't it?

When people say "the default for `--rebase` is false", they mean
this:

    I can say "git pull --rebase=<kind>" to specify how my current
    branch is rebased on top of the upstream.  But if I do not
    specify the <kind>, i.e. "git pull --rebase", the command will
    act as if I gave 'false' as the <kind>.

At least, I would think that is what the word "default" means.

And I would be surprised if the "default" in that sense is 'false';
isn't the default <kind> 'true' --- meaning "perform the plain
vanilla 'git rebase'", unless you explicitly asked for 'merges',
'interactive' or 'false'?

After the context of the hunk your patch touches, there is a
description on `pull.rebase`.  Down there, if you do not set
`pull.rebase` or `branch.<name>.rebase` for the current branch at
all, the system acts as if you had `false` for these variables.  In
other words, the default for these variables is `false`, meaning "do
not rebase, just merge".  But the default option argument for the
`--rebase` option given without argument would not be `false`, I
would think.

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/git-pull.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 0e14f8b5b2..d28790388e 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -116,7 +116,8 @@ When set to `merges`, rebase using `git rebase --rebase-merges` so that
>  the local merge commits are included in the rebase (see
>  linkgit:git-rebase[1] for details).
>  +
> -When false, merge the upstream branch into the current branch.
> +When false, merge the upstream branch into the current branch. This is
> +the default.
>  +
>  When `interactive`, enable the interactive mode of rebase.
>  +
