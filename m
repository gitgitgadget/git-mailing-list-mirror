Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418FDC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F73B613DE
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhDUGNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhDUGNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:13:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104CC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:13:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so47858487edt.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=aN2c/vCuHKv7+x+3DWWdiewfl27nqArHj8u8i8gSfK8=;
        b=YTKy3WJ9ivej3EipfIFcIaaLD8mtOryeR17IfbHptY33kg+nLJHOEnnm5ifzyMjd3C
         H+9qtjcRvV0/pkPiSLFczHhZCZ6d72TikiI1meKqsiTaTnIrcJnvUCn+98000PDjSRe/
         H6qgzZygWl4lEY3UeDjzkjZWFGnN2+IZ4wciHX/l38wnAY0d2FuH26jzDb7kPg7tuLDg
         ObVtycSqBjRxs+ufNR7LqpMNTut2rc5FAatQlUudJaKKOx5qlEWFM+ViB24ZCj8SkeDi
         MUyiadPbWZJkgEbvgbgFUP2oxRIAYT3HghhNIzltf7LL9c1+/VjF+wZsaerfsNq0qV76
         F9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=aN2c/vCuHKv7+x+3DWWdiewfl27nqArHj8u8i8gSfK8=;
        b=k4u1mD8/q+Mqgm1YVMmqXYs12TtJ3qqIHFjWhUYVZHyJzFkulnCVl/7eH/TU2/oCXV
         WNUgPVW5A738pBM2vS9PBLPCiKz7tQifMP5VTAXXEBcmnEZxFEO3xP56L8bKdVWpJrVU
         o5KrZpP11BpFZRkqziRnLz7sfkQF6DcXJ49ScrqGva7HEm0zYWGl63Jv2HZGLsjAr/1d
         bGob0q793/IvIqmq/W6vwBi8A3pqEy2MkBzrSBc5RA9qjy1EQAGmb7O6eB0LTYvcM8uh
         nPbsjoq6P+OmY18Y9pZNkgzjjPOGbvYqT/va+X9KrCFObwr8Cbu1N1suFd42HuhGJRSD
         1lSg==
X-Gm-Message-State: AOAM532aCdwUTPhtD+tn3sMkQcCBKp2hjsFAWUn965B48KnEQDfigTA/
        8rzGuLW1LOcLFbEzpcA1W5pd+4TwlBXPuw==
X-Google-Smtp-Source: ABdhPJzy06+ry6uFCboCCHquMu7zr7qiOVG5yFYwWKFtD36xLtTJTpGRXnQRSamd3CwWo7Yfp89BHA==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr4525280edr.212.1618985587174;
        Tue, 20 Apr 2021 23:13:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l6sm1235367ejc.92.2021.04.20.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:13:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 09/18] t5304: use "reflog expire --all" to clear the reflog
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <ba575839e422dfe241f7b567de14c10ec648f2e3.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <ba575839e422dfe241f7b567de14c10ec648f2e3.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:13:06 +0200
Message-ID: <87v98g413h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This is more explicit, and reduces the depency between test functions. It also
> is more amenable to use with reftable, which has no concept of (non)existence of
> a reflog
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t5304-prune.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index b447ce56a9b2..4ffc0076801e 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -94,26 +94,22 @@ test_expect_success 'prune: prune nonsense parameters' '
>  '
>  
>  test_expect_success 'prune: prune unreachable heads' '
> -

Similar to a previous comments, a few tests in that file use this
whitespacing. I'd say let's just leave it alone unlress we're doing some
whitespace-only commit earlier.

>  	git config core.logAllRefUpdates false &&
> -	mv .git/logs .git/logs.old &&
>  	: > file2 &&

Also, if we're re-styling things: ">foo" instead of ": >foo".
