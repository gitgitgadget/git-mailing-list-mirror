Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA41ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 00:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIVASc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 20:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIVASa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 20:18:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5983BA9260
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 17:18:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n15so5913783wrq.5
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=BaK095rXIboMAIpl783JSQfkWm0hhwY4BdIRYXvX/Q4=;
        b=qltFdbube+re86yPyC0SbEgclmwGONpF5JTRDo9qA9zLHOB1KRNphPTnwDUTFo8+E2
         4iNZMBFd/Ko+mjkAvZIuwqL2Z59LUhPmHgUHM16dkdwTkFGXjDmQ0yaVRGMadun2oXZ0
         FnzMDEAg3mpucQx+ADL9zpGFBtwdsY7Zg/cqR5JgwXIYspqpiTtRgjljytJzjj5IH9Mo
         JJEX/LTYzJMMA9bRumLYiVvc4DJAORi8aeUv/C4CEGloDJo5bdpV4TOOtabMJtJUzrDK
         RdJETcD/gaVIkYUHIuDEaBIycYoqIoJN/8WOunR0odb0yf405RZPPIxBDUHN4l4sxOHN
         E5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BaK095rXIboMAIpl783JSQfkWm0hhwY4BdIRYXvX/Q4=;
        b=tEV1j2uwQLk8o8501s+732kU+lm4lYcSxLHaUtozhyZIPXi4DbIpAo2P5oZrSwrCzB
         gOC/C4kKVbg+rbLmJRp4AjiRU3eb21uwJzB86zweXZzPpHqE25Ney4cNb7q8fyUn5Io/
         IF7Ceyx7/dyIugbwknfl0DqOF2ALzjILNRiDdV83key1XAKMMdI9nUFfISKjX5XNNUYs
         E99ke189MZZRxO9mWfJ/WMUlrcCZGejemmprFK5qom/vE2T7VWrA6uXdTQw9W8Du/MEN
         g7vdglIZjz++5ke/BvHK/y29jCrEsQMgeNL0C3Qux4nNMHGIDB0e71kaXsTTN7Byg6fR
         NrwQ==
X-Gm-Message-State: ACrzQf2125KKOvH8rMm2wqP1G+4sVNkNeoYSweMaiUg7XXdVW/DKf21T
        F7b03isYMIEZFyAQALeCrCyx3eUse4k=
X-Google-Smtp-Source: AMsMyM4+7hjLTQIxLqOlSya74pFS9Egw0PM7DOyX/7vByGKjyEfeQcQ7RBSEHLB88c95UllUSJ/Yfw==
X-Received: by 2002:a05:6000:178c:b0:22b:7f5:c724 with SMTP id e12-20020a056000178c00b0022b07f5c724mr317942wrg.384.1663805907483;
        Wed, 21 Sep 2022 17:18:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b0021e43b4edf0sm3783917wrt.20.2022.09.21.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 17:18:26 -0700 (PDT)
Message-Id: <pull.1338.git.git.1663805905554.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 00:18:25 +0000
Subject: [PATCH] check-non-portable-shell: detect obsolescent egrep/fgrep
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

GNU grep deprecated `egrep` and `fgrep` with release 2.5.3 in 2007.
As of release 3.8 in 2022, those commands warn[1] that they are
obsolescent. Now that all the Git test scripts have been scrubbed of
uses of `egrep` and `fgrep`, make `check-non-portable-shell` complain
about them to prevent new instances from creeping back into the project.

[1]: https://lists.gnu.org/archive/html/info-gnu/2022-09/msg00001.html

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
    check-non-portable-shell: detect obsolescent egrep/fgrep
    
    This is atop 'dd/retire-efgrep'.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1338%2Fsunshineco%2Fefgrep-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1338/sunshineco/efgrep-v1
Pull-Request: https://github.com/git/git/pull/1338

 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index fd3303552be..dd8107cd7da 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -45,6 +45,7 @@ while (<>) {
 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
 	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
+	/\b[ef]grep\b/ and err 'egrep/fgrep obsolescent (use grep -E/-F)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
