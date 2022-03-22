Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D9C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiCVS3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiCVS3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:29:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B790FF5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:27:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a17so21704699edm.9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ChFGlFkos03bdjnYPUDfHF/ayTWWAreO2M42JCxi5k4=;
        b=WpL1MvzQOnncYwbc6NvD52WMr3+KVao51IY1R0zm7tI4WIv7nrHV7X/f9yh9n+VvKR
         Fj3oQJKcFJWZnNO6zUorxRWHZvhcCCFql/EI1iaszmtqd6H2q1pIJ6KQt2TZKx35PS/T
         iGabdVD3sJy8TS30g3oOX18XiM/3zocx7haG6bxX7j1kLbsMD3hmoj8VH7f8PjZgLJMB
         qwAfauCnAPpE9ns7O44yqR6JS39zqOSSNvByGXGa3avhcPLc1gGfmgOllkEK307gVLJ+
         xo9WEjEsbcw3UhkHBNjwf+vy86XRbDPnenSsW7qi53PMZoLsF+ocYGWmt9lCfmaX04gx
         0iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ChFGlFkos03bdjnYPUDfHF/ayTWWAreO2M42JCxi5k4=;
        b=VJcuoBxZla91+k4sJmTEeST9bLLtjtMa5pIbyTYPqV0jy43XMvEr7x5AqAURWa0siH
         JpKwowTrQCGOPHkQzDlCU8LLGagobHIAemKJGdGVWk75SfMlDzHNPsiPllzjTSPUnzf/
         AqrwLXV1IfHwdreFTZ7WKZUuxjeEs0QXHqK72DblHMdvA4YrWenzHixCjDtHKMgW2Kzr
         BXpj4Og0Hggqh0wcORy/j2EWpWZBJQZhC+3dd6FFLAYtHztFmIDdlle8AiLQ+zagVuKp
         VxyKPGFrMLtW4PkdIvKoUduKmJWb5tjRn+uT0++mdjmvZlBtsO5y1H+ju8HeGOPw8M3R
         x2Bw==
X-Gm-Message-State: AOAM5331PSGEubW4LdBym4bI8EbV5skHMSS8oSSGuukPC2BBVAndVUwg
        87VXC++WZ/sLX8en2QUpMOvUEiANhYUSFw==
X-Google-Smtp-Source: ABdhPJxO5QRYIU1Fa640Qod51mwuHGo+D/t2NdKDTLapmSlXgo7/PJ1gE8qal3DZYzLY3l8ZQ3a0Jg==
X-Received: by 2002:a05:6402:1107:b0:416:439a:6a9e with SMTP id u7-20020a056402110700b00416439a6a9emr29528915edv.382.1647973666874;
        Tue, 22 Mar 2022 11:27:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm8463983ejl.122.2022.03.22.11.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:27:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWjEP-000Bs8-IN;
        Tue, 22 Mar 2022 19:27:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 16/29] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
Date:   Tue, 22 Mar 2022 19:19:53 +0100
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <14b775e9d8b1a4672f8175a546eb70e2790c1b23.1647972010.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <14b775e9d8b1a4672f8175a546eb70e2790c1b23.1647972010.git.gitgitgadget@gmail.com>
Message-ID: <220322.86ils5q1um.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
>  compat/fsmonitor/fsm-darwin-gcc.h    | 92 ++++++++++++++++++++++++++++

It's much nicer to have this compat-for-the-compat in its own
header. Thanks.

>  compat/fsmonitor/fsm-listen-darwin.c | 24 ++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 compat/fsmonitor/fsm-darwin-gcc.h
>
> diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
> new file mode 100644
> index 00000000000..1c75c3d48e7
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-darwin-gcc.h
> @@ -0,0 +1,92 @@
> +#ifndef FSM_DARWIN_GCC_H
> +#define FSM_DARWIN_GCC_H
> +
> +#ifndef __clang__

This was surprising, until I remembered that clang tries really hard to
pretend to be other compilers. I wonder if we should steal the macro
check from compat/compiler.h into something more generic & use it here,
probably best as a follow-up...

> [...]
> +#endif /* !clang */
> +#endif /* FSM_DARWIN_GCC_H */
> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index c84e3344ab9..d2ce942cade 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -1,3 +1,27 @@
> +#ifndef __clang__
> +#include "fsm-darwin-gcc.h"
> +#else
> +#include <CoreFoundation/CoreFoundation.h>
> +#include <CoreServices/CoreServices.h>
> +
> [...]
