Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C3F1F51C
	for <e@80x24.org>; Mon, 21 May 2018 14:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeEUOaD (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:30:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:56887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbeEUOaC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:30:02 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8laO-1fWuMW3On6-00C9o6; Mon, 21
 May 2018 16:30:00 +0200
Date:   Mon, 21 May 2018 16:30:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] merge-recursive: rename conflict_rename_*() family
 of functions
In-Reply-To: <20180519020700.2241-5-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211629450.77@tvgsbejvaqbjf.bet>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-5-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Lfq0ohFejjF5XaXWh2Hs+7iEN1j5X1g1ZZW9h1UlOrP/+WdL14m
 7IJkzse+ViMzvIaiRfazzUZeHliszW9O/aosA/1yGSahxmyy9SBTkyYG+t4A+RyFFQUOJWj
 d9F82SEYHALYKqJ/e98XKarxKDZEforYdKJ0UbwpTRh4ogAt+TIxg6/a6/aV47pMjMz9grz
 tUfWPnY7WdSQEKjw4I6dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fi1FF6uCOG4=:FFnWdmoIY6yYowVaL1Lxwf
 b0ARG7ZTi436/wqmsPN5y96ySpet1AHWRCm7GQfvNHdf6J4AdaD2gohcilPPfbY65OXYA5exb
 nQv8yuX3TGnq1gs2K2YjPZnhsmR9LZpv6lQE0x9JC9//7fJLJHyziUz+AgKgCw1/MASPyhxSD
 lXoXB6cRzzrl6rpJfGyesZRNp3UVZNuipX/tmO8lmtaiJbOXLFRlHugHN5sgaYAcBJUdB6NHT
 UzIisRlt3hp9gwpji/ZsSA0d31W7wHtMP5I7W32gKnBeC45E7s3cL66YGAu+LUpjRZ56YIIWv
 f8VqS3/GBkuWTyJj2T8KQGnyRHoErI21jzjaiWjIMctDZ24CU0TuOxVRA+srWS3YW04nqOQHc
 OQylevcQTAb9edit+212lKh2yz/4ZU8cO1YjcJxEPF05M6KxQQeON3EV4QN76+Kb56g/QxQc9
 3j2XJGWc2e6V+givgGFgqEjn+tq4DwC3r9eJjszcQwW0dIlTXyoeYRzz1AIckrd1TVpX2QQw+
 0Ki0r8T3UNosx8ER73nBcIywKTcfhfGaE7dKtnyTQEU1blKOSFYY+tk4D24CLh18bErZtjlzj
 qNFI0xu/lAFB0ylZyL73gKjAbKFdjvsMZE8vfEex+fK4QnwJjPHjuy1Hc/klD1LuFqB/cpik1
 F14A2Fu7iWZwNAkAxtIFZbehGIMHaoya8pnqZEJD+rk5AnCrt7FrCuvxsRylpnsoSscDpcxzi
 6JqcQeH6Y/ajLp+PRQe/bb/gCidOHNFdDqFrfHxAiyF1pL7mYv1zp1URNX0g+OTfA9muUDPIl
 Z0gwDcX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,


On Fri, 18 May 2018, Elijah Newren wrote:

> These functions were added because processing of these conflicts needed
> to be deferred until process_entry() in order to get D/F conflicts and
> such right.  The number of these has grown over time, and now include
> some whose name is misleading:
>   * conflict_rename_normal() is for handling normal file renames; a
>     typical rename may need content merging, but we expect conflicts
>     from that to be more the exception than the rule.
>   * conflict_rename_via_dir() will not be a conflict; it was just an
>     add that turned into a move due to directory rename detection.
>     (If there was a file in the way of the move, that would have been
>     detected and reported earlier.)
>   * conflict_rename_rename_2to1 and conflict_rename_add (the latter
>     of which doesn't exist yet but has been submitted before and I
>     intend to resend) technically might not be conflicts if the
>     colliding paths happen to match exactly.
> Rename this family of functions to handle_rename_*().
> 
> Also rename handle_renames() to detect_and_process_renames() both to make
> it clearer what it does, and to differentiate it as a pre-processing step
> from all the handle_rename_*() functions which are called from
> process_entry().
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Makes sense, and the patch looks obviously correct to me.

Thanks,
Dscho
