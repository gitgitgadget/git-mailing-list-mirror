Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FF6C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 12:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCMMgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCMMgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 08:36:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2929E38
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 05:35:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j10so4203745qkg.12
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678710939;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJjKktONJtYRj0UuJF72oeM4iJZLIXrVJLdhSHidd08=;
        b=QlXsG1G0YiVX8l0bBYy9kV1rpSTAyRHpIzYdim3hlL5MJwcLXyG1Yh4RFv4j7anW69
         GinDrSPkDatVk+CIdklPT53m+p3TJEFRVXRZ5FTt6IhKwBj5GsjFuczdd1hUtXXQO0Jy
         8ZSwa2vHWrc3YNfd3VUEYiIm9MgSqAi5pN+/jnkF1IwkSDNN7VMzj9EuGz2VsLE2sg0F
         QrO8WXlGvw907AxoVxQvx7ZYAWwCs9kxJRb1WKgVT6UBG1uqQrjPK5o+0IhpdU4N389t
         apZTIkR/c1vD3Ptxu+BxbKIpIEehncTKBSD5tTBFi2uJw/crz0ef3FL9qKsQ1i1CbylA
         mq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710939;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJjKktONJtYRj0UuJF72oeM4iJZLIXrVJLdhSHidd08=;
        b=2mA9lj+BlytvjPN9xbXVM8LctjBd7FokX4Ycno2/3QJlX5mt7gEwpvv89ttX4966RR
         Tv3+rBy1Zs5FS5Uheftl3nHNBKf8YXP5llRDuwJlWPxE+rt2I1QvFqE3uH8YFGeNe8Ks
         lxdn8jFtJNEsxeyssa1I765KwYS14IoxGec2ry7x/KFi7nbpq0v/zeU/DtIQU2j2woJP
         mFdMIZPXpiAHlWyRQbrVM4qiiOgrNCSRX+YyjljNkH2xucRns4Lao8Q3PJkCVXPhakSX
         shsv9Ynz0TRG06B4KZsfe0mg99mRASE/FGj/6LnYy9a83rqel4ekjY1xMKPR64jR3Yym
         J4ig==
X-Gm-Message-State: AO0yUKVLKUyb/eXH8xXYqB7LGwleUoVDzCqXfqojSykLn8QI15eG9mIV
        ASv20Ey14Xw/FSMEIVDMAhE8uNB7AZX7MJEYkRQQgSomyPJ7nA==
X-Google-Smtp-Source: AK7set8gThPvxNr7oINIr6FsJb+0FjeO878yn7pQYOcXcrILtRHJjpdcxgKqmsEg1Zj/pc36MFRZo1Odp6j6+FI0oLg=
X-Received: by 2002:a05:620a:1011:b0:745:a78b:b32 with SMTP id
 z17-20020a05620a101100b00745a78b0b32mr280989qkj.14.1678710939389; Mon, 13 Mar
 2023 05:35:39 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Mar 2023 14:35:03 +0200
Message-ID: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
Subject: git rebase issue
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Recently Debian has updated the Git to 2.39.2 and broke my user case
(I believe it's a problem in the Git itself and not Debian packaging
or so).

So, my use case is to run

  git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase" "$branch"

in the repository that is made out of bare + a few worktrees.

Previously everything was working (my bare repository points to one of
the existing branch:
In shell prompt: ...(BARE:netboot)]$

With the new release I have got an error

  fatal: 'netboot' is already checked out at ...

To work around this I have to split the above to

  git checkout --ignore-other-worktrees "$branch"
  git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"

which makes all these too inconvenient.

Any suggestions?

-- 
With Best Regards,
Andy Shevchenko
