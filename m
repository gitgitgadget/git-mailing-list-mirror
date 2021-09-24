Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DAC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 07:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5282960E9B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 07:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbhIXHqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 03:46:12 -0400
Received: from mout.web.de ([217.72.192.78]:35257 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244334AbhIXHqL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 03:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632469471;
        bh=l4yI3EQOxEvE1EFrCZMukvDIGf9ETw3w7jIaZ5ddXjY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ydam70hMVrKfC7nyFfcEUtLgq7PDDRGXQRTPmwCDIWwwOT9igq0LjL4XVIRrGpwbq
         wHC6K9cDsJ596QyoLgjK9GuRzTrtwVviFdNSL6FQCwjOapggRCCEVgNWrBC+4OSX4s
         RRpupXHFtRyGaLDaAia7sMUh7yVUSjRTOI6KaFl8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LsQTc-1mrqXm41jU-0124Ir; Fri, 24 Sep 2021 09:44:31 +0200
Subject: Re: [PATCH 03/13] dir: select directories correctly
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <d47c7a1cf2a3fa8cfdcfc6be1ac800af123e7efc.1629842085.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e51adbad-c633-b030-ff01-3cfc260a0d65@web.de>
Date:   Fri, 24 Sep 2021 09:44:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d47c7a1cf2a3fa8cfdcfc6be1ac800af123e7efc.1629842085.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IaKQLGDkK2pmbT5k5gyn89T98R8mwUNZXdjtG22gU+eXCyf3a0q
 5l9JGDkHwyhJvsQleU+htTlAL5tPZA1HPaxTDy9tkgDBuRQtXBuwH7JNz6NI5dCQ+1ZU8Lf
 8OZnxVMQ9KPN1rzG1kTj0yAZ2Img3LoeJkFqsjtkdx3mvUBBir6BnnLw1hW9cMb95iHZvG/
 j0vBtwDlbLqANrqVgCBLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TiPY37LDFUg=:YlTFuHc5qYPy5FgEDMM4nh
 N1/ULyaD5l7d/+SJSwEabNvCvBEHq1i2WjC0noTVcNWx+VbJBRhiQ+Wb/7AMCjS0FMQqtkvTz
 tFKxMg+P0YbTv+e/l6DnjkTrGmD+SFI6V2lOesTXaUDfVaVnjIwIoU5ZE8RQSdcwWav1iIq5Y
 pqrCTkZqG4jz8sxGf+TCzToEk5QmBuVuLoMiOjFS48Gs15N9rojxR30MZcBa4Bj7ftCWMmaQr
 YOnt5d+DYdUlur71lVpY9TrMkE29Iwdx86d5jndyZqZH+t7xEQRfg4mubsRFczCbP8bsYMgrB
 o+qOEpahsrPA5A1gEx2QKikPVDDWfXEc1rDfteQhZlMhsuH2lq5D/RGD+dLgOnL1eW6kNxJCY
 Qadp8cBjRvIkytxACVB+Z3CNhpS66HJ3u/zjINvyKcm5GE7ixTGx7cYvAbArXqHZ7UaRcDMGt
 l2yzWueKGJ9Ud0JTPEOqFyFng8bJ/HuFj0xSszD6g6ufl7yfU0cwwOOdj4utGI55qfH5ffs0y
 szg8U/UCuuQQQSSiPZtAb5hob3k0v4DEVUX7Q4KRpaYJjOb1gbGYLs0rPQPDrEH7fcn9dZq2r
 Z2VaD//jjHWC38mmWw88bsKPpy0GMRVZXzt5InbA41T9pu748VJLS6UzfU44tyreDHddM/CQI
 s6WyoN/ykBNhBKbZUC+XImzfTTmHNaRUexYu56C2aRbO8eOo0V48hasHmMiNrM3Sbw8LAuBdx
 il0g2/uXo/G7A2mzAn9p/CKIluhh2ikzMhRooukb9A0MBmQYcRhHHLq/9p4ok4z+p6DHLO27h
 zx9neWumCUY9mjbLwTzSwzOKhQGwwR5mBuAJCQUjDsoqjPnvRF7iPIi0CuhrbprfLx6+kE9zb
 vUuyu41CoaAJfDtNZgTY3TNZN8M8OBS3s1pyUbstGBBidlxQ4vShW165UjFhqQAeHc3gLE8fq
 ffrIDs71CIHteUv1hbPh+uUfyYDYvpZwFdXxeiZRmrJSXX+fVSm4UCncLsewFkvkYXwlxok1y
 5zwqzvhNAtztfscbwfu5qZ/lJrZUIFeC1IppXjEexzsec+Vs8wpUap7IHToWnnBCQbOTiyTqO
 SMzFz3vvxyyuOc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.08.21 um 23:54 schrieb Derrick Stolee via GitGitGadget:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When matching a path against a list of patterns, the ones that require a
> directory match previously did not work when a filename is specified.
> This was fine when all pattern-matching was done within methods such as
> unpack_trees() that check a directory before recursing into the
> contained files. However, other commands will start matching individual
> files against pattern lists without that recursive approach.
>
> We modify path_matches_dir_pattern() to take a strbuf 'path_parent' that
> is used to store the parent directory of 'pathname' between multiple
> pattern matching tests. This is loaded lazily, only on the first pattern
> it finds that has the PATTERN_FLAG_MUSTBEDIR flag.
>
> If we find that a path has a parent directory, we start by checking to
> see if that parent directory matches the pattern. If so, then we do not
> need to query the index for the type (which can be expensive). If we
> find that the parent does not match, then we still must check the type
> from the index for the given pathname.
>
> Note that this does not affect cone mode pattern matching, but instead
> the more general -- and slower -- full pattern set. Thus, this does not
> affect the sparse index.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 652135df896..fe5ee87bb5f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1305,10 +1305,38 @@ int match_pathname(const char *pathname, int pat=
hlen,
>
>  static int path_matches_dir_pattern(const char *pathname,
>  				    int pathlen,
> +				    struct strbuf *path_parent,
>  				    int *dtype,
>  				    struct path_pattern *pattern,
>  				    struct index_state *istate)
>  {
> +	/*
> +	 * Use 'alloc' as an indicator that the string has not been
> +	 * initialized, in case the parent is the root directory.
> +	 */

This means the caller needs to take care to release the strbuf between
calls for files from different directories.  Seems a bit fragile.  The
current caller is only ever passing in the same pathname before throwing
away the strbuf, so it's doing the right thing.

> +	if (!path_parent->alloc) {
> +		char *slash;
> +		strbuf_addstr(path_parent, pathname);
> +		slash =3D find_last_dir_sep(path_parent->buf);

The caller has pathname, pathlen and basename.  If basename is
guaranteed to be a substring of pathname then the parent directory name
length could be calculated without requiring a string copy or scan.

IIUC if pathname and basename can be pointers to different objects then
just checking if basename is between pathname and pathname + pathlen
would already be undefined behavior.

Using pathname, pathlen and dirlen instead would be safer for such
calculations, as it enforces basename to be a substring.  Seems like
this would require a lot of function signature changes, though, as the
call tree is quite high. :|

> +
> +		if (slash)
> +			*slash =3D '\0';

This doesn't update path_parent->len...

> +		else
> +			strbuf_setlen(path_parent, 0);
> +	}
> +
> +	/*
> +	 * If the parent directory matches the pattern, then we do not
> +	 * need to check for dtype.
> +	 */
> +	if (path_parent->len &&
> +	    match_pathname(path_parent->buf, path_parent->len,

... so this checks if "<dirname>\0<basename>" matches.  Intended?

> +			   pattern->base,
> +			   pattern->baselen ? pattern->baselen - 1 : 0,
> +			   pattern->pattern, pattern->nowildcardlen,
> +			   pattern->patternlen, pattern->flags))
> +		return 1;
> +
>  	*dtype =3D resolve_dtype(*dtype, istate, pathname, pathlen);
>  	if (*dtype !=3D DT_DIR)
>  		return 0;
> @@ -1331,6 +1359,7 @@ static struct path_pattern *last_matching_pattern_=
from_list(const char *pathname
>  {
>  	struct path_pattern *res =3D NULL; /* undecided */
>  	int i;
> +	struct strbuf path_parent =3D STRBUF_INIT;
>
>  	if (!pl->nr)
>  		return NULL;	/* undefined */
> @@ -1340,8 +1369,8 @@ static struct path_pattern *last_matching_pattern_=
from_list(const char *pathname
>  		const char *exclude =3D pattern->pattern;
>  		int prefix =3D pattern->nowildcardlen;
>
> -		if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
> -		    !path_matches_dir_pattern(pathname, pathlen,
> +		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
> +		    !path_matches_dir_pattern(pathname, pathlen, &path_parent,

"a & b && c" is equivalent to "(a & b) && c", but removing the
parentheses here serves no apparent purpose and distracts a bit from
the actual change, i.e. adding a parameter.

>  					      dtype, pattern, istate))
>  			continue;
>
> @@ -1367,6 +1396,7 @@ static struct path_pattern *last_matching_pattern_=
from_list(const char *pathname
>  			break;
>  		}
>  	}
> +	strbuf_release(&path_parent);
>  	return res;
>  }
>
>

