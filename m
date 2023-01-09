Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB41EC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjAITVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjAITVL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:21:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E931A826
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:21:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o15so7022021wmr.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 11:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6XLwGTZLyWrxP5Kv09SF7UpcEzokOXuZWqZNjED9UU=;
        b=PZHGcRwdasox2DfUU6sYRBGJoNlK5iOhQTlw80hvewlqWSYnV99odugkql86YPWkZ5
         UVFaB91STVWqGpqMPU62hcZRNMaMQ0jZ/sJWRm3CGUoDcbS0pQk2MHAOT+v4V8BvotMo
         r5Ft94xWQeYWK6XwzYgkBMx8UPH18bMNkVAqlzvRhcrbkT/m1PfiJ1Z3lUxajal/LPUb
         +I6uirr9Bz+kVWXtXTvuPM1O9Xzco2nA58EfjLvjmdIgLy9Pqq/GHN1Mh1B2KXvsDHkO
         nqQVCviDaCE7mNl5W93U29qftmCZm7Q8dqS1QkXagfpa8HQNEJVVywKwwrnNI+xvWSfb
         n72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6XLwGTZLyWrxP5Kv09SF7UpcEzokOXuZWqZNjED9UU=;
        b=TU6azdfbV62YurruZaaYuBRRELxd1VEwzm4tHz7ZTiODvyLZ0JebKiT2IsNKmLmGAs
         erGhFK68rvJLMu3OeP4lSHFW5AKCXuIF9jCrUMroL1m8+fwpb/oahU8Z+z0cY0Wgs7kL
         sbrPNuEn78nzv0XJQFiXCIJGVYPSgeYpisFLBA2YAmXixbUrBdSh37XXBDDr5oFouiB1
         LwRmiwiMxm5aqzudm9C4tSuRMMU0qO7PUyiG4DUc04Pxr+oB+4SqEis1m/iqddKr9B1o
         oe83IHaRwA1fcfDJoUVz4uPRjEH1aA0OCKcGFK137mz5jTC09u9/Vm6gXNXf18FZ9RbP
         7Shg==
X-Gm-Message-State: AFqh2koBTi07kifLLb3eMAAP7+VINKbymXrBHgGgaAHJOAw5f5JlBTCn
        ia/2LXol6n7ZpM2VUA/6CIg=
X-Google-Smtp-Source: AMrXdXsbxiQdA9vjtC0iI4y7bPaKCYdbG4ogi0s5Z0tYu63jw0V5bHP/MQD9VPRYtpK2haLg1SfT/w==
X-Received: by 2002:a05:600c:540a:b0:3d9:ebf9:7004 with SMTP id he10-20020a05600c540a00b003d9ebf97004mr4972283wmb.29.1673292069029;
        Mon, 09 Jan 2023 11:21:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm19177797wmq.22.2023.01.09.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:21:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pExhj-000B0h-2y;
        Mon, 09 Jan 2023 20:21:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 0/4] worktree: Support `--orphan` when creating new
 worktrees
Date:   Mon, 09 Jan 2023 20:20:28 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20230107045757.30037-1-jacobabel@nullpo.dev>
 <20230109173227.29264-1-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230109173227.29264-1-jacobabel@nullpo.dev>
Message-ID: <230109.86eds31plo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 09 2023, Jacob Abel wrote:

> While working with the worktree based git workflow, I realised that setti=
ng
> up a new git repository required switching between the traditional and
> worktree based workflows. Searching online I found a SO answer [1] which
> seemed to support this and which indicated that adding support for this s=
hould
> not be technically difficult.
>
> This patchset has four parts:
>   * adding `-B` to the usage docs (noticed during dev and it seemed too s=
mall
>     to justify a separate submission)
>   * adding a helper fn to simplify testing for mutual exclusion of options
>     in `t/t2400-worktree-add.sh`
>   * adding orphan branch functionality (as is present in `git-switch`)
>     to `git-worktree-add`
>   * adding an advise for using --orphan when `git worktree add` fails due=
 to
>     a bad ref.
>
> Changes from v7:
>   * Changed test_wt_add_excl() to use `grep -E` instead of `grep -P` (2/4=
) [2][3].
>
> 1. https://stackoverflow.com/a/68717229/15064705/
> 2. https://lore.kernel.org/git/xmqq7cxxzefp.fsf@gitster.g/
> 3. https://lore.kernel.org/git/230109.86r0w328nu.gmgdl@evledraar.gmail.co=
m/

I've looked this & previous iterations over carefully, and this now
looks good to me. Thanks for sticking with this so long.

For what it's worth (if Junio would like to add it):

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
