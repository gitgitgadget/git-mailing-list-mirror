Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE46C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 16:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbiEKQwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiEKQvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 12:51:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07579694BA
        for <git@vger.kernel.org>; Wed, 11 May 2022 09:51:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64FD7129594;
        Wed, 11 May 2022 12:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AmRoRGsyTnfRtm1W6uswCmq4rKCFbV7RGvbmwB
        EYSPg=; b=Tcur9oY7pY+Q5ifEXDeYf9LSMoNruyUQznv4yq5oTmD6u6lL4GbqWU
        3VRqj+90/dELiD4WaA8MxmWMva1k7fDKW5AKnKQeUl2A2hkGzw3z4N8jzbpbiIhH
        C+SE2GIUGecfqIgWmNvCWE8LmnchzgsVBDfY4MsusnTrMeISNPJHM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BCF9129593;
        Wed, 11 May 2022 12:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A912B129592;
        Wed, 11 May 2022 12:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Goss Geppert <gg.oss.dev@gmail.com>
Cc:     git@vger.kernel.org, christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/2] dir: minor refactoring / clean-up
References: <20220505203234.21586-1-ggossdev@gmail.com>
        <20220510171527.25778-1-ggossdev@gmail.com>
        <20220510171527.25778-3-ggossdev@gmail.com>
Date:   Wed, 11 May 2022 09:51:20 -0700
In-Reply-To: <20220510171527.25778-3-ggossdev@gmail.com> (Goss Geppert's
        message of "Tue, 10 May 2022 17:15:27 +0000")
Message-ID: <xmqqv8ucko6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9610866E-D14A-11EC-A3A4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goss Geppert <gg.oss.dev@gmail.com> writes:

> Improve readability.

It reads somewhat a subjective opinion, without explaining how/why
the change makes it more readable.  Perhaps

	Narrow the scope of the nested_repo variable to the block
	that uses it.

or something?

I was hoping that we can/should apply these two patches near where
the breakage happened, but unfortunately this part has been updated
a bit since then, so merging upwards would involve a bit of conflict
resolution.  We should be able to manage.

Thanks.


> Signed-off-by: Goss Geppert <ggossdev@gmail.com>
> ---
>  dir.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index a1886e61a3..329db72999 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1861,7 +1861,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  	 */
>  	enum path_treatment state;
>  	int matches_how = 0;
> -	int nested_repo = 0, check_only, stop_early;
> +	int check_only, stop_early;
>  	int old_ignored_nr, old_untracked_nr;
>  	/* The "len-1" is to strip the final '/' */
>  	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
> @@ -1901,6 +1901,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  		 *    configured by the user; see t2205 testcases 1a-1d for examples
>  		 *    where this matters
>  		 */
> +		int nested_repo;
>  		struct strbuf sb = STRBUF_INIT;
>  		strbuf_addstr(&sb, dirname);
>  		nested_repo = is_nonbare_repository_dir(&sb);
> @@ -1919,12 +1920,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  			free(real_dirname);
>  		}
>  		strbuf_release(&sb);
> -	}
> -	if (nested_repo) {
> -		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> -		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
> -			return path_none;
> -		return excluded ? path_excluded : path_untracked;
> +
> +		if (nested_repo) {
> +			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> +				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
> +				return path_none;
> +			return excluded ? path_excluded : path_untracked;
> +		}
>  	}
>  
>  	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
