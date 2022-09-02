Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D60ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 08:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiIBIxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIBIxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 04:53:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F797543E0
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662108783;
        bh=ZoKkJzL0yqPQSPSYBNhnBiqBI54tv4ErgBercyfNPg4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CRXztlP8M6QGw7qUzi5YEmFsLCrkglD3IImE+19BzWVXUiPcUAXgkHfb8gaMKCNV8
         GziDeb15CilX3IuPghcn25jk+UDNX4osKZLwiG16T+oQuO8BenDWFyduhEwUJe/pzW
         FKzphBjeZaBFa2iDxtYSXzVg8kCPiNYT3jL9u5eM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1oiHUJ3GHE-00N6R3; Fri, 02
 Sep 2022 10:53:03 +0200
Date:   Fri, 2 Sep 2022 10:53:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] add -p: ignore dirty submodules
In-Reply-To: <xmqqo7vzax2u.fsf@gitster.g>
Message-ID: <sq60608q-2179-1737-q987-736o14s1731q@tzk.qr>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>        <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>        <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com> <xmqqo7vzax2u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QIVy83W3gV2Bej37JpzWk71rvGpw+UwdCdCpROjReLV4Q2KhcjE
 203AaVLEz98Qc8EZhdXQXz6h9+uT/55vfum6zgJich8NYaTvCrculoe4aN9RDTjPKK3O2a2
 BvCAMbYk1oIXPRNDhux3k2GdVMpitFbEPVT2/gqs3cDQS7XSOYVgD1shBXLgN7vYXjIiwld
 lvu2yLHv5AUBikn9gCEmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XK5BvdiknRM=:6sDzzLuEGM1pjThbz8LldR
 p9EKsNWmg4Tw8n40atxNbx6MLuNNNa/931uiVH3jTOt0l2N3iEh2ajcpEGR4UdNK9rCIJbIhK
 p/iEqupNwbUKWTogUod2aqU8Q88VcbsA1215wTalxdVlKhoV8019/+mQxiV6KINtOYz5i431c
 CM17z3zll+2SxIBXi5eNfbXOWqLYUZLUL0PoLRssp5bFklEDI+q9PlW5g9xykTQjhsIL6NZQO
 bk4H+8Xu6L9ZbrfEVf+1qJrMHh/A60XZ3MN3vaodjg5mVt8zIoY/cFzyN2irRC5/JDwlga0p6
 cMsU8xwEH2m1LLnpNUJIhskGFjD4Twx+GHv+RoUfXFlEJhI076VxOrvLz42McYERfpPVvJaON
 wetloiQIjlsReD05V0AYtBhnwcN7g6gg3Xo7i9JK6W8ucg1Ev4r8Nf9M7yZOo1Kl6yFzbEBKs
 66jrCM/TJ/ERBmJIK737DhIOmWE66Tp97WPa5l5h4yT3kE1WKS4Pd+rTYZ/TBqQyezffbuWTA
 z533Fl71nOPXBn49rBklQmO1C30aVRUY0JCbu6FWQ4D4O368debDPLJw231UzN8ONMznh2MiK
 wFQlRcHXxLKb24zOAU0yyPJNnZWaX76oVsbpKwEa49iOcX6ak40Vk2K7pUd1/mOInY3oYbuWo
 7wdBn8wH6Pj1fUcKWAFEUEw72G22HeV8cYlR7HIe2dTDb/yYsvEZVQ+er1ZVpJ4MqxvMhW79g
 tcl+G7z/pCuHwvugI5sW4+e7qQvLAiw8I+w8tB0Ewe6H+ZUZNRNBVPHw6IocG3uCYBMBYfkal
 82Fp7OeBOYqVLAvdJkzMIhUW6Spll1t6Kt0QVIlG6pfAYY9HdgbmdYCQf9OsPO/Mr7DOxNhSc
 ewN0kmCEM+DYQQOhaiyguk1lhvcPqW45xDIuXqltXyIH0AKirpc6SGQsQZXoATfl7oDzkMe10
 8oEJ4r6DMipPuYQiKmtkmqbGI1JKQcql9ajqQT77aKr9lzK2DJC4YVGfYJ1ULBgGJeTM/xzWJ
 WLg8KLCpP2VW1u85kRIHNZ+HmMZ8X4RAko2h1cWfKezjdE4XuUdSvEaGdSWIB38t9E0UDST4U
 ar/e1hTaK6V3kovfZozmo8rLuGbjcVNIKeUuy7uR2k0Q+dxv2ngpvIY2We9bXPquSkqc9xrBf
 DmgpMGqDicY51qNmrMT3KNToGv
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Sep 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Thanks to alwyas running `diff-index` and `diff-files` with the
>
> "always".
>
> I notice that this round (like the previous one, v3) is made not to
> apply on 'maint'.  As I said in the earlier review, in general I
> prefer to fork a bugfix topic out of 'maint' unless there is a
> strong reason not to.

Sorry, I thought that your comment was more about changing the base commit
too often, not meant as "please change it back for your next iteration".

I have changed it back, fixed the typo and force-pushed. In case a new
iteration is still required, that iteration will have these changes.

Ciao,
Dscho

> It is a different matter if all these bugfix topics are actually
> merged down to 'maint' and tagged a new maintenance release by me.
> But I'd prefer to make it easier for motivated distro packagers to
> adopt fixes that proves good in our 'master' front to their maint
> releases, and it would be much easier to just merge a topic based on
> 'maint' than having to cherry-pick a topic based on 'master'.
>
> Thanks.
>
>
