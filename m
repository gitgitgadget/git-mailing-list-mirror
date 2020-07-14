Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA0C433E3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBF222B4B
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L51v9A0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgGNTky (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgGNTkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 15:40:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5370C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 12:40:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f7so24391922wrw.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5DDAMSFPTmN1jS/amfIK4H40ja7LtIOOB8+/8lFVaQs=;
        b=L51v9A0vfP0vCEPG5j+RA9Sh2obwy6giH+aTBpvZP+Nr1cSQir2omfGbB3tZEglgl5
         k3ILhQSGU0qLOtYLyoCEURixImV/9kTVLQ3GKzbNCJiOdDarJ3YJswe7uFZL4zAblhqi
         5MwELTEn7iuIYB9do2qv+nkgwR1TRXaaggFa4TYuafV+az0uIDaltvFMszSRyXTqlSHl
         7bUYEc1UGp8PnsgfKpJZzN3IdVn56G/cX7IPhzqLhpt0PFP86oQruMpGpWhC6WdVCh4v
         ZwaRq0WrjlkwDUHiCSuS/VsSmF++ObTGYVC7ckPIwsC3fhHorbZJozAdUQodCGniChkQ
         uuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5DDAMSFPTmN1jS/amfIK4H40ja7LtIOOB8+/8lFVaQs=;
        b=TXOdyFggzAuLxFSYC2TtmfX/UWR3STyoea2pKvTShuz7uiplSiNU4PLs0QmEavIFr4
         NtrNJV8zmQ/ciafe7op67j20qihCVgc/ejtIsWMyY+2FH7rL2IIPIt3uABp5igpWC3nx
         oPFiYqBvqMGb+nJFDZE8K9UuLzybDB9heDluJ5ty94ZzW43wN5deGMLG+BGiYTRadw2H
         zl7BUSysYoUJ3o9gMFr8wmvL8ZCR6svwMOclAEbNTwHEyGAPGPLqpb4htgKMGtDbGC/m
         BJzr2jRGpNGRdJQoulJ6vfsg45OsDKS8zGmeAcm07OTbWEGtvC2pFaplMEkvUUHM+3O5
         uLjA==
X-Gm-Message-State: AOAM530f4AWRCLtVgdjOKCIWufTEngRzD5jI45BACQ9LsrS9rBcrRL+W
        p2KNCZFDzoxm/MDA/WeGI44GOQkJlWGR+/elSFNLYtEGG90=
X-Google-Smtp-Source: ABdhPJzrhQgI8vFpDto3Lkat/q+lf17RQo/c/Yvi3t4S46DYQuehkgJ1IpDUbxuLg7xrV/wvQWqvJmIwwRYYOJbTKLY=
X-Received: by 2002:adf:8024:: with SMTP id 33mr8052172wrk.117.1594755651290;
 Tue, 14 Jul 2020 12:40:51 -0700 (PDT)
MIME-Version: 1.0
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Tue, 14 Jul 2020 12:40:40 -0700
Message-ID: <CABXAcUxw5EA6jPB93C-Cfg-tycLMQSKUgrLkLXSQUZPHeEva9Q@mail.gmail.com>
Subject: 'git rev-parse --show-toplevel' errors out with per-worktree configs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a bare repository clone that I create worktrees off. This works
fine, including 'git rev-parse --show-toplevel'.

I enabled per-worktree configs using 'git config --local
extensions.worktreeconfig=3Dtrue', and now I can't get the toplevel
anymore:
> git rev-parse --show-toplevel
fatal: this operation must be run in a work tree

Disabling per-worktree configs makes it work again. This also works
fine on a non-bare repository clone.

IOW, this works:
git clone <url> non-bare
(cd non-bare && git worktree add -b master2 ../wtree1 master)
(cd wtree1 && git rev-parse --show-toplevel)

This does not:
git clone -c extensions.worktreeConfig=3Dtrue <url> bare.git
(cd bare.git && git worktree add -b master2 ../wtree2 master)
(cd wtree2 && git rev-parse --show-toplevel)

Is this a bug, or am I missing something?

Thanks,

Cl=C3=A9ment
