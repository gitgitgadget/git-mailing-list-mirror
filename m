Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C6C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJUVsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJUVsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:48:40 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62540326E0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:48:39 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id g13so2394711ile.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LA0TJCvN42SSWUiKum3FGBwr2ZKCRJJyZN3gGLOV2NI=;
        b=F9IXADVfZSserB5asJ621+r8QjTa1ApicKyE5i8qZSwJZXDQSzuwqEkKNMnAPCR4Bh
         fkY3Yuj9+3D5I6trQZ72iqIujmkGJ74p8aVA6SRMLaw8wahaSQqahSHb7cWRan36Vf+J
         wOwa4StmvFX43nTJz/8/5DKQoXMwwq30GseO5ssOwkoLr8Lt5m9BcG9hz3Vu3YYL+R5n
         QJNahWmHJT3EuqsZJ/cn3Cr6fmzHTQas/J+gsq+tXMXvuFCYtVRLWqtt20c8Ykfzvlfc
         neRWg+hNZVNTBiGHU5Z/xLE1Rjjr7FkraFmNUtSMhtwB8ySAnM113NU75C86H5MHqBtg
         9gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA0TJCvN42SSWUiKum3FGBwr2ZKCRJJyZN3gGLOV2NI=;
        b=hCdzzHWM2JDpYWVgcLxVwzqkOFezjmJZuAEuyOxz3pZQyaQl9dAXpP6i4EFxivGzZp
         N7kitzMlkhZc45kr9tg5IZ7xLZ+v4tdLI0p5uYK4Lo/HPymc3l0wa7bl5ekNusVs/4AH
         PcEJ0p3z5enfEOMyqukM6z7X8PjPEtAtchtYemol2Q2jVVmuANOovjwssM3c95FY2+aU
         5pvoiYlQcbmODzNIzStUkF6h1K6+2GIK8/2G+5XKyetw9Z8ZK8YiZXPF1rmVhJlXGtIR
         gCsZmRQDDszkbLQKI0pkuQSPYmkWIvyeTFZWIb2QaA0YohqrcBBwq+nMmOl4EKio3NKO
         lxpA==
X-Gm-Message-State: ACrzQf2WiIO8XJ3iOxq1TJl4qwbtY877M//FLZTJkbBt0qSdE2PXjzv/
        Ab4hUsDXkmgKVRN68uCU/L+oNIfD9rlLFHRT
X-Google-Smtp-Source: AMsMyM737MxtlDfu6E+Dh6txH3jfxYRGVDwr8XdFRHKs85cP5FCARolFo8rkftNY42UiCNpU0zpIbA==
X-Received: by 2002:a05:6e02:20cd:b0:2f9:b5d4:94b8 with SMTP id 13-20020a056e0220cd00b002f9b5d494b8mr16300707ilq.144.1666388918635;
        Fri, 21 Oct 2022 14:48:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h1-20020a05660208c100b006aed243a244sm4884642ioz.54.2022.10.21.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:48:38 -0700 (PDT)
Date:   Fri, 21 Oct 2022 17:48:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git commit .' in a subdirectory also commits staged files in
 other subdirectories
Message-ID: <Y1MTtNcUHyv76UEV@nand.local>
References: <3a4dfad5-0f2e-14d8-61f2-779616de1ae0@tsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a4dfad5-0f2e-14d8-61f2-779616de1ae0@tsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yuri,

On Fri, Oct 21, 2022 at 12:40:51PM -0700, Yuri wrote:
> I had several staged files in various subdirectories of the cloned
> repository tree.
>
> 'git commit .' in one of them attempted to commit all of them, not
> only the files in that subdirectory.
>
> This is a very unreasonable behavior, because while being in any
> subdirectory 'git commit .' should only affect that subdirectory, and
> not files elsewhere.

That isn't right, though I can't reproduce what you describe from your
report. Try this script out:

--- >8 ---
#!/bin/sh

rm -fr repo
git init repo
cd repo

mkdir -p dir
touch dir/c
touch a
touch b
git add a b dir/c
git commit -m "a"

date >>b
date >>dir/c

(
  cd dir

  git commit . -m "dir"
)
--- 8< ---

`repo` ends up wtih the contents of dir/c committed, but b is still
modified (and its latest changes not part of the most recent commit).

Can you share a reproduction script?

Thanks,
Taylor
