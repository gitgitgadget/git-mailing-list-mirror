Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E622C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCHUvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCHUvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:51:36 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFAB8C0C4
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:51:33 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c19so19541262qtn.13
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678308693;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGT9PB1pIOwvvh0vhf4WZr3AX9GVK6KnarNwlUBn9ak=;
        b=nNPLs6KyobMKp/F0NoCfZOx8eVmXU1Hv7/CevjaxaZ3/+ow+pAH+uVMdF49NPs1va5
         vE/2QXfnH/o2vDf3CbjVRyZwPQSmzf3my6GTVVbWv2SRDw5VL18KleM+LpUQ4pkREMT4
         w4iLAOkAAc4A9iNxflSfszLz+lSOwvI29gTb0orlsYGgSSAfMG4AkMdIRrgnxkGM/Oar
         R3H6qeQmEitelQmf5Vq6VKeEjtiCzyYN+H/kg6+eUgwUnTdiGsvOLqydsWh9YVl7SKv2
         zKQNOeP77JhFQyQBTr9W+Z0jg/t8QwA6ZsmiGxzGfl1s+L9JOWrZB3BQZWDj2ZJiQOaG
         cHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308693;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGT9PB1pIOwvvh0vhf4WZr3AX9GVK6KnarNwlUBn9ak=;
        b=pyd7StQ71XO5zsZ78Ocv7nhPMHhQZOIL+4AS5UDAq5LGjUamK8NMhIHyVMQKlHid8X
         VJEAjmWwHhW8QTVvzienDsom3+aFDXfj72/kaLfKIujDmYtFXMOMD51WrRbeSwfwesZh
         qjJODlVqXbiu9trbagE3HjoZSRKmDzsXrc1lmW2m5CghW92TW2xgtBQGb+TDn3WSpL1i
         os8JzmX+OQX+JyXTEN3ITV6iu0bWuhUh20R5uQhdelIZcCFjlwnUpZn7XNO5y0vZo5XQ
         zkVBw0326I4GxX0f8JOUmdyT0Qucvi10oLvBDvpkWDjJYrns0gKZBebVLSEeOmKKmiKH
         oa+A==
X-Gm-Message-State: AO0yUKWzPwQGTTFvTFae2udJxYoGWwba4uZb28vLEkYAexuO3JdVa1JF
        N70hKO6ZdBj9XrAUJBcGvkbEdM6npiU=
X-Google-Smtp-Source: AK7set8+GuxN46GU+ITws3mXO5lmefHr5nvPl4tEl/ow8qoPt7wa7vY62RaaLqFwAR2SEphlxlzHqg==
X-Received: by 2002:a05:622a:206:b0:3b8:6b25:88bf with SMTP id b6-20020a05622a020600b003b86b2588bfmr33603223qtx.51.1678308692932;
        Wed, 08 Mar 2023 12:51:32 -0800 (PST)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id y8-20020ac85248000000b003b86b962030sm12368996qtn.72.2023.03.08.12.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 12:51:32 -0800 (PST)
Subject: 'BUG' in builtin add -p (was :Re: [ANNOUNCE] Git v2.40.0-rc2)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqy1o8wdgi.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <bff58f23-6188-9b1e-b23a-fc3d94e9f72f@gmail.com>
Date:   Wed, 8 Mar 2023 15:51:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqy1o8wdgi.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2023-03-07 à 14:47, Junio C Hamano a écrit :
> A release candidate Git v2.40.0-rc2 is now available for testing at
> the usual places.  It is comprised of 461 non-merge commits since
> v2.39.0, contributed by 78 people, 30 of which are new faces [*].
> 

> ----------------------------------------------------------------
> 
> Git v2.40 Release Notes (draft)
> ===============================
> 

>  * Finally retire the scripted "git add -p/-i" implementation and have
>    everybody use the one reimplemented in C.

I just hit a 'BUG' in the builtin add -p, I'll try to write a reproducer later but
wanted to send a heads up now in case you can reproduced easily on your own with the below info.
Note that this is not new in 2.40-rc2, I'm still on 2.39.1.

Basically I have an unmerged path from a conflicted 'git checkout $branch -m'. I resolved
the conflict, but did not run 'git add'. And then I ran (in the 'doc' directory of the repository)
'git restore -S -p ../doc/path/to/file' and got:

```
BUG: add-patch.c:498: diff starts with unexpected line:
* Unmerged path doc/path/to/file

Aborted (core dumped)

```

and the backtrace from the core dump is the below:


```
Reading symbols from /home/me/bin/git...
[New LWP 4172500]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
Core was generated by `git restore -S -p path/to/file'.
Program terminated with signal SIGABRT, Aborted.
#0  0x000014d138b0b7ff in raise () from /lib64/libc.so.6
(gdb) bt
#0  0x000014d138b0b7ff in raise () from /lib64/libc.so.6
#1  0x000014d138af5c35 in abort () from /lib64/libc.so.6
#2  0x0000000000703b75 in BUG_vfl (file=0x779d41 "add-patch.c", line=498, fmt=0x779d50 "diff starts with unexpected line:\n%.*s\n", params=0x7ffdd37529f0) at usage.c:320
#3  0x0000000000703c39 in BUG_fl (file=0x779d41 "add-patch.c", line=498, fmt=0x779d50 "diff starts with unexpected line:\n%.*s\n") at usage.c:330
#4  0x000000000051089a in parse_diff (s=0x7ffdd3752d90, ps=0x7ffdd3753910) at add-patch.c:497
#5  0x0000000000515339 in run_add_p (r=0xa5b3a0 <the_repo>, mode=ADD_P_RESET, revision=0xec35e0 "HEAD", ps=0x7ffdd3753910) at add-patch.c:1758
#6  0x0000000000408511 in run_add_interactive (revision=0xec35e0 "HEAD", patch_mode=0x74119d "--patch=reset", pathspec=0x7ffdd3753910) at builtin/add.c:273
#7  0x0000000000427f4b in checkout_paths (opts=0x7ffdd3753600, new_branch_info=0x7ffdd37533a0) at builtin/checkout.c:528
#8  0x000000000042c24d in checkout_main (argc=1, argv=0x7ffdd3753d40, prefix=0xebe58b "doc/", opts=0x7ffdd3753600, options=0xec0d80, usagestr=0xa342c0 <restore_usage>, new_branch_info=0x7ffdd37533a0)
    at builtin/checkout.c:1820
#9  0x000000000042cd1e in cmd_restore (argc=4, argv=0x7ffdd3753d40, prefix=0xebe58b "doc/") at builtin/checkout.c:1953
#10 0x0000000000406a83 in run_builtin (p=0xa371d8 <commands+2520>, argc=4, argv=0x7ffdd3753d40) at git.c:466
#11 0x0000000000406e68 in handle_builtin (argc=4, argv=0x7ffdd3753d40) at git.c:721
#12 0x00000000004070b6 in run_argv (argcp=0x7ffdd3753bcc, argv=0x7ffdd3753bc0) at git.c:788
#13 0x00000000004075cf in cmd_main (argc=4, argv=0x7ffdd3753d40) at git.c:926
#14 0x000000000050a80b in main (argc=5, argv=0x7ffdd3753d38) at common-main.c:57

```

Hope this helps,

Philippe.
