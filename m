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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2DBC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE41861139
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhHSIMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:12:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:55095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhHSIMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 04:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629360690;
        bh=2opkJoqTxQq+cigeOzULeiPWFYqM01sZiiquwr1Vnn0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HdB/7a7PWnlY2Q/ZyGYtYK9s3+r5sLE0/cqkmuPwAvU4Jo46wZ5NEqHgbuNh2DcTp
         fE5TRtUjnqlQaAJFNhpapMx1h8lDH2KiiUBuVvHst4Y2LVyUQymszVzAvyF0bQFyQt
         j9U3pO1VRw7vGoijk1rzYg5ez9/TIjLOtJOFwaks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1nDiyR3c9y-012biL; Thu, 19
 Aug 2021 10:11:29 +0200
Date:   Thu, 19 Aug 2021 10:11:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 6/8] attr: be careful about sparse directories
In-Reply-To: <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108191008160.55@tvgsbejvaqbjf.bet>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eAZ04gLdylaRLDSf91uQ8YqtpIfFET5WGsFplw+z71SGfOP5mvS
 b2TZzOuHtIm5hm7RLJ1h9ytdj1Bi3Na1+EzShmy7MQvxvFEqMr+B6eavVZt/7+nuUjB+yTf
 lIaO/PFMQD3rfE0Hs+rklRutemJhAf/vo85KEC1BBxD87Ms0V/4/CBkR9GFTqOoOMy58CDU
 ei5S/WOzUFOIqKKUSFHZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T918aALJ8jY=:0W/vN6akuzbqQ04G1l0dJF
 HBzKhPtDbgkpNMa6lgnXmsQAalmcZlU2jnIIcsnkcbadzxv4krEqSwYjSMzwl68ZYVIhMg+vA
 niWb9w7ueb32oVW4U5a/T9IfLyCyjJ+kPuyi1zhBi1jtNzB71ZsliIMds7W6ZHWHVUyo1uIBE
 V5m9Hg5ApKVwfhMXfLzZVeB2kdaHwD2UrWZAq24U6K+FQMjo/pEXOxmWV7bEaHmmB2u3HcYEv
 pCpf5dXDsTHsl/kC7DzoVr+Lc6HsMikDT4iseRnrGOdIBMavutCbAx2KGt338Q+YxDxD14kj/
 AMnhNacSKNYo6hdbVtI7+IjWitU2awyp0JZdvATlgl5k4NzJqQ3ykqFlxg/HZsiRjxpFMfDcw
 QhEIcke6fc8oYR8uP2LFWUdDWaYJUpq8+2O9R3icmF0cj3hW6KOHCaF5Nmn+TXYTrLpQGx33+
 esrriyvOhnbIXQV20fRYcZWzFv2fyrPUXIxvl6N7dhAQyQmKeXFLa57bfVzXrXQ70ChJLxziO
 I1GDSGPCJtMV0IbIDhffuw05DzFhmLMlHz+la1PxlFpf1SLMFe/1+cCS821KPoUURYB0aPhgK
 DUGiDXs9KJsGKgAqLSBgx1OraguOoWQ4LobdXclWWOZJMxPKcd4vUV46/TchiCxR11+T5e3B9
 w6VrOusE5fC4I6bTqTr8QH0d2t3r6+p813DXpXe1rHKbWqnPaJuxhrhkw8SzW4x6+iSqrJaWA
 nWYJobcRR9rmKmlFd2WUNIijMAN2Rhf+We5m7RuBUO4LiLiRQ/mjJs1iIZY+IGeLJlZ83Jpch
 XRMtKSD7JGsVl5mQ7COav4N+R+Vr2VnF6eSQOk2UZzf7J+7WNoKpmgYAcJriTAQ1pnQaMCyu2
 WGpcJsdSbVY6Xcdd5O/ei4CzsTmAY9ToWC9k3sWPV1rylflb7KlfGx0mTZx7RaQImyPv3734Z
 TLmQs/NHn4yHmeJZDiFxkslVIs1kfsaPFf1mr6xYtARL6wUr/VR/4yUriWxAq0N1uCeSk661V
 v4TfZtVd5FaeP9K8XUCr90T8xR02cxrJn7jVtAf1KUI28Rd9K8GiFDNYBtRKtDRrt07pOA7UY
 tO/q0VIhoojM3LyfOkvm0vUU7Iub+NsDbSJ2E2blkFN5nuGnX2blnyowQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  attr.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/attr.c b/attr.c
> index d029e681f28..a1009f78029 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -14,6 +14,7 @@
>  #include "utf8.h"
>  #include "quote.h"
>  #include "thread-utils.h"
> +#include "dir.h"
>
>  const char git_attr__true[] =3D "(builtin)true";
>  const char git_attr__false[] =3D "\0(builtin)false";
> @@ -744,6 +745,19 @@ static struct attr_stack *read_attr_from_index(stru=
ct index_state *istate,
>  	if (!istate)
>  		return NULL;
>
> +	/*
> +	 * In the case of cone-mode sparse-checkout, getting the
> +	 * .gitattributes file from a directory is meaningless: all
> +	 * contained paths will be sparse if the .gitattributes is also
> +	 * sparse. In the case of a sparse index, it is critical that we
> +	 * don't go looking for one as it will expand the index.
> +	 */
> +	init_sparse_checkout_patterns(istate);
At first I thought that `init_sparse_checkout_patterns()` is called by
`path_in_sparse_checkout()` below, and therefore would not be necessary.

But it is! Without it, we have no way to test whether `use_cone_patterns`
is set, because, well, it gets set by `init_sparse_checkout_patterns()`.

Would it therefore make sense to refactor the code to have a
`path_in_sparse_checkout_cone()` function? Or add a flag
`only_in_cone_mode` as function parameter to `path_in_sparse_checkout()`?

Ciao,
Dscho

> +	if (istate->sparse_checkout_patterns &&
> +	    istate->sparse_checkout_patterns->use_cone_patterns &&
> +	    path_in_sparse_checkout(path, istate) =3D=3D NOT_MATCHED)

> +		return NULL;
> +
>  	buf =3D read_blob_data_from_index(istate, path, NULL);
>  	if (!buf)
>  		return NULL;
> --
> gitgitgadget
>
>
