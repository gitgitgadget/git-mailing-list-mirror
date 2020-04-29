Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306AC83007
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09C221BE5
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzQQk4oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD2MWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgD2MWv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 08:22:51 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748CC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:51 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s63so1679289qke.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuRk8Jf6oZ6XhheTc3T6sd/5vPS38p5k5qkfJamfCaw=;
        b=jzQQk4oJ47nz0g/qI1VS/mnfnFtPYZVqUStLaLryaqV89PIHtYxk0lZPjD6HqVQd0y
         SpjwCvWYZjl9HSucw5WKZ4CmFz4zAqKOnM89q+EpLTz2EvODSDHCwRKebMtXf+ZGkzW0
         O8HRJGKrZzR1bUvlzMv7gKREkucPx3NrWLadPCCvCxItrzF8te2H2VJeYVoMMlFSl1sR
         22wJ6KNbqbNCSIhu5k1xUXA9PTzmLKeOCFkcuhxAIpDCeJOYZk1x00myWd8/ZY0zwWgm
         ufIGv6frzUJ93FWsjRYT0ssnrcHpjWQ4AX9lZ6pA2oyrUW1uUtuULdUG4s3QYOkcXFUE
         TpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuRk8Jf6oZ6XhheTc3T6sd/5vPS38p5k5qkfJamfCaw=;
        b=qstXemqFX2mv04r+V5Oc10cKY3hAgDPQWK1S2l+cElQMxD0o8N3IWFC31aEk0KFzVm
         OokiWEHy8yDmKAckhTCBeLZq7RCucz0jkQnPmh5ys3KTqJwpI8s92kTV31vSlgHceDvv
         0AaARhSw9DOeuwv5zosz/Xagp/v0/yYen5q56E/zVeD3W+CJ8X2CNemQxPVLnOhFewdS
         eVtebWRPMjIEse7Rdx8vSZbTVcnL0XiMNqr8WadD1amdqrj+UeGoG3r6pqW5mAZiLI/4
         PvQ2HBKLSSJ/oOrJLOKXHAAV5TGzJCriZLoRQqpaG7xAmks8A7OF/lWtsvuWBjFM6S1B
         cOOg==
X-Gm-Message-State: AGi0PubyEBUfGWrV7LwFCLCLyAr5jC4WRW+ARxrQ7US4FLhxsGjzrmzY
        e67tik79KTSjnptm2oDquPW97gng
X-Google-Smtp-Source: APiQypINNRiApHp6xtc88raZ88TwSiSaF+os+WFK3B6k+Scf3fXY7QiHCNVVWcZLU0+hWq6PkYQfhA==
X-Received: by 2002:a37:aca:: with SMTP id 193mr12174594qkk.442.1588162968830;
        Wed, 29 Apr 2020 05:22:48 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id t27sm15389383qkg.4.2020.04.29.05.22.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:22:48 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
Date:   Wed, 29 Apr 2020 08:22:22 -0400
Message-Id: <cover.1588162842.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the fifth part. It focuses on lib-submodule-update.sh and tests
that make use of it.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5].

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/

Denton Liu (4):
  lib-submodule-update: add space after function name
  lib-submodule-update: consolidate --recurse-submodules
  lib-submodule-update: prepend "git" to $command
  lib-submodule-update: pass OVERWRITING_FAIL

 t/lib-submodule-update.sh        | 47 ++++++++++++++++++++------------
 t/t1013-read-tree-submodule.sh   |  4 +--
 t/t2013-checkout-submodule.sh    |  4 +--
 t/t3426-rebase-submodule.sh      |  8 +++---
 t/t3512-cherry-pick-submodule.sh |  2 +-
 t/t3513-revert-submodule.sh      | 22 +++++++++------
 t/t3906-stash-submodule.sh       | 17 +++++++-----
 t/t4137-apply-submodule.sh       | 10 ++++---
 t/t4255-am-submodule.sh          | 10 ++++---
 t/t5572-pull-submodule.sh        | 16 +++++------
 t/t6041-bisect-submodule.sh      | 35 +++++++++++++-----------
 t/t7112-reset-submodule.sh       |  6 ++--
 t/t7613-merge-submodule.sh       |  8 +++---
 13 files changed, 108 insertions(+), 81 deletions(-)

-- 
2.26.2.548.gbb00c8a0a9

