Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C5C2D0DA
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B973721582
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llyU+p5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfL0Nrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:36 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:45750 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfL0Nrg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:36 -0500
Received: by mail-qk1-f180.google.com with SMTP id x1so21498039qkl.12
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYwFsxYoc8LlDKzxpVZrPhsHDf38LRMvMJTY/pGUsos=;
        b=llyU+p5YBB++F/8T2KIfcgpCAVDWrxgu2wxMJc2HBarkEqDxb0eRxyBDQ5o4BsYlF7
         tH6gM0/mGfFvs+RsstlMKSx5ijJL5n/HUeXnveoKGsSQnzKY9INH7VL9sy50ZIbGEINz
         Le/OtdZ5yECM6tp6ImzPin8KDVMc3Ci8Qp/3Cx7waKwoQFpxTIXLc8/yEChilmGUXnVR
         aKj05QVlNOGCKS/ZIGWqdj5zEpslGxM9NRvHDiF3lW6YqEwYZ4766hhnmkuYlQ6cxK3A
         llTr9XuCtHSz+a50BkWLrhOj3pqVIOnxdSp6uwH81VMrzki+jcZFlPMTSqNL0KoZdPWR
         cdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYwFsxYoc8LlDKzxpVZrPhsHDf38LRMvMJTY/pGUsos=;
        b=Im9OMgBUm/Wq6MnB44bQZRqGc5gWcLL8es8BokMEBFrElbBi0668w+AdVqzx8SxX4o
         XArouVK06vc0zphGOkDkD80jsCEEB/igS/zw9QEiVCQJH9F8j88kZFHjyC+OV1Tpsygd
         kSF0jgtCCY/e46yTmzR0S3XFJb89hqHDpcANBcxXWLhT1SX/K2rBHK8aKJXMerTPkWn9
         lKDHY5A3Tpl2ob2AzXILIJp2wHVuCLLWLYZzidE+WkuYAfDnNWV2Dw5oLWwhmEO+T6sh
         X0RA7NnzU5LZNQ5eIONBCIDwAsh9CkqEpx25iV0ygf+8yRAsbqQzEBFt7rWhM9ITAik+
         xeqg==
X-Gm-Message-State: APjAAAUsjR2y01Z2lLOzvqNXe0dEjby86xTI3He4eftXf1QxPeUKiQgx
        ODzHsnL+f3DJPXyrNAqC8eFKZCwg
X-Google-Smtp-Source: APXvYqyzv6GW8QF/9GNvOOP2HJXSH5c3cLpYV7C1u5uySDzOOX1R0Mpt7qLcixy+9GlP1jmqQEjbLQ==
X-Received: by 2002:ae9:dc82:: with SMTP id q124mr43728063qkf.20.1577454455378;
        Fri, 27 Dec 2019 05:47:35 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:34 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 00/16] t: replace incorrect test_must_fail usage (part 2)
Date:   Fri, 27 Dec 2019 08:47:09 -0500
Message-Id: <cover.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
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

This is the second part. It focuses on t[234]*.sh. The first part can be
found here[2].

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/

Denton Liu (16):
  t2018: remove trailing space from test description
  t2018: add space between function name and ()
  t2018: use test_must_fail for failing git commands
  t2018: teach do_checkout() to accept `!` arg
  t2018: don't lose return code of git commands
  t2018: replace "sha" with "oid"
  t3030: use test_path_is_missing()
  t3310: extract common no_notes_merge_left()
  t3415: stop losing return codes of git commands
  t3415: increase granularity of test_auto_{fixup,squash}()
  t3419: stop losing return code of git command
  t3504: don't use `test_must_fail test_cmp`
  t3507: fix indentation
  t3507: use test_path_is_missing()
  t4124: only mark git command with test_must_fail
  t4124: let sed open its own files

 t/t2018-checkout-branch.sh            |  71 ++++++++----
 t/t3030-merge-recursive.sh            |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |  21 ++--
 t/t3415-rebase-autosquash.sh          | 153 +++++++++++++++++++-------
 t/t3419-rebase-patch-id.sh            |   3 +-
 t/t3504-cherry-pick-rerere.sh         |   2 +-
 t/t3507-cherry-pick-conflict.sh       |  28 ++---
 t/t4124-apply-ws-rule.sh              |  12 +-
 8 files changed, 198 insertions(+), 94 deletions(-)

-- 
2.24.1.810.g65a2f617f4

