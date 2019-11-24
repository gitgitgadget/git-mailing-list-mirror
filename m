Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32571C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 05:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9B2075E
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 05:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLCeVpJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfKXFRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 00:17:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52604 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfKXFRs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 00:17:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86D7BA00F4;
        Sun, 24 Nov 2019 00:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YAxTEsDY5gCvAbbfwmjVP9oyRbo=; b=TLCeVp
        J1ij/k1X4M8Eqlfxgow7yJeN6DASJXQgqJFAwD2aQLnhKKlwoK4fpyrFM43LNomE
        f0spNJhF4Sl5niKPN7oE3vFGMCFUG82LhhdjcGMrE9rj54wBU/CE9jDaFtx1m+kW
        9V+UqnOJhZH86QY54SGJ3+us1BS6P5Sra6UhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a7MjQA2xGJRCn2BWw3EM67nY63d650Bc
        w45XNyQy2V4v3xCp4JiocIZCzwcNw3KzAC5mQjNlRWaWHNmgjGAlsXjrJSu4YJ2L
        ZrOZtHQYwfV+nTygWuT83izSL7MdWOs0CsHq230fWSl7KDN92TgdaHxTN16p36E0
        42DSxERdDfs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 730BEA00F3;
        Sun, 24 Nov 2019 00:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CCFAA00F2;
        Sun, 24 Nov 2019 00:17:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Manish Goregaokar <manishsmail@gmail.com>
Subject: Re: [PATCH 1/1] submodule: Fix 'submodule status' when called from a subdirectory
References: <pull.472.git.1574490521.gitgitgadget@gmail.com>
        <2004f4aaa99e5d936a3f3d141b5612df9b013f14.1574490521.git.gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 14:17:40 +0900
In-Reply-To: <2004f4aaa99e5d936a3f3d141b5612df9b013f14.1574490521.git.gitgitgadget@gmail.com>
        (Manish Goregaokar via GitGitGadget's message of "Sat, 23 Nov 2019
        06:28:41 +0000")
Message-ID: <xmqqd0dh26q3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDB212E6-0E79-11EA-9E6C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Manish Goregaokar <manishsmail@gmail.com>
> Subject: [PATCH 1/1] submodule: Fix 'submodule status' when called from a subdirectory

At least, downcase 'fix' to match the project convention on commit
titles (you can see "git shortlog -n 100 --no-merges", for example).

> Previously, when calling `git submodule status` while in a
> subdirectory, it was incorrectly not detecting modified submodules and
> thus reporting that all of the submodules were unchanged.

We do not have to "Previously, ", as the norm for our log messages
is to talk about the status quo (the state before applying your
patch) in the current tense.  The word used like this is fine,
though: "Previously commit X changed the behaviour of feature A, but
it was wrong for such and such reasons; let's address the issue
commit X wanted to change by doing this"

> This was because the submodule helper was calling `diff-index` with the
> submodule path assuming the path was relative to the current prefix
> directory, however the submodule path used is actually relative to the root.

OK; modulo tense, nicely explained.

> This fixes the bug by setting the `prefix` to NULL when running
> `diff-index` from the helper, so that it correctly interprets the path
> as relative to the repository root.

And then we outline the fix as if we are giving an order to the
codebase "to be like so", in imperative mood.  I.e.

    Always pass NULL as the `prefix` when running the diff-index
    command inside the submodule, to make sure that we see changes
    to submodules anywhere in the superproject's tree, not limited
    to the current directory.

or something like that.  By the way, aren't we running diff-files,
not diff-index, in this context?

> Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
> ---
>  builtin/submodule--helper.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This fix should be protected by an additional test or two to make
sure others won't break it again.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 909e77e802..abc5b46d46 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -802,7 +802,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>  			 path, NULL);
>  
>  	git_config(git_diff_basic_config, NULL);
> -	repo_init_revisions(the_repository, &rev, prefix);
> +	/*
> +	 * prefix is NULL since path is an absolute path
> +	 */
> +	repo_init_revisions(the_repository, &rev, NULL);

Absolute???  Isn't 'path' relative to the top-level of the
superproject's working tree?

In any case, I do not think this does not deserve a multi-line
in-code comment, once we get the code right.  Explaining why this
must be NULL instead of prefix is better done in the commit log
message.

Thanks.
