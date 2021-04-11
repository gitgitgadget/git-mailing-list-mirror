Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71425C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 10:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEC6610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhDKK7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 06:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKK7X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 06:59:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D911C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 03:59:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w3so15519485ejc.4
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ntjgua3rE+ihxgIzrI+OiC3Rybkr39xrfRBti225z3s=;
        b=MOvM36fOIaC8xQDFf1tw3R0JjBG5HV6qeoE/rUX/gNQYraFCMHiKSQcQYTdpoauv+X
         UAbpWqIUN+soRbU1ongz0URD1gEAxRtV+NP81+Ghp0kUxYrv4v/ZsATq04Q+i0FQAJzK
         uuMm9pFFxqrrnpTooEclI82CBcZsGR2ECkdi+F3coYO/QBhpoUZ7pc01AwSEAWeS68+E
         N1bU4+0NKsw/rhCSWKCRkkJXD5s9tsXwIh6lCDLUbbldWwnVZroQEgPDQbwmnWGOpwXW
         wJ/i56xUkiARu7RwfRFL9eZ8kcROeM72XEf8TOkF1IxI3A7T/Z2PI4JTUDT5AOew6I4L
         aKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ntjgua3rE+ihxgIzrI+OiC3Rybkr39xrfRBti225z3s=;
        b=LCAZfeStH7y+d77M03CeYFepreTuA1deu63OtXtlxd9rHvUMV4cMlC/aX+zn719zC2
         zaKMlxmGqctW7FnQ9m+T19R4nJaq/DxNqw8QJlUznT3Dl9HfAG0WTwKiU0C5FmB/SxN+
         B+QyipPC1EBWjFMIZLEtTiaBmkW8//zKlXeSwj4ZyfEApqbG3+T7Y+DGLNJ55OX3ewys
         yX9pTSvmDhwO18guBG4EP/woh/DeioxbDID6o/YtVFvQRntltjtN76rzrBG4ovw3qjWH
         smxPL89ByQEMY9ZnC7KGjKdIBgZrLXXrCDL1o1kOW/wWF//vk/EGjcS9j8PtrAzhYfYZ
         g9JQ==
X-Gm-Message-State: AOAM531xJ7Cw6DaSnoCeCoH7BwdaM8wodIfkYtWgFedNaK2K3ZRKBfGU
        m0WQiCfVES4szDnxUed09hg=
X-Google-Smtp-Source: ABdhPJyhtfKQs9iu3ehtq3CEEw1sGYH5I4TwZPG9USbDYfTfOvMXjuGJ//56VIhqpIOq/XAuYk+rPA==
X-Received: by 2002:a17:906:f1d7:: with SMTP id gx23mr23156098ejb.109.1618138745949;
        Sun, 11 Apr 2021 03:59:05 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id a24sm1587153ejr.58.2021.04.11.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:59:05 -0700 (PDT)
Date:   Sun, 11 Apr 2021 12:59:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <20210411105903.GG2947267@szeder.dev>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 03:02:33AM +0200, Rafael Silva wrote:
> > here are trace timings of running 'git gc' in a "normal" and in a
> > 'blob:none' partial clone:
> >
> >   $ git clone --bare https://github.com/git/git git-full.git
> >   $ GIT_TRACE_PERFORMANCE=2 /usr/bin/time --format='elapsed: %E  max RSS: %Mk' git -C git-full.git/ gc
[...]
> >   elapsed: 0:09.51  max RSS: 358964k
> >
> >   $ git clone --bare --filter=blob:none https://github.com/git/git git-partial.git
> >   $ GIT_TRACE_PERFORMANCE=2 /usr/bin/time --format='elapsed: %E  max RSS: %Mk' git -C git-partial.git/ gc
> >   10:35:47.637735 trace.c:487             performance: 0.000872539 s: git command: /usr/local/libexec/git-core/git pack-refs --all --prune
> >   10:35:47.675498 trace.c:487             performance: 0.036246403 s: git command: /usr/local/libexec/git-core/git reflog expire --all
> >   Enumerating objects: 188205, done.
> >   Counting objects: 100% (188205/188205), done.
> >   Delta compression using up to 4 threads
> >   Compressing objects: 100% (66520/66520), done.
> >   Writing objects: 100% (188205/188205), done.
> >   Total 188205 (delta 119967), reused 188205 (delta 119967), pack-reused 0
> >   10:35:50.081709 trace.c:487             performance: 2.402625839 s: git command: /usr/local/libexec/git-core/git pack-objects --local --delta-base-offset objects/pack/.tmp-2946990-pack
> >   10:35:50.100131 read-cache.c:2315       performance: 0.000009979 s:  read cache ./index
> >   10:37:04.973541 trace.c:487             performance: 74.885793630 s: git command: /usr/local/libexec/git-core/git pack-objects --local --delta-base-offset objects/pack/.tmp-2946990-pack --keep-true-parents --honor-pack-keep --non-empty --all --reflog --indexed-objects --exclude-promisor-objects --unpack-unreachable=2.weeks.ago
> >   Removing duplicate objects: 100% (256/256), done.
> >   10:37:07.482791 trace.c:487             performance: 79.804973525 s: git command: /usr/local/libexec/git-core/git repack -d -l -A --unpack-unreachable=2.weeks.ago
> >   10:37:07.549333 trace.c:487             performance: 0.008025426 s: git command: /usr/local/libexec/git-core/git prune --expire 2.weeks.ago --exclude-promisor-objects
> >   10:37:07.552499 trace.c:487             performance: 0.000362981 s: git command: /usr/local/libexec/git-core/git worktree prune --expire 3.months.ago
> >   10:37:07.554521 trace.c:487             performance: 0.000273834 s: git command: /usr/local/libexec/git-core/git rerere gc
> >   10:37:10.168233 trace.c:487             performance: 82.533331484 s: git command: git -C git-partial.git/ gc
> >   elapsed: 1:22.54  max RSS: 1891832k
> >
> > Notice the ~9s vs. 82s runtime and ~350M vs. 1.9G memory consumption
> > increase.  What's going on here?
> >
> > Also note that that second 'git pack-objects' invocation doesn't show
> > any progress for ~75s.
> >
> > FWIW, doing the same in a 'tree:0' partial clone is fast.
> 
> I'm not expert on the area - by "area": the entire git code base :).
> However, I was intrigued by this performance numbers and decided to give
> it a try on the investigation, mostly for learning.

That's the spirit!

> While I'm not sure
> about the solution of the problem, I decided to share it here with the
> hope that at least I'll be saving someone else time.
> 
> When I was digging into the code and adding trace2_region_*() calls, I
> notice most of the time spent on the `git gc` (for the reported
> situation) was in:
> 
>        # In builtin/pack-objects.c
>        static void get_object_list(int ac, const char **av)
>        {
>                ...
>                if (unpack_unreachable)
>                        loosen_unused_packed_objects();
>                ...
>        }
> 
> The loosen_unused_packed_objects() will unpack unreachable objects as
> loose objects, and given that the partial cloned .pack file is
> incomplete, this result in writing a lot of loose objects in $GIT_DIR
> increasing the execution time and memory consumption. This can be seen
> by watching the $GIT_DIR/objects/ during the `git gc` execution on the
> partial cloned repo.

Indeed, that 'blob:none' partial clone grew in size temporarily to
over 1.3GB during repacking, but luckily all those unnecessarily
loosened objects were removed at the end.  I first noticed this issue
while attempting to repack a considerably larger partial-cloned
repository, which I aborted because it ate up all the memory...  I
suppose that even if it didn't use that much memory, it would
eventually run out of available disk space for all those loose objects
anyway...


> I'm not entirely sure about this (not this late in the day), but it seems to
> me that we should simply skip the "missing" (promisor) files when
> operating on a partial clone.
> 
> Perhaps something like:
> 
> --- >8 ---
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 525c2d8552..fedf58323d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
>  {
>         if (!unpack_unreachable_expiration)
>                 return 0;
> +       if (exclude_promisor_objects && is_promisor_object(oid))
> +               return 1;
>         if (mtime > unpack_unreachable_expiration)
>                 return 0;
>         if (oid_array_lookup(&recent_objects, oid) >= 0)
> --- >8 ---
> 
> I'll try to prepare a patch for this change with proper testing, if this
> turns out to be proper way to handle partial clone repository.
> 
> A quick benchmark did show some promising result:
> 
>     # built from: 2e36527f23 (The sixth batch, 2021-04-02)
>     Benchmark #1: ./bin-wrappers/git -C git.git gc
>           Time (mean ± σ):     135.669 s ±  0.665 s    [User: 42.789 s, System: 91.332 s]
>           Range (min … max):   134.905 s … 136.115 s    3 runs
> 
>     # built from: 2e36527f23 + minor patch (from above)
>     Benchmark #2: ./bin-wrappers/git -C git.git gc
>           Time (mean ± σ):     12.586 s ±  0.031 s    [User: 11.462 s, System: 1.365 s]
>           Range (min … max):   12.553 s … 12.616 s    3 runs
> 
>     Summary:
>           'Benchmark #2' ran 10.78 ± 0.06 times faster than 'Benchmark #1'

I can confirm that you change speeds up repacking considerably and it
completely eliminates that temporary repo size explision due to
unpacked objects, but, alas, it doesn't seem to reduce the memory
usage.

Thanks,
Gábor

