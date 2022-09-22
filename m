Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FFAECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiIVTxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIVTwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:52:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8410BB0D
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663876344;
        bh=YDwUBrBHbNSp68LzPsVhOblKfSmb13HgwxSDTwI3zPQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X4hy8fVBcWTiffof1jaXQlZ+igi1tSC6Wal/zREk+ihrvFHVWQ8ZLDYsRlyfapWtU
         3U1je5hspiqNmDVUWeE9cNlrf3UzRcAkbAoxKkqmA1XkbFfHdlEmQDHWITSThLQCQB
         D0ungqFk8vVSfToZInntAUyhv3RGM3f7kctYR6+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.113.77] ([89.1.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1pUM6q2t4K-00xeqm; Thu, 22
 Sep 2022 21:52:24 +0200
Date:   Thu, 22 Sep 2022 21:52:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only
 repositories
In-Reply-To: <xmqqfsgk1i2t.fsf@gitster.g>
Message-ID: <p7896r78-o578-80nr-s3n5-sr01o9q8prs9@tzk.qr>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> <xmqqfsgk1i2t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rwFwnMqd0d2GwHffJmmXD04TZnp6eR6Tpf3AfMREH60DOB4CXct
 tY0cLDI0uDy4rriv5hG4RMowJ/Q4PiFEocYoze0Tm3hzdpXVaB/xn8jb//8YPEOwO3G5dfS
 3VM/miNN0hZMULjwo5m7tA0C4ZMr8edmm6BQEHsKltmzir5DE08xQKOVdxXAhh7uuBVqf28
 2wzScNiqi6b2jFcvVJm/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O96l9wyAOxQ=:JJqKtw+e6ZMRzk1uBU+bMo
 yQf8kTHqACMAoIYyKmoMUV562Vnfi8y4xj7mNlHTBCnMb6q3Xi57n7S0hAHFPRhpkvTPESZlC
 UEHNJppMl8PZ9j3ZY0JoJITe5Tfh9RtKN3BXGKWL3eavI8od8BE0TV+LHWzn5kKiUjhIRsBDF
 CtxnuAkuG6t2DCnYWu+r/Dvdee7Pwqfn0CYC7U3h/NCbQe4E+5wF+fj2JJUkSt2kDb5nhHo2X
 7+gc45tysv3WqhdnnsfCN9nwtkV6/V5Pi/hDNR3FagRQcoiBaAg/vYj6P7hVXaVFlYkZtVq/e
 oyim93WqkR7pQhUcfXi3rL3iDPOrKOh9o/JPzaKAavE8jel+LsnsWl+ieD+fuYF6BbTjRq5aS
 tDgbJqHlY0KAvJG2IBLcR7rzTPxDfM7VEugWZ+oeqfpWzfENpLm1KfKktTE+MGmwIk1mvaRAW
 RuQtaa3JJdf8aEN/U4DXk+WDnpt/4uTt/E8dkM0piDnsllJO8RMuLEEAl8buBoI/4eEE9CgH5
 ylIC9UXeqcqaORlDJLfQXg3ABc4HtxS/KUSco7i7AceToamBhAZGYQbdgXT5SRLJQibiyL3x3
 ACbvP2UO4LJgywa3lpQaYCfYAxGp5xnjOpB3DkLFwP/8CV2cNRWl2ruAQRuEI6zdK8I0be6sR
 ib204Owq9XDXtx0AlnFrW47HukW2ADX2Uhs3IV65gxAoOvFIhM2RnOMwL3v4H++PQYJibtOIO
 lVWOZdlrH3IMamqk3G58DtQTBXKFbhJNiKkF8C18t3sWdXIiuMVAQTvT+4VCai8jFPWeQtwaz
 9DLtlYuCKcth9hHNpw7/ei+D4hv3dqA5N+YdyUnrpQoic1z02MUl8y6WYU0R7jPmfU11h+hdM
 nR/3jshpfFnQYMfySXxag4Wg1T2j3+Qtv8524kPlhlP8dIaYF4b+XUFKJUqFTfghIe9v8/XjE
 Tp2qz2YCIV4kcupHEl9BktxmNZiMeqOc1OOfmBLwOY3sjYuHA3r6gnqG0Bu1SP6LUjZV3L13o
 bp151H90sVdRgNrqeO/4Feh8trxAvAXRCdKSccchM3vkhmUN+xHq2go5p+j+r1X7oaBBfpVpo
 0SKaRLNrv+ztV1/kJiam8ViUQu4Gi4vRRngGeGzWZGCqgGUhfD4rFRz25+iLE8hGiiQAtMzcb
 LAJyOUsABPmlPVv3iCV5zkxkBL
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Sep 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +	const struct object_id *tree_oid;
> >
> >  	parent1 =3D get_merge_parent(branch1);
> >  	if (!parent1)
> > @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o=
,
> >  	if (o->show_messages =3D=3D -1)
> >  		o->show_messages =3D !result.clean;
> >
> > -	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_terminatio=
n);
> > +	tree_oid =3D result.tree ? &result.tree->object.oid : null_oid();
> > +	printf("%s%c", oid_to_hex(tree_oid), line_termination);
>
> As we are not using tree_oid anywhere else, it might be cleaner to
> switch on result.tree more explicitly, especially given that the
> return statement also uses result.tree to decide what exit status to
> use, e.g.
>
> 	if (result.tree)
> 		fputs(oid_to_hex(&result.tree->object.oid), stdout);
> 	else
> 		fputs(oid_to_hex(null_oid()), stdout);
> 	fputc(line_termination, stdout);
>
> but that is merely "might be cleaner".

I would call it "more readable", even, not just "cleaner" :-)

> > -	return !result.clean; /* result.clean < 0 handled above */
> > +	return !result.tree || !result.clean; /* result.clean < 0 handled ab=
ove */
>
> The original returned 1 when we failed to cleanly merge and 0 when
> we cleanly merged.  Now, if we failed to come up with a merged tree,
> result.tree would be NULL and we return 1 from the function, because
> we failed to cleanly merge.
>
> OK.  These negations make my head spin X-<.

And here I thought that you couldn't possibly not like if I didn't refrain
from not avoiding double negations...

Ciao,
Dscho
