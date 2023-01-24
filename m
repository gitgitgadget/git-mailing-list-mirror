Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73483C25B50
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 11:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjAXLXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 06:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjAXLXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 06:23:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C5F8697
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 03:23:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so10696455wmq.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 03:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kJHodi5OFm07gUf5ee/qSk6C+YTwNTKirqnhvKXcPZU=;
        b=kcwkxENrvGWOncJsQ324y8HnDhD7TZ/M+Z4P7GIlF4nPk/GZuJgcpOVEHeBIDSnhzu
         OaCr6xSHaXtiQQyJ0lHpn545tB29bV3udT/JKq9t0dcWIfSEuh9D9nslSVu+Y8gyGH3X
         VDKtGd5P5y8GIfe5Ec6L0HKXWbiwT33J4NKxVHSjm2pyP7U0pqNmR9nQFqR9NdmGbwSm
         fZIMDnVYDyzPu4GdQajGIpJkcA4eQ6+odVJSNlkdBUTBQ3LwpEsVPaMgGqH8qNslQC5L
         aHEykf45z3v8geKZGRNU5d23qwyt7V2xA4CWQlj7nd6SZFXzGwqQfJ3xtyRuduoS7Zq6
         WM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJHodi5OFm07gUf5ee/qSk6C+YTwNTKirqnhvKXcPZU=;
        b=MvQjYeB8zVL5cDDpCf5FA6xp85LqIggDmnn/BVhVaTcRNs/BGoBXazEXwdKh+HB+m9
         nOoAjbomvvG/k/wOeUhbJA+2lEWKvUh2yW3kNuBh814gWFD+9NcNmy8jVLpqNO0Zqtkb
         bwbhG0EFQ1NtZKWXwELesNrK+cFQKMmZOJGcKXGwkoJcf7wuekvAJbJTrmKA6syhkUoV
         j2L2BLf+HNM5PCZIoEy+Mz9iPeYMx4PJUs5uVs6VbiWMLxueSLVGnwgZ/4RsVjQa73OA
         QtKLNbt7oQVZFwe3k5d+Okl83z6/4sDhIvwEPPX8aGX022aJRQWQN3vF1ZvSNZIjEblo
         /22Q==
X-Gm-Message-State: AFqh2kpH3GmdGluj+wJskLh7SXQVqI8GFEB1jze+OErVA+V7p1yGbvWi
        MXhlEP9xoqV/zEY2LkhLuqkaE9ZVnvE=
X-Google-Smtp-Source: AMrXdXu10ky3bfCHIglfJ6oiYMoHDVpbcu5RCQmy9Ail0ZIZlNMh/f9li3aGf9jUcPyE5WQU649ltw==
X-Received: by 2002:a05:600c:1609:b0:3db:12a:5e65 with SMTP id m9-20020a05600c160900b003db012a5e65mr27000888wmn.4.1674559400015;
        Tue, 24 Jan 2023 03:23:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c420a00b003db0cab0844sm1642366wmh.40.2023.01.24.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 03:23:18 -0800 (PST)
Message-Id: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Jan 2023 11:23:15 +0000
Subject: [PATCH 0/2] gitk: handle long command-lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches have been cooking for such a long time in Git for Windows that
you might think they turned into broth. Yummy broth, to be sure. But broth.
'Tis beyond time for the patches to make it upstream.

Johannes Schindelin (1):
  gitk: prevent overly long command lines

Nico Rieck (1):
  gitk: escape file paths before piping to git log

 gitk | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)


base-commit: 465f03869ae11acd04abfa1b83c67879c867410c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1469%2Fdscho%2Fgitk-long-cmdline-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1469/dscho/gitk-long-cmdline-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1469
-- 
gitgitgadget
