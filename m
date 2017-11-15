Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1878201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 22:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932558AbdKOWD4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 17:03:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:51130 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932437AbdKOWDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 17:03:54 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOOdZ-1eIeYc1MW5-005ovu; Wed, 15
 Nov 2017 23:03:51 +0100
Date:   Wed, 15 Nov 2017 23:03:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: reschedule pick if index can't be locked
In-Reply-To: <20171115104125.1686-1-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1711152301510.6482@virtualbox>
References: <20171115104125.1686-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lp3USNLluOIkEjXA5fl7EsnK77jtJqqdH61X1kPRgPjrBMrxG18
 B7baW+Jh251wUi9Ilci3VpsNeZTL9ouC1Y2m27N/vJ0xbXQ6fHIylsQygy4a7tnOgDTeh7j
 3wwbokxhFORiE4DzzLw09Ijat/XsD0IG6EiIB1SftuR3nYpDJ7bb7zYVNXHIT2H/Pkb3w41
 WxvxlbGGfIIxtXgYpxoWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0CO+NQne0DE=:tx/lHQcp6Q8AxeaRiSwVCs
 kImrmMm6cd4IosJ41rd17sAiyjlzPC1wi1jzbQdrLQTjTLFxPr5fq/qIy5QTpK0PPMDiuJ+W+
 KccOnZ6JvP7LlcFs4tC2RagAlEloRty8jsf9i/q2QSJNjiLKmEk4/WeVmodVqtvb+++MLvbBL
 f12DwYZG/hiCzwkNBP7sO7dqTGz0sQ20qUfTesCTQqwLUwxg7v9q7m2GF9z0b6arzvOZYpnX0
 phRmuBOdrW5ToCLKgbl+UzRqmlWxjI2OZj4Dncavywn12PrlJOX4IbW3vYGBugcb+XsRgNFc3
 2R3hgWyQrhbZf/jiv4RwoKsWHlgypPE2Pdl+Bl9QNUSFRO+DztuVRMALif+gpqdetpg/d12BG
 OKo70w+3vlj/dR/dxR92ujNHqCS42mXXA9ItyHDbZJed3/EKMNZaac9dSFyEZMJQagSGbUR5k
 5+Od+cBZ6kEMptcCNJnQVkQGNWCWQ2fuhMRw9HkJYM8wB7kOjueI8AJU/Xb3OKEkHclvLA9GL
 MgWz86gl2mM1PAEmFNu3pyPRQLmdixoY7+HXgk2EGkly0pfHFh4Dc2DN2YX5zwMn/+yUgC9E1
 SAA+huNqwiGCG9F+y9K5WmEGCuHmhM2EJrGYftOYRmFl1r8nVdW4cHH/yZweUyoWCm7e/AING
 XTexu1lpfTxBZfnMihul694X3Lmn9eIfSPDLvBfPFKQ/Ubd7Tc73FAjAAP9EGPr/z/DxAnP+R
 MDZmRnKWSBSAvxPHL2INhIBXEpcdMtn3hRIDB1hk+uYfPzQyeffjd+KE6WIQcYLWJ8HqUFozv
 GK6QEloHWTHoffNx7B8TDpf3kDIpJWGQRdKRy0oDutX5oaxNxM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 15 Nov 2017, Phillip Wood wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 6d027b06c8d8dc69b14d05752637a65aa121ab24..8c10442b84068d3fb7ec809ef1faa0203cb83e60 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -438,7 +438,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	char **xopt;
>  	static struct lock_file index_lock;
>  
> -	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
> +	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR))

If you test the return value for *negative* values, I am fully on board
with the change.

As far as I understand the code, hold_locked_index() returns -1 on error,
but *a file descriptor* (which is usually not 0) upon success...

Ciao,
Dscho
