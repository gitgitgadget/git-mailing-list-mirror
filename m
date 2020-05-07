Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581B4C54E49
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385E72083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Mi4kb3nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEGO1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 10:27:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:58221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgEGO1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 10:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588861657;
        bh=uWxSLwOgVAolf+uje5HCi+VnDAjrP4R3OEmStjaJEIw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Mi4kb3nd2glAuGtOGkZMGpxnxwnSM/NAbgz4FNFxEG9muv3PQRaZrXryhn1ycYksn
         u+svc8BuVZpESX+JP7KEh4yHmsEl3P2IZisuuBv3kSJcnIUTTwoBsbGCG3Si/YD1rb
         3SgOc45dCPljlVYSQJB9buIsRYkJ+5k0bnmth04A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.213.71]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwXr-1jQP2n3gAj-00BMW9; Thu, 07
 May 2020 16:27:36 +0200
Date:   Thu, 7 May 2020 16:27:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andrei Rybak <rybak.a.v@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
In-Reply-To: <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005071626340.56@tvgsbejvaqbjf.bet>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com> <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k6jhdpNne2QY+jEXdrvrzetC9MiwYvi5kAfJ+hSrwr9gahIPtYE
 +bvvZ+TSknUf3ISiNpdJbEg6mp9WUzPoWumTNNjv+Sq+fyFsLxBx6vKRKUkoBxi8knl2haO
 9B2+vv9kaELzMFn9UmPfnJtpPGNVOdWCQvB1phTxAPLWbGQyVFxlN+vyG5i3c2oap5eXDbj
 D2YD+4fw2eNZBt2S5+O8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ESy7609dF4=:BVvjf5tbm5CEm6fyFQ8RMn
 hkXvxZ+2+4UMNUd7yVBlpi07eZI7FBmxhw3Nn4qnAXUUyl4rOK+7u5ugfZnmS7pgBvnL8tYwk
 1OaKObXT+l0HaiS4t7jF/IQbDyjsaIF7CfN5lUIwCnm7fmWHf1uwBYgWjXmggmLFYTtYGX6vK
 6u/2NT7ggYvtiyoPruRybDjc+XzA2g7lyeVnXNbWt+i0QJEZra6EmmSm9tn0+oanDpKQT7Zus
 R4IMcaecAmRvU2q2vhqZmLpKcFsVVvXsNzdQXkdbU+jVtN/nbuin0usnKGKhYzRvvnDNx7ySJ
 UG6usmK3tBMdBtLa+opJgrVH3LXmOVBnxeGkPVtK/qkWyYFDzVAleQDg4wT3+B9CNxDn5erOV
 y9YM6oSkcHkAcFTuqKVVH79k5sq+/uf0lYYlZLsyckIgUBvXqfxmiu0iH8pjomElvOFrMHGnx
 tvNDlf6lSXQTrWFM4ro55I8RkPt/111HvmsMRh+ERMGJKNzs7I6GjMUdJT5kJuUaqH0DEpLRG
 z/v05v+tL5NYTHACgbr/QOuOIbJgjkx6y+C7bJiRQ2UpMh7jMpRxJ6pwtYqDnzwCWIo3fyqVj
 jEnTzy40TveFLiBVAIUSGwPV0rY+BtiJuETI0PPEsfXxnOekVww2oJXcsNc2HDCHyCBqiXywA
 2oEj0jFzQ5b1BOGtsHomJEfsVnTB8i1OgIBG+iJn7CgzjAdeVpWhSSxBk9sPKBZoFczVHnrAJ
 N2EA5YkENWvYfItiWmDr4l4gGuUzlr4ERf1pYEmnSgXIEbdYLPgQOCRMgc48XrWSB6gcWJbHY
 OoAfZR/x+0d3/cZ/6uCEjGfL+AfiwtLWZJ93uZbzLC4hOrsRsio6dGCoai8Ecgrrl+E3cYNkZ
 rB8LaZ1GZlLcrcZ2BoL/IxC1s8sa3zqtGzz5K73bmu+GC278/Yu/JtWP1KXOk561DG6OACyv0
 FH2g+5j1DT7yyxLzBMuuYKyVi51Ms4BgSUnfIA5/hKzSO0MAkGplIdeS+1dYsQ/+Y9s+Deit5
 AAAnOSe/5J4nHd7Ebe2M1orgAuimLR/luxMLV7YHDpiRKN/OeT747P5DUKLXvyrbMjWTbehUe
 kFdDMFh+2VDdOMXD3ISkQ39UaaoXwkY2eXBzz5+lZDB/Yqz2j661d8dpkkjERmwJB7PvcOvuW
 V38PF/7iDSTLIveQk5jayejG0A3zsJQot+GhoriMWsyzPU81Kp4uqQiLFPyffRlQDSKldRVXd
 Y5A/PxvREEBtiBnK9
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,

On Wed, 6 May 2020, Andrei Rybak wrote:

> On 2020-05-04 22:40, Johannes Schindelin via GitGitGadget wrote:
> > However, as reported by Paul Ganssle, that need not be true: the speci=
al
> > form `fixup! <commit-hash>` is allowed to point to _another_ fixup
> > commit in the middle of the fixup chain.
> >
> > Example:
> >
> > 	* 0192a To fixup
> > 	* 02f12 fixup! To fixup
> > 	* 03763 fixup! To fixup
> > 	* 04ecb fixup! 02f12
>
> Could you please clarify if I'm understanding this correctly: does this
> affect the fixups-of-a-fixup which were created by
>
> 	git commit --fixup=3D<pointer to previous fixup! commit>
>
> ? For example:
>
> 	* 0192a To fixup
> 	* 02f12 fixup! To fixup
> 	* 03763 fixup! To fixup
> 	* 04ecb fixup! fixup! To fixup
>
> Where 04ecb was created by pointing option --fixup at 02f12.

No, it only affects commits whose oneline (i.e. the first line of the
commit message) is `fixup! <commit-hash>`.

Ciao,
Johannes
