Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9F9C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbjELIU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjELIU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:20:57 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332A21FC8
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:20:56 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab362d7401so2155652a34.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683879655; x=1686471655;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30MmiijJ+B4m2bRDmZVmPPhxavBeAaORYeDHbkBngQw=;
        b=VwOon+SOBxG1XW+kxOC7+33nxi0uP1TC7We5ZDe7H76VhUg9g6EAfE6cE7FycsgxlO
         Z3Rb4uwrsftMG1DGu//V3K6YTOoIB2DHCQq81Nt8PiruUHvTcc/jmqGJLxhGp7ROIbhw
         Ww2MJ/uZ/g+B0srGYhub5+X2yZtPG/7YI6cFKclJwrVMIUvRcom49+glKPPBBrJZKKQw
         KLaQp7e/XpHI3JwBf8N/gDe0E9KQtr1+bYiN9shHy37D6ZYSbVuDkVR6+hXcyI/79izj
         adX/rjzvVYvUgu6YQ8akkohTLCV9X9G4/tPsFLQGSrlh0AeXbcuHKPh2LspuvzcT1We3
         SWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683879655; x=1686471655;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30MmiijJ+B4m2bRDmZVmPPhxavBeAaORYeDHbkBngQw=;
        b=Qs26kFse8bOARBLgkSG4tCErtHantYE3bGT4x3ng2I8Oww7WSAeLvNPurVWVxkl4sA
         MEy228prVAG0ixYxqiYpFhf0rpmG8h1Kr6ITc8X+gPYcFFPfFJs6nN+NPHIc8Z6ShSe9
         OOl/R3FJ3AOT6rcYza43joYjojRWZV79JNKn9CYmRHjZvMO3aAdxsqG9vN21dMQeN7GR
         PEUgmXmmKTr5TJ9nUb7RduMByN6z8tZqKTh3k7eYNEYmnjzneF1n1uiaXtwXhggDlQVq
         BNkezQ4wQkUtXis4KDVWAyDuMRv/yKIhWfbUlCOGLQvhFe5FHRhKS4ATNo/523COgVUO
         XP+g==
X-Gm-Message-State: AC+VfDwk0h7pd0NvXIjU44yYk2GTntWZLczBD9V1XKJxu6PY9wOmWLlP
        D42cZFCnZfz4EfhbHPjN4lhZirYrnDw=
X-Google-Smtp-Source: ACHHUZ6HmYcBP97wPdw2I6xtXB3+LjCcmWZ14zmk3e1gxxTZcRr6wbe4Yk6QbQf5+nspGcGK2udQ1g==
X-Received: by 2002:a9d:631a:0:b0:6a5:ff5f:f923 with SMTP id q26-20020a9d631a000000b006a5ff5ff923mr5397349otk.29.1683879655482;
        Fri, 12 May 2023 01:20:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v4-20020a9d5a04000000b006a950658447sm8142932oth.52.2023.05.12.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:20:54 -0700 (PDT)
Date:   Fri, 12 May 2023 02:20:54 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <645df6e614f00_215cec29462@chronos.notmuch>
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 0/7] diff: fix -s and --no-patch
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> This fixes an issue Sergey Organov reported.

Sergey, as you can see this series fixes the issue you reported.

First, I think these should remain working the same, simply for convenience:

 * git diff         # default output
 * git diff --patch # patch output
 * git diff --raw   # raw output
 * git diff --stat  # stat output

I don't think there's a way I can be convinced otherwise.

But there's many changes:

 1. git diff -s --raw                 # before: nil, after: raw
 2. git diff --no-patch --raw         # before: nil, after: raw
 3. git diff --patch --no-patch --raw # before: nil, after: raw
 4. git diff --raw --patch --no-patch # before: nil, after: raw

I don't think there's any way you can say my 174 changes make the code work
"exactly the same".

And this is better than Junio's solution, because #4 outputs a raw format,
while in Junio's solution it doesn't output anything.

Even if you don't agree with everything, this solution is better than the
status quo, and it's better than Junio's solution as it fixes --no-patch
immediately.

Cheers.

-- 
Felipe Contreras
