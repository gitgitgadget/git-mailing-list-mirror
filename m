Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4715DC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjEJX1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjEJX1W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:27:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD32693
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:27:21 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38eda4ef362so4301013b6e.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683761240; x=1686353240;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM1hQ7Ub6g3OwhPUpBTdXRBeCZtXX+g0dwKoQ+QXIhc=;
        b=NjnzqxM5rSldN+elpdHJWFOpRErOm8Jgj5U7x1TzLYcLzF+FkTeQvChCSVDJvh7A2O
         orOF6x1kOaK6zFlaN0Dm1uCdAFtZLhvqlcmkEo8Nm4l4AoU152cICM1mFvnbiyba3dfW
         dUkY59lZykqkz4ser1vq0MrX8SaBTTRLzAeACcS9Xb3UdKPp2XGrbvh59JA0jytNn4pK
         y+h4DhuXxn7bHV9KyYpXDKaxkpxvbbeSsVbTwGmdkMMdWfo21MdgR88p83FtaVaI5PaH
         RZVUSaG8XTz25v90d2npR8b9UrOlsqM4Ybh+VluiOXCZBZw129P/PuO7jnJJzSymfy1/
         iorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683761240; x=1686353240;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NM1hQ7Ub6g3OwhPUpBTdXRBeCZtXX+g0dwKoQ+QXIhc=;
        b=Ai+zYMp+Gzxwavusniu/Jc+zNAU1buLtSv7wcdb+c+8BnKvKVZKvdytcVGo3Z/MpmF
         glUdx9M1mPm7YKtg18RHyRAekhgbdfu/PFG/eoavDXItozxZLrUHb2ZMJsoCsE5kCnsE
         1FNJg/Euh4zVQbeuyTRN+IEl+Z1ArVjSERWrTrVA15CyXkgQb0ahc3xmuMYC+tQzQweN
         TvZebOqo+an8rwmKHneQ6Esoow3RQZGvpOUL6LGHzspkDZxZ5dettOTmLgme7v4HKdS7
         36o/hGDsQxNZSInqdFpL1v4KNuuOQkQT1GaV+ChC2hGMV3bKJQJ99afW1pHTgoOBjjL7
         QYXw==
X-Gm-Message-State: AC+VfDwFeQnkYARYYp5srl901GXWE8ZtXwUhvK1Ekm32mcXOJl7czcyI
        rCi1xZ/hpYyrI5bOvBiUMyc=
X-Google-Smtp-Source: ACHHUZ7s7r44EtBdVoVtC6vjU+vS79mTOkNXj2IyGihcI1qkY7EZHk22E5Kf6v7Gm3Vjs2OmOeQCkg==
X-Received: by 2002:aca:1a11:0:b0:38d:e632:8304 with SMTP id a17-20020aca1a11000000b0038de6328304mr3928385oia.54.1683761240552;
        Wed, 10 May 2023 16:27:20 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r66-20020acac145000000b0038de993f3a6sm2792787oif.53.2023.05.10.16.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:27:20 -0700 (PDT)
Date:   Wed, 10 May 2023 17:27:19 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <645c28576290d_7b63e2942d@chronos.notmuch>
In-Reply-To: <xmqq5y8z3jif.fsf@gitster.g>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <xmqq5y8z3jif.fsf@gitster.g>
Subject: Re: [PATCH] merge-tree: load default git config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > The fix is simple: load the default Git config in cmd_merge_tree().
> > This may also fix other behaviors that are effected by reading default
> > config. The only possible downside is a little extra computation time
> > spent reading config. The config parsing is placed after basic argument
> > parsing so it does not slow down usage errors.
> 
> Presumably merge-tree wants to serve a low-level machinery that
> gives reliable reproducible result, we may want to keep the
> configuration variables we read as narrow as practical.  The
> default_config() callback may still be wider than desirable from
> that point of view, but I guess that is the most reasonable choice?

If you want to *intentionally* ignore merge.conflictStyle in `git merge-tree`
then the documentation has to be updated as this is clearly not true:

  The performed merge will use the same feature as the "real"
  linkgit:git-merge[1], including:

    * three way content merges of individual files
    * rename detection
    * proper directory/file conflict handling
    * recursive ancestor consolidation (i.e. when there is more than one
      merge base, creating a virtual merge base by merging the merge bases)
    * etc.

If you want to ignore merge.conflictStyle, then `git merge-tree` would *not* be
using the same features as the real `git merge`, in particular proper conflict
halding (the conflict markers will be different).

-- 
Felipe Contreras
