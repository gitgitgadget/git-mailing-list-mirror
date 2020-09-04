Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB8C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA995206B7
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH8wr3s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgIDOJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgIDOIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 10:08:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B256C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 07:08:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g3so4635496qtq.10
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SL/UkRVQIrYbWi6Tx7dElaF9dy+xP5HBIY4ql7pbvN4=;
        b=YH8wr3s/56JxzqGhUoAOaOEmObP8P0E2ItOtofcM8/gUxY5VwDbE4CeaawYUb3kiIv
         lud+mV5wmmKrpjuGxT58VsEz/XcC3jBlCDavtcRPduLW4P87Fw+SqMy8th7Z0bVOZJpr
         MBenHE22a4RdiNVNS93kZekV82B1rWru8WCBHqT+Sm36lBEsrTPKNrBPwXlSDWBSzXPy
         w91E4Fwi6eRyDkerEbg9DgFsJuyAHz2aJ8/aeU6EOToj1Vy8K1Qc7ZxXaLQmcU4oJQwT
         LUzZ6en4B0jOBpgz2UbfbuqQnNLQlffNeCOwNmR8d2pIpHeJuwXHYktfxMk3UxVyEmC+
         +xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SL/UkRVQIrYbWi6Tx7dElaF9dy+xP5HBIY4ql7pbvN4=;
        b=ivTPqWxGRtkNtBtUlTXo3a5lSszUUo80DnKouu1KQzERLELClnKAzLohQ+ftXGk57F
         BZyqM1tkiqcgGq2ykuYFT36rPztl201plt2U+S6IhwG8K+AM8mRvhabDikhxGcd/w5Nh
         5KcqwkKS/xXEmTVnPlaYe5AH6k7QF1U1VEVTWEdn9YmItYsU6BDvXc9V2r3XjxI+yfNV
         j/1hZRIUo/phCs2WgrMPo54kcVSf64AwrBiIDooadiZLu5UXM/xRWOntsvnR9oERmDlR
         0lRBFG+fXm7NcR7tuw5u2JVAfyi4jakKFvJKhSvTTtjOmRLTyyLpQcD86NrykyIOHO1f
         MvGg==
X-Gm-Message-State: AOAM530BJKMB0JPJM+G3JS4Dlv8BweCyZI9ozLFDHzIKbJUW1DGU2/rE
        nYAHILh7EdXX91RKNZQwWQOfi08m9nf8XC9Ma7/+KONG4jtUJQ==
X-Google-Smtp-Source: ABdhPJyDLjkWtVn9LgH62mp6IX95PAELoc2CyZ4byb7QHID+20qtLUrQN/2Y/MRFzjWdUU6HUt98ocwQxcumIjMcTuQ=
X-Received: by 2002:ac8:7003:: with SMTP id x3mr8519336qtm.206.1599228499433;
 Fri, 04 Sep 2020 07:08:19 -0700 (PDT)
MIME-Version: 1.0
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Fri, 4 Sep 2020 16:08:08 +0200
Message-ID: <CABLWAfQhWUSUS8p2XoGcNMUAp-vatD+-pDMngiJJW5qHG2CYCQ@mail.gmail.com>
Subject: possible segfault wint index threading
To:     newren@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 44c7e1a7e0 (mem-pool: use more standard initialization
and finalization, 2020-08-15) i get a SIGSEGV in a linux kernel clone
with several remotes added:

(gdb) set args "fetch" "stable"
(gdb) run
Starting program: /home/sbodo/usr/bin/git "fetch" "stable"
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff6927700 (LWP 14810)]

Thread 1 "git" received signal SIGSEGV, Segmentation fault.
mem_pool_init (pool=0x0, initial_size=initial_size@entry=7031819) at
mem-pool.c:40
40        memset(pool, 0, sizeof(*pool));
(gdb) bt
#0  mem_pool_init (pool=0x0, initial_size=initial_size@entry=7031819)
at mem-pool.c:40
#1  0x00005555556eb954 in load_cache_entries_threaded
(ieot=0x555555a9f440, nr_threads=<optimized out>, mmap_size=6375563,
mmap=0x7ffff6928000 "DIRC", istate=0x555555a981e0 <the_index>) at
read-cache.c:2109
#2  do_read_index (istate=istate@entry=0x555555a981e0 <the_index>,
path=path@entry=0x555555a9ed50 ".git/index",
must_exist=must_exist@entry=0) at read-cache.c:2229
#3  0x00005555556ef68d in do_read_index (must_exist=0,
path=0x555555a9ed50 ".git/index", istate=0x555555a981e0 <the_index>)
at cache.h:1152
#4  read_index_from (istate=0x555555a981e0 <the_index>,
path=0x555555a9ed50 ".git/index", gitdir=0x555555a9cba0 ".git") at
read-cache.c:2296
#5  0x000055555573e4b0 in get_oid_with_context_1
(repo=repo@entry=0x555555a84dc0 <the_repo>,
name=name@entry=0x5555557e8a92 ":.gitmodules", flags=flags@entry=0,
prefix=prefix@entry=0x0,
    oid=oid@entry=0x7fffffffd890, oc=oc@entry=0x7fffffffd800) at
sha1-name.c:1843
#6  0x000055555573eee3 in get_oid_with_context (oc=0x7fffffffd800,
oid=0x7fffffffd890, flags=0, str=0x5555557e8a92 ":.gitmodules",
repo=0x555555a84dc0 <the_repo>) at sha1-name.c:1940
#7  repo_get_oid (r=r@entry=0x555555a84dc0 <the_repo>,
name=name@entry=0x5555557e8a92 ":.gitmodules",
oid=oid@entry=0x7fffffffd890) at sha1-name.c:1596
#8  0x0000555555748a0f in config_from_gitmodules
(fn=fn@entry=0x555555748b30 <gitmodules_fetch_config>,
repo=0x555555a84dc0 <the_repo>, data=data@entry=0x7fffffffd8f0) at
submodule-config.c:650
#9  0x0000555555749cda in config_from_gitmodules (data=0x7fffffffd8f0,
repo=<optimized out>, fn=0x555555748b30 <gitmodules_fetch_config>) at
submodule-config.c:638
#10 fetch_config_from_gitmodules
(max_children=max_children@entry=0x555555a47994
<submodule_fetch_jobs_config>,
recurse_submodules=recurse_submodules@entry=0x555555a4798c
<recurse_submodules>)
    at submodule-config.c:796
#11 0x00005555555a92bb in cmd_fetch (argc=2, argv=0x7fffffffde20,
prefix=0x0) at builtin/fetch.c:1774
#12 0x000055555557232e in run_builtin (argv=<optimized out>,
argc=<optimized out>, p=<optimized out>) at git.c:450
#13 handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:675
#14 0x00005555555734a5 in run_argv (argv=0x7fffffffdb80,
argcp=0x7fffffffdb8c) at git.c:742
#15 cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:873
#16 0x0000555555571f48 in main (argc=3, argv=0x7fffffffde18) at common-main.c:52


[System Info]
git version:
git version 2.28.0.394.ge197136389
cpu: x86_64
built from commit: e19713638985533ce461db072b49112da5bd2042
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-42-generic #46~18.04.1-Ubuntu SMP Fri Jul 10
07:21:24 UTC 2020 x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.27
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
post-commit
post-checkout
post-merge
post-rewrite

It appears that i have "index.threads" set to "true" in my config.
Once i set it to false the segfault goes away.

br

Sandor
