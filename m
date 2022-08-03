Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8EC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 03:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiHCDn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 23:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiHCDn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 23:43:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3915142E
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 20:43:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so15252003ply.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=58mgpM6gWTkLl6XsoMoZm0lQkdVLnDlM+/MB/xVdJO8=;
        b=GLtPeei7Rn6+FAa5oYCMRjffMe5nkoRo6Xwwl8RYNhTajsHVN1lyQ5rSLI6Rebavds
         IK40e46w4rwUbcQ6/56gozvQg96m3iqPyPUUNhnujkS+9qA6HuAm2fz8yb4UDscMhem9
         dY6IdGffGp5jE3//vmw66aZ2+cxCpZKb9O06LJ/4Icb0b0LvQCFdmJFnJRM9FXN0YoiN
         +tonjyIpcrKZJo9MESUs0IG03uWX1S4UzataDOjGkSjoXgmrKdciMu32JkZ89RdI1c5X
         Bhctr8F+U023VHncMYnJSxfZFVVU9zLDEZVqjaAQO2boTGfevhytMpdDRGcdTjQk4tCZ
         4hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=58mgpM6gWTkLl6XsoMoZm0lQkdVLnDlM+/MB/xVdJO8=;
        b=sgR10S6irIcJgUTotuXH4E+CqjOP6DQLPz4psrYlp7Isn9LBQvpIsUhJkgtAfqSCTE
         SPZO9Oo7kGcuuiESq6fOZarnG6+Jfbq4UZrRCqbNWUsJtjPKZ34FdZx9LMN52ycT6fE/
         fOHuHFWj+C94yLrPWc3HaFGqaiVlYwxtv2QFpmO6oEKmimMdReIVRJQNKuzaA7+Vo5gq
         5kGQ520d5zG5p/cqOvPaYUfbpOdDGSrKaY6uQtmIaKYJbVXkZaeVEuS+lhzpfscSB9V6
         nXVP97M67a1MBVIesPTswQDVhIp5eWInwSqW67eGY9vFAy8A1L9oskgsKuY9IIcUEGWo
         JWYQ==
X-Gm-Message-State: ACgBeo3O+atRirWHIIPILSR6AGzdxgEqlZB4K08Dx9Trzew3DdgfZOVz
        R6NSSodH5W8Bru8i4u4FTJHdkGpA/u6A4g==
X-Google-Smtp-Source: AA6agR6pPkIFzGXARNpU/TV4bJ3v6ZY8Kppse4piKGKIUfSLesqJsiYYRS22JxQNAzau5iWISvPKfw==
X-Received: by 2002:a17:90a:fa91:b0:1f5:1f52:a2ba with SMTP id cu17-20020a17090afa9100b001f51f52a2bamr2820209pjb.16.1659498206772;
        Tue, 02 Aug 2022 20:43:26 -0700 (PDT)
Received: from xxwECS.tbsite.net ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c10a00b0016eef474042sm487081pli.262.2022.08.02.20.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2022 20:43:26 -0700 (PDT)
From:   haoyurenzhuxia@gmail.com
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, derrickstolee@github.com,
        dyroneteng@gmail.com, Xia XiaoWen <haoyurenzhuxia@gmail.com>
Subject: pack-objects: won't show the "Writing objects" progress if bitmap exists
Date:   Wed,  3 Aug 2022 11:43:20 +0800
Message-Id: <20220803034320.119959-1-haoyurenzhuxia@gmail.com>
X-Mailer: git-send-email 2.37.0.rc1.4.gddbc07872e.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Xia XiaoWen <haoyurenzhuxia@gmail.com>

If bitmap exists, Run the command:

    $ git pack-objects --all-progress-implied --all --stdout --thin
--delta-base-offset --progress

Won't show `Writing objects` progress until writing objects finished.
The output will display `Enumerating objects` for an long time(about
100s in my case):

    Enumerating objects: 329780, done.

Untils writing objects finished, then the output display like this:

    Writing objects: 100% (329780/329780), 110.26 MiB | 1.02 MiB/s, done.
    Total 329780 (delta 0), reused 0 (delta 0), pack-reused 329780

I used `git repack -ad` to create packfile bitmap in the bare repo
(git.git in my case).

I found the "problem"(maybe) while `git push --mirror` to github.
