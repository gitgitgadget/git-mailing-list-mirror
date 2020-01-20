Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B8C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913192253D
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HplQHnUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATW3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:29:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:35099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgATW3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 17:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579559356;
        bh=Wf9pJhS7MdFXpUdBxnWC8OawwqScdS5M1DX6yfieKBI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HplQHnUKsp42uF6nYLMJybzM+0Qs3HKTvu81VTe4ZksAkEfWmiRATTogb7GU1HvoB
         XR4LucKu5LXuNNqyMTCqhFbe9XlC8GBJB73eVw5Q+AmGw1cCgwqG6FBiBXNq6X28Dd
         o0Ea+xJ6UgwhiPBj3jhrlldtYzUDx6qX8RLdRqOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1jOJS43njX-00nTUe; Mon, 20
 Jan 2020 23:29:16 +0100
Date:   Mon, 20 Jan 2020 23:29:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 11/29] bisect: libify `bisect_next_all`
In-Reply-To: <20200120143800.900-12-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202325000.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-12-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kiE0+qFufoZUlbP31xZGyVi+OxXk3HkfUDQ/i3LOOnhM5HuaEUp
 QUSC/MyE5q1GCFbgJllpwkNIPYf/YfLPD+SxOAiS+Du+aXqndoaO0EEVhIeWkuQAOThwhkA
 O2BASIZydciylAshhQ7d9WtbBAirS1hrkuoR+Y1CTMyjvC4IFbIROn2DpjKmSC+Wz/G0ZqB
 DFDWeN6cZ9dLDe+elVTyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C9YJgYBi3Bw=:/j0HDtvSrFo1ykEZSplI7S
 40dsTMpoQH0wQA6n3/eIfEzS+RGL93yLhQpzCkB7xZZkrNqIDLZYJdJljGCKJ99vVAdfjJlnE
 W5Avs6MH3+bIsSEhAqkYNxUB96EDvPDcsaZ3ws+NRBBE33BSpIzXn5IPIEgiXK5RF3R/VRQEk
 w0cex0W7RbKVzA/Im/k6fww19Hm4ogyNjz+zdUf2/aVuGyvAdzidPkyP9DrQiUluYZi+DbpNs
 fF/O5J0mdDvM1jdVHyve67HVAX1T4UfMT0qALqBwLJb8rVUSye3MBgijQZxk5WpZIhD+s23ok
 tOBvcXaa7IBerheIZ8jqvyRF5stQb/bcca2Yc4VHkh0qIJ3P2Rqc1Ng7IyxCS6S0MstSLReg1
 T5nIKEYrZW91V0vKk33uSf+Ih+cL98BuCqc1sn7PaNGPPnbBsC+QghkeJ2jUJpUmdghm0Om7G
 HYGkLMLzA/XGUU+YLpMZKSAE3nwpqZM2RyVtpoeSs8yZeDeCptLagMrI/bC4/CQv1DDWgcNxB
 xsAjEbr7TFx228Nu5y/cL1/ZPfPnXpi8hDHJ6RsvhLS91UDCcJICdnmeXIYktDRODXiBn2OCg
 EeUr/OLLXWbS/LXB37t8MI+KTcv17gcZ590aUzMBCtJ/hiOYfbO2Omd607RBHWLf6k06V2nCb
 wBHYB3sUEBG7iVsKd6Z6Jv+Qrfy/SSW8zMQyovG6hHGN64heevYwYzmB8rhvdqPUDD2VH9Fpf
 UzqJRkYmT58slZo+BNU0CojPeJSBLmpYTpbxnHSZFTfGAZ3TjpAZIlUkAJrjcBB2i6Rppby7r
 o88U0XEn9l/SbTEzoxFoez20s3c4uSpqAX309gEosuyRdiV9E0Pm9NH3I8mQJL/F012S6Mi01
 NJlGod27zlFmIBy1fvOd0ElxiJB5xDMzysUVTo13XEEdrHWvnL3HEIz2JE79LGP2gdYnhlcUq
 ntcWcR0wYJca8hjAVX397jBunkC4TCIJnvNkyEgp1SK6k6+eAbnMxnGpA0DEFucAzau6j3Hry
 FZvw47c6u1pXhhcG0NPl8v8MRZqOzYt+WAM1w/snLCam95aTsliYIlHQWxYCC4SC3/A73RfY1
 6aTcuk4VfnMmmg07uBdTaM20pNnbns1Tftm9BpFxWiphNOv+8u6sNyUYz50ZVQJrCJV0CgEV+
 uXRcttBQ6NheYk2RM72w98AWQzG2MNI8LiYRUFGzt862JrRVSNJfC+7hhmzDbPaUdYl08wOoo
 SgzgdxvPD0hYthnGxNrpB4evXhv3m1QQtgU56JJJ85LIW5WBDzvY7Y3/qEG8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 20 Jan 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Since we want to get rid of git-bisect.sh it would be necessary to
> convert those exit() calls to return statements so that errors can be
> reported.
>
> Emulate try catch in C by converting `exit(<positive-value>)` to
> `return <negative-value>`. Follow POSIX conventions to return
> <negative-value> to indicate error.
>
> Turn `exit()` to `return` calls in `bisect_next_all()`.
>
> All the functions calling `bisect_next_all()` are already able to
> handle return values from it.

So this patch brings more magic values that really would like to become
`enum` values. At this point, we're talking about `bisect_next_all()`
which is _not_ a file-local (`static`) function. Therefore, we now really
wade into API territory where an `enum` is no longer just a nice thing,
but a necessary thing: `bisect_next_all()` is a function that can be
called from other source files.

As far as I can see, this patch concludes the "libify" part of the patch
series (read: it would have been the second patch series I would have
suggested to split out from an otherwise too-long-to-be-reviewed set of
patches, if I had been your mentor), and I'll leave it at that for
tonight; Hopefully I will find some time to review more of these patches
tomorrow.

Ciao,
Johannes

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  bisect.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index acb5a13911..33f2829c19 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -967,10 +967,10 @@ void read_bisect_terms(const char **read_bad, cons=
t char **read_good)
>  }
>
>  /*
> - * We use the convention that exiting with an exit code 10 means that
> - * the bisection process finished successfully.
> - * In this case the calling shell script should exit 0.
> - *
> + * We use the convention that return -10 means the bisection process
> + * finished successfully.
> + * In this case the calling function or command should not turn a -10
> + * return code into an error or a non zero exit code.
>   * If no_checkout is non-zero, the bisection process does not
>   * checkout the trial commit but instead simply updates BISECT_HEAD.
>   */
> @@ -1000,23 +1000,35 @@ int bisect_next_all(struct repository *r, const =
char *prefix, int no_checkout)
>
>  	if (!revs.commits) {
>  		/*
> -		 * We should exit here only if the "bad"
> +		 * We should return error here only if the "bad"
>  		 * commit is also a "skip" commit.
>  		 */
>  		res =3D error_if_skipped_commits(tried, NULL);
>  		if (res)
> -			exit(-res);
> +			return res;
>  		printf(_("%s was both %s and %s\n"),
>  		       oid_to_hex(current_bad_oid),
>  		       term_good,
>  		       term_bad);
> -		exit(1);
> +
> +		/*
> +		 * We don't want to clean the bisection state
> +		 * as we need to get back to where we started
> +		 * by using `git bisect reset`.
> +		 */
> +		return -1;
>  	}
>
>  	if (!all) {
>  		fprintf(stderr, _("No testable commit found.\n"
>  			"Maybe you started with bad path parameters?\n"));
> -		exit(4);
> +
> +		/*
> +		 * We don't want to clean the bisection state
> +		 * as we need to get back to where we started
> +		 * by using `git bisect reset`.
> +		 */
> +		return -4;
>  	}
>
>  	bisect_rev =3D &revs.commits->item->object.oid;
> @@ -1024,12 +1036,18 @@ int bisect_next_all(struct repository *r, const =
char *prefix, int no_checkout)
>  	if (oideq(bisect_rev, current_bad_oid)) {
>  		res =3D error_if_skipped_commits(tried, current_bad_oid);
>  		if (res)
> -			exit(-res);
> +			return res;
>  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
>  			term_bad);
> +
>  		show_diff_tree(r, prefix, revs.commits->item);
> -		/* This means the bisection process succeeded. */
> -		exit(10);
> +		/*
> +		 * This means the bisection process succeeded.
> +		 * Using -10 so that the call chain can simply check
> +		 * for negative return values for early returns up
> +		 * until the cmd_bisect__helper() caller.
> +		 */
> +		return -10;
>  	}
>
>  	nr =3D all - reaches - 1;
> --
> 2.21.1 (Apple Git-122.3)
>
>
