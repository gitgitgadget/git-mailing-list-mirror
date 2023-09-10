Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0843FEC8748
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 08:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbjIJIZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJIZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 04:25:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A9188
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694334296; x=1694939096; i=johannes.schindelin@gmx.de;
 bh=7X4eCKo2XP0hafBnpTywlxzBmEhC6auctLeZ2BS2hAQ=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=GaCK0vojCyfr8efA7HAgcNjZN4gUu1k4JK1OGV95V7j8WN8T5zBiVZfOsKrbbkZi3Y3E4/R
 wYzRw1Ld/KCConFPqFXzw/rH8qlDKMYlncCwavl8VkKWNoWQLJB4fXnHfnjlxPGLUSM+RpuIG
 pliCNVPqp6UjaJ5xSFURXH8kOYvc/OA8mDdJZA7Ww7c4kJzutkBvEqT29XXGQ8EgXj3LN3h+b
 u00Y4zIDCffAFFgo2N0cOiG2VLau9A3KcwmS8qj4N1laSgllwM6CvGW/5uZj85EbsulDoCG6G
 F8km2+OgGgoQou3wStwxxoGlh7gb8a47SawFCcrRVKAFcXh4YhUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([46.183.103.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1pijD31Vgr-00woXS; Sun, 10
 Sep 2023 10:24:56 +0200
Date:   Sun, 10 Sep 2023 10:24:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
In-Reply-To: <4fecbf96-aa04-41bd-a589-bf7c368d586c@gmail.com>
Message-ID: <d139605e-7d00-4939-2784-ae5550638a46@gmx.de>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com> <912205bc-37c5-edbf-2f85-f26991ad65eb@gmx.de> <4fecbf96-aa04-41bd-a589-bf7c368d586c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MP76e71JwIfTeS3/CXC/ozM1ahZxQRX7A6JEb2w8E+S5vjlYzqh
 lGz35jS+nLmvUKDGe7GXynevL31oFfB4N9YROTgb0Z+AxSzQRVLqFEeTp9H14qIpLS7U7VK
 8HGLySWP0p+B+gQzNmH09oQuKAPFp3ZHjJDZ+Ezgp7OzhqMo8mWbS6o+2uLweE6wuqIWzkH
 UAVpeYr7Hd82bb3zA2AWA==
UI-OutboundReport: notjunk:1;M01:P0:qtn6+O57GHY=;mjzHPX3CsNqRLnQECH/Y0EfUtU3
 VFK1GDbRKfy5UbTuDkmhRFBXcIUM2KG4HsNDCu6MGrFdxXyrQxIPZhJISA4xHt2mumstwOs9v
 qdQJ5m1H7J+2WM9FfRVBcPbC4Sh8voUJ3gwOhXCyJkZuuzXFFuMZO9IiHpfoxFh6J5dG9FJx9
 RUcRhNuBy1obAtu0j94fsEcPSZ+sdpXRy/GJTG4XPsJHooJVXDhKpk4oEPzpev0zELY6ii2k8
 eP86chNCs0EmJBcID5f25/p35Bxf2PqMx7ZRbPPMbivtgf4Kb2XAfmiqOZeJMgQrXppSMjshW
 42q4wkpMniD2nNfRvjITe+0FENB3gl7HVeCgNg/1oNDq5YPufhg+CTQe3XcIr1+z+qqp4Si3N
 jf08DP3XhOL2vRhSjzPn4LiCdkgA06m5ANbk6TxAx3LofU2XReHv1bRp1tM06XtVv+bgPyOrH
 lJv532eNL+kqnj1BgfOXZCGVRNqKrlyEQFIu8Bh/I1Y0HbqO67/28E6Fr6/D0HEwmZIfRpnkJ
 roWsRzAdHT3T9fafruLKzpSW5BdDjKk77iK0lxDYBrq7Mz7nJ74jYS69HjHj5f+/HaOiz+R+z
 dFcbvzDDdnty3bA6PTN43s4Ttvlf8+6UJweDdijwkGSgES5bC/D0Cf9zTcBZOt1xnjZBMaehs
 X1k68HaTLnOxlDwp642Yobd9AFdb/W1q6No/r00g7IbXj4Wx6Yx7rbtopG/Xcy3yz9AZePbpV
 rVDRzVUR3BDK8WQ73WD6CF2oZfgflw9FHhqarlei/nUvJ/IRahvsXcMDN7Fn96UP3B3QndcCV
 61Nq5PPUH2k+FiDi+W25Z0mF6Qik04XscoVRTqy+klBV9SENZXMGGlegpt9S17dczrqpZPFwc
 s3u+i5RRzsqyOu3O2zA9/ogLlPB/zilTQOlFCvCrnCbyHw3b8cYSI86f4KKoYqBk0HdoWCDuK
 iyihO9y2Dn99dHRfW3f+z/I1A4s=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 8 Sep 2023, Phillip Wood wrote:

> On 07/09/2023 13:57, Johannes Schindelin wrote:
> >
> > On Thu, 7 Sep 2023, Phillip Wood via GitGitGadget wrote:
> >
> > >      Having written this I started thinking about what happens when
> > >      we fork hooks, merge strategies and merge drivers. I now wonder
> > >      if it would be better to change run_command() instead - are
> > >      there any cases where we actually want git to be killed when
> > >      the user interrupts a child process?
> >
> > I am not sure that we can rely on arbitrary hooks to do the right
> > thing upon Ctrl+C, which is to wrap up and leave. So I _guess_ that we
> > will have to leave it an opt-in.
>
> Peff pointed out it doesn't play well with "gc --auto" either. Do you ha=
ve any
> thoughts (particularly about the implications for Windows) on his sugges=
tion
> to put the child in it's own session, or putting the child in its own pr=
ocess
> group and making that the foreground process group of the controlling
> terminal?

The concept of "sessions" does not really translate well into the Windows
world. Neither does the concept of a "process group".

Ciao,
Johannes
