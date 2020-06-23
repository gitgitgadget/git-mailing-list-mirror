Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89D2C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00CD208C9
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d5O0Q0I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgFWTWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:22:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:54671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733220AbgFWTWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592940123;
        bh=hvSLDhI6Gy/lWpCv/iRW4q5Ms7wBAqpxzyEW9qPKt/s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d5O0Q0I16asNMNsxkF5SJ5JxDGC+5IC7A6YkB+odP+X+UYTmUUuulEhAdEQD/g2Vc
         K7bDDZmRk2N0ywr6hUdnj6I0rxND3kFQLGlwZjflvFVPMMIwg7mHdXjYTTjqzhpXVX
         Sx9JCqjscLTeaSNPC2okbb5evHpfkntGd/xFgUSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1jNem232Yr-00QhZA; Tue, 23
 Jun 2020 21:22:03 +0200
Date:   Tue, 23 Jun 2020 21:22:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/12] fast-export: handle overridden main branch
 names correctly
In-Reply-To: <xmqqmu54w91n.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006232120221.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com> <xmqqmu54w91n.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HSEEiuEsZXYZCavuDkBEPBAVSVirHCe4dRzT2Bpri4nkvd2b7S3
 8xjIiCGHTeJHJhazqONRDj4k+VOAj8q5l5HQZvsn3SgfwKu891poa5ZGZYYJmAYBkkqYr1b
 7zMPMIN5RUjf2tI3aW3t/QLJ7yy7mHHMWoPE6+hWwTIKm5XrP+/k+vFnQoHNTtsQ0OLyhrW
 JzPTxbzcuUSJz6ytrvoUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DtD3CmieaoM=:zf+OqVMU7j1OrjxlR3to8a
 u8wkRS9C3WSO906hK+XcQ2MzyDZIswP62h8BFiAp3kFQ95tPCGGT7Od/AOJLJ7W3otGYGe7C/
 Ywjm38wq/qlkw+R9kVgnTUjXitwGIgD4/J9oHIrlLQTqsRk7C4pRdg66BB8BK2fBsFU+idQIF
 KIXNUnSEfc9sghx+KN0NUT9Nw6i2ZIeohr8V0QK12PnHgQA2XmlpPV62yJs03x8muQZD4pB/V
 VmdI8kqnlWeE72ugvCXqaPK+R5btRILL3RcoRVmpBBOp5VMq8a1Re/mM7O8HLskCnb9FhkSmi
 zzfHzHBw0RQ7v8b+gTr+FYg6mDhi6Q/hutGMW3MTcSFi9hy3R0DPniivgjZI5Fuwqr4+Yl8HT
 uOYS/5B53g47+ef3WV5X/ctQy6REeYjrfjdnXbspItTwq/NU6ADYJg8as4LPF0O/Hn+6X0G3w
 ZJ1Lea1qhOAhhGJ1MOgiegwNfTwkU+YnWwCcJOv6gOEu3CRCY+KOGeCe4fCspvv2EoLHG+wx2
 +DzpRhiYGLdyhVkIUPt1fXZJxIMRIiNuiBjy5kjkmpEEHSfG1R2FUkkWu0CYF0lnta2gUNc1D
 kLeAiaQtks53YQZbhnjRlOy6ptQ+1TjT7XEVwgKKFcPJF91jPVnb1H2n0uS+xjoHoF3QktefF
 gRqy4LM88SqDMMPLcKloPA0nKcEjtbTSjHry5+2Bdf7Kgr/6ZRCJaHIRs5gt5g9keopYIxTTa
 egXX6/DniPF3p2AkXzdUxVhyH+ssYiM5eFhsHJwIlqq20sVurtk46rubTbsbgpU277iiLR+Wd
 hkYW26BSmZ793FyJyE+w0oAEgCQfU5L4oZWng6KTdFwZ1XA20ReyBcLsojWcN7OrvCIroVUct
 G5ar8xUJBP342UvvpPViKWzSC3oxf7T/GxOwDQGU0ygW5e9lbFgxYzXAOZwEPBXwCIpW9RFpB
 uZi0RvvlVApy7vvPZIjghp+xfRl5fZZiO9hWHY8wELgfi7mL9a68mUS+f034b2N9uecxL1YOr
 bgYxcMdGGP/mCFgEgasG14ojPFk3O+4CyzXapRmsv0QJsf5JVNufokwboNX/FfXNBT/MStB/2
 v5hdClyrMN583Shd11yKDE7/UlqnALDylo6GmycGYZbL8gbeKoxsp7z+eBNeSJ8RfZ+T2BNKw
 /37FDfg61bJD5RC832O8KJGeXoaRxk2Fvl0Ks/GJ6h1CeZLwZCFfGp7TJAdxVs22ilOo+A6OW
 7+1cTHr9B5UFw69ns
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +	 * While the main branch name might often be `main` for new
> > +	 * repositories (and `master` for aged ones), and such well-known na=
mes
>
> As I said, if you used a different word for the first 'main' in the
> sentence, it reads much better.
>
> > +	 * may not necessarily need anonymizing, it could be configured to u=
se
> > +	 * a secret word that the user may not want to reveal.
> >  	 */
> > -	if (!strcmp(refname, "refs/heads/master"))
> > +	if (!main_branch)
> > +		main_branch =3D git_main_branch_name(MAIN_BRANCH_FULL_NAME);
> > +
> > +	if (!strcmp(refname, main_branch))
> >  		return "refs/heads/ref0";
>
> The same comment as 02/12 applies here.  If the helper function
> returns "" when the user says that no branch is more special than
> others in the repository, the code would automatically do the right
> thing.

Seeing as the `fast-export` patches in this here patch series will be
dropped from v3, in favor of Peff's patches, this does no longer need to
be addressed.

> In any case, thanks for working on it.  I am on "vacation" so will
> be commenting on the rest of the series later in the week.

Welcome back! I hope you were able to rest.

Ciao,
Dscho
