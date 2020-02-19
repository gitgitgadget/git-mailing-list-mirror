Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D612C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56763207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqi/zWHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBSVKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:10:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39464 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgBSVKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:10:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id a141so1555556qkg.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dDzPkP7RsclvqL2vXi7sQaSKdkUuDBdq+DPuHAe3No=;
        b=Dqi/zWHZ3vY0CSyzQ9MTbwg9LC4DTovzD5nmKxYejPaSuq0mPmzKoxxXvI0qwkv3Xj
         KmsOi2ggi8ilAf52yamLOJV7DRQM9w1DW5/NqhQ2um8moeqg+PoF8d9byAZDzBomGGsH
         Uxbc7pxVBg1nGap3uXnjLtm0GkqxU8Ymg9aqJNTGFtVCWNyxGQKZ2NyRMVu3xllbP2bo
         CWRl3X160Ka7pEgEgcasb7YoIY+/GA21OY9LRxu2lRia6buXzE+cdITJ5RbFehkJHz+H
         t7vpQfmQdb3JbCkF7OeUgGl4vcYNjDb3yPjgt2za0+pIVEeE2ShPITLmgecpQA/t7hCz
         voKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dDzPkP7RsclvqL2vXi7sQaSKdkUuDBdq+DPuHAe3No=;
        b=sI32hBVqXZXg4mXSETVzv0h4CpMMIjmBB1g6LKsiRCxPRtqaVYeQxw9wNDBA61xlD4
         IiCzQV1RFgcpeW5RqGKrlMIc6ZTShn/9IV12YS0UfWvNc7+X1MRDjVqObEdXaMWpKm2j
         NRuUTdxyp772EIVfDFbL3Sh4sIqgSxfcPh5o0XZ9PTy2NVSLeztaZQGUKT/VuzakkNRb
         xA7paKbyxmVA84yp52YUYWlMHxOAaHRJmfubPzYlVbsBO9rN/Yzo8ZZ3sv69B5GZuqHB
         04YtkkCgeIPJGJF2lVAQnjCNc4SqaZscphvEQrqpnPi6iGnpv+/EkQEEoqEfBLGlZT47
         9wAw==
X-Gm-Message-State: APjAAAXFdMDAoomav0sGSc0kAozlhsURzt6MN8SJkvNUJh66WByJYi4v
        +7qL0yl3afCW6GSVfuxtLso=
X-Google-Smtp-Source: APXvYqx9WOTELOIywH7og0p78w1d91T60pNuChXXGCH+g46nncNY9ICDczONyoB21m8FlUnH68cmWQ==
X-Received: by 2002:a37:a4a:: with SMTP id 71mr24398019qkk.54.1582146617046;
        Wed, 19 Feb 2020 13:10:17 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:5cfd:e9c7:d1b7:62ee? ([2001:4898:a800:1010:e33:e9c7:d1b7:62ee])
        by smtp.gmail.com with ESMTPSA id j11sm479812qkl.97.2020.02.19.13.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:10:16 -0800 (PST)
Subject: Re: [PATCH 0/2] Document two partial clone bugs, fix one
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3666d3af-2c5e-40ae-99e5-b002c9011732@gmail.com>
Date:   Wed, 19 Feb 2020 16:10:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <pull.556.git.1582129312.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/19/2020 11:21 AM, Derrick Stolee via GitGitGadget wrote:
> While playing with partial clone, I discovered a few bugs and document them
> with tests in patch 1. One seems to be a server-side bug that happens in a
> somewhat rare situation, but not terribly unlikely. The other is a
> client-side bug that leads to quadratic amounts of data transfer; I fix this
> bug in patch 2.

While I was able to demonstrate these bugs, after looking at my real-world
example with these fixes I found _yet another_ set of issues.

My "real world" test is the following: run "git init" and then populate
the config file with these contents:

[core]
        repositoryformatversion = 1
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = <url-that-supports-partial-clone>
        fetch = +refs/heads/*:refs/remotes/origin/*
        promisor = true
        partialclonefilter = blob:none
[branch "master"]
        remote = origin
        merge = refs/heads/master

Then run "git fetch origin".

First, we check if the repository contains a .gitmodule file, which
triggers a download of HEAD:.gitmodules. First HEAD, then its blob.
(This may be a bit of a red herring: I may have forgotten to delete
the contents of my refs/heads/master when setting up the test.)

#0  promisor_remote_get_direct (repo=repo@entry=0x555555a71680 <the_repo>, oids=oids@entry=0x7fffffffda70, oid_nr=oid_nr@entry=1) at promisor-remote.c:237
#1  0x000055555572bbfa in oid_object_info_extended (r=r@entry=0x555555a71680 <the_repo>, oid=oid@entry=0x7fffffffda70, oi=oi@entry=0x7fffffffd8e0, flags=flags@entry=0) at sha1-file.c:1483
#2  0x000055555572bd7c in read_object (r=r@entry=0x555555a71680 <the_repo>, oid=oid@entry=0x7fffffffda70, type=type@entry=0x7fffffffda64, size=size@entry=0x7fffffffda68) at sha1-file.c:1537
#3  0x000055555572be15 in read_object_file_extended (r=r@entry=0x555555a71680 <the_repo>, oid=oid@entry=0x7fffffffda70, type=type@entry=0x7fffffffda64, size=size@entry=0x7fffffffda68, 
    lookup_replace=lookup_replace@entry=1) at sha1-file.c:1579
#4  0x000055555572c04c in repo_read_object_file (size=0x7fffffffda68, type=0x7fffffffda64, oid=0x7fffffffda70, r=0x555555a71680 <the_repo>) at object-store.h:192
#5  read_object_with_reference (r=r@entry=0x555555a71680 <the_repo>, oid=oid@entry=0x7fffffffdc20, required_type_name=<optimized out>, size=size@entry=0x7fffffffdae8, 
    actual_oid_return=actual_oid_return@entry=0x7fffffffdaf0) at sha1-file.c:1619
#6  0x0000555555755a53 in get_tree_entry (r=r@entry=0x555555a71680 <the_repo>, tree_oid=tree_oid@entry=0x7fffffffdc20, name=name@entry=0x5555557d5ffe ".gitmodules", oid=0x7fffffffdd40, 
    mode=mode@entry=0x7fffffffdcb0) at tree-walk.c:573
#7  0x000055555572f628 in get_oid_with_context_1 (repo=repo@entry=0x555555a71680 <the_repo>, name=name@entry=0x5555557d5ff9 "HEAD:.gitmodules", flags=flags@entry=0, prefix=prefix@entry=0x0, 
    oid=oid@entry=0x7fffffffdd40, oc=oc@entry=0x7fffffffdcb0) at sha1-name.c:1899
#8  0x000055555572fea3 in get_oid_with_context (oc=0x7fffffffdcb0, oid=0x7fffffffdd40, flags=0, str=0x5555557d5ff9 "HEAD:.gitmodules", repo=0x555555a71680 <the_repo>) at sha1-name.c:1946
#9  repo_get_oid (r=r@entry=0x555555a71680 <the_repo>, name=name@entry=0x5555557d5ff9 "HEAD:.gitmodules", oid=oid@entry=0x7fffffffdd40) at sha1-name.c:1602
#10 0x000055555573d962 in config_from_gitmodules (fn=fn@entry=0x55555573da30 <gitmodules_fetch_config>, repo=0x555555a71680 <the_repo>, data=data@entry=0x7fffffffdda0) at submodule-config.c:648
#11 0x000055555573ebed in config_from_gitmodules (data=0x7fffffffdda0, repo=<optimized out>, fn=0x55555573da30 <gitmodules_fetch_config>) at submodule-config.c:637
#12 fetch_config_from_gitmodules (max_children=max_children@entry=0x555555a32894 <submodule_fetch_jobs_config>, recurse_submodules=recurse_submodules@entry=0x555555a3288c <recurse_submodules>)
    at submodule-config.c:799
#13 0x00005555555a6920 in cmd_fetch (argc=2, argv=0x7fffffffe2e8, prefix=0x0) at builtin/fetch.c:1762
#14 0x0000555555570b9d in run_builtin (argv=<optimized out>, argc=<optimized out>, p=<optimized out>) at git.c:444
#15 handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:674
#16 0x0000555555571d05 in run_argv (argv=0x7fffffffe030, argcp=0x7fffffffe03c) at git.c:741
#17 cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:872
#18 0x00005555555707c8 in main (argc=6, argv=0x7fffffffe2c8) at common-main.c:52

THEN, we start walking the refs to see if we have the objects
locally:

#0  promisor_remote_get_direct (repo=repo@entry=0x555555a71680 <the_repo>, oids=oids@entry=0x555555af7ed0, oid_nr=oid_nr@entry=1) at promisor-remote.c:237
#1  0x000055555572bbfa in oid_object_info_extended (r=0x555555a71680 <the_repo>, oid=<optimized out>, oi=0x555555a71940 <blank_oi>, oi@entry=0x0, flags=flags@entry=4) at sha1-file.c:1483
#2  0x000055555572c420 in repo_has_object_file_with_flags (flags=<optimized out>, oid=<optimized out>, r=<optimized out>) at sha1-file.c:1935
#3  repo_has_object_file (r=<optimized out>, oid=<optimized out>) at sha1-file.c:1942
#4  0x00005555556e682f in ref_resolves_to_object (refname=0x555555af7f40 "refs/remotes/origin/next", oid=<optimized out>, flags=<optimized out>) at refs.c:261
#5  0x00005555556eb059 in files_ref_iterator_advance (ref_iterator=0x555555b27ed0) at refs/files-backend.c:754
#6  0x00005555556f1082 in ref_iterator_advance (ref_iterator=0x555555b27ed0) at refs/iterator.c:13
#7  do_for_each_repo_ref_iterator (r=0x555555a71680 <the_repo>, iter=0x555555b27ed0, fn=fn@entry=0x5555556e5930 <do_for_each_ref_helper>, cb_data=cb_data@entry=0x7fffffffdc80) at refs/iterator.c:417
#8  0x00005555556e7b79 in do_for_each_ref (refs=<optimized out>, prefix=prefix@entry=0x5555557cb095 "", fn=fn@entry=0x5555555a3cb0 <add_one_refname>, trim=trim@entry=0, flags=flags@entry=0, 
    cb_data=cb_data@entry=0x55555572bbfa <oid_object_info_extended+778>) at refs.c:1566
#9  0x00005555556e8918 in refs_for_each_ref (cb_data=0x55555572bbfa <oid_object_info_extended+778>, fn=0x5555555a3cb0 <add_one_refname>, refs=<optimized out>) at refs.c:1572
#10 for_each_ref (fn=fn@entry=0x5555555a3cb0 <add_one_refname>, cb_data=cb_data@entry=0x7fffffffdd40) at refs.c:1577
#11 0x00005555555a46d6 in find_non_local_tags (refs=0x970e93150326b500, refs@entry=0x555555b2ae40, head=head@entry=0x7fffffffde20, tail=tail@entry=0x7fffffffde28) at builtin/fetch.c:344
#12 0x00005555555a7a87 in get_ref_map (rs=0x7fffffffde90, rs=0x7fffffffde90, autotags=<synthetic pointer>, tags=<optimized out>, remote_refs=0x555555b2ae40, remote=<optimized out>) at builtin/fetch.c:523
#13 do_fetch (rs=0x7fffffffde90, transport=<optimized out>) at builtin/fetch.c:1367
#14 fetch_one (prune_tags_ok=<optimized out>, argv=<optimized out>, argc=<optimized out>, remote=<optimized out>) at builtin/fetch.c:1738
#15 cmd_fetch (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/fetch.c:1827
#16 0x0000555555570b9d in run_builtin (argv=<optimized out>, argc=<optimized out>, p=<optimized out>) at git.c:444
#17 handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:674
#18 0x0000555555571d05 in run_argv (argv=0x7fffffffe050, argcp=0x7fffffffe05c) at git.c:741
#19 cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:872
#20 0x00005555555707c8 in main (argc=5, argv=0x7fffffffe2e8) at common-main.c:52

This is running through has_object_file(), but the worst part is that switching
it to has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT) will cause
warnings when we do not have the object. Something else must be done here.

Since this is more complicated to fix, I'm going to set this part aside
for now. I may come back with a test case that demonstrates the problem.

Thanks,
-Stolee
