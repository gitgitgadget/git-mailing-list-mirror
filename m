Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A67DC433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF37206D8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GpD25KHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgG1PTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:19:31 -0400
Received: from mout.web.de ([212.227.15.3]:50559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgG1PTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595949566;
        bh=EdjBpbhOh742v2dkud7qOzDEWxU9dXRL/WijgHFIe0g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GpD25KHZGEtLGYmqnBbqfg6tVxOWxnzPd3dXJqWS5h5AVjUSn436ZMIzyvf5z6Qu9
         2P5Z7Ezt+p9eY+lb0pWypbdlhy3fgTfudZm4xcgrt+FZvxfXw+5++Bn/VxuEJCH008
         xCqDtYmWlIEwPRxl4uo9MhKBdd5WQx7M7WUAecN0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lnmpz-1kiKZt2p3f-00hsnt; Tue, 28
 Jul 2020 17:19:26 +0200
Subject: Re: [PATCH 3/6] commit-graph: consolidate fill_commit_graph_info
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <701f5912369c0fcc07cf604c3129cb5017a125ce.1595927632.git.gitgitgadget@gmail.com>
 <a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d4a613c1-f3e8-3789-2548-8344c4b976e9@web.de>
Date:   Tue, 28 Jul 2020 17:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ai8Ynhq+NqQCsNUhUX7O4TCkYgtrIjpSBQTCXxLuw/C40fDc9M
 Kjz/yaYrSdNAMPaNYrto9s6Ts0WSaZjMumntqdEpHD1Nc9mbhyT4fSeTgv+dRQgagZeXGyF
 7wHOzz16aQOxLE4PQT/xnQ5y9+Rp69qLDORvvI7w2OJuq5OHT51lOHaVZvpzZIbiKvSVHi/
 XyKGkc/BszMWkM4SmJhrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k1lviylg1DM=:Q0r04YSdrRC2fEu/SOnB0k
 8YMe0EPLdfeyvfazp/VVw0drrTrFWqAkyqPVZx3AIimCNqguVKfvO+1zbPTMK8JaL63XpbglX
 lfobPLTfU4v3t+WP+GMvyd6xNENKUAlvem7FYItvKKbdaNsVv6qpb4y6ObOuuNealhrBLpVTe
 bzNYCKS+9wV2hDIz75Xsi8QjHju9HmSVtwrLTQdb1putID/GmZvdRR86WlFl2DY45GDxYGXVb
 iHM+x6mxmrZFbdM7c44YyCz6bDjopA1ajJn6lD5XWDG61yv2Sgk/hLyGkDtEq7JDjD1j1vS/6
 MECITuEbeoWgaV1OI0WyXODIJVLI2kWk6nx/U+LUmWxuwOYGHxHScoLrOll2R6ZPWyuGum1QK
 x7FIKfj5xKFudToKHnvrhhXawVbiv2yfNFl6CS3mOg1spnIlBoHpoPdmm6rgZTsg4BTgk63Cs
 VvzMdpFRJseW94mDube5y2q7ltC7oSQF1APjz+JZAbwAjihkj/i818Wxg0LjAQ8IlHbL88Hdq
 1QZv4w4NDLBzLv53yEaPc0OQwG52dh+pl1P1gHV7iVFpGzl6OuHH/7JIMiP4BeDJFMoUA4Y9u
 BREGThoDviKJek4YfYkILL98KvfKcvE7A3/8prh4Y1j2uVFF0TKHIuYuCubsd0jb/ufXDYbdG
 cxnRrbnoG1yBKujxjTJyOdS7k7yICBqhl7Z4/JeKAAv2Fq1O53iDcWOCWqpzbegOmY2F0gcTt
 cUK9VK+HgsKakjIcSZxUhNzELIQzWFtuh5yMv0xD9ubaRBHnIxORrRT92GcLc9miizzYY/q6/
 2D88wsNzZjNYValBskhwekf+k6M5y04lnKCotyxf30Ml/w04gU1ZTm//BLdAZijjfNW0V7e+w
 liEZP7YKhLut16PbYOD3HlwAxP307jU3uW/YqxdXnzYowJBK0Vhu6flKMCj10AfIxdU/csPnp
 cDQ5T1gggv7yEyMDYWs21eEU9h1uVQIw673BE0IoMrbB9svd5LPYAV+6aY1e+oNsML6sawXAa
 pOoEpxPp/bndfyHuRZ38ySDtB49bIhFLc/ntVGWm00NSy2fP1IqauZfd4C72ghx81vThDkKGy
 9t2KQXC81lT+y/e8bM2iKqI5am3Ve+X9O0DrzsBevrhWNzQ8g8s8xjW+XqgAweefcPFISVNJT
 fz85BxAxBU5ALROWSWKVHqDRg+bZKrrbPZkU5gG9hsx86obEDnpqDpAqUFhdkthaHKUa5rk3I
 X9gWmVBPPq+HXryLZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Had to remove stolee@gmail.com because with it my mail provider
 rejected this email with the following error message:

   Requested action not taken: mailbox unavailable
   invalid DNS MX or A/AAAA resource record.]

Am 28.07.20 um 15:14 schrieb Derrick Stolee:
> On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>
>> Both fill_commit_graph_info() and fill_commit_in_graph() parse
>> information present in commit data chunk. Let's simplify the
>> implementation by calling fill_commit_graph_info() within
>> fill_commit_in_graph().
>>
>> The test 'generate tar with future mtime' creates a commit with commit
>> time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows int=
o
>> generation number and has undefined behavior. The test used to pass as
>> fill_commit_in_graph() did not read commit time from commit graph,
>> reading commit date from odb instead.
>
> I was first confused as to why fill_commit_graph_info() did not
> load the timestamp, but the reason is that it is only used by
> two methods:
>
> 1. fill_commit_in_graph(): this actually leaves the commit in a
>    "parsed" state, so the date must be correct. Thus, it parses
>    the date out of the commit-graph.
>
> 2. load_commit_graph_info(): this only helps to guarantee we
>    know the graph_pos and generation number values.
>
> Perhaps add this extra context: you will _need_ the commit date
> from the commit-graph in order to populate the generation number
> v2 in fill_commit_graph_info().
>
>> Let's fix that by setting commit time of (2 ^ 34 - 1) seconds.
>
> The timestamp limit placed in the commit-graph is more restrictive
> than 64-bit timestamps, but as your test points out, the maximum
> timestamp allowed takes place in the year 2514. That is far enough
> away for all real data.

We all may feel like the end of the world is imminent, but do we really
need to set such an arbitrary limit?  OK, that limit was already set two
years ago, and I'm really late.  But still: It's sad to see anything
else than signed 64-bit timestamps to be used in fresh code (after Y2K).
The extra four bytes would fatten up the structures less than the
transition from SHA-1 to SHA-256 will, and no bit twiddling would be
required.  *sigh*

Ren=C3=A9
