Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE259C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CEF60230
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhCAWY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:24:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:34059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232944AbhCAWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614637135;
        bh=s85FZQbFp+tO8pBGBy/+eTOe0FwiBpETSP9gJj/TbSc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KJYSQiQJXuZpZs4XpNjB/FKIJ8+wInfCnuUpVBgwftgWMKDEXKNNw+JJMtDjOejvg
         zLLUvwCVgr0ZCCdZsrbsMhigdr6RKeGwy/yeB+EG4mgunfvfP8wG8fEhjERsloTCTR
         svXa5p+ytxWqc8vx4qfwXEtQnsItnOMxJiFBYEjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.214.35]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1lebNh3Cda-00m40e; Mon, 01
 Mar 2021 23:18:55 +0100
Date:   Mon, 1 Mar 2021 23:18:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] pack-revindex.c: don't close unopened file descriptors
In-Reply-To: <YDk1/y1CmsPYC88C@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2103012312230.57@tvgsbejvaqbjf.bet>
References: <34c017296a7c5fe4a2ea70f8a0b2d8586b34a4dc.1614357030.git.me@ttaylorr.com> <YDk1/y1CmsPYC88C@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+YzHeqV4IYxJUVoV8xBl8H2CSgtq5ATEjOJz7twqTdMtmZsyWlF
 +GAcSeXIlRtwFKURGH3+r5Mfo6yvxC/Ngb6PkQf4RnT+bMhni0esglEeEAaQrV2MQGWPn5P
 Dwxb1GLluspxKtx+1QS5cZXILL/3yWpO+J9hTi8xlWcm283AZeSC0teq+DbcD9iekuu5Cmq
 P1GuOVmDu7jf//WMQHWgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:foptPBP8IRo=:8zv58h4xgn9OvNArIl3Rlc
 oW+It7sS9uWFOnXJiyTuxDokWiO92Db1J2/YOtrIVb4R18ExPoCZJJteBd2/p+b3tXPopfakL
 HAibcD2CiaSfXpoKIz59tpElIl8jst6++kXceqyfBTQV3YeN62BAoEkx7oEvhJzm6orxB5AHn
 G0sR/tkRO7wpxq7LNf0I7Vzuold+OUZrnLfQS+naboiw6oGATzB1+iqke+kxiKQZkzXTo4bay
 GeamfqWeTpNC68PGPRxaIHJ0XZZD0bSPrGh7Orfh+p3qdv8bzj2dgfllbepiiCjWwPklMTwiy
 BlYDLmj/d6c2HimbpPy8oTEKNF4ZEqlE7CfwJo1xXeYLluNmp893eLZHcgbPWCGO2rpxPvMLh
 zLDe5IjittlqCiIKC9bGd8JOHkcts2wSjhQf63atUUWLvs8B3fFpRyZ6w2cYYL4D+JDMb/wjV
 UHJmEK8VScsprr29Nal/Ebhymf8QSTgvfZ69tf+ejIbG+3ZRVfiWH1+QL30y86+ho/38XrCVC
 S52d5I+VgIVzLXbUUIskhMe3P98tUnWCj5ysjptJ4YSFJnNm8Mra4s5LDZEyU7sEl/IieCQ9w
 Tcaa0RMrfhzWowGOVRY98xlLjr1FpzMZdglbaPwHAufFMQ6rm5c2Mfx+h5Sz+oNw8Se4bRsTN
 bGxsfKAbxxgoggQaGrkGj0nelNs1SIXqusU7o4K5y7mRPjz64279P1aWurF5u91alUeWxyZJM
 iruse4YYtMvEN/seoFp9pla8dbosYNFOysc6AHcle+GAMAErLOYzUT7VghHjGv8E4B1BDNoyt
 wbebowrFkJUgEeqIk9VSlYm9PXbwJLUvD5x7Wk+//kRe8p+zpTNB/pQbBM98TuvqZ3C1kYuav
 N4/xzKP+TNDhmXKI2nC+Yom6rQtK0cW8nyPpCv8ks=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 26 Feb 2021, Jeff King wrote:

> On Fri, Feb 26, 2021 at 11:31:02AM -0500, Taylor Blau wrote:
>
> > Dscho mentioned this to me privately when reviewing Coverity results f=
or
> > -rc0. This one is legitimate, and the fix is easy enough, too.
>
> I'm excited that we might get Coverity results again. There were a lot
> of false positives, but I found its signal-to-noise ratio higher than
> almost every other static analysis tool I've looked at.

Indeed, the signal:noise ratio is pretty bad, mainly because of all the
false positives (Coverity _really_ hates what we do with `strbuf_slopbuf`,
it simply doesn't understand that we allocate `buf` only when needing to
write characters into that buffer) and the "intentional" issues (we leak
memory left and right in `builtin/`).

It does not help at all that Coverity has a bug for a pretty long while
now where it simply throws up its digital hands in the air when it sees a
GCC v10.x. I did find a work-around for Git for Windows' automated
Coverity run, a work-around that is somewhat ugly yet necessary, sadly:
https://github.com/git-for-windows/build-extra/commit/23eea104d53

Ciao,
Dscho
