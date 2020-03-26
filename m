Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC0AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C50206F8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXoVpgta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgCZHfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:35:44 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46443 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCZHfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 03:35:44 -0400
Received: by mail-pg1-f169.google.com with SMTP id k191so2439468pgc.13
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvE2HPZVpASQMIdzbWpzF12SipbTzi6dvho2og/sTnE=;
        b=FXoVpgtaMrjhvEuLvQbaxirJvJiosRkkSKcCN0SAxv/KQtmHy+7ei79U4b9w7zOKel
         PoAU7f8Qs6c+X94NDJvMzxV6MZHJx4UwgXhVup69UkLFUmL2lmTdLtONk0IEYyVpDKBY
         8UcOlgOFU9vHGIV5hFIq0W7G8OrWFaaCBgokrsz24du1HAW19sYyYk5QqrHSjV0G6azX
         8i6dDcMJQOXGDxgHNWxXrAnuVGkBDiNuVY9wZgvLBw9USRAKyxL4h+zqd4LDt+4usG7Q
         qjtbXtG9GS8p2i8UfLIMOOU+ce7TOEsiJe2ruUeT0JeTVsM8u1wxZouRMgNXYimxeh2w
         Ze/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvE2HPZVpASQMIdzbWpzF12SipbTzi6dvho2og/sTnE=;
        b=iXAImSi7HbECsMwZxiuGtIYbwsSx8MIWZed5jdt57O8VUcX4jgpM7nYihN7dpMW5kO
         1UjYEOqX0IYhdRIdwQIKhN24XNJBmUQMIS/nId8cjmfTdiAdJ0zPMkqrUa02++uE8AFI
         06rCTdeXDxBjVeICkJIOXxgBvTgiCyIqsNI1DN9uVVQdE/TnNELSZUPgqKlxBKhgW/RO
         Z48B98JXEl/zbLBxl/bSqsz89WPi/4SnAzLA/k2/cBEeuH8YAn4gx3Cs3VW2Q7m2LBMS
         5GyDl9ZNlfQ01rShAJgfIkrFMfBqynXI7NUvDXjzgcUZXZnKQrG/am5rrTrzNCwGte9u
         tRKA==
X-Gm-Message-State: ANhLgQ3svFL1AFBkbvK9mzJsVPlSdKd5lnacinV+LhZ3UE/qXtNHRLwM
        DtYUxnBjEdrubJs6bi8RQ4WCXqH2
X-Google-Smtp-Source: ADFU+vv53Xs9a0iI3r1jiiff0qOqCbpWNHLRLn5GL9lOeP2ikwwTGuVGWAIf3CBvtLRM6Pw4lsvISg==
X-Received: by 2002:a63:5011:: with SMTP id e17mr7132830pgb.338.1585208142703;
        Thu, 26 Mar 2020 00:35:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id d188sm968049pfa.7.2020.03.26.00.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 00:35:42 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/3] add travis job for linux with musl libc
Date:   Thu, 26 Mar 2020 14:35:16 +0700
Message-Id: <cover.1585203294.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently, we've un-broken git for Linux with musl libc,
and we have a serie to fix false negative with busybox shell utils.

There is a sample travis build for this serie applied on top of master:
https://travis-ci.org/github/sgn/git/builds/667111988

And, after merging with my v4 to fix busybox false negative:
https://travis-ci.org/github/sgn/git/builds/667112197


Đoàn Trần Công Danh (3):
  ci: libify logic for usage and checking CI_USER
  ci: refactor docker runner script
  travis: build and test on Linux with musl libc and busybox

 .travis.yml                                 | 10 +++++-
 azure-pipelines.yml                         |  4 +--
 ci/lib-docker.sh                            | 37 +++++++++++++++++++++
 ci/run-alpine-build.sh                      | 31 +++++++++++++++++
 ci/{run-linux32-docker.sh => run-docker.sh} | 20 +++++++----
 ci/run-linux32-build.sh                     | 35 +------------------
 6 files changed, 94 insertions(+), 43 deletions(-)
 create mode 100644 ci/lib-docker.sh
 create mode 100755 ci/run-alpine-build.sh
 rename ci/{run-linux32-docker.sh => run-docker.sh} (46%)

-- 
2.26.0.rc2.357.g1e1ba0441d

