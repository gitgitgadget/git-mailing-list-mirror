Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14541C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96F024673
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTMvvCaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLPVb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44192 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLPVb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so6313669pfd.11
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 13:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+/V58a9AfMl2QGNsnsU2EmU1XkCKZjEr8X0LNUACVA=;
        b=HTMvvCaZp5dwqfiCKIIfL2apkJtX7+T4XGjxUZuAh/QOK2SSL3tqHYu+vb7CpVjCEQ
         2y10zYm8yUq5aJChm7NuBeeqaPhdE/w9DWS1yBdoNsFjTOdXP6+7RGE6LHadBYEQ6V4f
         g4QGnUBbxI7rPkw+mRLQFIx/47IV6k8wgTFq7RT30BARrINTyqy4Iy01WMml3Ki690DV
         kh3Yh+UpSAAMXpQslYdS/bee9wQ+yp4g7tMdrPEOhY43Rq2V6VSENeAhoITazd5Zy1Z/
         snA76YLnqS6AC6/hELB7Oa0BkvRKAexKEHktTq0J+nZ+pu476zjMbBtyFaPZ1lx8Wa/n
         B+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+/V58a9AfMl2QGNsnsU2EmU1XkCKZjEr8X0LNUACVA=;
        b=n5Wq8W5fG8N+dm5MqczTg6vrnCCWW/dTHan9MuM/o/L/sNAGlVgyv8SPa6nuqCDN4D
         PcZPjCFFVzm89C5u5yYzkuk0JO86O4mYzlqi/xMJ6N8OoRyxfORB2rb/vjYRVy/lZcVB
         1KtbExw0m8wlDMjWG4NeCViXjIDFX6d2tZelo3oj8KXlueW8Dob6TmRS6SX2KhCWvtt1
         +0Vo2xYbzowvpeww3GrWCj1CMBGzu+PdjXUY3ndF5qdO7m3GZlUgNuL6UwRvbuGHoLQN
         IGCGuOpFAERC1XLp2iVPbEsxuZbYHPivLUs/V6MVZI+2Y0RbHl83v2dUs8AfXk6rjgP7
         MDrA==
X-Gm-Message-State: APjAAAVzoIYf3maZkBZ9o0agEW/f3SRFsd40u/KpB234Z8/pYCCfWYfR
        3wqTwpN8JRTFdgLJbqxAsL2KLvTL
X-Google-Smtp-Source: APXvYqzBoDnovxEzUzdcIUywgWVcI1e5A7Z4z0jbepIHxYQFVaHdap4LAxeDYzlD6Yzk9OXLaOy1tQ==
X-Received: by 2002:a62:3043:: with SMTP id w64mr18526090pfw.227.1576531916717;
        Mon, 16 Dec 2019 13:31:56 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id q6sm23951063pfl.140.2019.12.16.13.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 13:31:55 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 0/2] contrib/credential/netrc: Makefile + script cleanup
Date:   Mon, 16 Dec 2019 13:32:32 -0800
Message-Id: <cover.1576531851.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.664.g198078bb5a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently switched my workflow to use this credential helper and I
noticed a couple of problems:

1. The interpreter path was hardcoded to #!/usr/bin/perl

2. The script refuses to run outside of a Git repository

This patch series should fix these problems.

Denton Liu (2):
  contrib/credential/netrc: make PERL_PATH configurable
  contrib/credential/netrc: work outside a repo

 contrib/credential/netrc/.gitignore           |  1 +
 contrib/credential/netrc/Makefile             | 26 +++++++++++++++++--
 ...ential-netrc => git-credential-netrc.perl} |  2 +-
 3 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 contrib/credential/netrc/.gitignore
 rename contrib/credential/netrc/{git-credential-netrc => git-credential-netrc.perl} (99%)

-- 
2.24.1.664.g198078bb5a

