Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ADAC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942052073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+zR3upx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgF3PDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3PDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:30 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95214C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:30 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id u8so9386615qvj.12
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NAvF2KoUC5dFzRdGkGXNs3gP04eV4gZOIRVOSGf6ypM=;
        b=m+zR3upxn+Do+Zx49mXFiGUyK6wR2NJkz9+G4g+F7s/mlOqMRykpX0YdIwI5pL4o0i
         V/cesfh7OOoRc+1tbpDg36CCJHmLHyc0WCqSgTlY/HIpZaf3DcNzlsMp+LenShcS//DC
         FiICDwzvpBfTXmrldUbNH10z3K44hmtU1QtkEN4uCt7Y66qtxEfFTRP19jxGsUNPpNzP
         SUEj1yicuLB2tvLEdVWKQNZeCb90i4F4Fu9tLHNlLkIzgeOSuiKcibD7/8SoQOA1SceY
         1+ZdtHaXqP9k8gDHVJRUL4pknVTHg71YauPCxei2i4uQkyEpzaG6aANvULsG9my70U6E
         jCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NAvF2KoUC5dFzRdGkGXNs3gP04eV4gZOIRVOSGf6ypM=;
        b=fEIhAXXO7NY7d2PWx9AM1VpYFW1MKRY9d3KtW8YBNm013WslS5KNmP4KRwsX78UP96
         Hk4q8j5tulbdF10cjoVMD3KMUxw9IIW9eDrJxlRXrLur2EOMOlUfzSWf3hWZWex9NPUN
         BaQp9dRz0Qp55jP8HdFbY7yXwChRhwVDusTEu8e6pWOTJuK2lpeQ5Sktl2OMltGOLExq
         cec13Ec9mUmcqSbfYBbaBzCzYB/ZI6iKoxnokuSz/4QF59+NPM3FoEHEiHYef03RIIXK
         LFSWgFjA4ElKQkY6UC6lsL601+EvNp3wNnWH5Stfd3CTdRJwSdQMpvVFvJTpSZoHLTcC
         ceuA==
X-Gm-Message-State: AOAM533RXVe5YZfLerhshGc4K1lTsnYrYaMw6M+CJGaW1QAHlFcVUf6T
        Ps9OopOG7qn5ty/PdnAxcE8X5OFZs2Y=
X-Google-Smtp-Source: ABdhPJxHLjJHk7yTX1980uFlLSbtte6vXD2IR06kYLSGAEwFgqM2g23rpKC6jqepXvxeWqRscWQpYA==
X-Received: by 2002:a0c:e78b:: with SMTP id x11mr15409604qvn.103.1593529408459;
        Tue, 30 Jun 2020 08:03:28 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p66sm3209626qkf.58.2020.06.30.08.03.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:03:27 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/5] t: replace incorrect test_must_fail usage (part 6)
Date:   Tue, 30 Jun 2020 11:03:14 -0400
Message-Id: <cover.1593529394.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
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

This is the sixth and final(!) part. It cleans up instances of
`test_must_fail` that were introduced since the effort began. In
addition, it finally flips the switch and makes test_must_fail only
allow a whitelist of commands.

This series is based on the merge of 'master' and
'dl/test-must-fail-fixes-5'. In addition, this series was tested by
merging with 'seen~1' (to ignore the reftable failures) to ensure no
in-flight topics will require more changes.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5]. The fifth part can be found here[6].

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/
[6]: https://lore.kernel.org/git/cover.1588162842.git.liu.denton@gmail.com/

Denton Liu (5):
  t3701: stop using `env` in force_color()
  t5324: reorder `run_with_limited_open_files test_might_fail`
  t7107: don't use test_must_fail()
  t9834: remove use of `test_might_fail p4`
  test-lib-functions: restrict test_must_fail usage

 t/t0000-basic.sh               | 18 ++++++++++++++++
 t/t3701-add-interactive.sh     | 10 +++++++--
 t/t5324-split-commit-graph.sh  |  2 +-
 t/t7107-reset-pathspec-file.sh |  9 ++++++--
 t/t9834-git-p4-file-dir-bug.sh |  2 +-
 t/test-lib-functions.sh        | 39 ++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 6 deletions(-)

-- 
2.27.0.383.g050319c2ae

