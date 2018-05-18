Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E601F51C
	for <e@80x24.org>; Fri, 18 May 2018 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeERXcp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 19:32:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:56845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeERXco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 19:32:44 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdHLB-1ebeQF3ebZ-00iPOt; Sat, 19
 May 2018 01:32:34 +0200
Date:   Sat, 19 May 2018 01:32:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] fix a segfault in get_main_ref_store()
In-Reply-To: <20180518222506.GA9527@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1805190132170.77@tvgsbejvaqbjf.bet>
References: <20180518222506.GA9527@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/+e1zZHvJzbSPsNkxwgGDFL6PXcR4CRPOPtmt2XPaJJopO64roV
 SSXqtHgywHYKi8fZcmV36o64HWtFEu3j0Vdxm+8fGmBGH7t3AVaDRIr8YMKVQrSbSJIyMct
 WIG89olPJEB62k5Fb676vEVmx8uL3SIJW1kKPRk5EAHG10qHTkFpvFd03kJfSm9MZVkRIhe
 CloPZ21yxKAEHWzBc4QeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CqdpnNhoaEM=:JViSLjPtNNZs8NngPX3o2p
 WTULxezDYDVjn/u6g0C8SPJliBal6BAdVO3INHZktnS/Qaqs309DkUWgTjShu+iIG/7g/VkFo
 GSqbczvikI70NFGa+doeDsOAquyDSw5cTi/yjvASerydb43JI3xUMFUtGkRDqa4sMXJH9J18s
 iJgTAZiEsOlYH8/VKzdiydIcsb2coUBgAwPEIi0mi4Xm3NRsKlCQncc0eO9iLPIQQHM0nre+j
 dvUHvbuqFwv4ACVsLtVhy4Ow1egSjNXsIyXT0jn7Jpn0GqlZX/Jq9Q88uiGX7IZT+ayHFV4nV
 5BRqaH3GZf3/6bO0vNI0BWh6igbZswVDWx2EtuxXP5r9QKs4wvWhvH0kPeHLHibdccwl5QjQG
 j1Scq65CeOk9ivJPUDYhVEVvc8IOjRPXettyxJDI7q8bZuTuOesCeScFtzUOj278pyP0jtEmP
 hbMCSReKSIAjMovMEcZ3XPOtjQ/98Q3pixcqvsrUxZ1IRce6wDIywPP7eYF45aUqI8i2ycp0m
 MQb+aEyt750eP/aYGbyCyZ5TzTahbQbypMmXE0vu7heLKcUU4JcxxsTtXU8bKjUm1BGCLs8x7
 0QcwXyWXtHsG337Y0hEV5ukNs381BqLvOHnJI8YC7w5Shk38IHF5Qvf3MBR9dddf+cyEynqCd
 rmL0DT/9azBY5PKmFVQk1h0pTU5bfev9lP2whsNm+gQamVBjCKYWJWsud6liDvxqY4w4R9VW/
 R+2Cz7BvxH1E3IMp+hJnUdlOtb81S3mt1nFDMYCuzfTIlZl4fHRrYQm2RuhxVtK/39y3Tg6Kp
 g4Tdwch
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 18 May 2018, Jeff King wrote:

> I stumbled across a BUG() today. But interestingly, in the current tip
> of master it actually segfaults instead! This fixes the segfault (back
> into a BUG(), and then fixes the caller to avoid the BUG() in the first
> place).
> 
>   [1/2]: get_main_ref_store: BUG() when outside a repository
>   [2/2]: config: die when --blob is used outside a repository
> 
>  builtin/config.c       | 3 +++
>  refs.c                 | 3 +++
>  t/t1307-config-blob.sh | 4 ++++
>  3 files changed, 10 insertions(+)

Both patches look obviously correct to me.

Thanks,
Dscho
