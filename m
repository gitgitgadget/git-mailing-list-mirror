Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B78C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A055611AD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhETPir (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhETPiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:38:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37A8C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:37:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id s22so25794372ejv.12
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6SRm60UvoIFNNiHWyl/sAcyW+SdMiMYI6X8eBObM6bI=;
        b=moI7maQGjGIiCK090uC/lKGDHC/gmSE5ZB5Iph/1qUNV96tUp3mCXcPl5JeWRqe/Fm
         DPoCnUEwv5kDI3fCUNORwODoDwktvGHaS6Oxf2U4dx2zgc7AUHeQ51u8dFuWfnj9fwuK
         hLk3+EWFQqBK5FRhal6nxRcBxXtHv9wFOMX1kUgFSoEAeUQebjyvYX6SsvRpB4kry/qw
         nouL0/fvnOzGYuGh3c7M/Fo4EMUElKKMtYy4Jxjc1UD0H3X+5Gvy3xT697RtvsiWUkA4
         2IRlvJzWg6h7vhNp2m1ouvUle9I/mNkRHMf5AKfWxyI9QCEvBP5kTD8rogf2cVqWqC1D
         dD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6SRm60UvoIFNNiHWyl/sAcyW+SdMiMYI6X8eBObM6bI=;
        b=T8RdYKT/VjbhFf4RPED9cWQGEkBxvhWykOmcQA98suyEzYaU1kDSJS1AHfU+d8mW/T
         kz781nV2kNWGTaFEmHIjHZhf71mJsgjKVzi0SGNLuh2kdfpdmLSjqqYLOLIuIqbyEyNM
         uMTwmZ3HKeymWEKIMpTiiZCJ8JmgZOy6UxO3wGBfQ7ni0l51BVMOtz1bc5zbFWjsJIo+
         etP+nHPdtMJZLZuJH5RibAE4i2LefsZTVsUkyfkvn3+OibCvA+kkVMB7uGdVs5eBlquk
         OR71u2jT6WXsUxsbSKM7FeM2gJv4jEA+HGsUfkAYqcbYb45/IcG/8O+VXbQG1Ck53fP7
         D5pw==
X-Gm-Message-State: AOAM531PTeGCEhDOWJSVH9T9h9GAt8eXC9frxWa+qnxr2XHO6CBl0V4w
        lPleIgRV9FyUv33e1uDhCmviptBQzQkAog==
X-Google-Smtp-Source: ABdhPJy/6faKSanqyEqRy6y8eiUYYu9oZ1AG/cPUSc6jbEsZbk6KQcF0tfjy0zEpf9XAz17SEp9/8A==
X-Received: by 2002:a17:907:217b:: with SMTP id rl27mr5353849ejb.421.1621525043115;
        Thu, 20 May 2021 08:37:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o8sm1563198ejm.18.2021.05.20.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:37:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 15/21] t1414: mark corruption test with REFFILES
Date:   Thu, 20 May 2021 17:31:28 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <0d3b18cd35423dadd35d55073bd7230bfc908fee.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <0d3b18cd35423dadd35d55073bd7230bfc908fee.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87pmxlpgb1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The reftable format guarantees that reflog entries are well-formed
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1414-reflog-walk.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
> index 80d94704d012..72a5ac61a520 100755
> --- a/t/t1414-reflog-walk.sh
> +++ b/t/t1414-reflog-walk.sh
> @@ -119,7 +119,7 @@ test_expect_success 'min/max age uses entry date to limit' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'walk prefers reflog to ref tip' '
> +test_expect_success REFFILES 'walk prefers reflog to ref tip' '
>  	head=$(git rev-parse HEAD) &&
>  	one=$(git rev-parse one) &&
>  	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&

Isn't the point of this test added in 7cf686b9a8 (t1414: document some
reflog-walk oddities, 2017-07-07) to test what we do not when the reflog
isn't well formed, but when the reflog and branch history disagree about
what the latest tip is?

Perhaps reftable is going to guarantee that that'll never happen via
some transaction mechanism (I'm not sure), but if I'm right then I think
it's worth at least calling out that difference in the commit message
and/or modified test description.

Not a big deal, but this also makes me somewhat question the name
"REFFILES" as a prereq if we really mean (as we are in the first test
that uses this) "we don't need this under reftable, specifically".

Maybe I'm overthinking things and it's stupid to split these up, as we
have no other planned ref backend, but for any such future test backend
/ readability I'd find it much easier to grok if we clearly
deliniate/use REFFILES for tests that really are testing the ref files
backend specifically, v.s. say a !REFTABLE for things that we're
skipping because REFTABLE in particular makes certain guarantees we can
count on. Say that the reflog and branch is never out of sync.

Of course this also uses ref .. files, anyway, just food for thought.
