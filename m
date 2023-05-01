Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064CC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjEARYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjEARYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:24:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC2AF
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:24:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9536df4b907so579880566b.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682961882; x=1685553882;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1po45Fu97u7LcCH+OUpGhIlYaPWLFHFd9aRtW5Qpo3U=;
        b=h7gH21BAP9ai7yrdSEFWRmKxAFF7PDvwHXkoDCtZzaQSvvQzuCZpPTAKouJGnm49T/
         751CMd9nY8m93EfDyvyAp133EjJ4lWXu1zrVHS4+hBpE7qaM2eSfTWx7BXP571uptrlC
         u7pUiPTO2ZXZzk6vQ/H6f6lCnSEotNuljaA0FVUb7/vgKgawdaCU4a1rrLwNQl6LNA2g
         haf0NVp4ks3O23IJRwHlUDwU9zz5GRE7BPEEGIb4ex4JaP1HURuOam66csb2A73UonPA
         UbGYHx3jcTI6vXWcfZ1aVZMw0T3jSdzaidiggK/bI4V99S2vrLPdmG7dIbPmff/wxDk6
         kSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961882; x=1685553882;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1po45Fu97u7LcCH+OUpGhIlYaPWLFHFd9aRtW5Qpo3U=;
        b=E/+aYIBp65aLLknIRD9nd1XxQWjEITe97tiY7PSA4AZNhZHM0qUEpulvjj5Qsbu4Mz
         nDt4njr4xV2lHXhrYVtQeAzAL0gXjcdC3HGiVwzishYQUOIhGotZtYBwp5u7qHV0h5+M
         yC1OjsALV0bPwmcCecDLPrdhFVrZp+Co5sPqbbBVVWGCECuYhTdcTbysoAbgqNSx3wdV
         fCGtCGlJT2BK7LparI/MmEmp+Sl7d2s+YCOnamUVkiFsuIvnwo+IhtST5HaonAHWrGuS
         gwKAmZ8aGOZ7DFbZVd333x0VoWTYqCBC1N1AL7+ImkLIGZ2zM1EmIbxwDC6ZTmxHbTa1
         tlIQ==
X-Gm-Message-State: AC+VfDzNs1Umf83H1/pWg/Z7h1A3FhIlvIHkUGsuwvjoHKn3sjbG9hT0
        wt5QqcFC7sqziRUcYd1NF8uaVckaMrg=
X-Google-Smtp-Source: ACHHUZ72MtEYzMWfbB0qmCU2XtHQT0+/PzWMuFdVoKHd1np7UgHMsEFP3ZMZG4j8LSqv6pFEM6DLpQ==
X-Received: by 2002:a17:907:9304:b0:94e:4c8f:759 with SMTP id bu4-20020a170907930400b0094e4c8f0759mr15339298ejc.38.1682961882383;
        Mon, 01 May 2023 10:24:42 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t1-20020aa7d4c1000000b005066cadcc54sm12381905edr.43.2023.05.01.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:24:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptXGT-000FeG-1k;
        Mon, 01 May 2023 19:24:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove
 dependency on repository.h
Date:   Mon, 01 May 2023 19:17:11 +0200
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
 <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
Message-ID: <230501.86a5yohsme.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> [...]
> diff --git a/checkout.h b/checkout.h
> index 1917f3b3230..3c514a5ab4f 100644
> --- a/checkout.h
> +++ b/checkout.h
> @@ -1,7 +1,7 @@
>  #ifndef CHECKOUT_H
>  #define CHECKOUT_H
>  
> -#include "hash.h"
> +#include "hash-ll.h"

The end-state of this topic is oddly inconsistent in when it uses
includes, and when it uses forward declarations.

As I note in a reply to 20/22 you're adding forward declares there, I
think that's fine, but if you opdet for that why not do that here. The
body of this header only defines one function, which takes a pointer to
a "struct object_id".

Whereas above you did this change:

> diff --git a/apply.h b/apply.h
> index b9f18ce87d1..7cd38b1443c 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -1,7 +1,7 @@
>  #ifndef APPLY_H
>  #define APPLY_H
>  
> -#include "hash.h"
> +#include "hash-ll.h"
>  #include "lockfile.h"
>  #include "string-list.h"
>  #include "strmap.h"

There we really should include it, as we're not dealing with a pointer
to the "struct object_id", but the struct itself, so we need its
definition, and don't want to find it implicitly.

> diff --git a/chunk-format.h b/chunk-format.h
> index 025c38f938e..c7794e84add 100644
> --- a/chunk-format.h
> +++ b/chunk-format.h
> @@ -1,7 +1,7 @@
>  #ifndef CHUNK_FORMAT_H
>  #define CHUNK_FORMAT_H
>  
> -#include "hash.h"
> +#include "hash-ll.h"
>  
>  struct hashfile;
>  struct chunkfile;

Then we have this, where we seemingly could avoid the include as well,
and just add a:

	struct git_hash_algo;

Anyway, I'm not saying one is better than the other, I'm just wondering
why you're picking one, but not the other.

Is it because you know that hash-ll.h doesn't bring in other headers, so
its inclusion is OK, whereas later in e.g. 20/22 you avoid including
strbuf.h, because you know that'll bring in string-list.h?

If that's the case maybe we should just move
strbuf_add_separated_string_list() into some "used by merge-ort.c and
merge-recursive.c" file, remove the string-list.h includion from
strbuf.h, and then include "strbuf.h" without fearing the side-effects
elsewhere?
