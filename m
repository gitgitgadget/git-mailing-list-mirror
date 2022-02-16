Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFEC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiBPKoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:44:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBPKoi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:44:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C586E29
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:44:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p14so3575983ejf.11
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=C6r++z65uNxB3LH1dBbM3PkKRRY6RLY67gd5dj0mj1Y=;
        b=OjiS/GqqMg3UKxFYo5Y8cCUz9uX+ccHKXP/L4OtenGWDLhVWwiMYnrROJ6mfkY9zHe
         F0N6P8hX49YJloFw/0/kfHGgwUlUco7ig/khma0wO8OC59/fZGuSHhbVtqkbzD1uq5PZ
         8udq+aqYHXn7iEO6RbgNOo73E7HtSt5IGaB+DfEX4CyAhccqMgO3624ZgC1kLKprs7bE
         Nci+c1O3OQjR2VjHvDn2hy1Hay4sFlb/tMy6wOiGeXVvanEwuli+1OtbCsxf79vkRQeR
         D8WsgphqS9ro93GaPGnxREe83mFpGbsGrZXqHY6ZNLIlA9vl7ku0ps+SM8wLnU6rHOTx
         0CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=C6r++z65uNxB3LH1dBbM3PkKRRY6RLY67gd5dj0mj1Y=;
        b=aDTPcbMwIxPLQuiguhTbkBPsCBsoIjUc/ythM+7LjbB7ooWaq8gPgqXCAc0wUQuXFu
         w0uz0fmFflUdvs8/aTHS5l7Vlr5YndR7mD5hdB3+f5k0lmamgvSu2ejq5S1Cn3Djno1g
         53GzUsLaL8xdMXpl4B13nPvP9eHWxt+mL1b8DflRQrYo8waZ34Ep7pTZE+aNexRsFxly
         jYGbTTmruAQAUEZNFnYyNU1r4ZBvhLJyRjJjj4bJKKkQsR4711FrebKC9aFj2BLju47z
         w3Bse74ejpDl/UZvnB6MUaqbFOAJ994nTORnLoEFxVG7PiYl1NTOJD23LoHxUkbdsKb6
         sBeA==
X-Gm-Message-State: AOAM533TMQmTJXN+hviJDn6WFA2z5YJs3JNKOVdQv4b+Wb/6PX0kVmtg
        gZsmfJ0s9osDp4e3L7dU2uvfUXrQ7JOpfQ==
X-Google-Smtp-Source: ABdhPJyfHQ3gu4ExzHi846/CMw2rZ9m2fRTMULkKoCrjq+dj+hbKBI9L7E+VwhFzmt0Pfy3mWbtFGA==
X-Received: by 2002:a17:906:aad7:b0:6cc:c9aa:d9ad with SMTP id kt23-20020a170906aad700b006ccc9aad9admr1760327ejb.726.1645008264148;
        Wed, 16 Feb 2022 02:44:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dz8sm1430712edb.96.2022.02.16.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:44:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKHnL-003DWd-22;
        Wed, 16 Feb 2022 11:44:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/4] xdiff: fix a memory leak
Date:   Wed, 16 Feb 2022 11:28:56 +0100
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
 <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
 <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
Message-ID: <220216.86tuczt7js.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Although the patience and histogram algorithms initialize the
> environment they do not free it if there is an error. In contrast for
> the Myers algorithm the environment is initalized in xdl_do_diff() and
> it is freed if there is an error. Fix this by always initializing the
> environment in xdl_do_diff() and freeing it there if there is an
> error. Remove the comment in do_patience_diff() about the environment
> being freed by xdl_diff() as it is not accurate because (a) xdl_diff()
> does not do that if there is an error and (b) xdl_diff() is not the
> only caller.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xdiffi.c     | 33 +++++++++++++++++----------------
>  xdiff/xhistogram.c |  3 ---
>  xdiff/xpatience.c  |  4 ----
>  3 files changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 69689fab247..758410c11ac 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -315,16 +315,19 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  	long *kvd, *kvdf, *kvdb;
>  	xdalgoenv_t xenv;
>  	diffdata_t dd1, dd2;
> +	int res;
>  
> -	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF)
> -		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
> -
> -	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
> -		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
> +	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
> +		return -1;
>  
> -	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
> +	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
> +		res = xdl_do_patience_diff(mf1, mf2, xpp, xe);
> +		goto out;
> +	}
>  
> -		return -1;
> +	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
> +		res = xdl_do_histogram_diff(mf1, mf2, xpp, xe);
> +		goto out;
>  	}
>  
>  	/*
> @@ -359,17 +362,15 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  	dd2.rchg = xe->xdf2.rchg;
>  	dd2.rindex = xe->xdf2.rindex;
>  
> -	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
> -			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0, &xenv) < 0) {
> -
> -		xdl_free(kvd);
> -		xdl_free_env(xe);
> -		return -1;
> -	}
> -
> +	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
> +			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
> +			   &xenv);
>  	xdl_free(kvd);
> + out:
> +	if (res < 0)
> +		xdl_free_env(xe);
>  
> -	return 0;
> +	return res;
>  }

I wanted to test if this made some diff test pass under SANITIZE=leak
that didn't before, and my usual quick way to discover that is to run
the tests with something like this for testing:
	
	diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
	index 758410c11ac..7811ce2a1d3 100644
	--- a/xdiff/xdiffi.c
	+++ b/xdiff/xdiffi.c
	@@ -368,7 +368,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
	 	xdl_free(kvd);
	  out:
	 	if (res < 0)
	-		xdl_free_env(xe);
	+		BUG("needed freeing");
	 
	 	return res;
	 }

But doing so has all tests passing, so either this code is unreachable
or not reachable by any of our tests.

More generally I think this patch is taking the wrong approach, why are
we trying to the members of a stack variable in xdl_do_diff(), when that
variable isn't ours, but is created by our caller? Why aren't they
dealing with it?

The main issue the memory handling is such a pain here is because of
that mixed ownership.

The below POC (and seems to pass tests) shows a way to do that, which I
think in general is *much* simpler. I.e. sure we'll call free()
redundantly some of the time, but that'll be safe as long as we
zero-initialize the relevant struct.

The xdiff code is much harder to read & maintain than it needs to be
because it's trying to micro-optimize these sort of patterns.

E.g. with the diff below we'll now redundantly call the free on a xe2
when we only used a xe1, but "who cares?" is my considered opinion on
that topic :)

By not trying to micro-optimize it like that the memory management and
ownership becomes so much easier to deal with.

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 758410c11ac..6ad30a98b62 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1054,19 +1054,19 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
-	xdfenv_t xe;
+	xdfenv_t xe = { 0 };
 	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
+	int status = 0;
 
 	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
-
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
-
-		xdl_free_env(&xe);
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xscr) {
 		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
@@ -1078,12 +1078,14 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {
 
 			xdl_free_script(xscr);
-			xdl_free_env(&xe);
-			return -1;
+			status = -1;
+			goto cleanup;
 		}
 		xdl_free_script(xscr);
 	}
+
+cleanup:
 	xdl_free_env(&xe);
 
-	return 0;
+	return status;
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index fff0b594f9a..4751eab9c12 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -685,7 +685,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, mmbuffer_t *result)
 {
 	xdchange_t *xscr1, *xscr2;
-	xdfenv_t xe1, xe2;
+	xdfenv_t xe1 = { 0 };
+	xdfenv_t xe2 = { 0 };
 	int status;
 	xpparam_t const *xpp = &xmp->xpp;
 
@@ -693,25 +694,25 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	result->size = 0;
 
 	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
-		xdl_free_env(&xe1);
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe1, &xscr1) < 0) {
-		xdl_free_env(&xe1);
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe2, &xscr2) < 0) {
 		xdl_free_script(xscr1);
-		xdl_free_env(&xe1);
-		xdl_free_env(&xe2);
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	status = 0;
 	if (!xscr1) {
@@ -730,6 +731,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	xdl_free_script(xscr1);
 	xdl_free_script(xscr2);
 
+cleanup:
 	xdl_free_env(&xe1);
 	xdl_free_env(&xe2);
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index cfa6e2220ff..63fb2eee975 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -414,7 +414,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	 * ranges of lines instead of the whole files.
 	 */
 	mmfile_t subfile1, subfile2;
-	xdfenv_t env;
+	xdfenv_t env = { 0 };
+	int status = 0;
 
 	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
 	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
@@ -422,13 +423,16 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
 	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
 		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
-	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
-		return -1;
+	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0) {
+		status = -1;
+		goto cleanup;
+	}
 
 	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
 	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
 
+cleanup:
 	xdl_free_env(&env);
 
-	return 0;
+	return status;
 }
