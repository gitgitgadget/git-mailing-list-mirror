Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A013CCA47C
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 09:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiFNJCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbiFNJCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 05:02:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E0125E82
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 02:02:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g25so15840599ejh.9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vH2zUU/52PrFdU07mVlkSqiHs553zowsebMUKA5PENU=;
        b=M8Rg5uUnhLAzdGrw4JT8SvwWHvB53QbHoUSBs2Me5NFEvvHnYFT7NUP8U+7YIJjDua
         ZwICpXHMCUD6PxFeTkCIfIUQdJgUYv5iKljjQCnJbz7QEFTuciYDsZbg7w83lqTwbCSf
         8afl9kMIOlPNYC8VXh7v9o3oftb84guV37BvsxZchKDfGZq+vEAaDSSUPG6ZMrZ4tO1D
         EW5qHcmjy5zb/CrkqGkDeJ3P9kl4rFnGm9sM6KzBTOrja0F6YAWQYd5wKLSYBtsMXlW1
         rheC2g1zcJKHHkY1VofzcsoqrtfIsbv96oS/8sUq26VdYBrckpqW4HtgXqKK+47drNGb
         z3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vH2zUU/52PrFdU07mVlkSqiHs553zowsebMUKA5PENU=;
        b=5H/e9WvD0nJ7v7LwPSyu33L6r1j+Y//GiLzxwKl/klTEXQg6kQBbNoCcEMjmyfInkM
         4muQbsW8nNKZczp5Ik52jQI6c4Ox27+k7BxrI82HCqUCNm9uo2rn9kT8Ku89RjhCBifl
         SpnGPcDKcH3WyTiLzi/X+fIbLToSHgsKxkDgrcm7A0KnmWTQDDEwf0i5nUt9MEoHfA/C
         2WrG3N2yRQZ1zggW+cVUT9mpOpPgjO3LJJCxmkaB5JCKQPe8pt1vZoBOWR3qUL8GHPZr
         dvt3ye7dV8A+D8rdDZ45nOKW6I9xveIfNrtCma8H0JysDHfnlAnUOvbmYUnMgfI4v1t0
         sOiQ==
X-Gm-Message-State: AJIora+Bt1hARFg/xx1O1w7Dhf60ZE1XWlQe52D+OGWf6c0EJm1KwmpP
        CCT5sm0JirTI8IOEANo2PVgg0SY+UmCPIA==
X-Google-Smtp-Source: ABdhPJwUEc4TjpfXn+PKkMxJFQSQDuo+nh+uWlJQRB0lEu1bsGPL1wb/M603oij2iInCOqDuYUvN0g==
X-Received: by 2002:a17:907:6ea4:b0:711:d106:b93a with SMTP id sh36-20020a1709076ea400b00711d106b93amr3373301ejc.189.1655197353099;
        Tue, 14 Jun 2022 02:02:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id hh14-20020a170906a94e00b00703e09dd2easm4886141ejb.147.2022.06.14.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 02:02:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o12RT-000KkG-0P;
        Tue, 14 Jun 2022 11:02:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: reachability-bitmap makes push performance worse ?
Date:   Tue, 14 Jun 2022 10:55:54 +0200
References: <b940e705fbe9454685757f2e3055e2ce@tencent.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b940e705fbe9454685757f2e3055e2ce@tencent.com>
Message-ID: <220614.864k0nzkgp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, kylezhao(=E8=B5=B5=E6=9F=AF=E5=AE=87) wrote:

> Hi All,=20
> =C2=A0
> thank you for reading my report.
> =C2=A0
> =C2=A0
> How did we find out?
> =C2=A0
> The problem described in the title occurs on our git server.
> Each git repositories have multiple replicas on our servers to increase g=
it read performance, and the data synchronization method between these repl=
icas is git push.
> One day we found that the git push of a repository was significantly slow=
, and it took more than ten seconds to just create a new branch from an exi=
sting commit.
> =C2=A0
> How to reproduce the problem ?
> =C2=A0
> git version: 2.36.1
> =C2=A0
> # /data/test/repo is a bare git repository which can reproduce the problem
> $ cd /data/test/repo
> =C2=A0
> # number of refs
> $ git show-ref | wc -l
> 21134
> # pack information
> $ ls objects/pack/ -hl
> total 14G
> -r--r--r-- 1 root root=C2=A0 43M Jun 14 04:16 pack-9a7fc024652645a632fb82=
a4ff26c3ddf4883eed.bitmap
> -r--r--r-- 1 root root 169M Jun 14 04:15 pack-9a7fc024652645a632fb82a4ff2=
6c3ddf4883eed.idx
> -r--r--r-- 1 root root=C2=A0 14G Jun 14 04:14 pack-9a7fc024652645a632fb82=
a4ff26c3ddf4883eed.pack
> =C2=A0
> # objects information
> $ git count-objects -v
> count: 0
> size: 0
> in-pack: 5185141
> packs: 1
> size-pack: 13938704
> prune-packable: 0
> garbage: 0
> size-garbage: 0
> =C2=A0
> # number of commits
> $ git rev-list --all |  wc -l
> 955262
> =C2=A0
> $ cp -r /data/test/repo /data/test/replica-1
> $ cp -r /data/test/repo /data/test/replica-2
> $ cd /data/test/replica-1
> =C2=A0
> # create a branch from an existing commit
> $ git update-ref refs/heads/b_1 43fa4721c61106583cd552da85da3bd84f0f9929
> $ git show-ref | grep 43fa4721c61106583cd552da85da3bd84f0f9929
> 43fa4721c61106583cd552da85da3bd84f0f9929 refs/heads/b_1
> =C2=A0
> # number of commits of the ref
> $ git rev-list refs/heads/b_1 |  wc -l
> 117836
> =C2=A0
> # git push with bitmap
> $ GIT_TRACE=3D1 git push file:///data/test/replica-2 refs/heads/b_1
> 04:19:07.654103 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git push file:///data=
/test/replica-2 refs/heads/b_1
> 04:19:07.690006 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; 'git-rece=
ive-pack '\''/data/test/replica-2'\'''
> 04:19:07.694339 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git receive-pack /dat=
a/test/replica-2
> 04:19:07.751814 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command: git pack-objects --all-progress-implied --revs --stdout --=
thin --delta-base-offset --progress
> 04:19:07.754011 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git pack-objects --al=
l-progress-implied --revs --stdout --thin --delta-base-offset --progress
> Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
> 04:19:20.304868 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command:
> GIT_ALTERNATE_OBJECT_DIRECTORIES=3D/data/test/replica-2/./objects
> GIT_OBJECT_DIRECTORY=3D/data/test/replica-2/./objects/tmp_objdir-incoming=
-CaCTHm
> GIT_QUARANTINE_PATH
> =3D/data/test/replica-2/./objects/tmp_objdir-incoming-CaCTHm git unpack-o=
bjects --pack_header=3D2,0
> remote: 04:19:20.306550 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git unpack-o=
bjects --pack_header=3D2,0
> 04:19:20.306903 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command:
> GIT_ALTERNATE_OBJECT_DIRECTORIES=3D/data/test/replica-2/./objects
> GIT_OBJECT_DIRECTORY=3D/data/test/replica-2/./objects/tmp_objdir-incoming=
-CaCTHm
> GIT_QUARANTINE_PATH
> =3D/data/test/replica-2/./objects/tmp_objdir-incoming-CaCTHm git rev-list=
 --objects --stdin --not --all --quiet --alternate-refs '--progress=3DCheck=
ing connectivity'
> remote: 04:19:20.308332 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git rev-list=
 --objects --stdin --not --all --quiet --alternate-refs '--progress=3DCheck=
ing connectivity'
> remote: 04:19:20.344031 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 trace: run_command:
> unset GIT_ALTERNATE_OBJECT_DIRECTORIES GIT_DIR GIT_OBJECT_DIRECTORY
> GIT_PREFIX; git --git-dir=3D/data/test/replica-2 for-each-ref
> '--format=3D%(objectname)'
> remote: 04:19:20.346359 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git for-each=
-ref '--format=3D%(objectname)'
> 04:19:20.395511 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command: git gc --auto --quiet
> remote: 04:19:20.397949 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git gc --aut=
o --quiet
> To file:///data/test/replica-2
> * [new branch]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b_1 -> b_1
> =C2=A0
> # reset replica-2 and remove bitmap
> $ rm -rf /data/test/replica-2
> $ cp -r /data/test/repo /data/test/replica-2
> $ rm objects/pack/pack-9a7fc024652645a632fb82a4ff26c3ddf4883eed.bitmap
> =C2=A0
> =C2=A0
> # git push without bitmap
> $ GIT_TRACE=3D1 git push file:///data/test/replica-2 refs/heads/b_1
> 04:20:44.633590 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git push file:///data=
/test/replica-2 refs/heads/b_1
> 04:20:44.668908 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; 'git-rece=
ive-pack '\''/data/test/replica-2'\'''
> 04:20:44.673234 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git receive-pack /dat=
a/test/replica-2
> 04:20:44.720852 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command: git pack-objects --all-progress-implied --revs --stdout --=
thin --delta-base-offset --progress
> 04:20:44.723100 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git pack-objects --al=
l-progress-implied --revs --stdout --thin --delta-base-offset --progress
> Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
> 04:20:44.800298 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command:
> GIT_ALTERNATE_OBJECT_DIRECTORIES=3D/data/test/replica-2/./objects
> GIT_OBJECT_DIRECTORY=3D/data/test/replica-2/./objects/tmp_objdir-incoming=
-UOWY1E
> GIT_QUARANTINE_PATH
> =3D/data/test/replica-2/./objects/tmp_objdir-incoming-UOWY1E git unpack-o=
bjects --pack_header=3D2,0
> remote: 04:20:44.802056 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git unpack-o=
bjects --pack_header=3D2,0
> 04:20:44.802474 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command:
> GIT_ALTERNATE_OBJECT_DIRECTORIES=3D/data/test/replica-2/./objects
> GIT_OBJECT_DIRECTORY=3D/data/test/replica-2/./objects/tmp_objdir-incoming=
-UOWY1E
> GIT_QUARANTINE_PATH
> =3D/data/test/replica-2/./objects/tmp_objdir-incoming-UOWY1E git rev-list=
 --objects --stdin --not --all --quiet --alternate-refs '--progress=3DCheck=
ing connectivity'
> remote: 04:20:44.803930 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git rev-list=
 --objects --stdin --not --all --quiet --alternate-refs '--progress=3DCheck=
ing connectivity'
> remote: 04:20:44.834388 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 trace: run_command:
> unset GIT_ALTERNATE_OBJECT_DIRECTORIES GIT_DIR GIT_OBJECT_DIRECTORY
> GIT_PREFIX; git --git-dir=3D/data/test/replica-2 for-each-ref
> '--format=3D%(objectname)'
> remote: 04:20:44.836220 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git for-each=
-ref '--format=3D%(objectname)'
> 04:20:44.884165 run-command.c:654=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tra=
ce: run_command: git gc --auto --quiet
> remote: 04:20:44.886108 git.c:459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git gc --aut=
o --quiet
> To file:///data/test/replica-2
> * [new branch]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b_1 -> b_1
> =C2=A0
> =C2=A0
> It can be seen from the above operations that git push is stuck in the gi=
t pack-objects process for about 13s for a long time.
> After I deleted the bitmap, the whole git push completed in less than 1s.
> =C2=A0
> During testing, we found that not every git repository was significantly =
affected by bitmap.=20
> This may be related to the number of objects in the git repository itself=
, the number of refs, and the sha1 pointed to by the pushed branch.
> =C2=A0
> We benefit from bitmap performance optimizations for git fetch and clone,=
 but it seems that it affects the performance of git push.
> =C2=A0
> Maybe we can disable bitmap under the process of git push?
> As far as I know, the number of "counting objects" represented during a g=
it push is usually small relative to the entire repository.
> Counting objects by building bitmaps in memory may take more time than be=
fore.
> =C2=A0
> Of course, it would be better if anyone has a better solution.

This is a known issue, I think you've found the same problem discussed
in these past threads:

https://lore.kernel.org/git/38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.tw=
osigma.com/
https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/

The latter one in particular has a lot of extra details. The former also
has the suggestion of a per-push bitmap configuration as a workaround.

As your numbers show it's still an issue today, but those threads should
help you if you're looking to dig further into the root cause.

Aside from the underlying root causes it would be very nice to fix the
progress code in that area, i.e. we "stall" on "Enumerating objects",
which is just a matter of us not having a separate progress bar for the
very expensive bitmap work we're doing.
