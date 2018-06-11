Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032671F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933194AbeFKU5I (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:57:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:48309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbeFKU5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:57:07 -0400
Received: from localhost ([188.192.2.98]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPppG-1fNXve40Ti-0053UX; Mon, 11
 Jun 2018 22:57:05 +0200
Date:   Mon, 11 Jun 2018 22:57:04 +0200
From:   Clemens Buchacher <drizzd@gmx.net>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] checkout files in-place
Message-ID: <20180611205704.GA1399@Sonnenschein.localdomain>
References: <20180610194444.GA1913@Sonnenschein.localdomain>
 <20180611203541.GA6@606faba9ba17>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611203541.GA6@606faba9ba17>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K1:wqW8P0RCWAQRw8uR0/Sm7GETB8eFTABhClcpOw7xf4PVAAT5ERz
 1Q9k2CNIdDwgU3lCLHSY11aHzZ8f6IMr+HEgGrm1ROxVZpfVeyJsGLWvwm/anvoYYRz1FRA
 8uD/A9wliJiaOaYqpVylA3EhC3RlSIz6cgnoyApKV8l66DsRi1UV2UNvVT6N/NB5PgjbAgp
 FUL/M94QBcwCY4uYbKzRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EJG98zdazNM=:WqDAnVSv2/dePkkPjN0MN+
 dMPBzzJHKtnpmyWTkH0DotiuUyCY8n6vgZWQr6rPGVATRL7sELNYU6kk5+YyQpGz5xxx/sOQB
 6c0F187PHdCo0J/L5+RcWzt0CqqhfaKEtHFlBNmQMsCTv7J3JkKzlWqfDHsMbYERms+bfaAnF
 DenNmuXXvHX0cA2Ovze1u7APU8uy/KoJ05tS6W9672Oo3IQwLB6ub3OI/dxQXCEAYdPvpUDmm
 cbTzZ6ebFgnH4qJ2bcBPj6oSJcaaJzktZGHusenD8EwSOGwBxqcLiQAWg6PliXu/aQa7xFi8W
 IFIAYVePhnmb3tgH8eRMRrarKGeuXlGL9zaAaqsVEfuE87jXouvIPs6qO3oH9mlI+rCqVGBHD
 FYzbN2YXtZcd+x6efHp8NEYpnzd2r22rEMOuOYY8kFb+F66f852KXZYB8wCOt0kFsrQTP0yj/
 OtwLNElBprnHNuwTflSfzsikrxYvaHgRFSkLGKppvf7EPyXywRyku/+nk2slYbimhchoTABRu
 hlcom3gZ5TlVG0YWvsNOGywosBx5Rn3z67Z6AqKzlZLw70leMQNiRx3BZj8wzwihIIkJFqG+E
 kDrzG1xYjRpwf67sy+xDHsVs8JpFa2xSQOvhS2ulMR3w1SBC5CMseMzC7OaKJs7CH0bS0noN3
 ZquoVOa7CBwh/6BX2YAQ+LjYkc5i4F5vL4jmsap9GXlFFWVzwTbTfX8yLU2JPM6w6F+OCIhAJ
 1VcJkMv2W3ktvNSPjnAAKUebqsvzAPu9w+/LGN6hsicKCtZ08UCa8NalaRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc: Orgad Shaneh

On Mon, Jun 11, 2018 at 08:35:41PM +0000, Edward Thomson wrote:
> On Sun, Jun 10, 2018 at 09:44:45PM +0200, Clemens Buchacher wrote:
> > 
> > It is safe to do this on Linux file systems, even if open file handles
> > still exist, because unlink only removes the directory reference to the
> > file. On Windows, however, a file cannot be deleted until all handles to
> > it are closed. If a file cannot be deleted, its name cannot be reused.
> 
> I'm nervous about this proposed change, since it feels like it's
> addressing an issue that only exists in QT Creator.
> 
> You've accurately described the default semantics in Win32.  A file
> cannot be deleted until all handles to it are closed, unless it was
> opened with `FILE_SHARE_DELETE` as their sharing mode.  This is not the
> default sharing mode in either Win32 or .NET.
> 
> However, for your patch to have an effect, all processes with a handle
> open must have specified `FILE_SHARE_WRITE`.  This is rather uncommon,
> since it's also not included in the default Win32 or .NET sharing mode.
> This is because it's uncommon that you would want other processes to
> change the data underneath you in between ReadFile() calls.
> 
> So your patch will benefit people who have processes that have
> `FILE_SHARE_WRITE` set but not `FILE_SHARE_DELETE` set, which I think is
> generally an uncommon scenario to want to support.
> 
> Generally if you're willing to accept files changing underneath you,
> then you probably want to allow them to be deleted, too.  So this feels
> like something that's very specific to QT Creator.  Or are there other
> IDEs or development tools that use these open semantics that I'm not
> aware of?

I am also not aware of other IDEs which have this issue.

Orgad, you also mentioned FILE_SHARE_DELETE here [*1*]. Does the Qt
Creator issue persist despite this flag? You also just commented on
Github that "Regarding Qt Creator, the issue should be mostly solved by
now in 4.7". So a fix in Git is no longer needed?

[*1*] https://github.com/git-for-windows/git/pull/1666
