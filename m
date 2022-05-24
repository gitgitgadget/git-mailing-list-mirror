Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29587C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiEXO3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiEXO3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 10:29:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905076A01F
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:29:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n23so23383038edy.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p47X9IZ4G07fM8AeBa7n5883JoByr8WGFFqZFHP8968=;
        b=c9MqBXozrb294SIwAhcM2tIuFFJ5nnXdtqiFCLVvZahx4e+KZbrVZs69ZP3FEKaPbT
         5XuGnTcPMw8E3ez3KnbNa1ynerIJfAHj7WkY5Nro66l9Ua9OgzyCCnLwQen+KL95b41c
         pkfVng/JUY4eNhiXFwak90/NfnaHo6HeNRSA/64t2eOo/s6IDo7hVrTS7r/l2B/qLbqe
         1C7e5rHsEMswPST2KRVfdQ2LdsWioztJ4c2pNLWCPKW+B8/aNnNRHVxcYdND1iG5qsD5
         UGOKaHrB14ZYLIWVPGb6pNx+WyJN3v36JIAt5vaRWUDujtv5sCwr/mf/7ptMS48ezATT
         AS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p47X9IZ4G07fM8AeBa7n5883JoByr8WGFFqZFHP8968=;
        b=eD+O11OVr1E9CtnUGYDxtcgTfq/FsWtDyIhEkURTH/J/nX2I51r6xiYkP2JlOEtag6
         6vOshZ0RRc/HoNBnb8lyQiOfUDsp/omPWH/1aHdv8AH42QrBFDnkiBi3z0/1AzZgs2Os
         Cu9J41sTfbXxWTxGgLokbvkGKQDuXLbdVSVVZoMaFE4Tt2oq8SgmEjYhcPqKAVq5FXOw
         vW9UoK7tRhUo14B2eP4J/eFuBRxDhtkJa/OeL42e3Y5jq/TNnqVtg45kETadKVzIiBpd
         uxbPOBwrcTXZJ6KVYgXqdY4ey3IXwOnCEM6FL3oEnP1sBZBOgA+Wuumn8QMsgACEr5fY
         0Low==
X-Gm-Message-State: AOAM5332zgEemZVQKNZE6Y9XxPEJyMWBW/JrRBKis+iJVurL+BR3/1IC
        mC36tVuHtgVPu399s5nkkYxntq0fCna5/yk2raI=
X-Google-Smtp-Source: ABdhPJxDIXRHbCmSkhbbh/Fqw2MbuC5RqMnWwydSGpXcGEZ2RAmaKaOwjDl5iK8CQSwgxweKmb6kN8PXREGBIb1qLw4=
X-Received: by 2002:a05:6402:5210:b0:42b:7718:b6ef with SMTP id
 s16-20020a056402521000b0042b7718b6efmr7092624edd.22.1653402561058; Tue, 24
 May 2022 07:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-2-ggossdev@gmail.com> <xmqq7d6sm3e0.fsf@gitster.g>
In-Reply-To: <xmqq7d6sm3e0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 07:29:09 -0700
Message-ID: <CABPp-BGXRzYCvyM38dEUvQ125+VtRu++7L9UiRz98u+1=Lov7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Goss Geppert <gg.oss.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2022 at 9:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Goss Geppert <gg.oss.dev@gmail.com> writes:
>
> > diff --git a/dir.c b/dir.c
> > index f2b0f24210..a1886e61a3 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1893,9 +1893,31 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>
[...]
>
> > +                     real_gitdir = real_pathdup(the_repository->gitdir, 0);
>
> This function is repeatedly called during the traversal.
>
> How expensive is it to keep calling real_pathdup() on the constant
> the_repository->gitdir just in case it might be the same as our true
> GIT_DIR?

I agree that treat_directory is called many times, but this
real_pathdup() call is inside the "if (nested_repo)" block, so this
new real_pathdup() invocation should occur very seldom.  Or are you
worried about cases where users have *very* large numbers of bare
repositories nested under the working directory?  Even in that case,
which seems pathological to me, I'd suspect the
is_nonbare_repository_dir() ->
read_gitfile_gently()/is_git_directory() codepath (used to determine
the value of nested_repo) would be much more expensive than this call
to real_pathdup(), so would it be worth trying to optimize this
real_pathdup() call away even in that rare case?
