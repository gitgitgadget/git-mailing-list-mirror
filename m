Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7F01F462
	for <e@80x24.org>; Fri, 31 May 2019 11:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaLlr (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 07:41:47 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:37415 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaLlr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 07:41:47 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 07:41:45 EDT
Received: from smtp6.infomaniak.ch (smtp6.infomaniak.ch [83.166.132.19])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x4VBVPiW029173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 31 May 2019 13:31:26 +0200
Received: from [IPv6:2a01:cb00:807:e500:fab5:24b3:6e93:219] (2a01cb000807e500fab524b36e930219.ipv6.abo.wanadoo.fr [IPv6:2a01:cb00:807:e500:fab5:24b3:6e93:219])
        (authenticated bits=0)
        by smtp6.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x4VBVPCs006459
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 31 May 2019 13:31:25 +0200
To:     git@vger.kernel.org
From:   David <courrier@david-kremer.fr>
Subject: Severe Regression in Git 1.21.0 -- not receiving any data
Message-ID: <04a82e31-2292-ef73-98c5-b9a5ff28e000@david-kremer.fr>
Date:   Fri, 31 May 2019 13:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr-classic
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Summary

I was trying to clone the AOSP source tree (Android Open Source Project) 
and I finally was able to formally identify what seems to be a severe 
regression (one that is blocking usage) in the last version of git (2.21.0).

# Steps to reproduce

The AOSP projects recommend to use ubuntu 14.04 as its build platform. 
The git version for this distro is :

```
root@eb57f366840e:/android# git --version
git version 1.9.1
```

In a docker image for this OS, I am able to execute:

```
root@eb57f366840e:~# git clone 
https://android.googlesource.com/platform/manifest
Cloning into 'manifest'...
remote: Sending approximately 39.94 MiB ...
remote: Counting objects: 852, done
remote: Finding sources: 100% (27/27)
remote: Total 16017 (delta 4968), reused 16017 (delta 4968)
Receiving objects: 100% (16017/16017), 39.65 MiB | 9.04 MiB/s, done.
Resolving deltas: 100% (4968/4968), done.
Checking connectivity... done.
```

Now, on my local Archlinux Box, the git version is 2.21.0 (latest).

The same command:

```

git clone https://android.googlesource.com/platform/manifest
```

Is launching a single thread that uses 100% of one CPU core FOREVER, 
until a timeout arises after like 40 minutes (the remote hung up 
unexpectedly). Someone on the #git channel (irc.freenode.net) was able 
to reproduce the exact same behaviour.

I must add that this of course arises only with the repo I mention in 
this email (github repositories are just fine). So probably a mismatch 
in protocol between git server/client ? Anyways, I'm far from having the 
skills to fix that thing.

I hope this report is useful, and in any case, I would like to know 
about the possible outcomes of this report.

I would be actually very surprised if someone did not notice that 
before, given that the latest git version is from february, but I can 
try anyway :)

Cheers,

David

