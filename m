Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE6EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04036611F2
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhJVO3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhJVO3M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:29:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E5C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:26:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so2311738edj.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1Ash7/3I9rsxlafHVCIXOe3LuIBnosmG7V41FdxhaT0=;
        b=buuGNBOXevgzdQAlR0A62/AXi4VLlLUTP6K14jYsnVFppBecmSFDvHGV8frD7fAbb5
         jQ41+g4JezZ1vWxwj66IYfrGsIt0gfkNy6zVqVOj4EwifH+Sa9duA1sKrI9vYDqBoeAw
         KM4FEf93r+zzOC4CP0W5xvIro3GV6ZkqVmUER1VAFpfm10hZzjfpD4tnFkLYOCrS3rbe
         HVtFCUJSokeREIBWz6XDfOVC3W7ltyKtNsl7KyhAnvSlXyi9qWSswaPBHKe9uVmdYhiB
         xUEFU8IdyT9WeiGKm6EoS9rrjtqKvyRNJgl/CbH7wNUudZC35u/slQdlcDuVhHqS/eKU
         6f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1Ash7/3I9rsxlafHVCIXOe3LuIBnosmG7V41FdxhaT0=;
        b=k45HNKj+tTuqMN56FRF65wVEYcqrOD4bDoTzjI83BVEBqJwiGl64P9y2Mdjfz2KOSB
         3DRobbk/RaAJTilqPyA/iLE1f6G5+bDHfKKhCRzv5e/izrmNhjqdSpM2/heCKLcPeEjn
         noL1ajkTXa0XNmvLnTRzy9lRwKx0uyAZKtcWU0Tpuj4J9hqu7M7WX8vqTkFft1iCfjCJ
         Aontlyr6i7j5FkdjFQ0MblSSa4xzy+atu8ewbtRbhYDoN6BdS7RICiWqlKJr88DskQvM
         tQmG7i+9C7wakQrMkBsXm1wObp8U8r198fT39kioOLjPwo8i0SsRJq2MNOq0Zl2vPDCL
         SnDg==
X-Gm-Message-State: AOAM5335mCeEQ29OXRIWq1wlCCapmsoSL8Mu5vqjapcgMzbOL/KSddIp
        uRLJDCVD9GVwXiyOFdgd3gtnvSgtFmi6/2x8GBCPA1qeENQ=
X-Google-Smtp-Source: ABdhPJy0++dCdPZDreqmSNMGO8uxe3vX7NYAFk8zxctLIJ0G4Uhd0nbZD6NKYL5ya0llnX0P72SvG5tCVYdXuA1rZNU=
X-Received: by 2002:a17:907:1c29:: with SMTP id nc41mr15319124ejc.135.1634912812715;
 Fri, 22 Oct 2021 07:26:52 -0700 (PDT)
MIME-Version: 1.0
From:   Philipp Eib <philipp.w.eib@gmail.com>
Date:   Fri, 22 Oct 2021 16:26:42 +0200
Message-ID: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
Subject: Error in 'git clone' via SSH in v2.33.0 (related to commit ae1a7ee)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using git-for-windows, I noticed that an SSH git clone of an internal
repo broke for me in git v2.33.0
The exact error is:

fetch-pack: unexpected disconnect while reading sideband packet/s
fatal: early EOF
fatal: fetch-pack: invalid index-pack

Cloning via HTTPS continued to work.
It was also repository-specific as cloning other repositories from the
same (Gitlab) instance via SSH was working fine.

Together with the maintainer we traced the problem back to git commit
ae1a7ee (https://github.com/git/git/commit/ae1a7eefffe60425e6bf6a2065e042ae051cfb6c).
Reverting this commit and rebuilding fixed the issue within git-for-windows.
(You can read the full conversation here:
https://github.com/git-for-windows/git/issues/3444)

Unfortunately I cannot give a reproducible example as the internal
repository cannot be shared.
I have also not tested on linux.

Regards,
Philipp
