Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A1C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 17:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B14360E74
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhIERRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhIERRI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 13:17:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC47FC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 10:16:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m4so7119433ljq.8
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuGLgg7bRSPaYIy+TjEL/Ls0JVaciTcNkvnQyc03W60=;
        b=mbWD7r8852BVH7SkmdIN+ITcR10XibroLQxEctWLLEOaZwYEw+IQrxnEiG76uQLmn3
         kjPJljJzGxvg3mbYz4IsqfXo9p1KhgBvjmffJYCicaX2oBItIh0VRvVTI7R2pDzO2JyR
         MW2zjeujsNDO2DJZdqgjRngiL8Aw0j5/pjGt9IfjrivDjPsVFkmlp+9QiYJ0iYjTiRbq
         1N7qs0qhjpVYzjOmMrxEbdV8DMJ5DNwCO6CoVbl1H///+QKWhzff5dfxy6kGY7MzliJb
         b+fmszr2vQjBGuR6GlGD1RYgo7/brsy8+QqPUve46sRQsgNAn7sf4CRq1A5rq/iOoOxS
         oDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuGLgg7bRSPaYIy+TjEL/Ls0JVaciTcNkvnQyc03W60=;
        b=RFOTVl6ylkcaHcv8h2JnPZZaOVFJVzOgFxgwU+8K8BDGJebr79DKjzGQmftUmGjxVo
         Sqg+w5/11c2w8ikcxdc25TRmNNc5H1xmMWlCMD7wrrHYMkkEyE8+KHpLXoz3kkcfVu0u
         JW3NoypbfZxzX2t2BEYLYLdHAgCMDSftw6vX905BT/tfyfL+j48KYZnaAq7XGdRDowLX
         dCyzjsL9hQ5AiFgYVZFWaRZ/SbUPc7BMnuYdXDrNJHIBN5r/i2U8azcvlhXqJYH2Ydrl
         I0XCQ9sm2ZEifbaduxAKATr24nl1W3P40sA0ZQCBHOSyEF4lSY8lFolhN5AFWhbAiOSs
         9x1g==
X-Gm-Message-State: AOAM530nePU9s+K9WsunyyUNslw8nLcvgafE71K9u9ei+NRP3+nh0rS0
        Ns0nt6rCpIoUuyXK4EAWrpWoEeyfU4AIc+aDqmItXGYO
X-Google-Smtp-Source: ABdhPJy4OBrZDHwQTfXya4IntI0+mhaRAIUOo+up0Nrf8kmp6OB6X91I6lStOVTApzxMJZY0/f03WKoAA2s2tbfzsW0=
X-Received: by 2002:a2e:7401:: with SMTP id p1mr7514675ljc.303.1630862162893;
 Sun, 05 Sep 2021 10:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <0e1f7a47-89e3-5f49-663e-bdd3e8efb6e5@rawbw.com>
In-Reply-To: <0e1f7a47-89e3-5f49-663e-bdd3e8efb6e5@rawbw.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 5 Sep 2021 10:15:51 -0700
Message-ID: <CAPx1Gvc6noTDYPt9x3b4_TE0z8-KE5cB6KQHcn5UL9pi0cKoGg@mail.gmail.com>
Subject: Re: stash push/pop unstages files?
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 10:12 AM Yuri <yuri@rawbw.com> wrote:
> In one sub-directory I altered some files, added a directory with files
> and added the changes (git add .)
>
> Then I called 'git stash push && git stash pop'.
>
> After this the newly added directory remained in the staged status, but
> altered files became unstaged.
>
> Is this an intended behavior?

Yes.

> Why stash push/pop unstages files? Shouldn't it preserve the directory
> as-is?

It does, *provided* you invoke the pop step with `--index`.

When `git stash push` makes a stash, it saves both the index
(staging area) and working tree, as two separate commits.

Later, at the time you apply the saved stash, you choose
whether to use the saved index / staging-area (`--index`) or to
discard it (no `--index`).  The apply step uses the saved working
tree in all cases, and if you also stashed untracked files with
`-u` or `-a`, it uses this third commit as well.

The `pop` command is just `apply` followed by `drop` if the
application succeeds.

Chris
