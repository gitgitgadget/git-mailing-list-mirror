Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56422C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360D6206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJNhGBFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgEEHSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 03:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgEEHSP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 03:18:15 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40183C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 00:18:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i68so1177542qtb.5
        for <git@vger.kernel.org>; Tue, 05 May 2020 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+zvnvL3R2GprOn4RFla+LkynCM5Qyl8w+YcPLIepoU=;
        b=SJNhGBFhxDYck/ALcMEjJROjnCgDBGWK6ZmtItxB7DVkI+fd25aeYc9T2hm8vf+Rfx
         89XsD7cxd/TTRoZg5TjBoFdLQxtSjYGdW4uzeaepskVzD1iYaKirU7JjGj6DexEnwkc2
         CFynLgkGyl/7UpNudMQI09rVtY7kXn6Gnm13vMxIsUszmLSqNofM6yucA0Z0vuPdN3D7
         nnb7rVO87fntI0zco4U/Mo2gqfgLO1PgjzCt3ImryQbJbtjSPHq2gvZUbMgSdxbIjE6U
         v/wa12YmbJoElL+9mblEdwy8PkhAzS5tOJWaf/CY1UUs2UdbCnllKrTcDORss89mF3d7
         iFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=n+zvnvL3R2GprOn4RFla+LkynCM5Qyl8w+YcPLIepoU=;
        b=e221OXtGg2l2a/s4btcD4p80b1DAMGg8LjoBS9jWaSio2KvKWGGmUi8bNPWg7xw77N
         h/ekvV5GP+UgHfawH9M2g001b4zljZWFVNIwer3YIU1Y+MkdAEdIXUwEvZkxPbPuCoWG
         myliMPjiibOXDNL8omUks3j1JJBt3Z1ouKb8gR6L5EgQajYIYp5/oCY7pnoaC78EIA4D
         oruPmMieyxS7IRQxvitSSceQnqkGOxF6PYLoy/r5HUl85d1htYmolvYxMFgCQKsrTQzI
         0el0U0ofjTq03H1m00c+G/bMKZFrSIh2o7VWJ53XdTWs3HO0RYq3c1g10I3zEey0Cwxv
         Vo9w==
X-Gm-Message-State: AGi0PuaQblnJmFWQ8bkrcC5ZveUTlLFOP/aokOBLuBFfOtVXJdDAObAR
        i6H0yFwEuQkR9u7YqCOgdbcNxqcM
X-Google-Smtp-Source: APiQypKPkY971jCR8JYY9Cq/BWvFOoJpJ5xo4THlH5cUEwojDLC0RbVRl6dn+aFqdUGZRAagNAqHJw==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr1106692qtq.331.1588663093755;
        Tue, 05 May 2020 00:18:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r51sm1019307qtk.89.2020.05.05.00.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 00:18:12 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Harri=20Meht=C3=A4l=C3=A4?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/1] enhance "git restore --worktree --staged" behavior
Date:   Tue,  5 May 2020 03:17:15 -0400
Message-Id: <20200505071716.23240-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which enhances git-restore to default --source
to HEAD when --worktree and --staged are combined.

Changes since v1:

* tighten the commit message and documentation changes as requested by
  Junio[2]

* drop patch 1/2 since 2/2 threw away all the changes from 1/2, and the
  end result is the same with or without 1/2

Although the code is identical between v1 and v2, I didn't include
Taylor's "Reviewed-by:"[3,4] since the documentation changes have been
refined a bit.

[1]: https://lore.kernel.org/git/20200501082746.23943-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/xmqqimhfoelf.fsf@gitster.c.googlers.com/
[3]: https://lore.kernel.org/git/20200501221613.GC41612@syl.local/
[4]: https://lore.kernel.org/git/20200501221951.GD41612@syl.local/

Eric Sunshine (1):
  restore: default to HEAD when combining --staged and --worktree

 Documentation/git-restore.txt | 11 ++++-------
 builtin/checkout.c            |  6 +++---
 t/t2070-restore.sh            | 11 +++++++++++
 3 files changed, 18 insertions(+), 10 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5b61812e17..84c6c40010 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -22,10 +22,8 @@ The command can also be used to restore the content in the index with
 `--staged`, or restore both the working tree and the index with
 `--staged --worktree`.
 
-By default, the restore source for `--worktree` is the index, and the
-restore source for `--staged` is `HEAD`. When combining `--worktree` and
-`--staged`, the restore source is `HEAD`. `--source` can be used to specify
-a different commit as the restore source.
+By default, if `--staged` is given, the contents are restored from `HEAD`,
+otherwise from the index. Use `--source` to restore from a different commit.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
@@ -40,10 +38,8 @@ OPTIONS
 	tree. It is common to specify the source tree by naming a
 	commit, branch or tag associated with it.
 +
-If not specified, the default restore source for `--worktree` is
-the index, and the default restore source for `--staged` is
-`HEAD`. When both `--staged` and `--worktree` are specified,
-the default restore source is `HEAD`.
+If not specified, the contents are restored from `HEAD` if `--staged` is
+given, otherwise from the index.
 
 -p::
 --patch::
-- 
2.26.2.672.g232c24e857

