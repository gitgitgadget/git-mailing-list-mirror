Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C29C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDEC20665
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbIk1hub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJEHoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgJEHoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:44:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C26C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 00:44:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g9so4956053pgh.8
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qjHP76J4uioHdlVAEaAzcH0j7Rl6q3veYWTHgxbZuZ0=;
        b=bbIk1hubLRmcMbKwhU7jHh2dbP0W32xLsDHsIohy5JN3g5ECZh+XWncIJXMYe6LcyL
         1XwAsF7rwpDfXTxlfEPcfiJnHAzyu5JToP7MlSQQrBn+RYMAe8BZmbYI8iKKRkodOb/p
         9LM67uDo8H8xN02ihTNH7F+Ql+VE/TdeEStnWHLozAPnUeHP5QQFKwjeQ8GyZq//WZpf
         QDmuTooBnvxGt7MoiqtAyohWquLfMUptCACyGwb8EyzFg2vpnuYdt40lU5Ihrr0Cr4U1
         +Y3SqScyrYzv7/ibhkcI0sc1qskgEZpPrgboxpxHidjShlUpiiAZbAl0jcQbZFO8UGZB
         8SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qjHP76J4uioHdlVAEaAzcH0j7Rl6q3veYWTHgxbZuZ0=;
        b=gaksIxG1Jf5PEEb3czl6N4I1Dak7hOyOisRKL//BydVctbbU9+D1eefnmR6rGc/RSk
         hyVLT9mKHa17a+0TIUPKPcARXvLdbWc/+PU1OC7ejShFNDR/vCwzx2106EpoElULAmcS
         MGtMjt4wrqAulSCRbwL3PCUxP16Lb1V+TRiDfEIXYBQeUfkZgATaLW5YMYOFcMCK0/dt
         fw0dDmHDJDZJdvJUMC4EtDeeTtXymV5OK5UhXZg5r0TFRLq7qdQMQg4GMLRdIh6bvnmX
         4w3DbI8jzZ6ESDMDukuQyyPZxWy6YmVsHtEaLjm0urFVZPRNhwynBhLiz0+kBuk8cYJE
         t5Cw==
X-Gm-Message-State: AOAM5316GPwfZwh1Oo0qsoG70es3/FH9y1eB+wuVViPHfeEZyWKX6AUM
        gOk9uo/vzKmOqcj/up83lNQ=
X-Google-Smtp-Source: ABdhPJwbH7HduCmLTWk9js0GPfzqo4WhoGVyKRCNK053Ovg7js3GBf24aCzsO01+j/49r/6wRuTYMw==
X-Received: by 2002:aa7:8dc7:0:b029:151:2237:52c5 with SMTP id j7-20020aa78dc70000b0290151223752c5mr15783090pfr.32.1601883846835;
        Mon, 05 Oct 2020 00:44:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id d6sm8279860pjz.12.2020.10.05.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:44:06 -0700 (PDT)
Date:   Mon, 5 Oct 2020 00:44:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] fsck_tree(): fix shadowed variable
Message-ID: <20201005074404.GD1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071905.GA2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005071905.GA2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Commit b2f2039c2b (fsck: accept an oid instead of a "struct tree" for
> fsck_tree(), 2019-10-18) introduced a new "oid" parameter to
> fsck_tree(), and we pass it to the report() function when we find
> problems. However, that is shadowed within the tree-walking loop by the
> existing "oid" variable which we use to store the oid of each tree
> entry. As a result, we may report the wrong oid for some problems we
> detect within the loop (the entry oid, instead of the tree oid).
>
> Our tests didn't catch this because they checked only that we found the
> expected fsck problem, not that it was attached to the correct object.

Oh, goodness.  Does this mean we should be similarly checking oid in
the rest of the fsck test scripts?  (I'm not saying this patch should
do so, just curious about what you think on the subject.)

> Let's rename both variables in the function to avoid confusion. This
> makes the diff a little noisy (e.g., all of the report() calls outside
> the loop wee already correct but need touched), but makes sure we catch

nit: s/wee/are/, s/need touched/need to be touched/

> all cases and will avoid similar confusion in the future.

Thanks for doing that --- it does make reviewing easier.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fsck.c                     | 40 +++++++++++++++++++-------------------
>  t/t7415-submodule-names.sh |  5 +++--
>  2 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/fsck.c b/fsck.c
> index f82e2fe9e3..46a108839f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -633,7 +633,7 @@ static int verify_ordered(unsigned mode1, const char *name1,
>  	return c1 < c2 ? 0 : TREE_UNORDERED;
>  }
>  
> -static int fsck_tree(const struct object_id *oid,
> +static int fsck_tree(const struct object_id *tree_oid,

optional: we could call it "tree".

>  		     const char *buffer, unsigned long size,
>  		     struct fsck_options *options)
>  {
> @@ -654,7 +654,7 @@ static int fsck_tree(const struct object_id *oid,
>  	struct name_stack df_dup_candidates = { NULL };
>  
>  	if (init_tree_desc_gently(&desc, buffer, size)) {
> -		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
> +		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
>  		return retval;
>  	}
>  
> @@ -664,11 +664,11 @@ static int fsck_tree(const struct object_id *oid,
>  	while (desc.size) {
>  		unsigned short mode;
>  		const char *name, *backslash;
> -		const struct object_id *oid;
> +		const struct object_id *entry_oid;
>  
> -		oid = tree_entry_extract(&desc, &name, &mode);
> +		entry_oid = tree_entry_extract(&desc, &name, &mode);

optional: could call it "child".

>  
> -		has_null_sha1 |= is_null_oid(oid);
> +		has_null_sha1 |= is_null_oid(entry_oid);
>  		has_full_path |= !!strchr(name, '/');
>  		has_empty_name |= !*name;
>  		has_dot |= !strcmp(name, ".");
> @@ -678,10 +678,10 @@ static int fsck_tree(const struct object_id *oid,
>  
>  		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
>  			if (!S_ISLNK(mode))
> -				oidset_insert(&gitmodules_found, oid);
> +				oidset_insert(&gitmodules_found, entry_oid);
>  			else
>  				retval += report(options,
> -						 oid, OBJ_TREE,
> +						 tree_oid, OBJ_TREE,
>  						 FSCK_MSG_GITMODULES_SYMLINK,
>  						 ".gitmodules is a symbolic link");

Right, this is a property of the enclosing tree, not the blob
representing the symlink target.  Good.

not about this patch: Could report() notice when the oid doesn't match
the type passed in, to more easily catch this kind of mistake?

[...]
> @@ -692,9 +692,9 @@ static int fsck_tree(const struct object_id *oid,
>  				has_dotgit |= is_ntfs_dotgit(backslash);
>  				if (is_ntfs_dotgitmodules(backslash)) {
>  					if (!S_ISLNK(mode))
> -						oidset_insert(&gitmodules_found, oid);
> +						oidset_insert(&gitmodules_found, entry_oid);
>  					else
> -						retval += report(options, oid, OBJ_TREE,
> +						retval += report(options, tree_oid, OBJ_TREE,
>  								 FSCK_MSG_GITMODULES_SYMLINK,
>  								 ".gitmodules is a symbolic link");

Likewise, good.

[...]
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -148,13 +148,14 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
>  		{
>  			printf "100644 blob $content\t$tricky\n" &&
>  			printf "120000 blob $target\t.gitmodules\n"
> -		} | git mktree &&
> +		} >bad-tree &&
> +		tree=$(git mktree <bad-tree) &&
>  
>  		# Check not only that we fail, but that it is due to the
>  		# symlink detector; this grep string comes from the config
>  		# variable name and will not be translated.
>  		test_must_fail git fsck 2>output &&
> -		test_i18ngrep gitmodulesSymlink output
> +		test_i18ngrep "tree $tree: gitmodulesSymlink" output

Makes sense.

By the way, why does GETTEXT_POISON lose the gitmodulesSymlink
keyword?  Is this just a limitation of GETTEXT_POISON losing
information that's passed in with %s?

With the commit message tweak mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
