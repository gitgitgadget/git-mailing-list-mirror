Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB074ECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245573AbiHZHpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245574AbiHZHpm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:45:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887B6744E
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:45:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so1110204edd.4
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=Tk0T1LcyGJbetwp6QmgEHB/j5fYQeWZKm0b6WvSzZbo=;
        b=E3DFOAt47mgvgVyQGOAY4/JabFHYqSmy8bmSQs49Jf5k5m68ARWKnqAXR9vBRJbxul
         jmx+CQ59bgSUsdxSrXSEJW2TfZAdORj6ZPuN8VIvQZyM+lII0O7SKiVlV468B1Bb3IR4
         LamMEa445wB0iknNyA81kokz3oknM02eXLvkg/oDwajJUowvAxs4w1gg2auG+i0VqFBS
         KY5JcZog6VEaIcVZVc5qBayeQULp9jjWjTRuykhdv3KSEIbdsnk6FN2Wf68f2dBP0zuz
         tZTytXZtgdT73bIodm9QWB+4BF3qKbQ742zKoasWy2/Y5YrrSKtILtqAmsuROk8HswFA
         4K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Tk0T1LcyGJbetwp6QmgEHB/j5fYQeWZKm0b6WvSzZbo=;
        b=GM+EqP8tzVQ8nZ9Fu4/TFeukj1VUI5Di5NB5hbfLT3rQajRxU5LVK0n20efgbRWgcH
         +M1kO6iC4njM6j02wzJ1mP/7EYmxGwNcVDf3O9Vo6BC+975JUwUgTFmtqZL2TfPOKIOl
         GMfLDeT9KOsgW6kD4Jg0nuECUJNJTxkA8KMFnAasmhbolstZ0NgkW3FcPKB8vTftsVJb
         XOcHcj+0rs8XLps4LkKhPEvxLtguNefE+J/izE2TVC6XhS9pmNpZwYQPGOHpwyoT4as9
         rp1upcJbZWpIp+Y2oz7wBVMaxpU2DOuDu7xrP+l7qzdcHx5pgRCQrS1zzMCbLeZEFVhb
         JZRQ==
X-Gm-Message-State: ACgBeo0jL1pqQjxrsdF6HvqJRNEgi/z3jU0wDjU9YDdRswBU0orbZKx8
        XYI/bm92O6sUX/R+q9GyzKcVBTNno+EjIcG/5jHv0+xzMXZmRQ==
X-Google-Smtp-Source: AA6agR4xcR+UPXs8QCcc6/iFbCAk5gISXV9SMDQPlZF63Y2A/psmxug+/UZCWVBUeq6BfNHC2H1ublnOxvTLlkVNvzU=
X-Received: by 2002:a50:fc17:0:b0:446:861b:ee10 with SMTP id
 i23-20020a50fc17000000b00446861bee10mr6137213edr.251.1661499938559; Fri, 26
 Aug 2022 00:45:38 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>
Date:   Fri, 26 Aug 2022 15:45:25 +0800
Message-ID: <CADmGLV2sAaq2PHJoiBAasmimXvBwO9jU-6iWhKhiKAnnecg8mQ@mail.gmail.com>
Subject: git gc memory usage
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a question about git gc memory usage=E3=80=82

I execute git gc in a git repository, in the information below top,
we can see it uses res 1.5g, Why does it use so much res.
We all know that res does not contain cache. I think git gc should use
cache more.

top - 15:08:50 up 6 days, 23:22,  0 users,  load average: 2.11, 2.69, 2.80
Tasks:   8 total,   2 running,   6 sleeping,   0 stopped,   0 zombie
%Cpu(s): 18.9 us,  3.4 sy,  0.0 ni, 74.2 id,  2.7 wa,  0.0 hi,  0.8 si,  0.=
0 st
MiB Mem :  31346.3 total,   1760.7 free,  23487.9 used,   6097.8 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   5312.7 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
COMMAND
    288 root      20   0 2274.2m   1.5g   1.0g R  74.7   4.7   0:14.40
git
      1 root      20   0    2.5m   0.1m   0.0m S   0.0   0.0   0:00.01
sh
      6 root      20   0 1895.3m  46.5m   9.8m S   0.0   0.1   0:03.88
bin
    270 root      20   0    4.1m   3.4m   2.8m S   0.0   0.0   0:00.01
bash
    278 root      20   0    4.1m   3.4m   2.9m S   0.0   0.0   0:00.00
bash
    283 root      20   0    6.9m   3.1m   2.6m R   0.0   0.0   0:00.00
top
    284 root      20   0    6.6m   3.6m   3.3m S   0.0   0.0   0:00.00
git
    287 root      20   0    6.6m   3.6m   3.3m S   0.0   0.0   0:00.00 git

I am using git service in docker container(memory limit is 1.5g)
The following is the memory usage in the container before and after
executing git gc.
From the stat information, the cache is indeed used.
This confuses me why res uses 1.5g in top.

before:
# cat memory.usage_in_bytes
62099456

#cat memory.stat
cache 22167552
rss 39739392
rss_huge 0
shmem 0
mapped_file 8921088
dirty 0
writeback 0
swap 0
workingset_refault_anon 0
workingset_refault_file 23384064
workingset_activate_anon 0
workingset_activate_file 675840
workingset_restore_anon 0
workingset_restore_file 135168
workingset_nodereclaim 0
pgpgin 55803
pgpgout 40624
pgfault 58542
pgmajfault 396
inactive_anon 39739392
active_anon 0
inactive_file 15781888
active_file 6529024
unevictable 0
hierarchical_memory_limit 1610612736
hierarchical_memsw_limit 1610612736
total_cache 22167552
total_rss 39739392
total_rss_huge 0
total_shmem 0
total_mapped_file 8921088
total_dirty 0
total_writeback 0
total_swap 0
total_workingset_refault_anon 0
total_workingset_refault_file 23384064
total_workingset_activate_anon 0
total_workingset_activate_file 675840
total_workingset_restore_anon 0
total_workingset_restore_file 135168
total_workingset_nodereclaim 0
total_pgpgin 55803
total_pgpgout 40624
total_pgfault 58542
total_pgmajfault 396
total_inactive_anon 39739392
total_active_anon 0
total_inactive_file 15781888
total_active_file 6529024
total_unevictable 0


after:
cat memory.usage_in_bytes
1610506240

# cat memory.stat
cache 1391554560
rss 218566656
rss_huge 0
shmem 0
mapped_file 917385216
dirty 135168
writeback 270336
swap 0
workingset_refault_anon 0
workingset_refault_file 1296396288
workingset_activate_anon 0
workingset_activate_file 57040896
workingset_restore_anon 0
workingset_restore_file 135168
workingset_nodereclaim 0
pgpgin 2551098
pgpgout 2157961
pgfault 1536942
pgmajfault 627
inactive_anon 218431488
active_anon 135168
inactive_file 979427328
active_file 412348416
unevictable 0
hierarchical_memory_limit 1610612736
hierarchical_memsw_limit 1610612736
total_cache 1391554560
total_rss 218566656
total_rss_huge 0
total_shmem 0
total_mapped_file 917385216
total_dirty 135168
total_writeback 270336
total_swap 0
total_workingset_refault_anon 0
total_workingset_refault_file 1296396288
total_workingset_activate_anon 0
total_workingset_activate_file 57040896
total_workingset_restore_anon 0
total_workingset_restore_file 135168
total_workingset_nodereclaim 0
total_pgpgin 2551098
total_pgpgout 2157961
total_pgfault 1536942
total_pgmajfault 627
total_inactive_anon 218431488
total_active_anon 135168
total_inactive_file 979427328
total_active_file 412348416
total_unevictable 0

Looking forward to your reply, Thanks very much!
