Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF35C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EAA61461
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhDWM2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:28:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:60207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242322AbhDWM2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 08:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619180895;
        bh=KH1w04hUroamX/MeCPKhsylEopUx41IaZgHWtj1AUqA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q/acwiFbtmytL0RhumVZKQVg4pn56KSbJCKBadKo0wMNDZ/jWxALUJIQlyQV6QMjh
         p2dKeQtQJiN6bGfmYYvFz2CMk7XDbSbAGm3UEBoYcSSFqRxOOQgC6rsZ6WpyHBFZbF
         nOQJHpsZPASTaH/QqVjkHj6TyvTvfDEMK3xcm1Bg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.213.207]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1lKzMO3aM2-00updj; Fri, 23
 Apr 2021 14:28:14 +0200
Date:   Fri, 23 Apr 2021 14:28:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] cache-tree: avoid needless promisor object fetch
In-Reply-To: <20210423031659.2362659-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.2104231409500.54@tvgsbejvaqbjf.bet>
References: <20210423031659.2362659-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FgTFzicMxBdc6IdQJ2m/kJDHG3JrfP8i/ycERho8yhGTPVHrQFd
 0hJj9ae2vVtiE5IPIwQMfbGLB++u6MDKU7b4aB0W0Mrs+1L+LtIvfVzAweeWc6TlvjKlILE
 5iJiWzGzP90ppTMDmIHIUFIr7W5n0htZpivbsq3iDqGIgsJEylo2kE5/t1LJC6l41b9mjob
 ci074MVPY31g+rE/lZ1jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WBgWOqsyIq4=:WZylwimeocaagYeKDYBOwV
 tSuCnT5gBmDrZpOloTEUR3RIEJaMWNx/oqY/Befi/gzdoWU6wwLp0/I6nAuPwzTxCjOjLV6X8
 QHSTvcDt/ny16g+KX3ITLpO2AOTGo5mTBZXuzg/AXE0UniKRNTNCPNOvOodDibaKomUahGe9a
 KQ6Gho3kR0tEGUwTwjrLPYSyBkciUY88nTq5haHw9t/lJvEXT6IlvDhI5Ey5fDsfQZP0gAgn5
 cx14jFBaKaXE/duSeb0Cusc0JsNjmFVcTa42MGxt4B6zGzOUSOZLUuGq/8t4C4HZNk1lYmPzd
 HztWyTS+H6PYoYcSlw1GWpB+za6VzhW6FOyF7zMZI1gBDkatXYS8Zq7vQWpx62HyXkP3LmocM
 8k4lEkLQpT0GSM5kcD9MgL+VZ6V8ptjwmJx9FBdqpTKAGdKPbEVgBEM+rspx1Xx7044szFuVK
 ycYaBRsRkUiXdpUta14I2sXCm70iogvcah3Uvd5rLYQCmKejgUsdGsNgP7fpNh+NwxZMvnqgs
 aq60BqjfCL1XvgkpQfrSpmQUuHRBa+Tb0PK1xCmGVI+CT66hl55s/Hcx90UNI2jdtNrh77qOI
 sbfUuUUXpLCiSrHSNHFKsuUJ0YpjAcCi3NHlTXLd1OYFlfko8Mz5qSIa6AJ+G/WO4R3PxSolt
 kCAVjqA7sx9kA7W2EtIGPAZGWFrpTD31tCy0bNBWkVYGGzCcqEU8ozcfnirJ6xCsLtUaV/TgL
 sVVzspIZ9FZm2dYYyri0ypDfC1jPsRnp5Nll3JI9j66lU/RKIzDOitxTqNSs35vCf9ip+KOkl
 b8cor+MO3FmxIoRcnZlDGNRm5Yf+eIAYZWdnFgAakz/UwzszFXulXsVCkp2I+wT7Mo/6osZ9E
 ZMDEYR0kc9XHLS4JOMz0bMjFKxo2pQFX9bk21bjyzxyh64Nr+4DSVLTVyX/GUUruCzs2jofVn
 eTdXYjUXZPs0G/ois+ZQFeVtomcGCWDjTHXMq45z+ylaLvYp71LyT9ziUW1lrb4ITtVAVclvQ
 Du6y0NCGoG2Z9NMOSVcutlkKRMRzYknPJE5CyOhna9jfmOaV/i/1nTUVa7QQjd4OlwFDdsxc5
 uZQbMPkuuSAjfUSoSb3vXrEUqTfpNDFLkmpUi1yp+Ij3EHPUwLlg03R7NEAP5vdw1YfE8yxPR
 U/pozXNN0tFkjvchRJsTwKBiXP3wWSXWRiYhRK3mxhrXG3cXx+HsFZnTupNrA5+Wmbz7LJG7V
 VJ5vy0Cq9Q768pdVc
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 22 Apr 2021, Jonathan Tan wrote:

> In update_one() (used only by cache_tree_update()), there is an object
> existence check that, if it fails, will automatically trigger a lazy
> fetch in a partial clone. But the fetch is not necessary - the object is
> not actually being used.

I find it curious, though, that the `ce_missing_ok` variable is defined
thusly (sadly, the context of your diff is too small to show it):

                ce_missing_ok =3D mode =3D=3D S_IFGITLINK || missing_ok ||
                        (has_promisor_remote() &&
                         ce_skip_worktree(ce));

Which means that the `has_object_file()` function is only called if the
entry is not marked with the `skip-worktree` bit, i.e. if it is _not_
excluded from the sparse checkout.

Wouldn't that mean that the object _should_ be there?

I guess what I am saying is that while the commit message focuses on the
"What?" of the patch, I would love to hear more about the "Why?". And
maybe the "When?" as in: when does this actually matter?

And since the bug was critical enough for you to spend time on crafting
it, maybe it would make sense to add a regression test to ensure that this
bug does not creep in again?

>
> Replace that check with two checks: an object existence check that does
> not fetch, and then a check that that object is a promisor object.

This essentially repeats what the diff says, but it might make more sense
to explain why the post-image of this diff is more correct (and maybe
discuss performance implications).

>
> Doing this avoids multiple lazy fetches when merging two trees in a
> partial clone, as noticed at $DAYJOB.

Ah. But where are those trees fetched, then?

Maybe lead with the description of the bug?

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Another alternative is to think about whether the object existence check
> here is needed in the first place.
>
> There might also be other places we can make a similar change in
> update_one(), but I limited myself to what's needed to solve the
> specific case we discovered at $DAYJOB.

I only see another `has_object_file()` call site at the very beginning,
and I think this needs to fetch. Or maybe it is more efficient to
construct the cache tree from scratch than fetch it?

There is also `cache_tree_fully_valid_1()`, where I think the same
handling could potentially make sense. (Or, if you target `seen`,
`cache_tree_fully_valid()`.

Ciao,
Johannes

> ---
>  cache-tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index add1f07713..6728722597 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -6,6 +6,7 @@
>  #include "object-store.h"
>  #include "replace-object.h"
>  #include "promisor-remote.h"
> +#include "packfile.h"
>
>  #ifndef DEBUG_CACHE_TREE
>  #define DEBUG_CACHE_TREE 0
> @@ -362,7 +363,9 @@ static int update_one(struct cache_tree *it,
>  			(has_promisor_remote() &&
>  			 ce_skip_worktree(ce));
>  		if (is_null_oid(oid) ||
> -		    (!ce_missing_ok && !has_object_file(oid))) {
> +		    (!ce_missing_ok &&
> +		     !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT) =
&&
> +		     !is_promisor_object(oid))) {
>  			strbuf_release(&buffer);
>  			if (expected_missing)
>  				return -1;
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
>
