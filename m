Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285241F463
	for <e@80x24.org>; Mon, 16 Sep 2019 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfIPVrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 17:47:18 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:50200 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbfIPVrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 17:47:18 -0400
Received: by mail-vs1-f74.google.com with SMTP id w22so357084vsw.17
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HZzysyzgHZerp0oDY99kU/flLvtOVzGKiJm8VctybRU=;
        b=OSFVoGrU8S0uQgPd/oouLI3cTNFRZwAipGG+cAny8UQfoxEI85AGfwDF4mG4ktHyUL
         TqMERxk0mR2L0MrtlTd3kP4/HZa/oGFLzY4a58SnNMtAZnoNkxqHCd744US8t+vex/1y
         G9X2/5Vt6GF5i+27KHsXOZB/Rx5QvGH5obivKV89SianZ30LdEa2RERZoGRTktayT2LW
         gJ1r5SSB4aoel4CcjFaOXLiDcvEqsubMVS6p9K7MeTqaHhn8TITy3/ubmMkEQ3Ty8kN8
         kP36YjuH3pVvd5BZfuy5CYuUdw+J8kCyVxgQaOZItSGQcBS9d7zeJ3dJt0zrbxgNhHVo
         rmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HZzysyzgHZerp0oDY99kU/flLvtOVzGKiJm8VctybRU=;
        b=Cb+yhWx4XOhw3owzaHlKVU34KNDV7XS+zh9juhnWwMR6zdp1aTf7Zwszlgx2bBEA29
         qp8PEUBh5AcARAkztNHJbA52Jvy6iM2pFqneX3d6o0K4OfUW2+7451m9+O/msrnJyjN4
         NLs3UjhMiOWKsYZeWTEs0iIIvgYCRxBc310Z+Wtj+SyBHoD2llguOZPBOHf/riDBmntx
         lSP+Dndp+btjXARN2b8IgONnoR/msb4ZAwd3KroxA3cBZgSscEdDOB98iyWnIXU9OItl
         NuKeTKIoTNm98DFmT8OY5TT41bjUkUX24KxPwB5Xhf9dQ2K7bqRZhdZSOhtxDEOWY+C7
         6QuA==
X-Gm-Message-State: APjAAAUzozrgaVFpRj1JqiM+T+wR3URvz4/Tv0En84vR0XmYA1Vt9DgE
        XpxMhdnIzYQ44kQI3Z0Z+66GNEmiiGEhAu/w/naB4sdfkqCR5QES7igGNNVukEI6OzTKc6dOyiG
        3bdDXPaEq2Okbz8TRyk2dj1E2MsidyCp5H7bp9/8zlkhE++JuombTxwj86s6v38gEFP5kpMjKAc
        6p
X-Google-Smtp-Source: APXvYqx9PdRCbU7IWO6V/GHnWFRgy5XcPp8QzrnJeJCcCHanCDZPy0fz8fG5Of8+znTRFa182nVCTWJZSVWfql9iaWnz
X-Received: by 2002:a1f:8fc4:: with SMTP id r187mr9517vkd.17.1568670436348;
 Mon, 16 Sep 2019 14:47:16 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:47:07 -0700
Message-Id: <20190916214707.190171-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: merge-recursive thinks symlink's child dirs are "real"
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was raised by a coworker at $DAYJOB. I run the following script:

  $GIT init test && cd test
  ln -s . foo
  mkdir bar && touch bar/file
  $GIT add foo bar/file
  $GIT commit -m "foo symlink"
  
  $GIT checkout -b branch1
  $GIT commit --allow-empty -m "empty commit"
  
  $GIT checkout master
  $GIT rm foo
  mkdir foo
  (cd foo; ln -s ../bar bar)
  $GIT add foo/bar
  $GIT commit -m "replace foo symlink with real foo dir and foo/bar symlink"
  
  $GIT checkout branch1
  $GIT cherry-pick master

The cherry-pick must be manually resolved, when I would expect it to
happen without needing user intervention.

You can see that at the point of the cherry-pick, in the working
directory, ./foo is a symlink and ./foo/bar is a directory. I traced the
code that ran during the cherry-pick to process_entry() in
merge-recursive.c. When processing "foo/bar", control flow correctly
reaches "Case B: Added in one", but the dir_in_way() invocation returns
true, since lstat() indeed reveals that "foo/bar" is a directory. If I
hardcode dir_in_way() to return false, then the cherry-pick happens
without needing user intervention. I checked with "ls-tree -r" and the
resulting tree is as I expect (foo is a real dir, foo/bar is a symlink).

Is this use case something that Git should be able to handle, and if
yes, is the correct solution to teach dir_in_way() that dirs reachable
from symlinks are not really in the way (presumably the implementation
would climb directories until we reach the root or we reach a filesystem
boundary, similar to what we do when we search for the .git directory)?
Also, my proposed solution would work in the specific use case outlined
in the script above, but can anyone think offhand of a case that it
would make worse?
