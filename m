Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C545BC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 21:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9229C218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 21:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mNLxeYd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLRV3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:29:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53473 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLRV3d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 16:29:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 162B827D31;
        Wed, 18 Dec 2019 16:29:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VleZt/ffZpAA0D3Crg4zhsYRox8=; b=mNLxeY
        d/+W8JUU9BUwCAaNZO78zidCFsTFbicAt9QNzfwjThCq87Eav6Tb0gDBBtXzxTyN
        U2EWsN+hMyIAUrDoy9sM+pS8HmebEMfWRp++lDDD7JDogT4hodOK10r8qBtiO9Co
        Aoqu7vfWVbPeLQDWP4nWnbmKDQK/o+ShiQxI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pT/BSOJs407hLZZnG46G5/QwZChnCiVz
        9+JGdwILk8ZNuVuhk+T4HwiqJW2UN5rya1EA1tkkhdt4rb7kGR1iCkzhZaOPHNlh
        48zPo+qnz984t/L9qqx8S1lT/hBZN+fXyo5bH+FXd0/QaIqBfDA+ab7mRw+GpAA3
        rWlxTk3B9Ug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CA9827D2E;
        Wed, 18 Dec 2019 16:29:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64A8827D2B;
        Wed, 18 Dec 2019 16:29:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, blees@dcon.de, kyle@kyleam.com,
        sxlijin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 13:29:25 -0800
In-Reply-To: <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 18 Dec 2019
        19:29:44 +0000")
Message-ID: <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 777BC2AA-21DD-11EA-87CB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...
> Fix most these problems by making treat_leading_path() not only loop
> over each leading path component, but calling treat_path() directly on
> each.  To do so, we have to create a synthetic dir_entry, but that only
> takes a few lines.  Then, pay attention to the path_treatment result we
> get from treat_path() and don't treat path_excluded, path_untracked, and
> path_recurse all the same as path_recurse.
>
> This leaves one remaining problem, the new inconsistency from commit
> df5bcdf83ae.  That will be addressed in a subsequent commit.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  dir.c                                         | 57 +++++++++++++++----
>  ...common-prefixes-and-directory-traversal.sh |  6 +-
>  2 files changed, 49 insertions(+), 14 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 645b44ea64..1de5d7ad33 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2102,37 +2102,72 @@ static int treat_leading_path(struct dir_struct *dir,
>  			      const struct pathspec *pathspec)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	int baselen, rc = 0;
> +	int prevlen, baselen;
>  	const char *cp;
> +	struct cached_dir cdir;
> +	struct dirent *de;
> +	enum path_treatment state = path_none;
> +
> +	/*
> +	 * For each directory component of path, we are going to check whether
> +	 * that path is relevant given the pathspec.  For example, if path is
> +	 *    foo/bar/baz/
> +	 * then we will ask treat_path() whether we should go into foo, then
> +	 * whether we should go into bar, then whether baz is relevant.
> +	 * Checking each is important because e.g. if path is
> +	 *    .git/info/
> +	 * then we need to check .git to know we shouldn't traverse it.
> +	 * If the return from treat_path() is:
> +	 *    * path_none, for any path, we return false.
> +	 *    * path_recurse, for all path components, we return true
> +	 *    * <anything else> for some intermediate component, we make sure
> +	 *        to add that path to the relevant list but return false
> +	 *        signifying that we shouldn't recurse into it.
> +	 */
>  
>  	while (len && path[len - 1] == '/')
>  		len--;
>  	if (!len)
>  		return 1;
> +
> +	de = xcalloc(1, sizeof(struct dirent)+len+1);

That "+len+1" may deserve a comment?  If we wanted to shoot for the
minimum memory consumption (and we do not), we would probably
allocate

	(sizeof(struct dirent) - sizeof(de->d_name)) +
		max(sizeof(de->d_name), len + 1)

bytes, but unconditionally adding len+1 is simpler and easier to
understand.  Either way, we *are* relying on the assumption that
either:

 (1) the "struct dirent" would have d_name[] array at the end of the
     struct, and by over-allocating, we can safely fit and carry a
     name that is much longer than sizeof(.d_name[]); OR

 (2) the "struct dirent" has d_name[] that is large enough to hold len+1
     bytes, if the assumption (1) does not hold.

is true.

> +	memset(&cdir, 0, sizeof(cdir));
> +	cdir.de = de;
> +#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> +	de->d_type = DT_DIR;
> +#endif
>  	baselen = 0;
> +	prevlen = 0;
>  	while (1) {
> -		cp = path + baselen + !!baselen;
> +		prevlen = baselen + !!baselen;
> +		cp = path + prevlen;
>  		cp = memchr(cp, '/', path + len - cp);
>  		if (!cp)
>  			baselen = len;
>  		else
>  			baselen = cp - path;
> -		strbuf_setlen(&sb, 0);
> +		strbuf_reset(&sb);
>  		strbuf_add(&sb, path, baselen);
>  		if (!is_directory(sb.buf))
>  			break;



> -		if (simplify_away(sb.buf, sb.len, pathspec))
> -			break;
> -		if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
> -				   DT_DIR, NULL) == path_none)
> +		strbuf_reset(&sb);
> +		strbuf_add(&sb, path, prevlen);
> +		memcpy(de->d_name, path+prevlen, baselen-prevlen);
> +		de->d_name[baselen-prevlen] = '\0';
> +		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
> +				    pathspec);

So this is the crux fo the fix---instead of doing a (poor) imitation
of what treat_path() does by calling simplify_away() and
treat_one_path() ourselves, we make a call to the real thing.

Looking good.  Thanks.
