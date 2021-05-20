Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB73EC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9155A60FF0
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhETVsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhETVsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA21C06138B
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i9so26613143lfe.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eviGgcskDLooN5m6ONcVTZnyIS7T55MFuBNigtUpyOM=;
        b=DoXSDkkRrIt8Ychdyzt8q742+JIOhATtrqkvnna2kRaE3psnwI+uvsDDn0dIFxAi/J
         KodtXkOfPk3wG07ZA7BUtyfDzxjC23rigPLRmG8WAh+NBQKn3rxWDo4QKZDQ7e2tZrTb
         WJyVDnrLMLenEyt1h0kvIITV0D5RnGlMmwtacs1TU/ufaZofIH0wsaUUcAU/PS3jtFZ6
         CPAP5NhhUajFHH/coH3IWm7yljOpT3fV6/0XCj0sz7WnntSAYJFBPfYACIgfAyM3L0SU
         9XrhIfp/0EAzyS6w+NuTNgTtz0y+4n0tlcYERH/MR48nSf7CV2SsjbDLMM7LacdMC4dJ
         vb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eviGgcskDLooN5m6ONcVTZnyIS7T55MFuBNigtUpyOM=;
        b=c79ArCODXxFfaXlWmP51mvDUmZOblb1uZcd/kFZl8UFHY/CG+sgzIqt8KS7UhnUqje
         nCL18vxsUVql8fBFMPLRWOgF3eQ1wNC9lcLKnydMUPFyHuXoVjBdXwY5uwxEqvGplA9J
         U6ttLteZrizjE/mJNe96gm5jpjTkKtzXI3TJsx6ALGU/KyaoRvAsIWqI2HJ1HDpnBw4P
         u4uyqzhvYyqtBTfKcvEiImjeHMhr2oGlLID2OqKCCtJ0GUWqzgAYYlEWfh9s5JGU7kqp
         KN5/lqqQ55K3cFpihFWpWMlb1q/7mhZhRtvT6TGc1NLw2T/Hqg4kWIPimFt4aTEQsTh/
         xnNw==
X-Gm-Message-State: AOAM530i7I5w/j3JcSzwGg4ZEc6dAJDoNQfCY2gBLnoYjDzQseKT/QXL
        r547KDWN0ZhjaAcjd8NMuMS2/1IMAVs=
X-Google-Smtp-Source: ABdhPJy2ZBVuaAi0VAZlUdj+5tOeMLuMNpElV+rrluynn5aIZeONh3Sb7I6Il+XWgblocdWQnzE94A==
X-Received: by 2002:ac2:5289:: with SMTP id q9mr4418187lfm.141.1621547236393;
        Thu, 20 May 2021 14:47:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 00/10] diff-merges: let -m imply -p
Date:   Fri, 21 May 2021 00:46:53 +0300
Message-Id: <20210520214703.27323-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p, on
one side, and -m that did not imply -p, on the other side.

Only the last patch is the actual functional change. The rest of
patches are additional tests and refactorings that are not expected to
alter existing behaviors.

After these patches

  git log -m

produces diffs without need to provide -p as well, that improves both
consistency and usability. It gets even more useful if one sets
"log.diffMerges" configuration variable to "first-parent" to force -m
produce usual diff with respect to first parent only.

These series, however, don't change behavior when specific diff format
is explicitly provided on the command-line, so that commands like

  git log -m --raw
  git log -m --stat

are not affected, nor do they change commands where specific diff
format is active by default, such as:

  git diff-tree -m

It's also worth to be noticed that exact historical semantics of -m is
still provided by --diff-merges=separate.

Updates in v3:

  * Add test for "diff-tree -m" and mention it in descriptions

  * Fix one more typo in descriptions

Updates in v2:

  * Fix style and typos in descriptions

Updates in v1:

  * Stop parsing distinct diff-index options beforehand, as it could
    cause unexpected behaviors. Implement different strategy to avoid
    clash of diff-index "-m" and diff-merges "-m".

  * Added tests for "git log -m --raw" and "git log -m".

Sergey Organov (10):
  t4013: test that "-m" alone has no effect in "git log"
  t4013: test "git log -m --raw"
  t4013: test "git log -m --stat"
  t4013: test "git diff-tree -m"
  t4013: test "git diff-index -m"
  diff-merges: move specific diff-index "-m" handling to diff-index
  git-svn: stop passing "-m" to "git rev-list"
  stash list: stop passing "-m" to "git log"
  diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
  diff-merges: let "-m" imply "-p"

 Documentation/diff-options.txt    |  8 ++--
 builtin/diff-index.c              |  9 +++++
 builtin/stash.c                   |  2 +-
 diff-merges.c                     | 36 +++++++++--------
 diff-merges.h                     |  2 +
 perl/Git/SVN.pm                   |  2 +-
 revision.h                        |  2 +-
 t/t3903-stash.sh                  |  2 +-
 t/t4013-diff-various.sh           | 24 +++++++++++
 t/t4013/diff.diff-tree_-m_master  | 11 ++++++
 t/t4013/diff.log_-m_--raw_master  | 61 ++++++++++++++++++++++++++++
 t/t4013/diff.log_-m_--stat_master | 66 +++++++++++++++++++++++++++++++
 12 files changed, 200 insertions(+), 25 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_-m_master
 create mode 100644 t/t4013/diff.log_-m_--raw_master
 create mode 100644 t/t4013/diff.log_-m_--stat_master

Interdiff against v2:
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 15ca3c75bff7..7fadc985cccd 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -293,6 +293,7 @@ diff-tree --stat initial mode
 diff-tree --summary initial mode
 
 diff-tree master
+diff-tree -m master
 diff-tree -p master
 diff-tree -p -m master
 diff-tree -c master
diff --git a/t/t4013/diff.diff-tree_-m_master b/t/t4013/diff.diff-tree_-m_master
new file mode 100644
index 000000000000..6d0a2207fb30
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-m_master
@@ -0,0 +1,11 @@
+$ git diff-tree -m master
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+:040000 040000 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 0564e026437809817a64fff393079714b6dd4628 M	dir
+:100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+:040000 040000 f977ed46ae6873c1c30ab878e15a4accedc3618b 0564e026437809817a64fff393079714b6dd4628 M	dir
+:100644 100644 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
+:000000 100644 0000000000000000000000000000000000000000 b1e67221afe8461efd244b487afca22d46b95eb8 A	file1
+:100644 000000 01e79c32a8c99c557f0757da7cb6d65b3414466d 0000000000000000000000000000000000000000 D	file2
+:100644 000000 7289e35bff32727c08dda207511bec138fdb9ea5 0000000000000000000000000000000000000000 D	file3
+$
-- 
2.25.1

