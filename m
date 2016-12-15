Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F35209E6
	for <e@80x24.org>; Thu, 15 Dec 2016 07:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbcLOHSX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 02:18:23 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36535 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbcLOHSW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 02:18:22 -0500
Received: by mail-io0-f182.google.com with SMTP id 136so61736524iou.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gEAehs35jRwdSKdROqBHSexM4gR5yAP9l5I7hQC8LsQ=;
        b=s3JhK2REFWdJwSTF7w3k4et43L88rhY6BJBgnxAY618+tMRn8yNgfMAPxQGW8SSDby
         ZiW4926nHWw+B0T+7ZwdigJ64sIV6mFXgrQeDcOSw6NdeTOJcYqIfNDd2sc5xyKrOaig
         WCEdhAZ3bWNfAFylOagFNUWrGyc+fuImGlo8W0eInNOGslEKIyw3qERn4tvW3th5p8Uc
         kCUseIEGRv+6CQP0jM7hROQmmeDrOFWgauDL/xbyd9ZCvfZoPTuAbdIsLEzpPfK5EyYd
         a83uz+N83taT0JuYfR0weC7M6T0QM3Sn2kEHt9UYYVIyUoPylsEQLDc/9J6shht72Hkp
         WPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gEAehs35jRwdSKdROqBHSexM4gR5yAP9l5I7hQC8LsQ=;
        b=C50fuCTBHZsYmXvCL5vdJVxIYFh132WxgU63yh+MMoy5R7P5CrajHT8FClEquXkeL0
         f5f+3qH0VFjaSvvzUhVVr13BYIisCJCJ+1AxfZk5asaJMRaoYgTS+VbEqeWMkxVr1Pld
         EbMgkp0mgRnU2uE5M8cebDYjvweznf27xnydpsNJP243uU2lquyHjIvclwqpfishSuZt
         okOqIkykiTDRUk/kUsh6Hk2bQaK4yJEuyXY1RLkf1IShJFPjzvTm/a7XTQavJsS3V/jH
         pzmDMogwfdd80f2Cg0bbHRGXgE3g/CTa7kr5Jz+yR6y00kLjsavEmjfT5Y5DQsE9AU17
         1Hiw==
X-Gm-Message-State: AKaTC026wE1RIGYhninZjoXd7VlHmXOldE1VQ3rT9psvZUQc1cSg/jUKSuCS444bPYJipirAH/t1f6kYuNL42w==
X-Received: by 10.107.199.133 with SMTP id x127mr1092999iof.216.1481785924319;
 Wed, 14 Dec 2016 23:12:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.157.4 with HTTP; Wed, 14 Dec 2016 23:12:03 -0800 (PST)
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Wed, 14 Dec 2016 23:12:03 -0800
Message-ID: <CA+KyZp4HzsSOghKZnKgXEXy_gqw-9oTHveDHn1eRUY-_C6_jww@mail.gmail.com>
Subject: git bug - merging JS / Node.js code with "git merge --squash"
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@git-community

I am on Git git version 2.7.4

This problem is happening on Ubuntu 16.04, but the same problem was
also happening when I was running on MacOS.

I am consistently seeing merge bugs, when merging between branches of
a mostly Node.js project.
I am seeing fairly bad merges that mangle the code in ways that seem
to clearly show some sort of Git bug. Some of these merges were for
files where there was likely not even a diff between the files.
TBH I am no Git expert, but maybe I will learn something from this
investigation.

The latest example of a mangled file is here:
https://github.com/ORESoftware/suman/blob/staging/suman.conf.js

You can see some repeat code, and also there is a dangling brace which
means that the file won't even "compile" with Node.js, using "$ node
-c". Notice that this file was *not* a file where I recently  had to
manually merge code or manually fix a conflict, so I am hoping this is
not obvious operator error.

Here is the script I am using to merge between branches:
https://github.com/ORESoftware/suman/blob/dev/publish-suman.sh

basically it is doing the merge with this line:

git merge --squash -Xtheirs dev -m "squashing" &&

This is obviously very concerning because I can get very strange bugs
that I wouldn't expect, because I just assume that merges go well if
they succeed and it's hard to check for failure after that; even in a
compile statically typed language it could still prove difficult.

I am doing a check to make sure all my files compile with "node -c"
after the merge, but even then Git could create mangled code that
would still pass a "node -c" check.

Please let me know if this is a known bug and if there is a good
strategy to avoid it.

thanks!

-- 
Alexander D. Mills
(650)269-9502
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
