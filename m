Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C6DC32774
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiHVPTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiHVPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D246DB5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:12:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so13638255wri.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc;
        bh=brZMdbQ+zrUP/TY2WusIHMjtPRf4XTNmkZdU6obf1tk=;
        b=ME+rFA6bXg0kPppusyCA+VRLrX+6CJiWjA+ySLHoMGIKSrxvuGe276e1z0cka2U9ph
         rI1nkc3zGA+Oe5rYeHHZi75Hn5GNVV8pbcSx+PxraeTtA1ywUj1Ejg8uFfPIAZYMDIAa
         FeNEo7nxeNoLNMn885YJ+8w2vmlFTxT6W2FehiJ/kD0HQT4CwG4LG/8RvmvIjnVMwG8a
         Tq5iYEgtehEfqR9Ifc+CG5GmJG+RASwIXuSeVdR/tw3jcAy7Tc19DcUifCZk10PZCBxu
         sRD12T+PBonBHkBVX7X2ipNGcxs/Wb/RiD9p2b/5JC7yjJwpj0zI1+GleazQpwlfTG9j
         JnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=brZMdbQ+zrUP/TY2WusIHMjtPRf4XTNmkZdU6obf1tk=;
        b=ak0hyPy2nbDVy4iENErovYQchqmdwAq4bNCZWFwn82GaRlaBxd5yFUIWpHvPC19xEO
         o2J1fgKNTMAa1jtmZlppSyRaRX8ZW+xEwCVQ8GqotxPSKsbcVZOhr1mt4fy0ayCwc1vd
         mPlXDmw6V2aq8G11vj6RapTglPR+NYUxm1M/VbHIVl89vzc6don9forHGX45RrYEQRCd
         O3Vx81JzcihZqTApNpA6BOrCmMDDI5VzEVhmH268yJSy6vCipw1ikPFcK/uwCzRj1DIQ
         ZOenS7UC9FXtDLFaGCPk3A4freG5w+u26z8uD6WocnbdTJmDn71NADQNBC4ftOytGAfH
         V9yQ==
X-Gm-Message-State: ACgBeo2u030qmgEBkn1F3kUoboftjSFPGv1FP4aX59V82wwYEI0Tmjm6
        WPWqZcx7ZMJaoCpTqchOczfuy48DuZo=
X-Google-Smtp-Source: AA6agR5rPnTS5m1ypCDghpkAoEfd/TFEXnJJNwsD6aXQemQO4L8y7iAZH4Yta/4RJff33HHBiAZhNg==
X-Received: by 2002:a05:6000:1686:b0:220:66b1:d897 with SMTP id y6-20020a056000168600b0022066b1d897mr11571784wrd.653.1661181175981;
        Mon, 22 Aug 2022 08:12:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003a6091b3a96sm19872718wmq.23.2022.08.22.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:12:55 -0700 (PDT)
Message-Id: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:47 +0000
Subject: [PATCH 0/7] Bundle URIs III: Parse and download from bundle lists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third series building the bundle URI feature. It is built on top
of ds/bundle-uri-clone, which introduced 'git clone --bundle-uri=' where is
a URI to a bundle file. This series adds the capability of downloading and
parsing a bundle list and then downloading the URIs in that list.

The core functionality of bundle lists is implemented by creating data
structures from a list of key-value pairs. These pairs can come from a
plain-text file in Git config format, but in the future, we will support the
list being supplied by packet lines over Git's protocol v2 in the
'bundle-uri' command (reserved for the next series).

The patches are organized in this way:

 1. Patches 1-2 create the bundle list data structures and the logic for
    populating the list from key-value pairs.

 2. Patches 3-4 teach Git to parse "key=value" lines to construct a bundle
    list. Add unit tests that ensure this logic constructs lists correctly.
    These patches are adapted from Ævar's RFC [1] and were previously seen
    in my combined RFC [2].

 3. Patch 5 teaches Git to parse Git config files into bundle lists.

 4. Patches 6-7 implement the ability to download a bundle list and
    recursively download the contained bundles (and possibly the bundle
    lists within). This is limited by a constant depth to avoid issues with
    cycles or otherwise incorrectly configured bundle lists.

[1]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/

[2]
https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com/

At the end of this series, users can bootstrap clones using 'git clone
--bundle-uri= ' where points to a bundle list instead of a single bundle
file.

As outlined in the design document [1], the next steps after this are:

 1. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [2]
 2. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [3]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[3]
https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com

[4] https://github.com/derrickstolee/git/pull/21

[5] https://github.com/derrickstolee/git/pull/22

Thanks,

 * Stolee

Derrick Stolee (5):
  bundle-uri: create bundle_list struct and helpers
  bundle-uri: create base key-value pair parsing
  bundle-uri: parse bundle list in config format
  bundle-uri: limit recursion depth for bundle lists
  bundle-uri: fetch a list of bundles

Ævar Arnfjörð Bjarmason (2):
  bundle-uri: create "key=value" line parsing
  bundle-uri: unit test "key=value" parsing

 Documentation/config.txt        |   2 +
 Documentation/config/bundle.txt |  22 ++
 Makefile                        |   1 +
 bundle-uri.c                    | 442 +++++++++++++++++++++++++++++++-
 bundle-uri.h                    |  98 ++++++-
 t/helper/test-bundle-uri.c      |  90 +++++++
 t/helper/test-tool.c            |   1 +
 t/helper/test-tool.h            |   1 +
 t/t5558-clone-bundle-uri.sh     |  93 +++++++
 t/t5750-bundle-uri-parse.sh     | 141 ++++++++++
 t/test-lib-functions.sh         |  11 +
 11 files changed, 889 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/config/bundle.txt
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh


base-commit: e21e663cd1942df29979d3e01f7eacb532727bb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1333%2Fderrickstolee%2Fbundle-redo%2Flist-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1333/derrickstolee/bundle-redo/list-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1333
-- 
gitgitgadget
