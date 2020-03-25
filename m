Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199BC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7243920714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCl87UJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgCYFzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:14 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40230 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:14 -0400
Received: by mail-qt1-f182.google.com with SMTP id c9so1275495qtw.7
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rafjBEHpJ9I3fIYFr9sPJnG9Zt/0mJdUxvHSscPEDao=;
        b=SCl87UJNPKwGmP3Q2y9VsLCSfe84vbIi6yNbhV6qERsM6TPEmawtUnQCoUkt7QFehE
         OUHh67M8LlSdGgfCV8cEByxm73zCnvJuy9fBLwGybMf0aT9KxBbJKE42Jf+V3Y/uiCFV
         KwW4Gc13X1rDhIpkxXxrwRay+tUc33/lBy6RfWz6pGghRcxQZKcMY4sjjs42hPFkNuA6
         upjzQarsW+AyxXYcwcoB0xYYEpAgtpnqeOacqKLdJ1R6ov3tJUdP3J//7Qlc372VSeom
         8M+cOSV6Z5UCR5EcJMhdvebq41B06sljZuKvi3B0sAdkVhaFE9PUoRIRv1RN0QEnKK++
         QgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rafjBEHpJ9I3fIYFr9sPJnG9Zt/0mJdUxvHSscPEDao=;
        b=m5A9KyuzTiikSC3WHbljKTrC4vR0LCeJ3u0Qyrtw91a5oiiutIpKF85RrR3YesA/PO
         4K8j5iBPcWc2E5Xbxon9JA3mdMxUK5fVZPC/oyuylA7hx76uLQUKdD5PSh2pbrppAb9J
         Q1Ri6hbsCikx+i39tmVa10vuBdr8pvZpmAjBU4dKLOUy83thwuOw5QFGUZmcYOiBw61w
         gvS0uBbGIZoGoeJFgKHKQT/Y+oYukk5NTpqgLY3gPi6ZoGz93Cx5q6sER4Pu6bFHVjN5
         qQkPqYOQ6eDmmavyyX1T6uSoIPcrXuIOTTT5R2D3yZePE61SN1RTadftVk9gz73GLBda
         pCMg==
X-Gm-Message-State: ANhLgQ3iF9uCD2wz2IbIHeaolqQWtv4llW06RPS403cEePhPjHfijE/q
        wX3tncrpKi5RlxVMEDkSVz95nfd3
X-Google-Smtp-Source: ADFU+vvFkAshUcesv9RZETlUCJI5lrChnR+OKz8SZr4ccZOzdAKIg3BpQGaBBWkrwrpi4z+GLUfPzw==
X-Received: by 2002:ac8:2f17:: with SMTP id j23mr1146214qta.249.1585115712733;
        Tue, 24 Mar 2020 22:55:12 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:11 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/8] t: replace incorrect test_must_fail usage (part 3)
Date:   Wed, 25 Mar 2020 01:54:47 -0400
Message-Id: <cover.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
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

This is the third part. It focuses on t5*.sh.

The first part can be found here[2]. The second part can be found here[3].

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/

Denton Liu (8):
  t5512: don't use `test_must_fail test_cmp`
  t5512: generate references with generate_references()
  t5512: stop losing return codes of git commands
  t5550: remove use of `test_might_fail grep`
  t5607: reorder `nongit test_must_fail`
  t5612: don't use `test_must_fail test_cmp`
  t5612: stop losing return codes of git commands
  t5801: teach compare_refs() to accept !

 t/t5512-ls-remote.sh       | 66 +++++++++++++++++---------------------
 t/t5550-http-fetch-dumb.sh |  2 +-
 t/t5607-clone-bundle.sh    |  2 +-
 t/t5612-clone-refspec.sh   | 26 +++++++--------
 t/t5801-remote-helpers.sh  | 10 ++++--
 5 files changed, 52 insertions(+), 54 deletions(-)

-- 
2.25.0.114.g5b0ca878e0

