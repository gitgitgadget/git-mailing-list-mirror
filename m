Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9168C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 01:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB8A61404
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 01:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhDXBJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 21:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDXBJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 21:09:31 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3991C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 18:08:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso24373819otl.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=XT+VZK6J45zJ1nCN67e87068FbsMMDrcs5/frFQkOt8=;
        b=daoU9Q5pP0u/1j3RZreDGEdK+6+qcS5W+aCYLDipz4FXGIwZiEWP02eycZkk88+rH9
         8WOtZM6HWdavG+JfqQNAuRRtTiAuulAw2Hco9kd3pwOqaSDsP2ph21IW0IxotFsJPCrm
         thGJ3Y+ZDTtmUk5qIycBNhnS6ZqxtyLLXQ/3JgoGPDzMPNbeZtRXt43Y2+13oxP3K0q1
         17a0ORhvhKFHARri7N23qiVng4xnWsTxMZ95Orygku4lV3IfY/Es24YBZjBlS1qRvIla
         hQj+SEUh8FhVtiVjLRe4Y5+fIU8NgcWXwvXu0d9emYI/fY7ViFhn9n3IcF9a6YXV9p8I
         OKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=XT+VZK6J45zJ1nCN67e87068FbsMMDrcs5/frFQkOt8=;
        b=iQcyYPkW54z2SXsvo8LbEuHgzhAzU8TuyWLIt/3sLFNQR4tPSZZxKyS86hB8GOL/kM
         kWk6fsENeSzlpy3iiZXpyoVkuXWuryLn+bXN064EiwEqLdK8ZEcz9EzWmDS9QBu7zPpZ
         TF88kgm5Q7dzEfCtKN0DshmwPD5L2wQUDSKP5/0XvAMGb68Ck/JomPDjbvJHVEA60OOu
         a9hEYlJ6QGqcyJ3xoIKa0Slvfbi6tYVD/5uU2KRAZnYaoVa9/DB/DUakdfLt9KDcgy4Q
         Yyqi/EL8hZfYmOsNMJGz+SrGHr1aLVp3AcSun5nZMmVV9m4wtlFcDajJsAc3/5sHYOu3
         JDxQ==
X-Gm-Message-State: AOAM531v47/18sIVUMUqJIZ8eiBGbOkh399C6MlRJu2bnbc6WpJtr6RG
        xugvF0kpiGH1dtAg7QwE41w=
X-Google-Smtp-Source: ABdhPJwP02CISd6KZbqUXxZMAOYpdqHcADaRrvCsq2Xz6hjvYonr5ak+w0fTbnpO6kMYcrvlYdP7BQ==
X-Received: by 2002:a9d:457:: with SMTP id 81mr5690049otc.93.1619226533947;
        Fri, 23 Apr 2021 18:08:53 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t19sm1768408otm.40.2021.04.23.18.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 18:08:53 -0700 (PDT)
Date:   Fri, 23 Apr 2021 20:08:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?QW50b2luZSBCZWF1cHLDqQ==?= <anarcat@debian.org>,
        git@vger.kernel.org
Message-ID: <60836fa129078_ff602089c@natae.notmuch>
In-Reply-To: <87mttofs5t.fsf@angela.anarc.at>
References: <87mttofs5t.fsf@angela.anarc.at>
Subject: RE: how to rename remote branches, the long way
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 wrote:
> Before people start throwing things (like `git push origin oldref:newre=
f
> :oldref`) at me, consider that I've been beating my head against this
> for a while, and everywhere I look basically suggests this:
> =

>     git branch -m to_branch
>     git push origin from_branch:to_branch :from_branch

Better:

  git push origin from_branch:to_branch :from_branch &&
  git branch -m from_branch to_branch

> I wrote this primarily with the "master to main" migration, because a
> bunch of projects (including mine) are suddenly, actually migrating
> their main branch from master to main. Personnally, it's because I'm
> tired of being yelled "master" from my shell prompt all the time, but
> naturally, I guess opinions on the matter vary.

Just tell git to stop bothering you:

  git config --global init.defaultbranch master

-- =

Felipe Contreras=
