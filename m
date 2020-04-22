Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B0C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95742082E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbgu/BW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgDVOS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVOS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 10:18:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C0C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 07:18:25 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f13so1250716ybk.7
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ayg2v2vvsLvDba6ozcLkfnYgHLsBSVa8l50VwSvBZr4=;
        b=cbgu/BW478J6LeiBr+/RwVD6/UUc4GWh47VPsYDqV/PfkbAh1Uo/STYCqxVselaWKC
         LFuWBRl7SoCNVnsVxZDq0BtevIdOgTaZfylDWkc1vZ1ky/Rjd9ZmYrHTZQXz3AQQL0lZ
         qbCMPvgHRulJ/f/w2DdNhnZVh9TsTm7O4/O8FRk8mhqOKhZkHKSKtIT7E2Q1xU6i25gt
         H6RkEQVzJ3CNgNCA8aDtZkymIuZltmBDvKV7wjJ2SkRIqCtY25US7SjJ1iWWuhVUz9rM
         DidLKjrjKcENUeg3cZM9GcCWVQsKxOZ2k8eGM7grVa0e3np7RBUG2VXWEZd+DhU0kqYl
         2rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ayg2v2vvsLvDba6ozcLkfnYgHLsBSVa8l50VwSvBZr4=;
        b=VYT7pcqImCljbk7icqAAs5WNXhIAiy0CyiaH4uoR2wIJEUpVEiZvsjs02Zxbp1sqha
         Pnoki3jPJSEfopCj8BlSZwt4NBj+SXDusSzJeAlSpVhbLwHnz9WinYFeliKU2IjRyBHY
         cQZeOH+W8VndphuEln80Ay9F8IB2SVYV2hvzkhakaZLxmIhgRbLxSXYx19DMboEZoiEb
         iXoKjqT/e7GMwmCcXAY+1OnpZWXa2F2UkSnkl7Y8qPZSGW7N8R+Y8RLzQ68zu1HnCqJb
         LTzujJGuKCYy/fnintN5GvG+mT+PBceuSDARasWeSrjGlieMRh1eu06VX4c87bPoBh19
         tDBQ==
X-Gm-Message-State: AGi0PubMeqnZ3dVT4EGFkVq0zU2orj60fa1nilXtf6AVeEH4CsJbsT1J
        v0Qhgv4g+k+qufxHJI3Y6kwg4sOXgZX4veoWRZmg1myB1Fol+A==
X-Google-Smtp-Source: APiQypIOo8hSYqj8h+U6Yacosa1GT5ONgcSnlisR7FUqWi4yTdT17Im3coi8Sz3RQC2tOEHJZ4H8RsUtqo2tspALP/U=
X-Received: by 2002:a25:6cd6:: with SMTP id h205mr36690677ybc.404.1587565104879;
 Wed, 22 Apr 2020 07:18:24 -0700 (PDT)
MIME-Version: 1.0
From:   Pierre Demailly <pierredemailly.pro@gmail.com>
Date:   Wed, 22 Apr 2020 16:18:14 +0200
Message-ID: <CAMmcmXZPxNYmVMzLydKpAzYN=qRhNRr048EA9mairZ9t_22j-w@mail.gmail.com>
Subject: [feature request] keep flags when trying to push with no upstream branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Didn't find how to submit a feature request on github, hope i'm at the
right place.

When using command git push, if the current branch hasn't upstream
branch, an error is submitted with following message:

> fatal: The current branch master has no upstream branch. To push the current branch and set the remote as upstream use
>
> git push --set-upstream origin current_branch


It would be well to give the command to use with previous used flags.

Example: git push --no-verify
>
> fatal: The current branch master has no upstream branch. To push the current branch and set the remote as upstream use
>
>
>
> git push --set-upstream origin current_branch  --no-verify


I didn't find any place to see features request list, so I don't know
if someone already asked for this feature, I'm sorry if it's the case.

Regards.
Pierre.
