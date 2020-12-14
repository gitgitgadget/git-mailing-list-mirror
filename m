Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A5C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30083221FC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 15:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437761AbgLNPoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:44:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:35643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgLNPnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 10:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607960539;
        bh=T1Jfy8uGgQ/jiAi0Xn1+fAy5PoQRpMcJXC4BEv1bbgs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=keiygUjSzyd0CA+zP5KimKczK7otg8Ya69lTAZQQWHOpB6cMLal3EXTbO7QQOsGDZ
         LR99GGk5w5JtQwLrenXl+K4q4lYkvjYZPbRDAqa7Z8TajrIHYjCL9WSsFLRYnZW9dQ
         9F9JM+HGIRzkJnYyLYXy8OaMZPkwqzxgcGopCD0Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.214.172]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXtS-1kg8oE3ezI-00QUO2; Mon, 14
 Dec 2020 16:42:18 +0100
Date:   Mon, 14 Dec 2020 16:42:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename
 detection
In-Reply-To: <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012141641230.25979@tvgsbejvaqbjf.bet>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com> <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com> <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com> <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
 <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JC0ucddJL4dG/JHyIS7X4Pf5Q6hI0XIYJ22KK3N+o34KEICg0gt
 LMhxQ3v2j+x/IkMv//bLKH5wr7xf4Bx1oaBGXMdK+Vo/KiJdfhf6sFM8TihLO1cKUePIuSg
 SCGxg46cPKbMM9MiTUCit0ksIQpI4H2bQhVi8LYrpf2TbHB0Wsc8eP3+gjtPv3ONXWVCVjk
 8ndI8KL+/KkvCkF4mAt0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lpn33h0teJk=:XS+0v/hjjJPsoYuM0oGVNt
 CC/TI7GGqDjrfvU9vXVpNmuFTDA5CF5ps1661kkkaPnfa8OapZzxzMbKf2uVJVHMm8wzkkDPO
 +6oXXxO6CdSssR3bJc9j64vldGiYAhOg/Ql3lMrRjE8h6G28SVMYxW/UQ1J2F4JfEdBbQmf3l
 FGRlRf6YDTdz5E6xRXmSSbqDBqxHg0oVYfSCv/12OGr8sKJZTagnMXJYa1aD3fULe/p76PL6b
 mAoUQV9b02Jz/mM6EPFr6kszjyqxeqhyYwEykrqEDtxeDF29lGsro8EvbcTKcgFp8YPTO9tk5
 WRpTmyZpCAIiHcw3THkeUFf3g+FwSpNid8LFOnTaSk9t1I/CzvT0K4zG5Pz2L3XT6F32nCcVR
 A0jkXg2jbx/RS9mp0bPqNNdLh1syvdu14zpiafmhdxcOwB1skpq2UdL7bigC/xn2FrFZtAVPj
 NrvPo3dPiGTLXRm29FbO1W2HzEYepIDzL6tWgrwb7um9pJbmiPUnvXxjcis+cKtakZatWzHD1
 vXsQrcpGe9m17MyL+GnzOfr0iXFJjZBP14SC7aZ8rlrm5uAK/ZYysAk6lO3sn3LOc6BoGsMUD
 1wNGhfrpNbNnD3UP2btZESACTZo5ox/b+ef2OWMg20LowEBKHVpf4tROxe102TrD9ZSyXx/Of
 ErAZOEL29JrFPdE4vThYwu4pJReNVCkRZg3W/+uU68Pirlqsgrw+RyMmIP6BKudLxY4VfvpjP
 jAOINWMGIZoZcg/nx0mGicq1n423GnrbWrSODXbuF8LsxwCpZ4kTaVP1O1D3FgNBmznvT3SJw
 +DF8SuxgThLWcxg0/shYP+0EUUpknxN8dfixsy15wzj5CcjgLpwrEObDuvXSB//1mHc86V/uV
 vTJRn1qy7GeRBPEXTqVmho3hBLLbzZCI5Ri+3IeEc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah & Stolee,

On Mon, 14 Dec 2020, Derrick Stolee wrote:

> On 12/13/2020 2:47 AM, Elijah Newren wrote:
> >
> > Sorry for two different email responses to the same email...
> >
> > Addressing the comments on this patchset mean re-submitting
> > en/merge-ort-impl, and causing conflicts in en/merge-ort-2 and this
> > series en/merge-ort-3.  Since gitgitgadget will not allow me to submit
> > patches against a series that isn't published by Junio, I'll need to
> > ask Junio to temporarily drop both of these series, then later
> > resubmit en/merge-ort-2 after he publishes my updates to
> > en/merge-ort-impl.  Then when he publishes my updates to
> > en/merge-ort-2, I'll be able to submit my already-rebased patches for
> > en/merge-ort-3.
>
> Let's chat privately about perhaps creatin

Yes, I am totally willing to push up temporary branches if that helps you,
or even giving you push permissions to do that.

Ciao,
Dscho
