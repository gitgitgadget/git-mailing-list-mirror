Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88EFC11D24
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818220679
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="S1uR7Jqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBTVPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:15:07 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:32929 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBTVPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 16:15:07 -0500
Received: by mail-wm1-f53.google.com with SMTP id m10so3696504wmc.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=gQhfwxnPLtxNz6s3BgmBvTnnXwYJcdfJSO2/70Eo3N0=;
        b=S1uR7Jqq+DRtu7a7oDy+5NVKNdxWDpxD77zl8/pedjMtAmus9P6ilOxHFWbDTKFHjK
         1q8Ex2ccQqckfVjM9SmBFdIoSebu0UtWzfmUOB5GALYQH6BWKbcbFKNiRxIh3qHCStq4
         u5Ytr6K/WgOJnD65FyNzakVlyfyGKq1OA9YdLig/zMumYvq1mG1/9ADhAmYg5y6aOxQH
         RQdxxo5ZfaVuPY9bfTZxcA1eBAka7Saa7xpG6TdKg4kKnEgZW9kDp0s2MXbVzUZyGQta
         7bagygcYGzJU1S02RyDcO3FDcU+jhVgY1YoLCJ+/xqeKUD8850lUVFvWDA6g9T98FDDX
         0lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gQhfwxnPLtxNz6s3BgmBvTnnXwYJcdfJSO2/70Eo3N0=;
        b=AZzuhFVzGq1c8b6IqZlzeJBdO5cHatWoj5f3bpTosMyK1Am54/ywdx3UwusXoiaHzn
         EoZg+AaFRgxJ1+3LSf5HAsfCsf1fBVwYbdWeyzVShrz6DrONMy9nFXn/SXBpeqILP0pj
         chdJTx0t6IMWFN1h+bDmQfVO0uRMoloSVRWL4QJXZzyKsFrsTWXYg3zU26qKhVs/2LY6
         e+4UkdvnhDOE3jQTiso9e6YNeYLQm+fN/5WIvbTA3T0tG3d5erV+d+CVgaCVm57Y9idp
         2+O5Hh98v6Z7232R1Im0VvqBysVCDuklSUULu3ZP4k5lhstNFwmd5dRxxLH9jvW1QGyH
         CbpQ==
X-Gm-Message-State: APjAAAWzPJsXynBkUUOn85PDRR0om7vs6PYS8iTWYyR9nE+TtxmJTWmT
        zs1GfoA6qrrj6TpPMOxEB9qnVPP+y6W4tuGWIZS03pMrNwg=
X-Google-Smtp-Source: APXvYqw+ziGoO6XvhVApH2cXBs3grcp6HhBB4J2Rsziv4VGtTSQOz83zhmeoPUHrhpQ4vCcY8Iz5dwEzUGOBy3DbP1Q=
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr6569730wmd.48.1582233304908;
 Thu, 20 Feb 2020 13:15:04 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 20 Feb 2020 13:14:55 -0800
Message-ID: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
Subject: git does not wait on hook exes (^C)
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a small example:

```bash
#!/usr/bin/env bash
foo() {
    echo zzz part 2
    sleep 1
    echo exiting now
}
trap foo SIGINT

echo zzz part 1
sleep 10
```

```console
$ git --version
git version 2.25.GIT
$ git commit --allow-empty -m foo
zzz part 1
^Czzz part 2

$ exiting now
```

- I pressed ^C during the first sleep
- control was returned back to my terminal
- the hook script was still running in the background

Anthony
