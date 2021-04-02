Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5265C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D65461107
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhDBJ7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhDBJ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 05:59:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CCC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 02:59:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l18so4932983edc.9
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+t9U06ILCZ3XfX1u6c8YW0rOXoLpfw+Kj91fX3w8ndo=;
        b=lPS0Sb5tumfNfqenl7cYzu9JeasilLHDlsJ+DH7KAnzGFrt/rPtcUfxhdplTaAUREz
         4UoUiD4bA8erRVHHDzYn8zdf10geT+V8AqrFjj0Z5LsP1348djkrhaA3p9WsSSZfa/XF
         BAY7mov97VAWLE+Fv3V7yp4u2hhAE4BifBW3i6dPJ0WtNZNpSBMj2Cx+R0aF3Gjyz2GO
         AvoVPHYlk/aqFCMHuzScZwJhzEfXFdArl0A88XZTZPnc/2VatAonKq7zuB3fUPC1MPZM
         1VLG777ltCzzU5gNPirWaX9XOx/MWZH5AnAorM8c5fjYCmHdpSB/cvtQK0StcAdJWTGZ
         cxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+t9U06ILCZ3XfX1u6c8YW0rOXoLpfw+Kj91fX3w8ndo=;
        b=D/x7CA/bbD0LFUkBfZqZWSXsGXDzKP17CqTm/323Widnv2Vh3oAMdLftsmYAEzaYDS
         oTAA08tH0oZg3dP0hFxMwhmC7ZvBPZeIkX8o0OqC/sd0dibQJZWI2SRc04UzMDdeKdpb
         WgdUL5Ohi2D4XyiYEfczwhaNyxJGLi2YZAfEdqjnHJC9pqlRxMV0LSQYSQjePE0H3hcb
         Kbg9N9RjV0wr3DcV8WWZnlrbthAEOSSuP9CpyxXK4GI9pgG6jx4feRIJFsxKllNW8A3d
         G8ZEe2rKyYPABwQ3ZHPCenxrsa4F201b5cI8uj5kknuSTntKJlcGjCOOMPUvUFfDSw2S
         1vUg==
X-Gm-Message-State: AOAM530ESfe5vbev1Dw1eVtVKuyIEWw5tmmJ6k1xe8zzQJHlkCzwDz/g
        fCuyLE5f1hXM9dXuZ9sYFqey+jIoVTrY+Q==
X-Google-Smtp-Source: ABdhPJwB5fu/eiNT5fQJcY2H4GI2O8iCn6oeMOb5CdnLgFfu9JZXheCCX5jFXq/J73/n7gET2A0z8w==
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr14658552edd.87.1617357544579;
        Fri, 02 Apr 2021 02:59:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lm24sm3968644ejb.53.2021.04.02.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:59:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
Date:   Fri, 02 Apr 2021 11:59:03 +0200
Message-ID: <8735w9knx4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, Albert Cui via GitGitGadget wrote:

> From: Albert Cui <albertqcui@gmail.com>

Formatting nit:

> +Git has https://git-scm.com/docs/githooks[hooks] functionality to allow users to
> [...]
> +local checks of code e.g. linting. As documented in
> +https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, server-side
> +checks may be more appropriate, especially since developers can always skip

This should be a linkgit:* even in the technical/ directory, should it
not? We build docs on git-scm.com (among others), but in our source tree
we should be using linking syntax, not linking to our own already-built
docs on some website.
