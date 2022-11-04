Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C8C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiKDCYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 22:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKDCYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 22:24:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC211135
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 19:23:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n191so2839297iod.13
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vG5YRkWFE6vpbXNIkSqF88pFsFALnlsqqoZq7AWqcqs=;
        b=zxT1w9yVvneuG+BuZDCAypGqqwY6+AFjmdANttj+o0PIGaScAi5+xXbufkHE0wIYUm
         HAKjUS67kjxss9h50xD/vkAsgEKwY+nBqzZIYfCHOkfp+8up8VFh+1EfAWnfQpGZkcT9
         v2n2mlx5nECQ+IszcUlNchjwtsYplsYmo9WOPN23UgHjSnxzFQMZ+Dut2xR2m5qAczWK
         wDNK4SaAh/xfwsw8kXR8DZ2UYrS5iUrlVHQaH4qWAfNJ2KtB43CUEmNPIdwAf5dpn6CN
         Gz+qFpM3fpo7HRldIXzTayvnEMuK9J7acvMPdOuWd6Iqot3LVOa5e+/fxHle73knVmxT
         70WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vG5YRkWFE6vpbXNIkSqF88pFsFALnlsqqoZq7AWqcqs=;
        b=IpwFSxlYexotSm+ORKwKKJ/s+KerDqrDq2fz16mieJfVc5faSB6vUOrGDlWjSSKG2z
         xH+t+AM5j0fsvgwiPKc7Zp4+8a728dT6dLm/42Lp4tSiqrf0RtLV8GZbWWvILZqRGbZ8
         T6GUYBNyjxDoWquZsrGZCGCNNDVZqoz7e5yTxchce1BtLn7C+HFopPWHSccopQve52dL
         KA2HYpY4UnTu+Ih4oN70Q0/zP+avpi+sRtvGQeeSA7VbVMh+ZXhE8Auh2gR4GfWQhWx4
         cOK8TNyjASB0jQsQhaZth6pZlx8ixb/ECVlozrVZwYhUGhBsJB1W5Pk7YaDoUNxIaLoY
         rnnA==
X-Gm-Message-State: ACrzQf2BFK9EaPtfS6ak4vGy/rxNrPB79Spo4l3C7S/xZjDNioQ64CJ2
        1XdKNZvdjsLXjnl02sPKPifbjg==
X-Google-Smtp-Source: AMsMyM5f3AZaz5T/zgP52I4da+6BGBWAIv7seWfGl+I3584BWBG/Eq0ebhOvOR3bhiasJ8JriHIwDg==
X-Received: by 2002:a5d:9411:0:b0:6a7:f7ec:6dd8 with SMTP id v17-20020a5d9411000000b006a7f7ec6dd8mr20312107ion.44.1667528638105;
        Thu, 03 Nov 2022 19:23:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y19-20020a056638229300b00363da904602sm797104jas.13.2022.11.03.19.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 19:23:57 -0700 (PDT)
Date:   Thu, 3 Nov 2022 22:23:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2R3vJf1A2KOZwA7@nand.local>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 02:46:23AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > This is particularly problematic in the case of Pull Requests where a
> > single contributor can easily (inadvertently) prevent timely builds for
> > other contributors.
>
> The "timely" being an issue in git/git and/or gitgitgadget where CI time
> is a shared resource, but not in a <someuser>/git running CI just for
> <someuser>?

Yup, agreed.

> > To help with this situation, let's use the `concurrency` feature of
> > GitHub workflows, essentially canceling GitHub workflow runs that are
> > obsoleted by more recent runs:
> > https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency
>
> In my own fork I very much use this concurrency not-cancel-in-progress
> intentionally.

Interesting. I noted basically the opposite in my earlier reply[1] to
Johannes, where the behavior I want is that newer pushes of the same
topic supersede older ones that are currently in progress.

But I think you make a compelling point (which doesn't match my own
workflow, but I can see the utility of nonetheless).

I was thinking that we could rely on something similar to the ci-config
ref stuff from back in e76eec35540 (ci: allow per-branch config for
GitHub Actions, 2020-05-07), but it looks like it'll be a little
trickier than that, maybe impossible.

We need to know about the state of the ci-config branch before we set
the concurrency bits. So I think you *could* do something like:

--- >8 ---
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4fdf4d3552..f1ca364f96 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -2,11 +2,6 @@ name: CI

 on: [push, pull_request]

-# Avoid unnecessary builds
-concurrency:
-  group: ${{ github.workflow }}-${{ github.ref }}
-  cancel-in-progress: true
-
 env:
   DEVELOPER: 1

@@ -39,7 +34,14 @@ jobs:
           then
             enabled=no
           fi
+          skip_concurrent=yes
+          if test -x config-repo/ci/config/skip-concurrent &&
+             ! config-repo/ci/config/skip-concurrent '${{ github.ref }}'
+          then
+            skip_concurrent=no
+          fi
           echo "::set-output name=enabled::$enabled"
+          echo "::set-output name=skip_concurrent::$skip_concurrent"
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
         uses: actions/github-script@v3
@@ -86,6 +88,9 @@ jobs:
     name: win build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: ${{ github.workflow }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent = 'yes'
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v2
--- 8< ---

...and similar "concurrency" blocks in each of the other jobs to define
the settings at the job level instead of at the workflow level.

So, it's doable, but a little gross. At the very least, it would satisfy
Ævar's workflow requirements, too, since he could write a script that
exits with non-zero status to avoid the new behavior.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Y2R0YrQzKaUZzaPB@nand.local/
