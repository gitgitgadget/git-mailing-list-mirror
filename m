Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAEBECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJaXvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaXv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:51:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC06359
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:51:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f5so11781409ejc.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSgG5kCiX76ys2jVuConXjmEMSJjvHrC8gOEFSZwlCY=;
        b=oRCwO2yIj7puS3FGr5D0Z9d5DArg1LE7NYvInVZCrK2ttOruu64py+NXi0cYNTpYBE
         OPiXU/ffgGgz1MPl9h4aoFFnZ8NTGgEm6cr0CawbkXVX/gWYoUc+Q1CPIrZZv8DTglkn
         Go5eaiiLio+yG633s88LPNqzucP0Yhzbyo5ZK2nvvQRD2llrHM2Go14M1/NzqmU877D+
         FYKZ/O6SDjmJ9lP9fSWYweOp9D6+ezJSHSfQ5XeXojwAfeys1LiWDyqX0k4LgpeZ0c6B
         oIaTbuj9uPitnnz8YpcA+gl+gnWecAl0WSl/H9dfDO+BrTCYGLCbCxeg3wk4T6pbCJkq
         WrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSgG5kCiX76ys2jVuConXjmEMSJjvHrC8gOEFSZwlCY=;
        b=HHxbDS1p4ZmDOKr6TL6AMXvxudYoktI3pA+EzNX7hd1/A7HcYdoyrtd1e9MrPJQcAc
         qP+TAMXgiXIFoBi5HIeUlO469OWOp3yhY5O2N4LouJJiSC30UUsXjxT/Ep/w2+UzbIZX
         Pteah6PNXdmsM6v7N2jRUrO5iwiNh1JeX0NHlQBd0sWgcULTHeKME8R4UrzY0j7UzTZn
         Fd5pfvjZeEI5T51x3DUez5uOHtBLK90LTpsgzhsTtxBcnzBl6hy7sgebYHxVAlrUJyMx
         3QxkiRgohL8xDqpEmgKV8eA7xfEb+OOF81cmLgJ5sozZzsCXV0zU7f2vZdNf/E1u6RCS
         CTxA==
X-Gm-Message-State: ACrzQf0ACfGC6HEuRVi0X8RWr3cvEX/TGl6mPH+xFmv83a2FUGupFzMF
        +yyftH4eUbdlP3rjkrQi3YjXQfIjj0QgcA==
X-Google-Smtp-Source: AMsMyM4kxMy4UjRKeWpFJfZkLGz1WC8DZ2hJ07yZYakFnEQ0FPOaerHfzHaPukObOtCBMCoZasLKjQ==
X-Received: by 2002:a17:906:db02:b0:780:24e:cf9 with SMTP id xj2-20020a170906db0200b00780024e0cf9mr15148851ejb.460.1667260287117;
        Mon, 31 Oct 2022 16:51:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id nd38-20020a17090762a600b007a62215eb4esm3555152ejc.16.2022.10.31.16.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:51:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opeYw-00AvE5-16;
        Tue, 01 Nov 2022 00:51:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: ab/misc-hook-submodule-run-command (was: What's cooking in git.git
 (Oct 2022, #09; Mon, 31))
Date:   Tue, 01 Nov 2022 00:46:57 +0100
References: <Y19dnb2M+yObnftj@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y19dnb2M+yObnftj@nand.local>
Message-ID: <221101.86iljz5z7l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Taylor Blau wrote:

> * ab/misc-hook-submodule-run-command (2022-10-31) 3 commits
>  - run-command tests: test stdout of run_command_parallel()
>  - submodule tests: reset "trace.out" between "grep" invocations
>  - hook tests: fix redirection logic error in 96e7225b310
>
>  Various test updates.
>
>  Waiting for review.
>  source: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>

I think per
https://lore.kernel.org/git/221031.86tu3k6u2d.gmgdl@evledraar.gmail.com/
&
https://lore.kernel.org/git/221031.86pme86tcg.gmgdl@evledraar.gmail.com/
that this is ready to advance.

If you don't agree about the 2/3 let's just drop that one. I don't
really care enough to start some alternate rewrite proposals for that
random test which I didn't add in the first place, so I don't really
have the motivation to fix it. It just seemed like an easy enough
post-cleanup for an earlier landed topic.
