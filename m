Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EBC636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 15:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjBVPp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjBVPp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 10:45:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401D37576
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 07:45:25 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b14so3671469ior.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpPjX7nUSjdBlERDh4w7y7g8TcM6He4toTwf7qLQDpA=;
        b=OhBAjkilvOarmpjIC28fqBBvFVbGL87KWM5szME8HiBpQcKxcngWhL5XRHJt6fQIlu
         DsZI6gR+qNyVDrdkgh6fMHNd4Zrejr01pADLUiUU2xpQ3qmW7oJcWeG7PY4cz7rKUfPG
         fm3CQVnHwrncYSZppsa/1kRP61v/aXmZSpWxcHJG1UjFiNAccyUj3VAmP1fehVinTK3O
         iPKeAYB3GUpV3LLHBKxWenKauMk73yFFesHeYNPZ1YudqCSB4Hm0Qzo1dxmEbA77Hp/O
         M51DNMLeoRUvx4WKhpu+kGRI/flAjS6YjjrJ72cncCahWyCQ5gf0HJan8plVyyTAc/7G
         ta/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpPjX7nUSjdBlERDh4w7y7g8TcM6He4toTwf7qLQDpA=;
        b=UINetcp5VxHHcqo82MZPNQhTK3ZYAu4ykjvgdrV+tnI3OEwhNc4rqFLxE/KYtw+gXF
         Ui4x0BRTcZ8AycQ4+mchKnIYgUFyLpOGUdcVAlBpHSHdRAAOXekFU1csdJofOvH8YdTy
         qY9fI+olsqyr3h0Hqk4lX8RVGyIMRP9BMeXD8q5qw3N0FnweIJjtXe8PuTID/8G26Yhn
         UnIwyqF81N5y/l1gk3ONspLUeR1pnLMK0IoWH+agrd3g3cadGbVY9mLBfUIGDRG5QWNa
         eyIm9pIZIZMJbSIj20L5prlWFvKwSLe6u9BphXjp3L96OfsB54dn46RMic9aOWTeRxkU
         flVg==
X-Gm-Message-State: AO0yUKUp/Rd9LYWhUwrW9s9OxjfSdA+XfeL4dxJrfhOh+iAtH0vIFZxM
        rV2JSdGxG+ltdOAPB/5/TL4C5gZVHAd2Pw==
X-Google-Smtp-Source: AK7set+NRcOJDhhtHKEIvQM6uimJ/5Dk3zY8ZGrKPxBVjWuh02ci0X8IP7fMZy9uQs9OCv70TPx7uw==
X-Received: by 2002:a05:6602:2d04:b0:740:7d21:d96f with SMTP id c4-20020a0566022d0400b007407d21d96fmr1559093iow.1.1677080723951;
        Wed, 22 Feb 2023 07:45:23 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::1b0])
        by smtp.gmail.com with ESMTPSA id v12-20020a5ec10c000000b0074c7db1470dsm1909622iol.20.2023.02.22.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:45:23 -0800 (PST)
References: <m0ttze4qzl.fsf@epic96565.epic.com>
 <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
User-agent: mu4e 1.8.14; emacs 28.2
From:   Sean Allred <allred.sean@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Subject: Re: [BUGREPORT] Why is git-push fetching content?
Date:   Wed, 22 Feb 2023 09:04:23 -0600
In-reply-to: <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
Message-ID: <m0pma14sbx.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> It's hard to know for certain what's going on here, but it depends on
> your history.  You did a partial clone with no trees, so you've likely
> received a single commit object and no trees or blobs.

Yup, this was the intention behind `--depth=1 --filter=tree:0`. The
server doing this ref update needs to be faster than having the full
history would allow.

> However, when you push a commit, that necessitates pushing the trees and
> blobs as well, and you don't have those.  If the remote said that it
> already had the commit, then it might push no objects at all (which I've
> seen before) and thus just update the references.  However, if it pushes
> even one commit, it may need to walk the history and find common
> commits, which will necessitate fetching objects, and it will have to
> push any trees and blobs as well, which also will require objects to be
> fetched.

Absolutely. The commit in question was fetched from the same remote to
which we're pushing, so it would seem by definition that git-push should
not need to push *any* object content whatsoever.

> My guess is that this is probably made worse by the fact that this is
> shallow, and that necessitates certain additional computations, which
> means more objects are fetched. However, I'm not super sure how that
> code works, so I think it may be helpful for someone else to chime in
> who's more familiar with this.

I'm certain this is just an unforeseen interaction between all these
pieces. I wouldn't be too surprised if we're among only a handful of
folks using git in this way.

> If you want to see what's going on, you can run with
> `GIT_TRACE=1 GIT_TRACE_PACKET=1`, which may show interesting information
> about the negotiation.

I'm not sure of the best way to include this information, so I'm just
going to inline it. I've edited this log file to remove several tens of
thousands of lines of object hashes and operational refnames. I've
annotated it with some guesses of what things might mean. I'm still
*relatively* new to reading such log files for serious debugging.

    08:30:47.655623 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/bin
    08:30:47.655623 git.c:460               trace: built-in: git push --no-verify -o emc2.enable-logging git@$REPO.git FETCH_HEAD:refs/tags/hswebrec/app/stage1/latest

This is the command actually run in the foreground. As you might
surmise, we're uing Git4Win. It's worth noting that FETCH_HEAD here is
0962f6cd9b1f2b5a012581823c12f0f0619bd3f5.

    08:30:47.655623 run-command.c:655       trace: run_command: unset GIT_PREFIX; ssh git@$REPO_HOST 'git-receive-pack '\''$REPO_PROJECT.git'\'''
    08:30:48.100544 pkt-line.c:80           packet:         push< 4edfa5e150857e21c686826e1e430f6b014ed173 refs/archive/app/devnull\0report-status report-status-v2 delete-refs side-band-64k quiet atomic ofs-delta push-options object-format=sha1 agent=git/2.38.4.gl1
    08:30:48.100544 pkt-line.c:80           packet:         push< 5d27e7331f08365c9bb3d342ae020807a386f42a refs/heads/app/10.1/stage1

    ---8<--- literally thousands of refs removed...

    08:30:49.121310 pkt-line.c:80           packet:         push< 90c12d8c0ad0559047b3b9de78d948901fcffac3 refs/tags/zrb/I10121236/726711
    08:30:49.121310 pkt-line.c:80           packet:         push< 90c12d8c0ad0559047b3b9de78d948901fcffac3 refs/tags/zrb/I10121236/726712
    08:30:49.121310 pkt-line.c:80           packet:         push< 0000

Looks like the above was the remote telling the client what objects it
has by virtue of what refs it is tracking.

    08:30:49.193113 pkt-line.c:80           packet:         push> shallow 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5
    08:30:49.193113 pkt-line.c:80           packet:         push> 0000000000000000000000000000000000000000 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5 refs/tags/hswebrec/app/stage1/latest\0 report-status-v2 side-band-64k quiet push-options object-format=sha1 agent=git/2.39.2.windows.1
    08:30:49.193113 pkt-line.c:80           packet:         push> 0000

And this is the client telling the remote what objects it has ('shallow
0962f6...'?) and what changes it would like to make.

    08:30:49.193113 pkt-line.c:80           packet:         push> emc2.enable-logging
    08:30:49.193113 pkt-line.c:80           packet:         push> 0000

...as well as our push-option that enabled more logging for us (nothing
relevant to Git communication -- mostly just internal web services and
print-statement debugging).

    08:30:49.193113 run-command.c:655       trace: run_command: git pack-objects --all-progress-implied --revs --stdout --thin --delta-base-offset -q --shallow
    08:30:49.224949 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:30:49.224949 git.c:460               trace: built-in: git pack-objects --all-progress-implied --revs --stdout --thin --delta-base-offset -q --shallow
    08:30:49.224949 run-command.c:655       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch git@$REPO.git --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
    08:30:49.246673 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:30:49.256718 git.c:460               trace: built-in: git fetch git@$REPO.git --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
    08:30:49.256718 run-command.c:655       trace: run_command: unset GIT_CONFIG_PARAMETERS GIT_PREFIX; GIT_PROTOCOL=version=2 ssh -o SendEnv=GIT_PROTOCOL git@tracklab.epic.com 'git-upload-pack '\''epic/test/trackdev/mono-23/app.git'\'''

It looks like this is the client initiating a fetch.

    08:30:49.699720 pkt-line.c:80           packet:        fetch< version 2
    08:30:49.699720 pkt-line.c:80           packet:        fetch< agent=git/2.38.4.gl1
    08:30:49.699720 pkt-line.c:80           packet:        fetch< ls-refs=unborn
    08:30:49.699720 pkt-line.c:80           packet:        fetch< fetch=shallow wait-for-done filter
    08:30:49.699720 pkt-line.c:80           packet:        fetch< server-option
    08:30:49.699720 pkt-line.c:80           packet:        fetch< object-format=sha1
    08:30:49.699720 pkt-line.c:80           packet:        fetch< object-info

The remote tells the client what version it is so the client can send a
request the remote understands.

    08:30:49.699720 pkt-line.c:80           packet:        fetch< 0000
    08:30:49.699720 pkt-line.c:80           packet:        fetch> command=fetch
    08:30:49.699720 pkt-line.c:80           packet:        fetch> agent=git/2.39.2.windows.1
    08:30:49.699720 pkt-line.c:80           packet:        fetch> object-format=sha1
    08:30:49.699720 pkt-line.c:80           packet:        fetch> 0001
    08:30:49.699720 pkt-line.c:80           packet:        fetch> thin-pack
    08:30:49.699720 pkt-line.c:80           packet:        fetch> no-progress
    08:30:49.699720 pkt-line.c:80           packet:        fetch> ofs-delta
    08:30:49.699720 pkt-line.c:80           packet:        fetch> shallow 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5
    08:30:49.699720 pkt-line.c:80           packet:        fetch> filter blob:none
    08:30:49.699720 pkt-line.c:80           packet:        fetch> want 8da2fa849db733188b1820865deb800d8e6abfc6
    08:30:49.699720 pkt-line.c:80           packet:        fetch> done
    08:30:49.699720 pkt-line.c:80           packet:        fetch> 0000

The client asks the remote for content. Looks like the filter here got
changed from tree:0 to blob:none. This could be the bug -- and could
explain the 'weird' amount of content that was actually downloaded. A
fully-fleshed-out clone would be about 8GB, but I could certainly see a
blobless history being ~700MB. Interesting to note here that
0962f6^{tree} is 8da2fa.

    08:30:49.715316 pkt-line.c:80           packet:        fetch< shallow-info
    08:30:49.715316 pkt-line.c:80           packet:        fetch< 0001
    08:30:49.715316 pkt-line.c:80           packet:        fetch< packfile

Not sure what this bit is, to be honest.

    08:30:50.527739 pkt-line.c:80           packet:     sideband< PACK ...
    08:30:50.542281 run-command.c:655       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 6448 on win-pool7447' --promisor --pack_header=2,71814
    08:30:50.574053 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:30:50.590271 git.c:460               trace: built-in: git index-pack --stdin --fix-thin '--keep=fetch-pack 6448 on win-pool7447' --promisor --pack_header=2,71814
    08:30:53.027721 pkt-line.c:80           packet:     sideband< 0000
    08:30:53.200395 run-command.c:655       trace: run_command: git maintenance run --auto --no-quiet
    08:30:53.246231 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:30:53.248264 git.c:460               trace: built-in: git maintenance run --auto --no-quiet
    08:30:59.362381 run-command.c:655       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch git@$REPO.git --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
    08:30:59.378458 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:30:59.394133 git.c:460               trace: built-in: git fetch git@$REPO.git --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
    08:33:28.966748 run-command.c:655       trace: run_command: unset GIT_CONFIG_PARAMETERS GIT_PREFIX; GIT_PROTOCOL=version=2 ssh -o SendEnv=GIT_PROTOCOL git@tracklab.epic.com 'git-upload-pack '\''epic/test/trackdev/mono-23/app.git'\'''

Nor why we'd go through a separate round of fetching.

    08:33:29.530124 pkt-line.c:80           packet:        fetch< version 2
    08:33:29.530124 pkt-line.c:80           packet:        fetch< agent=git/2.38.4.gl1
    08:33:29.530124 pkt-line.c:80           packet:        fetch< ls-refs=unborn
    08:33:29.530124 pkt-line.c:80           packet:        fetch< fetch=shallow wait-for-done filter
    08:33:29.530124 pkt-line.c:80           packet:        fetch< server-option
    08:33:29.530124 pkt-line.c:80           packet:        fetch< object-format=sha1
    08:33:29.530124 pkt-line.c:80           packet:        fetch< object-info
    08:33:29.530124 pkt-line.c:80           packet:        fetch< 0000
    08:33:51.764098 pkt-line.c:80           packet:        fetch> command=fetch
    08:33:51.764098 pkt-line.c:80           packet:        fetch> agent=git/2.39.2.windows.1
    08:33:51.764098 pkt-line.c:80           packet:        fetch> object-format=sha1
    08:33:51.764098 pkt-line.c:80           packet:        fetch> 0001
    08:33:51.764098 pkt-line.c:80           packet:        fetch> thin-pack
    08:33:51.764098 pkt-line.c:80           packet:        fetch> no-progress
    08:33:51.764098 pkt-line.c:80           packet:        fetch> ofs-delta
    08:33:51.764098 pkt-line.c:80           packet:        fetch> shallow 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5
    08:33:51.764098 pkt-line.c:80           packet:        fetch> filter blob:none

But we can see this blob:none 'mistake' again...

    08:33:51.764098 pkt-line.c:80           packet:        fetch> want 0000063ae70e4385b0527df060daf0a81b306c8d
    08:33:51.764098 pkt-line.c:80           packet:        fetch> want 00003efd5bd3b3795950588f7d051e8d0b42def3

    ---8<--- many, many thousands of objects removed

    08:33:54.154726 pkt-line.c:80           packet:        fetch> want ffffd8aad00ab11c0672096203f57564b286da08
    08:33:54.154726 pkt-line.c:80           packet:        fetch> want ffffd967eaed43bf87d40a84f2f9e12c59575abe
    08:33:54.154726 pkt-line.c:80           packet:        fetch> done
    08:33:54.154726 pkt-line.c:80           packet:        fetch> 0000

... with all of those trees

    08:33:56.058314 pkt-line.c:80           packet:        fetch< shallow-info
    08:33:56.058314 pkt-line.c:80           packet:        fetch< 0001
    08:33:56.058314 pkt-line.c:80           packet:        fetch< packfile
    08:33:57.783631 pkt-line.c:80           packet:     sideband< PACK ...
    08:33:57.799321 run-command.c:655       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 6540 on win-pool7447' --promisor --pack_header=2,344628
    08:33:57.830596 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:33:57.830596 git.c:460               trace: built-in: git index-pack --stdin --fix-thin '--keep=fetch-pack 6540 on win-pool7447' --promisor --pack_header=2,344628
    08:34:35.033275 pkt-line.c:80           packet:     sideband< 0000
    08:34:46.298777 run-command.c:655       trace: run_command: git maintenance run --auto --no-quiet
    08:34:46.330052 exec-cmd.c:237          trace: resolved executable dir: C:/Program Files/Git/mingw64/libexec/git-core
    08:34:46.345653 git.c:460               trace: built-in: git maintenance run --auto --no-quiet
    08:45:14.094158 pkt-line.c:80           packet:     sideband< \1
    08:45:18.281129 pkt-line.c:80           packet:     sideband< \2pre-receive started at 1677077118283
    remote: pre-receive started at 1677077118283
    08:45:18.297266 pkt-line.c:80           packet:     sideband< \2Received line '0000000000000000000000000000000000000000 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5 refs/tags/hswebrec/app/stage1/l
    08:45:18.297266 pkt-line.c:80           packet:     sideband< \2atest'
    remote: Received line '0000000000000000000000000000000000000000 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5 refs/tags/hswebrec/app/stage1/latest'

    ---8<--- clipped pre-receive output

    08:45:18.550847 pkt-line.c:80           packet:     sideband< \2pre-receive finished at 1677077118556 (273 ms)
    remote: pre-receive finished at 1677077118556 (273 ms)
    08:45:21.448647 pkt-line.c:80           packet:     sideband< \1000eunpack ok002cok refs/tags/hswebrec/app/stage1/latest0000
    08:45:21.448647 pkt-line.c:80           packet:         push< unpack ok
    08:45:21.448647 pkt-line.c:80           packet:         push< ok refs/tags/hswebrec/app/stage1/latest
    08:45:21.448647 pkt-line.c:80           packet:         push< 0000
    08:45:21.798337 pkt-line.c:80           packet:     sideband< \2post-receive started at 1677077121804
    remote: post-receive started at 1677077121804
    08:45:21.814043 pkt-line.c:80           packet:     sideband< \2Received line '0000000000000000000000000000000000000000 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5 refs/tags/hswebrec/app/stage1/l
    08:45:21.814043 pkt-line.c:80           packet:     sideband< \2atest'
    remote: Received line '0000000000000000000000000000000000000000 0962f6cd9b1f2b5a012581823c12f0f0619bd3f5 refs/tags/hswebrec/app/stage1/latest'

    ---8<--- clipped post-receive output

    08:45:21.972423 pkt-line.c:80           packet:     sideband< \23.0000; path=/; Httponly; Secure"]}}post-receive finished at 1677077121979 (175 ms)
    remote: post-receive finished at 1677077121979 (175 ms)
    08:45:22.051793 pkt-line.c:80           packet:     sideband< 0000
    To $REPO.git
     * [new tag]         FETCH_HEAD -> hswebrec/app/stage1/latest

--
Sean Allred
