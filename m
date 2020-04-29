Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE18C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8616C206D6
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGw0Wd2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgD2Ngq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2Ngq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 09:36:46 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8FC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:36:45 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q204so1751629oia.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tKr/B24jjaVDKc9B4dQYluRFP+YiR2mUWfvwcZUGgkY=;
        b=mGw0Wd2sYluCtpeu2j7VEcDalmZAQsNacfBWO1UU59eJHqIKYd+aZuMNHjzdNxjl5L
         eUz/pIGHFY07FyHI8MM5sXyWQu8326h9rCTF0K5BJqM0TD044aJYWBxAX/Lxy/b1nnCW
         S8DRntfF6Sqg8FFOu/VH6s70q+PQt6nbt89apa5PmyJYUc1iYWcg9UtiI/fC2VCLoPuz
         zNwafL2ZuYc216r3DXK++jna+6vt7J9a8joVG5lIWcn32roEJzJ+lLKUYzyc5Ub6K2Zx
         9zEpU0jVKWlhN1PmUj8z81vrFvK3jKfXHYFDiN94u/SwIZVnTLVQdaEVrFPbGAZf75ay
         Z+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tKr/B24jjaVDKc9B4dQYluRFP+YiR2mUWfvwcZUGgkY=;
        b=tegYbLBKb2bXywM4s3NyY55OHtdc23MI8oQ/yIWJvZ6yM/oeI0wbHKQhDKKHRcWsHh
         iGFVmPz06dU7/+Tfm2OH4k1F9sX+teAPNxN6tZwItIPsK6aF4vMERycblsSn5Pj8WWKw
         5EnXZUislbo8soerkxxj7M+W6NqnaS1NU/68vhNEKEAhFbdEpI6P90UV1s0jfJx7IzjA
         EHQEpmfmzwZuWZkrB3KCsSK4nfdSfoWLPj+KP3UQaDi4Q+Br3BUK/iNHpebzeyRIIZzK
         4N6sKpYW5WIh9gftMGFLQGG5tOXds84jFtFDbkZs8ZAEtH4RxpCbJc1R6puGvIle9F/X
         lN9w==
X-Gm-Message-State: AGi0PuY1qfNug2P57MkxXXiiGDxhL0tMRNzywBsNZPIqyjWXl4mUnX88
        R5QTEGIqloEdc7ZaG3bO+FhW5sLyPIYT3CBRSSDusal2XXk=
X-Google-Smtp-Source: APiQypKBLzqW7iAr29VV/lv7GwgJMYib5HnhOJ2HaJNW9ozTYhIZQeKrrAfxpGggIu7wHVHt6dxb15hVCP0d7NL4AjQ=
X-Received: by 2002:aca:4858:: with SMTP id v85mr1600385oia.51.1588167404857;
 Wed, 29 Apr 2020 06:36:44 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Glidden <41mortimer@gmail.com>
Date:   Wed, 29 Apr 2020 09:36:31 -0400
Message-ID: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
Subject: git fast-export not preserving executable permissions?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git world!

I have run into an issue that I cannot seem to resolve with git
fast-export. When running a fast-export on a repo that contains
scripts with executable permissions (e.g. a gradlew script), the
resulting export does not properly reflect the executable permissions
on the script files.

To illustrate this issue, I created a small sample repo, with one
executable file and one non-executable file. From the output below,
you can see that the mode in the output from fast-export is the same
for both files; according to the documentation for fast-import, the
mode for the executable file should be 100755 instead of 100644.

    $ ls -gG
    total 2
    -rwxr-xr-x 1 106 Apr 29 09:13 executable_script.sh*
    -rw-r--r-- 1  63 Apr 29 09:12 non_executable_file.txt

    $ git fast-export --all
    blob
    mark :1
    data 106
    #!/bin/bash

    # This is a shell script that should be executable.
    echo 'The script executed successfully!'

    blob
    mark :2
    data 63
    This file is a simple text file that should not be executable.

    reset refs/heads/dev
    commit refs/heads/dev
    mark :3
    author Doug <41mortimer@gmail.com> 1588167102 -0400
    committer Doug <41mortimer@gmail.com> 1588167102 -0400
    data 25
    Adding some sample files
    M 100644 :1 executable_script.sh
    M 100644 :2 non_executable_file.txt

Please let me know if there is any further information I can provide
about this issue.

Thank you,
Doug
