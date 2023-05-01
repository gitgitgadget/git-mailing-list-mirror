Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54BAC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjEARQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjEARNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:13:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF51A6
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:12:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-959a3e2dc72so558108566b.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682961135; x=1685553135;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTr3y3K6SFZew3fnWgwr/JXUAEKdyQsZwG/7NflWuwo=;
        b=K6MP7X7buKnjJQ2tbDjQugZtxo+UTkQxjbIOCodaVd532UDhN9Enr1Ac+zkHzLr7cm
         jm31WpfxSiDQSAdDXXdl0WPe0DlSCeVlHKodr/PzrH/PPUoCELcBQdCL/mo1D9Qr1V2o
         tm8IHMXxpcfxsZDJdq5qlJvtDmipBGw7pEWvTNOEd9QMcHCy1l2rxsP0aebHNxx8bBqJ
         JUkh5lxoNnz3bFGBJbnaBD4EKH0tv/pEePf66WJ3AF/Mc719gkJORn8KSv1StXpPep1W
         mdY5ft6UDo6SHLbXE1TopwZ07RpHlMXP3BqyMO3Xdk1bRsw2XmYi24PV50VtbPkqpDaK
         NMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961135; x=1685553135;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTr3y3K6SFZew3fnWgwr/JXUAEKdyQsZwG/7NflWuwo=;
        b=EFSd/bVkqWkcODydY1dTsvBr6wMLIah9cC2b5n4BcATYtcQgHmfcKVujoKBUDTgIn/
         foom5yLoC633iDAS41Fw93mtLIf9uP52VFreQ2NVAcOwRFNjUsIzxZ66c4vN/xmUpRsO
         Kl8Tyvgp9Q2TJJo5dwM/BSypIBjWf3yObXFgIc/UDAFOU/bgeSbA/5g2KHtjzvFH+Sck
         a1DPIzigC/03HqFUhmSnLuCdA8aToKIYPdDB/yPC7ATdZ6om40RXv5qQEPri0c1Emwqy
         vtWszEoxtpulcAqjpSnV58SJ1d+hQhcstf5/dp+gOhOsY04t2RFopejqK4JVPL+r65bI
         c0ow==
X-Gm-Message-State: AC+VfDzvrWYCBznupTM4RWWVT7MT3GvDJfjcpDWGfnysVxxVFjfHfmeT
        3XczxctiyW1UZ7CN8cGME9+9wXp3Uw0=
X-Google-Smtp-Source: ACHHUZ654AIwynsAH5VuSRRaprjf7i8/7Lob7b5dq5OJ6iVTO7KcvqAfqSNx+WmuOQNtUiRNl731kw==
X-Received: by 2002:a17:906:6a28:b0:906:3373:cfe9 with SMTP id qw40-20020a1709066a2800b009063373cfe9mr16934454ejc.10.1682961134880;
        Mon, 01 May 2023 10:12:14 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q26-20020a170906941a00b0094f01aa9567sm14923912ejx.20.2023.05.01.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:12:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptX4M-000FBc-03;
        Mon, 01 May 2023 19:12:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 21/22] diff.h: reduce unnecessary includes
Date:   Mon, 01 May 2023 19:11:22 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <b7a96a08d1463ec51f0d8384012d812fd5f43537.1682194652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <b7a96a08d1463ec51f0d8384012d812fd5f43537.1682194652.git.gitgitgadget@gmail.com>
Message-ID: <230501.86edo0ht7a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  attr.c              | 1 +
>  diff.h              | 1 -
>  http-push.c         | 1 +
>  line-log.c          | 1 +
>  pack-bitmap-write.c | 1 +
>  reflog.c            | 1 +
>  tree-diff.c         | 1 +
>  7 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/attr.c b/attr.c
> index 2d8aeb8b58c..ddf2b0cbc2e 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -20,6 +20,7 @@
>  #include "object-store.h"
>  #include "setup.h"
>  #include "thread-utils.h"
> +#include "tree-walk.h"
>  
>  const char git_attr__true[] = "(builtin)true";
>  const char git_attr__false[] = "\0(builtin)false";
> diff --git a/diff.h b/diff.h
> index 53aeb02a54b..69e574f4315 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -4,7 +4,6 @@
>  #ifndef DIFF_H
>  #define DIFF_H
>  
> -#include "tree-walk.h"
>  #include "pathspec.h"
>  #include "oidset.h"
>  #include "strbuf.h"
> diff --git a/http-push.c b/http-push.c
> index 3f184986362..866ba243a89 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -16,6 +16,7 @@
>  #include "sigchain.h"
>  #include "strvec.h"
>  #include "tree.h"
> +#include "tree-walk.h"
>  #include "packfile.h"
>  #include "object-store.h"
>  #include "commit-reach.h"
> diff --git a/line-log.c b/line-log.c
> index 10c19daec4a..6a7ac312a43 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -18,6 +18,7 @@
>  #include "setup.h"
>  #include "strvec.h"
>  #include "bloom.h"
> +#include "tree-walk.h"
>  
>  static void range_set_grow(struct range_set *rs, size_t extra)
>  {
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 3d3fd380654..cdffe2ce47d 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -19,6 +19,7 @@
>  #include "prio-queue.h"
>  #include "trace2.h"
>  #include "tree.h"
> +#include "tree-walk.h"
>  
>  struct bitmapped_commit {
>  	struct commit *commit;
> diff --git a/reflog.c b/reflog.c
> index 57dc7c0d051..ee1bf5d032c 100644
> --- a/reflog.c
> +++ b/reflog.c
> @@ -5,6 +5,7 @@
>  #include "refs.h"
>  #include "revision.h"
>  #include "tree.h"
> +#include "tree-walk.h"
>  #include "worktree.h"
>  
>  /* Remember to update object flag allocation in object.h */
> diff --git a/tree-diff.c b/tree-diff.c
> index 9ea2dd7a6c3..20bb15f38d9 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -5,6 +5,7 @@
>  #include "diff.h"
>  #include "diffcore.h"
>  #include "tree.h"
> +#include "tree-walk.h"
>  
>  /*
>   * Some mode bits are also used internally for computations.

This, unlike the preceding 20/22 really does seem to strictly match its
$subject, i.e. diff.h didn't need tree-walk.h, but some stuff using it
needed it, so we're moving the include to those users themselves.
