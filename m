Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF392022D
	for <e@80x24.org>; Sat, 25 Feb 2017 10:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbdBYKNY (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 05:13:24 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:51878 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdBYKNX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 05:13:23 -0500
Received: from [192.168.1.84] ([188.107.90.21]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LhGKW-1bvKHv1co4-00maov for <git@vger.kernel.org>; Sat, 25 Feb 2017 11:13:19
 +0100
To:     git@vger.kernel.org
From:   Carsten Fuchs <carsten.fuchs@cafu.de>
Subject: git status --> Out of memory, realloc failed
Message-ID: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
Date:   Sat, 25 Feb 2017 11:13:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:UoD9JhEYun7Zss6E4vNDfR2t25oPY9mawg5MJKyIC37I3Z7oW9N
 aHTd6lj0L3LNDepfdW/MBBYmCyjL0yL/8dJDdPqATs5E9qoJpzOsW5PYj0IwEGPGAPcRJ+G
 y7FKG5VLfZGqnblsxKQ4miIu7FPf/+xGbCY/r4PGdE1HyQYjI/Pqlun9vg/8rdi3rsx31Ys
 pCZrG4qcevytDsPdFo36g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q7DVlT4BukU=:2mvi8d30uJzbl39GKgr/2N
 cxr94x7cCRNe8ppiL1ui7vjPVwba5rCCcMdPN3Gu51cgZi6oJNWms5oYHRQRLp0Wjalf1Pxal
 MwVAqaVkzwxYqAGnrLimz4Yt/RwwvP2+j34gmUeYvQyX6FLvYvHdZOVGHTZkGEXh+tQ6n41Lx
 FQr7oT4Oo0LmLihqgzwyDw/00icmU3EGR2Cu7AlBqXMPo/JJhiFljOPX8uyfFR+sX547XiDk2
 XLGHF4JuAVW1r+SMdSL4vd6lVJUj6JDk996MScoCMj5VW/54smtHQrxXC2nYVBmq+PYttJXsu
 4qFTno/KZ5ngG46bmpJT9DU0ypagIMQqJkr35v10OtUHSRT9eUPOIqVPsAHCmFbHIglgSdHLh
 zDcwE0VjZStNiAmzNvl38uIRiTqtS3Ur5/Vw/pkKxhPVfs6LYXP0fZ2PfUjmNZoAQpNYjwwBZ
 cnC+T+RTwV+UQ9MvmmUWxrmeENpXcLn/OedOb65zS3Cds8xukJ/N0iSY7fpyB0Gd/RUY2pSLx
 8oAQWwvpWRJedtgDB3Vhd33bh9a5YAtd02wEHeXtJDZlhdK988u+MEYrsQPys/T93cJmuDPER
 o84R0MQbcd0qQQz/+nPHQmlr0TBsJNxWCbSuJEP0WT+d/eKL8+NknPoUYFdwI+9CUxr2oA9On
 uRB/R0tECnEgpfiEjeAKxHTUfaaiPrhGQW2BxdG2Mrqa5gCsSxBN10sIojGhm5tSZ7qZO0y3p
 pQDlG5jtnFkjUt3C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git group,

I use Git at a web hosting service, where my user account has a memory 
limit of 768 MB:

(uiserver):p7715773:~$ uname -a
Linux infongp-de15 3.14.0-ui16322-uiabi1-infong-amd64 #1 SMP Debian 
3.14.79-2~ui80+4 (2016-11-17) x86_64 GNU/Linux

(uiserver):p7715773:~$ git --version
git version 2.1.4

The problem is that `git status` fails with an out of memory error:

(uiserver):p7715773:~/cafu$ git status
fatal: Out of memory, realloc failed
fatal: recursion detected in die handler

I talked to their support and their suggestion was to set a couple of 
memory constraints and to run `git gc`. This seemed to work well – but 
`git status` still fails:

(uiserver):p7715773:~/cafu$ cat ~/.gitconfig
[color]
     ui = auto
[user]
     name = Carsten Fuchs
     email = carsten.fuchs@cafu.de
[core]
     editor = nano
     pager = less -M -FRXS
     packedgitwindowsize = 30m
     packedgitlimit = 40m
[i18n]
     commitEncoding = ISO-8859-1
[pack]
     threads = 1
     windowMemory = 10m
     packSizeLimit = 20m
     deltaCacheSize = 30m

(uiserver):p7715773:~/cafu$ git gc
Zähle Objekte: 44293, Fertig.
Komprimiere Objekte: 100% (24534/24534), Fertig.
Schreibe Objekte: 100% (44293/44293), Fertig.
Total 44293 (delta 17560), reused 41828 (delta 16708)

(uiserver):p7715773:~/cafu$ git status
fatal: Out of memory, realloc failed
fatal: recursion detected in die handler

The repository is tracking about 19000 files which together take 260 MB.
The git server version is 2.7.4.1.g5468f9e (Bitbucket)

Well, their next response was that they have no solution for me – 
except, unsurprisingly, coaxing me into a more expensive hosting package.

I've read the Git man page about `git config`, but was not able to come 
up with anything to improve the situation.

Any ideas what I could do to reduce the memory consumption of `git status`?

Best regards,
Carsten

PS: Many thanks to Philip Oakley for initial advice at git-users, to 
which I should have properly subscribed in the first place, as the 
Google Groups interface seems to lose messages (mine at least, and 
inadvertently posts them as HTML) and gmane's NNTP interface reports 
that it is unidirectional/read-only.

