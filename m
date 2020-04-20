Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B3C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919A820A8B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9S67Zev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTIyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbgDTIyz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:54:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF7C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so2320178qvw.5
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5e2MFzK4i7pUZIs33foe5Cj4OLlkabGDwxdX4pV0Ykg=;
        b=C9S67Zevm3e/j1buSxloevdpfq9VsLEJHUZ97Tdda0cZvgG63AdVGqeUjRuCzzrDz5
         QrF1YmNAw8hFgy1D/OKOpGRvORaznWdfMLGSG8qMCoUwo8hReHOiYua8CCzdzT6J7cmL
         ux9tFmewRYOKHNdE722nmUG1GFjGQvHcWvepfzgpqoNDJ5QAox0ti4JkUJKqBsBrlzag
         ym1UO9MHNDyF96NAFcq3J3gaZ6AUrfVb4OPh7P9IrPa4VX3hNAtPev2VinhbiJ9pPqu0
         81+182w6j3Rv4NcAhGfEAh4HgnLKLrDjpd9jV/qCOdsKEEjgoBjNQrybhK0I6yD98vaq
         DDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5e2MFzK4i7pUZIs33foe5Cj4OLlkabGDwxdX4pV0Ykg=;
        b=e7jMmJztDGUiW4Hx0jwEPzmW55vNon8Ati3eISmgwvvuYtVieUAfpnnargYPwzACD4
         P32BCR/TeowU32d/SW/i5qz+60QtTt7wf5p/pkDJg71jEj82l2R4jsz7ILZtQWTxZ10y
         A+74wy3Mg+w3icezGMp5MiDguTBPDo+Ke98pgtF79i5O560XLR696+Eh09RX5+4jpgc8
         Vb5xbfZtxEvWRSCyN5qfs/dNK3hZngGoKDHrNW5Dhn0bXHcEIzX862n93wzVgQwzr5MU
         tlfXMuDDOHg3tjVsuRb28qX3KLNzSFwgWBRklelQNt8Kaysb5V4DeJRsTXWHGZshuCRF
         IdmQ==
X-Gm-Message-State: AGi0PuYgLTgeLCkQaHilUPsWHiD2qjpr0IpgyTJ4ZYG/DQKgcJgjc2Od
        1mggBPfm6zDLqzfYjOwbkPT9zsTN
X-Google-Smtp-Source: APiQypK/4vHoOPjZ/UoM7M2+6lUydvPCnrgRRWlEvfZx6Rx/ongC+6+fjTauv26h22CPsm1oCL95cQ==
X-Received: by 2002:a0c:8bc2:: with SMTP id a2mr13747457qvc.246.1587372894088;
        Mon, 20 Apr 2020 01:54:54 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:53 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/8] t: replace incorrect test_must_fail usage (part 4)
Date:   Mon, 20 Apr 2020 04:54:38 -0400
Message-Id: <cover.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
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

This is the fourth part. It focuses on t[6-9]*.sh.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4].

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/

Denton Liu (8):
  t6030: use test_path_is_missing()
  t7408: replace incorrect uses of test_must_fail
  t7508: don't use `test_must_fail test_cmp`
  t9141: use test_path_is_missing()
  t9160: use test_path_is_missing()
  t9164: don't use `test_must_fail test_cmp`
  t9819: don't use test_must_fail with p4
  t9902: don't use `test_must_fail __git_*`

 t/t6030-bisect-porcelain.sh            |  8 ++++----
 t/t7408-submodule-reference.sh         |  8 ++++----
 t/t7508-status.sh                      |  2 +-
 t/t9141-git-svn-multiple-branches.sh   |  8 ++++----
 t/t9160-git-svn-preserve-empty-dirs.sh |  4 ++--
 t/t9164-git-svn-dcommit-concurrent.sh  |  4 ++--
 t/t9819-git-p4-case-folding.sh         |  2 +-
 t/t9902-completion.sh                  | 12 ++++++------
 8 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.26.0.159.g23e2136ad0

