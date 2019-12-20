Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25FC2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A18C20866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFZmPXfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLTSvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:51:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43307 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:51:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so10359499wre.10
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XTvg1fozl0HuZtvYkG6pkOfqInbpSWgTeDS4bGBXYbM=;
        b=fFZmPXfco19vhdg8QRzQKobkt+R/gRBjnXIDNw9rMq2fPjHbfh1UO5r+pxV8sq70C5
         dxbmLSz95PwqmI/Of/05kkKDOfbvV56yLUJA6Xt5D1qooEn5u2oiXTJWJgytmkHwCLNP
         huD3RpsYLu/TfvIWdysZV0QOWyem1EDOfTSk8T9XwSe9ZkQJQjQUjKP3XGuriJVcrkrX
         ugxdqihjV85MCpUstPynAKZEp3MWWddBkaMFBajlQtu5oy47guKFy64Vlpi+TCfldxUT
         g4gYdJlShsLEJ67nrlmb/2Q1JRNgHCJk9NTjNBPR3E3izWds7xV9azw+8Zv/L53Qv9zj
         eIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XTvg1fozl0HuZtvYkG6pkOfqInbpSWgTeDS4bGBXYbM=;
        b=XDlKOclY+9iBJbjsy2YHyn+DBFAykZCmgXn+KVIOhSKPeTowjbldcLGBFTaAOon7CK
         D5vFaffUx9k+ZcTPvf/z/Ep6WzRYKNXKJ1hRJMt3Fwpf6f7YvDI8NlUz4nuxqF1AFq14
         LOl6JroJ6KRn3QlmNikRJqm1de7cSNhht79jVBzDl4JEGzsyDBVqiGRx5G3bmg9TFfkh
         CPYv9GuyPjRXAWkmi51UuKoDxmf0f+cfJ1xK0Mt1McwCbBFYtJQHMn828TWYqiUAilj+
         +AKmRWYCPtkn7I8C4rgw2VbvUfPe0qXFTROL0A9XeljCYPbbov8B2ZAN2oK94Gu+3Tvf
         PF9w==
X-Gm-Message-State: APjAAAXDDNLeg2QjoShQpDgMJ1W0JQeh5Wz2FttJHvM8w0BSOz4OEPLO
        cYVbScOLUNgL/jNlhjfG+NU=
X-Google-Smtp-Source: APXvYqzwfox5hZc7wLgKoEUHrUZKIEQNjyLHHx+zAu9NhivF+6+Q5uApA+Mpys98ifyxacV/OImLXw==
X-Received: by 2002:a5d:480f:: with SMTP id l15mr16758087wrq.305.1576867905299;
        Fri, 20 Dec 2019 10:51:45 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-84-217.w90-5.abo.wanadoo.fr. [90.5.87.217])
        by smtp.gmail.com with ESMTPSA id c9sm10141371wmc.47.2019.12.20.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:51:44 -0800 (PST)
Subject: Re: [PATCH 00/15] rebase: make the default backend configurable
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <0387d5b2-6b53-a428-291b-2489a9447bf3@gmail.com>
Date:   Fri, 20 Dec 2019 19:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 20/12/2019 à 18:09, Elijah Newren via GitGitGadget a écrit :
> This series does a lot of work around making the default rebase backend
> configurable:
> 
>  * provide configurability of handling empty commits and iron out
>    differences between backends
>  * increase/fix capabilities of the merge/interactive backend to make it
>    workable as the default
>  * document the remaining differences in backends more thoroughly
>  * add an --am option for explicitly requesting the am-backend
>  * extend merge/interactive backend testing to put it on par with the am
>    backend
>  * add a 'rebase.backend' config option and:
>  * switch the rebase.backend default value from 'am' to 'merge'.
> 
> Areas I'd like reviewers to focus, in priority order:
> 
>  * Patch 15 (Are we ready to switch the default backend? Or should we leave
>    this patch out for now? Junio suggested we may be ready or at least are
>    close[1])
>  * Patch 1 (Does my empty handling make sense? Do others agree I fixed 
>    --keep-empty, or do they view it as breaking it?)
>  * Patch 8 (Do the updates to the documentation of behavioral differences
>    make sense? Is it too long?) * Patch 11 (okay to change the
>       git-completion shell prompt slightly, especially in light of patches
>       15 & 16? We did a prompt change previously when we merged the merge
>       backend with the interactive one, so I assume so, but just want to
>       make sure people have a chance to chime in.)
>    
>    
> 
> If it's too soon to switch from the 'am' to 'merge' backend, we can just
> drop the last patch and I'll resubmit it later. I generated this series
> mostly through switching the default first and then watching what broke, but
> moved the patch to the end to make it easy to drop.
> 
> Briefly, reasons for switching the default backend boil down to the fact
> that the am-backend drops information and thus limits what it can do. This
> manifests in different ways:
> 
>  * lack of tree information that would allow us to warn users that new files
>    in old directories might want to move along with the other files that
>    were renamed with those directories[1]
>  * incorrect application of patches in the presence of non-unique context
>    lines[2], which could be avoided with access to the original files
>    involved.
>  * less information available to annotate conflict markers (since am creates
>    fake ancestors and commits on top of them, and doesn't have access to the
>    original commits)
> 
> [1] https://lore.kernel.org/git/xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com/
> [2] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
> [3] 
> https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
> 
> Elijah Newren (15):
>   rebase: extend the options for handling of empty commits
>   t3406: simplify an already simple test
>   rebase, sequencer: remove the broken GIT_QUIET handling
>   rebase: make sure to pass along the quiet flag to the sequencer
>   rebase: fix handling of restrict_revision
>   t3432: make these tests work with either am or merge backends
>   rebase: allow more types of rebases to fast-forward
>   git-rebase.txt: add more details about behavioral differences of
>     backends
>   rebase: move incompatibility checks between backend options a bit
>     earlier
>   rebase: add an --am option
>   contrib: change the prompt for am-based rebases
>   rebase tests: mark tests specific to the am-backend with --am
>   rebase tests: repeat some tests using the merge backend instead of am
>   rebase: make the backend configurable via config setting
>   rebase: change the default backend from "am" to "merge"
> 
>  Documentation/config/rebase.txt         |   8 ++
>  Documentation/git-rebase.txt            | 150 ++++++++++++++++----
>  builtin/rebase.c                        | 181 +++++++++++++++++++-----
>  contrib/completion/git-prompt.sh        |   2 +-
>  rebase-interactive.c                    |   4 +-
>  rebase-interactive.h                    |   2 +-
>  sequencer.c                             |  80 ++++++++---
>  sequencer.h                             |   6 +-
>  t/t3400-rebase.sh                       |  36 ++++-
>  t/t3401-rebase-and-am-rename.sh         |   4 +-
>  t/t3404-rebase-interactive.sh           |   2 +-
>  t/t3406-rebase-message.sh               |  19 ++-
>  t/t3407-rebase-abort.sh                 |   6 +-
>  t/t3420-rebase-autostash.sh             |   2 +-
>  t/t3421-rebase-topology-linear.sh       |   4 +-
>  t/t3424-rebase-empty.sh                 |  89 ++++++++++++
>  t/t3425-rebase-topology-merges.sh       |   8 +-
>  t/t3427-rebase-subtree.sh               |  16 ++-
>  t/t3432-rebase-fast-forward.sh          |  59 ++++----
>  t/t3433-rebase-options-compatibility.sh |  13 +-
>  t/t5407-post-rewrite-hook.sh            |  12 +-
>  t/t5520-pull.sh                         |  27 +++-
>  t/t6047-diff3-conflict-markers.sh       |  13 +-
>  t/t7512-status-help.sh                  |  12 +-
>  t/t9106-git-svn-commit-diff-clobber.sh  |   3 +-
>  t/t9903-bash-prompt.sh                  |   6 +-
>  26 files changed, 582 insertions(+), 182 deletions(-)
>  create mode 100755 t/t3424-rebase-empty.sh
> 
> 
> base-commit: 12029dc57db23baef008e77db1909367599210ee
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-679%2Fnewren%2Frebase-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-679/newren/rebase-fixes-v1
> Pull-Request: https://github.com/git/git/pull/679
> 

BTW, I have investigated on the performance regression when split-index
is enabled, I’ll give my conclusions next week.

Cheers,
Alban

