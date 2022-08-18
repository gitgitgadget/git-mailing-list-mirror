Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD10C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiHRPVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245573AbiHRPVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:21:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA07330E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:21:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tl27so3884467ejc.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=lzfSgXLJmpj8yMTEQ9wpo2QB6uC6I05gecG5/nVU7E4=;
        b=qWQjA0PSmRTR1kh+o1Vw7MMuo7/2FLkV5XLkKFlZAlMghQVdpHrVf5LLWZH6OmmNrF
         GDrgc4xmHY8sQn4KJKpUQRLLr0Jw+rtymCkUMP7I/DqQVIgZzH0Ct8FE4cjT3ydFXN2+
         L/ArzWLJG3Dl8Yu5wQKFe6zoQOgLyacAH/d/jUO375IKyNLH7XlFiHK3I7tux9g5LTpj
         MFlhrXQonNkJz9/TO7lJcwbmchmnGXS+hG7xvFyuU3T2nHppsJypw5MJxW4XfTUMzk89
         pG2NLj/2UXSzj0ZkwtXPJSpVCscTy82F4dC2OXmmQRGEZJkaYIgyWq6GpclwCK2Td1DX
         m0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=lzfSgXLJmpj8yMTEQ9wpo2QB6uC6I05gecG5/nVU7E4=;
        b=hFVdBRkoXwAULN4xC+V0Gn4qwJ6iy75habAryAo2pIAmhwCZpJs5FI1mbLa+kX5aJd
         1aN4aCqlL26KuvTV+PgU0Dly8mWIz8cwHdHg4e/4lb3dBFLu3TpqcqUw39ky1WhjvUAT
         Niws88GAqiej+1LFUKib2Ov7EUgkXgEpR6VA0QQrJK6xnz3NvfmQEjLWcdkgAe3LVHT2
         pwYCK9jy+HNMX1RJp+IyEFJiNTE640Tc+4aLCtJBF0ygFPh0xvyA/mfOpjXLyj6SMaK1
         GODZ9Bp2m0QgBeFFOe6Bnv56zhmyhafya2q4LRF1kppS0HnNSLgwKtaUzeCr+KxbjQ1f
         AJ7Q==
X-Gm-Message-State: ACgBeo1kxyC6nQt9NQiybE9rXHaOHmLkd5HMlxsepcmi/lJJR7LdCZR3
        7UurhGdoYYgflWC/MWstld2XgdRnx6hjRMUDJKfr9BSp7Y0=
X-Google-Smtp-Source: AA6agR6zVHY+HKzp9Z+48fO6KWtz+dQmCLznsT6tR3wxdDAxq4g2kU61oarinURo7bWmlZwu825b1gaNzpUDuaJOUEg=
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id
 mp31-20020a1709071b1f00b0072f56dbcce9mr2094864ejc.605.1660836093903; Thu, 18
 Aug 2022 08:21:33 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Fulton <mfulton26@gmail.com>
Date:   Thu, 18 Aug 2022 10:21:23 -0500
Message-ID: <CAED_RJPh28o8bFsBEEzAYvp1DXhff2JWiTk3zHh3VbaHZephgg@mail.gmail.com>
Subject: Programmatic patches (transform commits)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a way to commit a transform script that programmatically
applies file changes rather than committing the file changes directly?

e.g. Imagine in a large repository that a contributor wants to replace
certain instances of "abc" with "xyz". A transform script might be
like the following:

```sh
#!/bin/sh

sed -i 's/abc/xyz/g' $(find .)
```

Applying such a "programmatic patch" will potentially edit many files.
Doing a code review on such a change is error prone due to authors
resolving merge conflicts manually, etc. while reviewing the patch in
some circumstances is much easier (especially tools for specifically
this type of file transformations are used to make it easy to parse
code, traverse abstract syntax trees, make edits, etc.).

Does anything like this exist today? Depending on the implementation I
could see there being cross-platform support challenges but maybe
there is something that already exists to assist with this which I can
learn about.

As an alternative to making this part of Git I can see tools like
GitHub Actions being used to look for commits of "programmatic patch"
files, pick those up, run them, and commit and push the change but
having a solution for this as part of Git itself would make it
independent of GitHub and more reusable, etc.
