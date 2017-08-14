Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A9F20899
	for <e@80x24.org>; Mon, 14 Aug 2017 16:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbdHNQFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 12:05:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:56179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbdHNQFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 12:05:19 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwaMR-1dXVGb3z4h-018J81; Mon, 14
 Aug 2017 18:05:11 +0200
Date:   Mon, 14 Aug 2017 18:05:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "Dr.-Ing. Christoph Cullmann" <cullmann@absint.com>
cc:     git@vger.kernel.org
Subject: Re: Bug with corruption on clone/fsck/... with large packs + 64-bit
 Windows, problem with usage of "long" datatype for sizes/offsets?
In-Reply-To: <1232852793.287524.1502435085656.JavaMail.zimbra@absint.com>
Message-ID: <alpine.DEB.2.21.1.1708141802510.19382@virtualbox>
References: <1232852793.287524.1502435085656.JavaMail.zimbra@absint.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XViUjO7rqJdg9DCdyGFwqrBMr912oIszGBsK22NUVfSF4oS31pv
 ejr3njngYid4eYjQUtsbxJMk+0/xBqmpPVqA3HM04AC8hH1q2WNRdDPQubM+JKrFK+s/uWb
 sEQqV2ngJG8qoS57zScWy7d3wgzagNpEmaBaGlHvwNdgFJmVSw0q41dDDo2rC5fQ8XFtjEz
 Oj4cgVXw3LJFlBuSoU3hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dtwTcBJftZQ=:UaNm+zAIW2QjiiWdbJwofp
 Lr1zrjdUx0FZr1dxjdhKbJyVvARJEm9utsTMn0DMmdH3w5fmCEuXLF+wykyWMenIwMbQgiNDe
 mv6hIWSCimkYfUv9xU9wN0JBgSTwj2mzSb5Xu2GoAmEyAM8eQZkZVc0tm4QvOEZ0VnTDB80pu
 U8ai4thBrEtk07qPSyKKwwDKY1M3yb7FbccZ6PWMHpJ5cFjksPXOnLveUQzHERW99JMcCa9ic
 PS9pMdrl8C726VzxmDJeuc11X7F2ouU124ZWpb2QmTt9yKClLto/lyiegUsGGkMTpfNcFXFP8
 JZPvd7J/UeVhOV9FK++rmPUccMPl1OkxWvYCam1r7bbrvKp3nZGTzcyQ6QZlQhA2mz1zeVkkj
 F0ORkBXorLoVWzQPwkP6eyuTP1GRSMa6N+zFKAkr7UlgRE7acQZTBppmLrQzrw6yd/NPLHsy4
 6xMXfOuaLbcHf+FbWBAjN+zJcZltqBc4BJgDtIOfmH/nE4yrQy7icnoGqn3FZ0OTfRz9nqWHt
 k5G8EX3zOaTpde8DD2/JBvdnJok1jTABteDP4DZAkgZnG3WpPedfb0gwgK//wvk00DlyKEVER
 mRnMmMuelQFNypwk2NmtWYBBaBrZfrUlfY1NV+P9tBoZIn70Ci6FAHg/6tSdj3i6pXXEJ8/il
 0jwcrflMCZig/guSn4nnXw98bjDNM2HtNEZdKM0SR7cIONtzwCgtKlNQj8reUih7m9y7mSzp/
 2nMEXq3UPQ7vW4epPpqwGlv0Dh+wpEtDwHmt+im8xyj6KfHZOV2okQihsmI2Md96pFz0HdDjN
 /wyZXa6HITlpuXnHDISTGFbH/1SaGZ4KQFY2rCR5tIaTEz9/mY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christoph,

On Fri, 11 Aug 2017, Dr.-Ing. Christoph Cullmann wrote:

> on Windows 64-bit, for a repository having a .pack file > 4GB I get
> during cloning:

The reason is Git's source code that over-uses the `unsigned long`
datatype.

In a nearby-thread, an underappreciated effort by Martin Koegler is
underway to get the ball rolling in getting it fixed. Maybe you can help
making Martin a lot more welcome on the Git mailing list, and maybe even
help getting his patches reviewed and integrated?

Ciao,
Johannes
