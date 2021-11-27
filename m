Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ECEC433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 14:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355210AbhK0OGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 09:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhK0OEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 09:04:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ADFC061574
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 06:00:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so50804937edu.4
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 06:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J2c0QssTyolTt9DoQqgkrNZS4j5Ui1CsITFo/MZNhxo=;
        b=OG1c+vcs9cZFI6o60hTWilufcH3KzINLJN5aujTBH8HTp9AJAEGBJdi3+pteW0D5Pg
         /xz2GhbJW9mtqrdsg2guH2vpX4FO5/XyQl6DVjk/5cGrXAPfOcwK2LEItt76/RYNCtAd
         4wM4gVgOlOBni2qjXGiKeGoI4+1kijENLVSmzMfqTBa7sdZjoNsUbAMGLYjby9TLDCQc
         yQm4TwFw/sqrBDrH3mhQ7h4EQUDP7CxwNOYY/7hdKstMA2lAVrZqqY9JmZcWDVkhkjB/
         XTpsFHgQKLYpJh9fGjgru786eQ6+WhMq0XzvALsA18gAz7j01MJncgrs72FVS716TBte
         JXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J2c0QssTyolTt9DoQqgkrNZS4j5Ui1CsITFo/MZNhxo=;
        b=pWSzM1/t7eZbW908UwF4kY47J1Re6+D8wOUGXRYjDrE1O+k1N/vVhsGTe5ECEpjKdQ
         n/GGeFM8C0R43bQGgkFjuB06UH7Mg+6WhkD5+Srnb4jprIEXJ1eeue/pZmtiyt9ODHv3
         nJyTqYbRqpeIm05xlAR+YqZjdrJAWFUmJ5btTeoGS1Eu4z5ecVCjY+jBCADnEBWVYJ7S
         YaLyBpGbooH5wk0y0bpP3hM+9JTlgJJYAkA5g+k8lisFgaX3mmtJisYA6oMegbaVn8Eh
         FAvch7xpo27LGwnffOUojQTtaGRAbsRTzuvZ1pMr1Se8fWKY9VP/BlMzsNQ32Dq+FXaf
         K4VQ==
X-Gm-Message-State: AOAM531ViizwK9nYjkqP9gXLhCNK48Q+BXalhfIZsMS1oorA9DBXNAaI
        ZYTp8qS222/582/p4baPJ8BxiqBchlY=
X-Google-Smtp-Source: ABdhPJzX4h73Mco+CGgfrwnDhw3CAqEH0/u30hVtIVmcxywMDDSWyx8s7EeO26BMCnZeS6HsxCBXfA==
X-Received: by 2002:a17:906:c111:: with SMTP id do17mr46314580ejc.284.1638021645953;
        Sat, 27 Nov 2021 06:00:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hz15sm4473039ejc.63.2021.11.27.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:00:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqyFv-000Vat-OU;
        Sat, 27 Nov 2021 15:00:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
Date:   Sat, 27 Nov 2021 11:40:04 +0100
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
Message-ID: <211127.86v90dhf5g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:

[Just some more "I haven't really looked at this in all that much
detail" commentary, so maybe it's stupid, sorry]

> From: Elijah Newren <newren@gmail.com>
>
> Removing the current working directory causes all subsequent git
> commands run from that directory to get confused and fail with a message
> about being unable to read the current working directory:
>
>     $ git status
>     fatal: Unable to read current working directory: No such file or directory
>
> Non-git commands likely have similar warnings or even errors, e.g.
>
>     $ bash -c 'echo hello'
>     shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
>     hello

Is that really realistic? Any "normal" command would use "pwd" or look
at $PWD, both of which "work", this error is only because we're starting
a new shell.

I wonder if it was just because you ran into our bin-wrappers edge case,
but that should be really obscure for any real users.

> This confuses end users, particularly since the command they get the
> error from is not the one that caused the problem; the problem came from
> the side-effect of some previous command.
>
> We would like to avoid removing the current working directory of our
> parent process; towards this end, introduce a new variable,
> startup_info->original_cwd, that tracks the current working directory
> that we inherited from our parent process.  For convenience of later
> comparisons, we prefer that this new variable store a path relative to
> the toplevel working directory (thus much like 'prefix'), except without
> the trailing slash.

I'm still not clear at all on why we need a "original_cwd" at all then
as opposed to just using "prefix" (or adding "the_prefix" if passing it
down is painful). I.e. we discover our relative path, we resolve the
relative path to the root, can't we use that as the "don't remove our
CWD" guard?

Does our prefix change at some point, then maybe "orig_prefix" would
make more sense?

This is with the context that I haven't dug into your code, so maybe
there's some obvious reason I'm missing...
