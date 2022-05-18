Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA6C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbiERS66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiERS6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 14:58:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16686218FF8
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:58:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F20A4189902;
        Wed, 18 May 2022 14:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qHqjhMDXZZxwQM1nrQwppGuaHo3vMuRwyav4Gy
        CnLq0=; b=xufR66C5QalpapUALwn5kzaVZSIPRmpgfsz43KdkmOmM6xW+3YQVhh
        0rjFs3SmmWkHSayjMW+dc3URIzjKW7WWADUK/4CvGvN3DPG1sEUkVdGNVo64PZDC
        Nsbs/FJgwonkpdS/vGgZS04LRQ9pVJ1g0GOsm3vQSvykT7Duob/9w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E58AD189900;
        Wed, 18 May 2022 14:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C88BA1898FC;
        Wed, 18 May 2022 14:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "mataha via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, mataha <mateusz.kazimierczuk@xolv.io>
Subject: Re: [PATCH] templates: clarify SHA1 arg in prepare-commit-msg
References: <pull.1265.git.git.1652899219597.gitgitgadget@gmail.com>
Date:   Wed, 18 May 2022 11:58:46 -0700
In-Reply-To: <pull.1265.git.git.1652899219597.gitgitgadget@gmail.com> (mataha
        via GitGitGadget's message of "Wed, 18 May 2022 18:40:19 +0000")
Message-ID: <xmqqtu9mvfa1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C677126-D6DC-11EC-AB6A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the development community.

"mataha via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: mataha <mateusz.kazimierczuk@xolv.io>

The name here must match the name you sign the patch off as,
i.e. this line should read

    From: Mateusz 'mataha' Kazimierczuk <mateusz.kazimierczuk@xolv.io>

> 'prepare-commit-msg' hook sample description doesn't mention the third
> argument (a commit object name) nor when is it actually passed to that
> hook by git-commit (if the source is a commit; see builtin/commit.c#L777,
> sequencer.c#L1219). Seeing that it's documented in githooks(5), there
> should be no reason not to include that in the sample hook as well.

There should be a mention of the commit that added the hook, namely,
8089c85b (git-commit: add a prepare-commit-msg hook, 2008-02-05).
The log message for this patch should also observe that this third
argument, which is given only when the source is 'commit', was not
mentioned in the sample hook added by the original commit.

Interestingly, its log message reads:

    ...
    Its purpose is to modify the commit message in-place.

    It takes one to three parameters.  The first is the name of the file that
    the commit log message.  The second is the source of the commit message,
    and can be: "message" (if a -m or -F option was given); "template" (if a
    -t option was given or the configuration option commit.template is set);
    "merge" (if the commit is a merge or a .git/MERGE_MSG file exists);
    "squash" (if a .git/SQUASH_MSG file exists); or "commit", followed by
    a commit SHA1 as the third parameter (if a -c, -C or --amend option
    was given).
    ...

So it wasn't a mistake that the sample did not mention it.  I think
the reason why the original, and today's version, does not mention
it is because no sample code in the file actually uses it.

I am not yet convinced that it is a good idea to only add mention to
the third one if we are not showing how it is used to this file,
especially given that in the documentation we _do_ cover these
arguments fully.

Thanks.

> Signed-off-by: Mateusz 'mataha' Kazimierczuk <mateusz.kazimierczuk@xolv.io>
> ---
>     Mention the third argument in 'prepare-commit-msg' hook sample
>     
>     'prepare-commit-msg' hook sample doesn't mention what the third argument
>     is for nor when is it actually passed; I feel like it should be, for the
>     sake of convenience (this doesn't mean that a user shouldn't refer to a
>     more detailed description in the manual, of course).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1265%2Fmataha%2Fdoc%2Fprepare-commit-msg-args-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1265/mataha/doc/prepare-commit-msg-args-v1
> Pull-Request: https://github.com/git/git/pull/1265
>
>  templates/hooks--prepare-commit-msg.sample | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index 318afe3fd86..bc06d0701a8 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -3,9 +3,9 @@
>  # An example hook script to prepare the commit log message.
>  # Called by "git commit" with the name of the file that has the
>  # commit message, followed by the description of the commit
> -# message's source.  The hook's purpose is to edit the commit
> -# message file.  If the hook fails with a non-zero status,
> -# the commit is aborted.
> +# message's source and the commit object name (if the source was
> +# a commit).  The hook's purpose is to edit the commit message file.
> +# If the hook fails with a non-zero status, the commit is aborted.
>  #
>  # To enable this hook, rename this file to "prepare-commit-msg".
>  
>
> base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
