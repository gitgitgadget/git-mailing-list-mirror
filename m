Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936C01F770
	for <e@80x24.org>; Mon, 31 Dec 2018 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeLaMba convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 31 Dec 2018 07:31:30 -0500
Received: from smtp.msys.ch ([46.175.8.2]:34944 "EHLO sleipnir.msys.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeLaMba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 07:31:30 -0500
Received: from mail.msys.ch (smtp.msys.ch [46.175.8.2])
        by sleipnir.msys.ch (8.14.3/8.14.3) with ESMTP id wBVEJqRI018379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 31 Dec 2018 14:19:52 GMT
Received: from dev.arcapos.ch (dev.arcapos.ch [46.175.8.141])
        (authenticated bits=0)
        by mail.msys.ch (8.14.3/8.14.3) with ESMTP id wBVEJpMx025751
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 31 Dec 2018 14:19:51 GMT
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Marc Balmer <marc@msys.ch>
In-Reply-To: <CACsJy8C8DVz7u7z01Q3T_vY+DY-StwCQLhkhDJ6XK5C2z0agLA@mail.gmail.com>
Date:   Mon, 31 Dec 2018 13:31:21 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DE854533-FC7C-4DD4-8F42-C02C4D4524CB@msys.ch>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
 <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
 <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
 <CACsJy8C8DVz7u7z01Q3T_vY+DY-StwCQLhkhDJ6XK5C2z0agLA@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-SMTP-Vilter-Version: 1.3.6
X-Spamd-Symbols: BAYES_00,RCVD_IN_DNSWL_LOW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> Am 31.12.2018 um 12:36 schrieb Duy Nguyen <pclouds@gmail.com>:
> 
> On Mon, Dec 31, 2018 at 6:24 PM Marc Balmer <marc@msys.ch> wrote:
>> In a (private) Email to me, he indicated that had no time for a fix.  Maybe he can speak up here?
> 
> Well, I guess Junio will revert when he's back after the holidays
> then. Meanwhile..
> 
>> In any case, if I can help testing, I am in.  I just don't know the inner workings of git-subtree.sh (I am a mere user of it...)
> 
> If the repo you're facing the problem is publicly available, that
> would be great so some of us could try reproduce.

Unfortunately it is not.

> 
> Otherwise we'll need your help to track this problem down. in
> git-subtree script line 640 (or somewhere close)
> 
>    progress "$revcount/$revmax ($createcount) [$extracount]"
> 
> could you update it to show $parents and $rev as well, e.g.
> 
>    progress "$revcount/$revmax ($createcount) [$extracount] ($parents) ($rev)"

I did add this, plus changed progress to output a linefeed, and now just before the crash, the output looks like this:

436/627 (2013) [1649] (6e54a90a29e4e01fa2d6a42c232e02e08e912b2d) (2ca7b24e731ff91c94c9abf214686cb29cdc367e)
436/627 (2014) [1650] (1ef866e5a18012e80eed36315deb932c2b66d34a) (6e54a90a29e4e01fa2d6a42c232e02e08e912b2d)
436/627 (2015) [1651] (c8585f441548dd43f113a96ba48f6fa70363d388) (1ef866e5a18012e80eed36315deb932c2b66d34a)
436/627 (2016) [1652] (663bb110a58decfe889cf7c6b766f1d0c032ba39) (c8585f441548dd43f113a96ba48f6fa70363d388)
436/627 (2017) [1653] (edbdd28e009e52c8001bb54e53a56b059167e07d) (663bb110a58decfe889cf7c6b766f1d0c032ba39)
436/627 (2018) [1654] (c47739713912ae6e94714b9a1a6732407b236932) (edbdd28e009e52c8001bb54e53a56b059167e07d)
436/627 (2019) [1655] (d444823b97d9a8e53c4e721a44e4c49619d0b372) (c47739713912ae6e94714b9a1a6732407b236932)
436/627 (2020) [1656] (15a7ccecb2ca8bc47c77a997f8c74e7ac3b13325) (d444823b97d9a8e53c4e721a44e4c49619d0b372)
436/627 (2021) [1657] (b9bc5c9b33b100b57e23626ff422dac73f94384e) (15a7ccecb2ca8bc47c77a997f8c74e7ac3b13325)
436/627 (2022) [1658] (eec0f28c6fe5f7d664c41a913883d64cdf53c111) (b9bc5c9b33b100b57e23626ff422dac73f94384e)
436/627 (2023) [1659] (e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94) (eec0f28c6fe5f7d664c41a913883d64cdf53c111)
436/627 (2024) [1660] (27b96988847caf3bfd71df2d7f58cbe6ba78208a) (e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94)
436/627 (2025) [1661] (11e5861e50f88237ce362b6c7531e4e90bac86ac) (27b96988847caf3bfd71df2d7f58cbe6ba78208a)
/usr/libexec/git-core/git-subtree: line 751: 122202 Done                    eval "$grl"
     122203 Segmentation fault      (core dumped) | while read rev parents; do
    process_split_commit "$rev" "$parents" 0;
done


> 
> Then please run these commands and post the output here
> 
>    git rev-parse <that-rev>^@

Did that with the last three lines:

$ git rev-parse 27b96988847caf3bfd71df2d7f58cbe6ba78208a^@
11e5861e50f88237ce362b6c7531e4e90bac86ac
$ git rev-parse e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94^@
27b96988847caf3bfd71df2d7f58cbe6ba78208a
$ git rev-parse eec0f28c6fe5f7d664c41a913883d64cdf53c111^@
e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94

> 
> and
> 
>    git show -s --pretty=%P <that-rev>

$ git show -s --pretty=%P 27b96988847caf3bfd71df2d7f58cbe6ba78208a
11e5861e50f88237ce362b6c7531e4e90bac86ac
$ git show -s --pretty=%P e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94
27b96988847caf3bfd71df2d7f58cbe6ba78208a
$ git show -s --pretty=%P eec0f28c6fe5f7d664c41a913883d64cdf53c111
e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94

> 
> where <that-rev> is $rev from the last few progress lines before bash crashes.
> -- 
> Duy

