Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73D0C83F17
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjH1WtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjH1WtR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:49:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2EF11A
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579de633419so44186267b3.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693262953; x=1693867753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cF7NzjRgrAHsTCdhX+DXEkLPa2jkZhRp7bQ1m1SDus=;
        b=w3FJgbDxkGwqXdPQk+9Zo8gNGP6GUN4iPLej0nLoTnZYsQ2nk5TSKsDSCDuM0+QN1J
         5NuUFY7VyOoASDTXL58Lnalnq3f/v8BrvuexDgyihu55QZ8f/BnEBtV8rBNr8GctU8xP
         IlTe7dXGKSZuEeUQbYqN8W69CBdOOOmNbrqTSF6J9sO1JptyNQnB5dJIl+7mfXIOru4p
         VobRaz41JXKX+zDSEOWayIeNKKkwt2yGdfM5ORRKdN8rHsh2fG6XYctP+gi1Gl519jNo
         /e1STONFnboDYimYh22dVYjAAfm1XGXi3TDmjq/8d4nu87VTqtvvULmi+e0ceWYiLZLc
         RGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262953; x=1693867753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cF7NzjRgrAHsTCdhX+DXEkLPa2jkZhRp7bQ1m1SDus=;
        b=OAPaQZnIfjKkM35PnkxNlUJhxN6CktuI8Z0ksJUz/D8YXCEB5vakU48TfdkQGga9Bb
         B5O1Y8yrb8WJPSVkKBP659Ahx8LFtz09XgOnpfBxRUJbf964Dxjf6Dkm8I2jH45fZ1qz
         QJ4+Bm3Ak9oPR4uGRgvo2ZMlNoe7wzs8RNt1eNvFQf8Ol7w8fYY1RKiX9RpRLcgFsSwy
         Nl+NFENe+1zESOC9rS7E2OFRwEoGAmjI21ehfFQ8WfwhEtO0dWKY8DQS11RVSdjRxbB8
         eYGKvqr35DDYimhtiIVS0eSkxi4ixqjqCDlJCy+VlmgycdsvndWKmClujbDld+A//GJb
         1rdg==
X-Gm-Message-State: AOJu0YztNV1A5T5IAzyw6BzB1XsXRay6Ynh0egB67+797GgRg7XT/fYD
        SIYH04ovGE02vTquukmcJkrFHVOXWiEhAlEoZUjLzA==
X-Google-Smtp-Source: AGHT+IGQfo3O3b3PB7Hrv12Uxsj56lQB1twQI2xz7bVF5k3KiIgz2ir+nU8BdHp7tqZDB6iV4BlMmg==
X-Received: by 2002:a81:8782:0:b0:589:a9fc:ffcd with SMTP id x124-20020a818782000000b00589a9fcffcdmr27624036ywf.20.1693262953657;
        Mon, 28 Aug 2023 15:49:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t130-20020a0dea88000000b005839a780c29sm2406323ywe.102.2023.08.28.15.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:49:13 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:49:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 4/4] Documentation/gitformat-pack.txt: drop mixed version
 section
Message-ID: <03c54e21ee48028cd7c0d136671eb9d1e8b9546d.1693262936.git.me@ttaylorr.com>
References: <cover.1693262936.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693262936.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This section was added in 3d89a8c118 (Documentation/technical: add
cruft-packs.txt, 2022-05-20) to highlight a potential pitfall when
deploying cruft packs in an environment where multiple versions of Git
are GC-ing the same repository.

Now that it has been more than a year since 3d89a8c118 was written,
let's drop this section as it is no longer relevant.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.txt | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 49bb09d7df..870e00f298 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -588,32 +588,6 @@ later on.
 It is linkgit:git-gc[1] that is typically responsible for removing expired
 unreachable objects.
 
-=== Caution for mixed-version environments
-
-Repositories that have cruft packs in them will continue to work with any older
-version of Git. Note, however, that previous versions of Git which do not
-understand the `.mtimes` file will use the cruft pack's mtime as the mtime for
-all of the objects in it. In other words, do not expect older (pre-cruft pack)
-versions of Git to interpret or even read the contents of the `.mtimes` file.
-
-Note that having mixed versions of Git GC-ing the same repository can lead to
-unreachable objects never being completely pruned. This can happen under the
-following circumstances:
-
-  - An older version of Git running GC explodes the contents of an existing
-    cruft pack loose, using the cruft pack's mtime.
-  - A newer version running GC collects those loose objects into a cruft pack,
-    where the .mtime file reflects the loose object's actual mtimes, but the
-    cruft pack mtime is "now".
-
-Repeating this process will lead to unreachable objects not getting pruned as a
-result of repeatedly resetting the objects' mtimes to the present time.
-
-If you are GC-ing repositories in a mixed version environment, consider omitting
-the `--cruft` option when using linkgit:git-repack[1] and linkgit:git-gc[1], and
-setting the `gc.cruftPacks` configuration to "false" until all writers
-understand cruft packs.
-
 === Alternatives
 
 Notable alternatives to this design include:
-- 
2.42.0.49.g03c54e21ee
