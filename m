Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 07:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiF1H7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiF1H7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 03:59:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B0630B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 00:59:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g4so4538921pgc.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwAdxpPqpBLBue0DAMNtdMw2UnxWHFsUb9DcAkCM7Dk=;
        b=i4LocCmcz7jGzciUUBaa16hBrK0XJEROsa+JZhCyeapD6bwikA9nc9x1qYB55UV112
         SYqcUYzY31abMhCzXtVZVR2sNDZCXmVSdMp26D1vzPO99b6OXfhGf75PPzI2lXUAxoiP
         ealoQMV/pidAjYTlXiquXHjuM87lxw90lyCOGktwI88ryabp9gl7aabZK8ntMD9nvbKj
         XG6xT4WvcvKRRXCbi2pF2AWLWl2eaP2KgwQ+RK9uskNWytrTWmVtAXEBkrGIdjT1wyOQ
         rMzqHJ3RHuyeERUFQ7mcpNarkIhxko0374Uh10KASO4p7NZTv2ZpeTRv5YY1KscCIy1k
         Sakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwAdxpPqpBLBue0DAMNtdMw2UnxWHFsUb9DcAkCM7Dk=;
        b=J3UeHXWX+fxMpSyhDDA5FGRbO9MCOMVhbAoWAXihiOJZEdqZruVTH6kEfpwG31y1IU
         D56ibNeEGDWSjl/g57d3vOfYcTMwu/lrdaLhhdcdoLCggjq9k6O5Ad5ACSH3Aeespl1R
         g3HeC0RkqBDYSrQ5PzXafSG6jOS2p6BCi86EkV1zGYt9DYIg40FwWBamvGt5BV0W6jGP
         oRC3yDQqwnE1qLBD0KkeBHiEMBcBo94GeYGQbSzKAjDM0zPHa/u3JcDdgeEH/y7ymM6V
         1Ca/fsF+C6o3oVmvwMesqKVyCjCo2NfiakyL6z7mtHxK2nh1Waphtg8MxHObUnX2Y3n0
         dK6g==
X-Gm-Message-State: AJIora+osZdVcoe7m0T2r1soYi/qCVEypOQjYQtErzWDlSmtRVnQTIX+
        aSdl3ty4K+yRZZxwEGJl6Rk=
X-Google-Smtp-Source: AGRyM1serG5Z23iICP5rFmhkh2xqfI8vuce2Mpv85vuA4xNuby/BI3cl6jMbEMZ7lYjCVY8PmB75JA==
X-Received: by 2002:a05:6a00:138b:b0:525:1f0b:3121 with SMTP id t11-20020a056a00138b00b005251f0b3121mr2356994pfg.8.1656403144336;
        Tue, 28 Jun 2022 00:59:04 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id m18-20020a634c52000000b0040c74f0cdb5sm8556377pgl.6.2022.06.28.00.59.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jun 2022 00:59:03 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 5/6] bitmap-lookup-table: add performance tests for lookup table
Date:   Tue, 28 Jun 2022 13:28:43 +0530
Message-Id: <20220628075843.19170-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yrom04Go0tCAZWT8@nand.local>
References: <Yrom04Go0tCAZWT8@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> I think this "create tags" step can happen outside of the test_bitmap()
> function, since it should only need to be done once, right?

Yeah, I also think the same. That's why I tried to not include in the
Function but for some reason, one test is failing -

  perf 24 - rev-list with tag negated via --not --all (objects):
  running: 
  		git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
	
  fatal: ambiguous argument 'perf-tag': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  not ok 24 - rev-list with tag negated via --not --all (objects)

One thing to note here is that the first `test_bitmap` call always
Passes. But the second `test_bitmap` call fails due to above error.
It throws error irrespective of any parameters for second `test_bitmap`.

If I put it inside the function it doesn't throw any error! 

For this reason, I put it into the function. Do you have any idea
why this happend?

> And I think these two tests could be combined, since this could just
> become:
>
>    git -c pack.writeBitmapLookupTable "$enabled" repack -ad
>
> right?

Yeah, sure.

> There is some funky spacing going on here, at least in my email client.
> Could you double check that tabs are used consistently here?

This is due to my editor's spacing issues. All seems fine when I look at
it in my editor. But actually it is not. Fixing it.

Thanks :)
