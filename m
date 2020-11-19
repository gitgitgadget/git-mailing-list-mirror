Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A896BC2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E332225E
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 08:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtXc/sJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgKSISw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgKSISv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 03:18:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C772C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 00:18:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f11so6993368lfs.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZWy3M17sn8yvwi1e6pCz/ns9N2E/eDZTVHn9y41EpUA=;
        b=YtXc/sJKEKCUwe+3Fxp/2zhGrJdSipS7B9bWJ58IPJhqDv1//T6esJBKAndrrgbRXV
         /hw8kEB2/mmXHiAJ/oaqbjiKWnL3xKQathQLQB85q31QOqe17S/xrZxsWiIt+ryUZM3/
         fFhVUd4bSSjmnUsCrdDruAiml4j3pALa7K5mDwK56pbgzoXlfuDIROIAZfu3d7tAk1rV
         bFPv/O2zojrRjExYliGS+cwdcog0s3CZOemfW9wNsWoclTFJGnXsEp2gYhPzkkSf7mbR
         wNczi4vpX8Jb/IKChcGBH4t/juAqma26MpdV+MXBpnfW1oEB2cHJFF2/2kY2aMhy0Qrb
         M4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZWy3M17sn8yvwi1e6pCz/ns9N2E/eDZTVHn9y41EpUA=;
        b=Ar3E/b7whecrK39oMkzPS8cj0WvraUaEEM55RRf7ifAUCg0CK2DtoBx0xCgBVTPdDi
         WE7L4uOaEDBbDsm7aLUqvLTVXJ+/BeyMq99ah2VsWNgVGiPlwH4Sso1dVuHrzPnXTB6/
         Z9fxXjEDf0ze22onl2POZ0oz3oaXgzh+ZxwZhOuCzhW3Ntw/cPfTtkZiEydVbI0rs6lh
         5pg0FnqVQgBHpUkX2+NmkeS0ks/3Jrhr3EFJJTAlYvMU16e4LBR/khPXw70iL5d9MOpB
         twh5Id9ZE+SwouuqKjHrwB95ucF88fL3uc2NGoUX59VeIyTaoy8WXoWZsUHuwARsUizZ
         7Seg==
X-Gm-Message-State: AOAM530gCS+nmxzCGjrkBi9ryv7rFVB9xinQkznN5t+D7hytOmbFDI/3
        w5sT/TlkrzZFlpQpziEGnlNr+GYhmbmxL4ipcrx+JUkuNoWu7g==
X-Google-Smtp-Source: ABdhPJxeU4D6W09b53bf0DjV49KkF8Ib0o+wkKq8hpwDVlT35g+0liVPRvAYtHR4s1dQWvvlKTsO0BlPmWY2ppFWaQ4=
X-Received: by 2002:ac2:4834:: with SMTP id 20mr5038632lft.598.1605773927642;
 Thu, 19 Nov 2020 00:18:47 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Thu, 19 Nov 2020 16:18:36 +0800
Message-ID: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
  1. linux environment, prepare a large repo to give you enough time to debug
  2. clone that repo
  3. during clone, send SIGTERM to the git-upload-pack process

What did you expect to happen? (Expected behavior)
  there is no git process left

What happened instead? (Actual behavior)
  there is a git pack-objects process which is forked by the
git-upload-pack process, it becomes a zombie

What's different between what you expected and what actually happened?
  there shouldn't exist zombie processes

Anything else you want to add:
  you may need a docker container environment to reproduce this since
mostly init process will cleanup zombie processes for you

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.26.2
cpu: x86_64
