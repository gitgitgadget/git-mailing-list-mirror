Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7984C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C289D20801
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hMCOhNej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFKOFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:05:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:33635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFKOFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 10:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591884323;
        bh=aO7RKGwTFbvr7y9OyqNA4jE553Bc+WLVi0OG2vsDvPU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hMCOhNejB1snPcLNyzx9Pg7XEw8RXPlaFKfsdpqGseg6nm6V4AFaf1HkS05P/RtoK
         dazdJpnu+ZrEPR8Istos25LySk+Hy5otwOqiARxi1rYf1n426EscidSDzcLYJJNF34
         FkLcVLoBrfIOv4EHYZJd5a13dTKsPlSPUh7WdzIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.212.132]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1jYhg233tJ-00ObIg; Thu, 11
 Jun 2020 16:05:23 +0200
Date:   Thu, 11 Jun 2020 16:05:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
In-Reply-To: <xmqq3672cgw8.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o1J/1BBfEuy9gaEUlNpVUheybgVabirQKRxhR7ToCFQp5fRNlf4
 8Qx2deFzQRsSpdKd3tpwg88iKeDwgsce5isRsu5RDj4i0MBRHNhxDgtq8I5Vf9oaLEqNqJ0
 PXd6X+xPw2yZtd86kufJ2dP25jrOdlxH4y7wpkAAsd4viZrQYCGwoTZ4ExLnwieSJ5+VhBG
 5WJXB+IjRGKVr0rhaoutw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:01c3RPSCHTs=:yoD4dJ+jBW212Hupucuqew
 4yER8M1YMKLwNF89nMVBGkdMejmxseG2mdXm8W2fryrFgm1k42qQWtsKNwT36avIaRt7l7tR3
 SKOMC8hnJHN0uGkAS8nbXUn6+o8MAZo+T2EisMIgOI4YzgiouQSkxVVT+wSKwNpUkQ9zL2/fq
 3EHBkzSkkA89sYjYETzYO4nv+ZDz22fzZzWwYF5DJjrpjYKEAzwoCKN/zyJh/Bv+6f2D5G7Ss
 wZ6wUdertug6mBFdj56L89/4ANNdeZYJhwKq+yJOqMkgKd317+upFXPtgl4TgIpNq47hfmqSE
 XWoIlg879ANkBkF103Zh1fiPef5GcJulLbiNnwmzUeUZKggM7M08r19QrTxrG2DKt3vpi8MoY
 VSnf1K7Ynn3f/BreK87gYgwQRSaCKUou51qx+5Z8BxVAoIhAgGTqoy8WlmprUvtPkTSCNRAcX
 7C9MzuQPsebAlsqGULDfxWd0wpIDLktFgSaiF+3ilEA2J27CFTmwTiBpCzw4fp24P/9caR/AE
 mGpXGSO1as+OjHkm1AYWFqOfr2uvEw+8hr10un4G2EYxrrdOef2NNsDbn9U6OiaeNbR+1VvVk
 t0o4Zj5M+SkJgnp+NeId8+zEtrjEJS3Ax4kE7TzSJRUXnOzb8ZOCVwpS7hMgM300DgM4G/R/U
 +RDv2cJXo5NhLNpHSSLfW4mTiz0G3NdiUkEChVBV9nBfmfXUYT6Zoc97ejoR9f/LhW3PuyfwW
 NZ9q22zwtCh89W2QrYmOwTYIbUUl1TuSNOBHpdu2RVKn2HTIRpk5ojH1+Fzou3lNHmuWEcz83
 ywGwC8+Ji561hxuW/gCAjcAntGsuU45T4T0/SEJjyg/ynWu9oudV3+lLIdzvhoDxIl5xY4jfw
 6neOJhT8o4piMcSpx/UtyXHDsfmfWQ1LJlB+ZSpsG9JylnESElG22gvlL79Xk2WBiUgWHWtYn
 kNSzLHq40+BSDqH9iZ4HjFXvOdBawFC/h391+YXNJGy76Cb0bXjHsINdAIGkl3Zah25NDHBmq
 xqDxuqOiqck/zP+FCxCzszy/e2DvsQCvwEhpJ5kcW4ZV0t5U4RgXH+eskwM3/cTlBHK+JDePE
 yWBx0hnBaxCz2br5sLD8SZwRN4eosUThPHLaFXQQYJMcdC3dUJwVOljXwWJcuGQYDBLSpyIjd
 t4npDol+zO4L5EanMikOsCSQQHWLl+O9K36Z2QSgoG5eheoxlY9cncw10YtZ/+fmx3hEPdAit
 BhshWmHfMuyEeYCjE
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 10 Jun 2020, Junio C Hamano wrote:

> Matt Rogers <mattr94@gmail.com> writes:
>
> > I think that's not very convincing.  If branch names in general are id=
entifying
> > enough to warrant anonymization then shouldn't the default name be too=
?
>
> It is a good argument.  I also heard a rumor that often branch names
> contain codewords given to pre-released hardware that are highly
> confidential in certain circles, and heard that it is one of the
> reasons why Gerrit has server side ACL that lets you hide some
> branches from authenticated users that can access other branches.

Yes, branch names in general _can_ contain information users may prefer to
keep private.

However, we're not talking about branch names in general. We are talking
about the default name of the main branch, to be picked in _all_ of your
new repositories.

> Again, the original comment explains why 'master' without such a
> configuration knob was not worth protecting, but what it does not
> explain is why keeping it (and only that branch name) unmunged gives
> a more useful result than munging everything.  From the point of
> view of "I want to debug the shape of the DAG, without the actual
> user data", munging 'master' to 'ref47' while other branches like
> 'next' are munged to 'ref%d' does not make it harder to use or less
> useful for the debugging than only 'master' is kept intact in the
> output stream.

Yes. And you're unlikely to configure the default name to be used for all
of your future `git init` operations to be something non-generic.

I am still highly doubtful of Matt's suggestion that it would be worth
protecting the default name of the main branch to be used for _each_ and
_any_ new repository.

Now, if you suggest that `git fast-export --anonymize` should either not
special-case the main branch, or at least have a configurable set of names
it skips from protecting, then I will be much more in favor of those
suggestions. However, those suggestions are quite a bit orthogonal to the
patch series at hand, so I would want to discuss them in their own code
contribution instead of here.

Ciao,
Dscho
