Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E116EC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92996197C
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYQKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFYQKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:10:32 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A07C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:08:10 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso1394915ooh.9
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=H7O8/m2LbtM/nlTf64YXA0EJlOH7tfHECXMStrxmWhs=;
        b=sxEbQDmweCihazQ62tdHqIKZ9o+sYZ/++4oq2GL67TqwQhyOuJK1xicILXESANMiI+
         pdjDGWO1iUU1beBdTtMrbElLNLo3pV602lRdokCs366sFuE45mMCOEJ4VZSPh7zE4SSl
         AgDPzIjPC8aMQHVt+mGdGjeGvMisKrcZdas0+Y0lEy6lmCL3DG/eR2n2QWbW1fftC7QQ
         flNz5czdgZEfl/AcMjvACpyP4YNtjergsLUl9/rtm+XZpy+z4BYBOemu4d0G3ZWEinCz
         roJ7kWegOYylRgBU/tkhcCVTHQlYMbmsUkYc2zfXrE9Pl31rbyj5WY8FPGFJe66x4GBx
         EpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=H7O8/m2LbtM/nlTf64YXA0EJlOH7tfHECXMStrxmWhs=;
        b=A3vDDRxafdx8BGQbd0QDZgCWEpp8yHCSaYeWCwi7SoaNM8o54ZFWmyIvcCSWUg1e7V
         tZMff1MaM4fUQFDecLYTnIKNKXLrSkfrqM6kBn6+ADZe+q7ytvje5kZWqM7rAVeVT7yJ
         8DUiZp1EtUG2ewuozxPu+OOmuzPMPwC6x+qUwARCBvPyZKlsMSu2lkyLZuJSLy09PO6q
         rkdSPvtvBgWCty+vEx0KRFeWTOInwG0onQC6Z6wjnA2mrV+kkoN7BHCVuOvQ09HKVik4
         x2rHbAajnKgI3k1OMKuax0bADxAWl8aRLtO/9hWtdyy+gu0Yyugnrhyno2XR+W5BncoQ
         G5KQ==
X-Gm-Message-State: AOAM530ATDydFCkY129LN174jfnin58bDnE8Cx9xA1bnMciN2jjxYEns
        irH75G6nzrmpN824EX77oxWsPlLK0Xqvug==
X-Google-Smtp-Source: ABdhPJx6rVDRyhrkZQAS8OhIxEStR+cnxVla4qH17HBoWA0aNrAkpZpUjdVuwU3YJsa2nwkwL4fG6w==
X-Received: by 2002:a4a:6049:: with SMTP id t9mr9823812oof.14.1624637289976;
        Fri, 25 Jun 2021 09:08:09 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w11sm1330188oov.19.2021.06.25.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:08:09 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:08:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Marco Giuliano <marco.giuliano@tesisquare.com>, git@vger.kernel.org
Message-ID: <60d5ff68194a1_c23720822@natae.notmuch>
In-Reply-To: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
Subject: RE: Nonexistent changes appear rebasing but only with
 rebase.backend=apply
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marco Giuliano wrote:

> I have the following repository status:
> 
>    * commit 2 (BRANCH X)
>    |
>    |  * commit 4 (BRANCH Y) (HEAD)
>    |  |
>    |  * commit 3
>    | /
>    |/
>    * commit 1
>    |
>    |
>  (...)
> 
> What I'm trying to do is rebasing branch Y on branch X, with the command:
> git rebase X

Have you tried using --onto?

  git rebase --onto X commt1

-- 
Felipe Contreras
