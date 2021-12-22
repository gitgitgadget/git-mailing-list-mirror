Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05F5C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbhLVKGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:06:22 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:40564 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhLVKGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:06:21 -0500
Received: by mail-io1-f44.google.com with SMTP id q5so2116220ioj.7
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WABng9ahDfOOlZJkO1I6/HIjRC/K946CpSx829EguMM=;
        b=nVk9sWCBMVcLbfS8pdvtEX/jia2sB2NMpfC9kIQrhHQmDIA3oVkUHTtx4HAy9O4XVU
         nS3bc+tu7emsRQMZjwMCT7AkTOYv1MSCrTODPvJ9tYMbq43ou1VQnGXS3KG2PKHE5Cj6
         qODZPj2ldsJJfzrDoLynoTGRqT2EOHOWZPY1alRkoZJM7JhJdNzsLKLSyzxaqB15uNS8
         bEUWA9UOyq3rpeZONBjrNa4g/ODVW63mQ0RIx9jGb0rcnW3F9uVHfrcZK2pEzHBwebVC
         7lSvfG8cxWaeshsRv55hM4LEDKPpCc4SXNXkuztZ7hPKbnTJVHy2q2imol4Igmg6DEDa
         /nNQ==
X-Gm-Message-State: AOAM533k9zu2NHmqnU5wVxdjoWMrdwa/qBYtCMv6ugEwGp+5yin9g1/1
        KjVYHW5IDOxvPyC1f/1Td9PgfJKz7CNlF6pHFEEdDhUzIXw=
X-Google-Smtp-Source: ABdhPJx9kA+Zb+RYNvS6Y2BhMxwM9SkEImKbcs9bkM1yhE7zRvY9eu6eS8ClsAurTMacjCw0vIfaCKazlxen7rw6hWk=
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr925348iov.107.1640167580964;
 Wed, 22 Dec 2021 02:06:20 -0800 (PST)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 22 Dec 2021 11:05:45 +0100
Message-ID: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
Subject: bug: git name-rev --stdin --no-undefined on detached head
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all!

I ran into a situation that I think may be a bug
using git name-rev for detached heads.

Steps to reproduce:
Create a detached head
  git checkout --detached
  git commit --allow-empty -m foo

Expected results:
My understanding is that
  git name-rev $(git rev-list -1 HEAD)
  git rev-list -1 HEAD | git name-rev --stdin
should yield the same result.

As well as combining with other flags
like --name-only / --no-undefined

Actual results:
Where this fails as expected
  git name-rev --no-undefined $(git rev-list HEAD)
this just prints the SHA wo failing
  git rev-list -1 HEAD |  git name-rev --stdin --no-undefined

"name-only" is also affected
  git rev-list -1 HEAD |  git name-rev --stdin --name-only
returns the SHA and not the name

Tested on
git version 2.34.1.windows.1
-- 
Erik Cervin-Edin
