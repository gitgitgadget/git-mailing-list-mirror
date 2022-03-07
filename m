Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB6C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiCGLSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbiCGLSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:18:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CCF7005C
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:43:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so30802155ejc.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WjIHUhh4ukTld0FJGnU195HVTrxrtrZeU+FYU2Nq76s=;
        b=YVmVCDPsY1ahOwBIexubj7qlCQ+ftAVa82uYDf63dDQEMFD3VagipRX1jMuhYDZ2ZQ
         fo9mFPa5vihZOgwbwhdbHfGnvnQ57egxBD2UedKFRN9T2bFs8z2N7JDXgKoWxrGF2U+R
         t4eHQVd0lu4QcQpAiWJ0JO7ESWCjhhWC2uLEAiuGMh5cxM6iBKbKgE5aGzSIsCZGutsn
         lth6tA2hyypkjqMPJrfpVnZwlUKye2MPUz8xZjaeZMVWFbI1pwKvIHIQVec9HvZc1oth
         1SZ7qd2i3Md9tIt1IlSCVgekAHhNNeNkzU0KF5tGWt7BAKnt3D5leh4kdynlvW3Sy2p6
         dtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WjIHUhh4ukTld0FJGnU195HVTrxrtrZeU+FYU2Nq76s=;
        b=eZ93KWAIQnsHsY3TnSiGMbUU6UrvAnsKd0nDSIv94ecikzi9QakSqlRSJDfjli2Y2a
         f7rMdzvno0eNhsYCySGAYUJG/Lj8jj42z/GOHOkynIxcUheGonqaJg5G2y44fH8jB8z4
         GlurYNg99mxuCeFz7oxeDtLTxwEy0Uotcysn8SXYO9ncykr4lez5flnjNjIG8QT+L/xx
         lcW3HkqIst9qyCZCpvr52VwDMmADJvBrsH6QxlJL3k8DVL0GbjkO5GZauyg2R73ypyAv
         xbS/Z4jqGtM/OTQ3Ulhu1C3QZdqFgD4+xnZ9vLdVctrNBPr7e8I/uMYVz5fz/37cSz1Y
         0zzw==
X-Gm-Message-State: AOAM530iSiA8xGP74ho0U9CgzG+kRJ7Fz6GkAuOBcQTHy275YfMSFL7v
        XHdJWZnsYSlQ+zBQwEiyoZOVNVk+vkA=
X-Google-Smtp-Source: ABdhPJztmeTVuxIuWiJixjWBz2ySdymoSkBJhX+HTn1xdVwsVpi/A8UpzZLeAicv7nSUsW4uQtTYqQ==
X-Received: by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id o3-20020a170906358300b006d10c07fac0mr8416068ejb.749.1646649786276;
        Mon, 07 Mar 2022 02:43:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec48-20020a0564020d7000b004164b34e071sm1067714edb.86.2022.03.07.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 02:43:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRApU-001Q9J-R1;
        Mon, 07 Mar 2022 11:43:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
Date:   Mon, 07 Mar 2022 11:37:25 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +#define kFSEventStreamEventFlagNone               0x00000000
> +#define kFSEventStreamEventFlagMustScanSubDirs    0x00000001
> +#define kFSEventStreamEventFlagUserDropped        0x00000002
> +#define kFSEventStreamEventFlagKernelDropped      0x00000004
> +#define kFSEventStreamEventFlagEventIdsWrapped    0x00000008
> +#define kFSEventStreamEventFlagHistoryDone        0x00000010
> +#define kFSEventStreamEventFlagRootChanged        0x00000020
> +#define kFSEventStreamEventFlagMount              0x00000040
> +#define kFSEventStreamEventFlagUnmount            0x00000080
> +#define kFSEventStreamEventFlagItemCreated        0x00000100
> +#define kFSEventStreamEventFlagItemRemoved        0x00000200
> +#define kFSEventStreamEventFlagItemInodeMetaMod   0x00000400
> +#define kFSEventStreamEventFlagItemRenamed        0x00000800
> +#define kFSEventStreamEventFlagItemModified       0x00001000
> +#define kFSEventStreamEventFlagItemFinderInfoMod  0x00002000
> +#define kFSEventStreamEventFlagItemChangeOwner    0x00004000
> +#define kFSEventStreamEventFlagItemXattrMod       0x00008000
> +#define kFSEventStreamEventFlagItemIsFile         0x00010000
> +#define kFSEventStreamEventFlagItemIsDir          0x00020000
> +#define kFSEventStreamEventFlagItemIsSymlink      0x00040000
> +#define kFSEventStreamEventFlagOwnEvent           0x00080000
> +#define kFSEventStreamEventFlagItemIsHardlink     0x00100000
> +#define kFSEventStreamEventFlagItemIsLastHardlink 0x00200000
> +#define kFSEventStreamEventFlagItemCloned         0x00400000

Can we define these as 1<<0, 1<<1, 1<<2 etc.? We do that in most other
places, and it helps to quickly eyeball these and see that they don't
have gaps.

> +#define kCFStringEncodingUTF8 0x08000100

Should this be an OR of some of the above, or is it unrelated?

> +typedef struct FSEventStreamContext FSEventStreamContext;
> +typedef unsigned int FSEventStreamEventFlags;
> +#define kFSEventStreamCreateFlagNoDefer 0x02
> +#define kFSEventStreamCreateFlagWatchRoot 0x04
> +#define kFSEventStreamCreateFlagFileEvents 0x10

Ditto 1<<0 etc.

> +#else
> +/*
> + * Let Apple's headers declare `isalnum()` first, before
> + * Git's headers override it via a constant
> + */




> +#include <string.h>
> +#include <CoreFoundation/CoreFoundation.h>
> +#include <CoreServices/CoreServices.h>
> +#endif

In cache.h which you'rejust about to include we don't include string.h,
but we do in git-compat-util.h, but that one includes string.h before
doing those overrides.

This either isn't needed, or really should be some addition to
git-compat-util.h instead. I.e. if we've missed some edge case with
string.h and ctype.h on OSX we should handle that in git-compat-util.h
rather than <some other file/header> needing a portability workaround.

> +
>  #include "cache.h"
>  #include "fsmonitor.h"
>  #include "fsm-listen.h"

