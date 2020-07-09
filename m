Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEFCC433E5
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BBE206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtp6p4qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGICRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgGICQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560AFC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a6so5174924wmm.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8/0cFyyOXa+IpXhIbJl3HbfduKhU75mE7N/JEs64XQo=;
        b=Jtp6p4qWdVUVmoxKlFOfKSlOgzQ/XTEC8gBIAcxdhJLQvQdDFv3VuesqljdMwwB8vY
         Vz06NHVLlaoIr0e62POM/aXjfMLX8swa0IbSG6VDF7p2w/Vy8kDbp5SDF8xB+UFvYDMZ
         42PKN1xZdAzZf1HFH2QO3TzN+Rz6MiEyM4U6URaWk8Kf918n53Bhi/lprg2hzSnBb5iU
         p9NZ9+6MHmG8S3NQrHsTLKdTYkEoF3fMKnjubo79//oN1vvZgMjGT29YahGpUf7GcpNY
         GhNmjV+L5zhfoUuIVrUR3DYqDqKZeRjppqucglNpVMUTHwwRtAe7ugAti8pAJ2I/Lk2C
         8SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8/0cFyyOXa+IpXhIbJl3HbfduKhU75mE7N/JEs64XQo=;
        b=QoZZd0Bkw18IQSYxxddORbbkbbppmTI47tp8AjGBBf1qWCY5P9WRH1LQQYHpsfRQd7
         /4tqd6wKEskqNaLGpFHIkTnT6yCGTC5xZdSZzgH5X0bYyZgiZ6Ex2YMubn6Rj2xLTLCS
         EXWOaMcoNYelJ1drK5wfdmAOH1yWL6DzX+Um7Hf++jb66glyx6gueLd8cmMstp2H2uXX
         7CbqFPzJ/s10i4mAfGebLp+prhMayMAPqHlqAzZdn7Zw/fazbtQwVpda4dEolXZlhzdC
         RHPRDsgQ2bDxZNglq0Mtno1sJ+ltafZQ9kHGaULUFj2V1xWqvERLhEfWBDljSAAM9nwu
         +abQ==
X-Gm-Message-State: AOAM533Fl+Lia+eDT+da/7MycNXxdr1QPA4nuTuel6bKXUQT2l6K6hrp
        whzOHLuM0a6c+KP9jPuVGFV3ZO13
X-Google-Smtp-Source: ABdhPJw1yPJx+/c2uHGCOuwbVGqPFFwgHsZGm15XHFfW7pSJND9Qo+PRhzW9rbrZoyDKNegOP03Nbg==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr11396490wma.129.1594261013710;
        Wed, 08 Jul 2020 19:16:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r28sm3028116wrr.20.2020.07.08.19.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:53 -0700 (PDT)
Message-Id: <f61bbb57cbcd52144e81f093cf7c4c80249397f2.1594261008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:47 +0000
Subject: [PATCH v3 5/6] git-rev-list.txt: move description to separate file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A following commit will reuse the description of the `git rev-list`
command in the `git log` manpage.

Move this description to a separate file.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-rev-list.txt         | 39 +-------------------------
 Documentation/rev-list-description.txt | 38 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/rev-list-description.txt

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index f2b83df2fa..b06e11ae56 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -14,44 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-List commits that are reachable by following the `parent` links from the
-given commit(s), but exclude commits that are reachable from the one(s)
-given with a '{caret}' in front of them.  The output is given in reverse
-chronological order by default.
-
-You can think of this as a set operation. Commits reachable from any of
-the commits given on the command line form a set, and then commits reachable
-from any of the ones given with '{caret}' in front are subtracted from that
-set.  The remaining commits are what comes out in the command's output.
-Various other options and paths parameters can be used to further limit the
-result.
-
-Thus, the following command:
-
------------------------------------------------------------------------
-$ git rev-list foo bar ^baz
------------------------------------------------------------------------
-
-means "list all the commits which are reachable from 'foo' or 'bar', but
-not from 'baz'".
-
-A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "^'<commit1>' '<commit2>'". For example, either of
-the following may be used interchangeably:
-
------------------------------------------------------------------------
-$ git rev-list origin..HEAD
-$ git rev-list HEAD ^origin
------------------------------------------------------------------------
-
-Another special notation is "'<commit1>'...'<commit2>'" which is useful
-for merges.  The resulting set of commits is the symmetric difference
-between the two operands.  The following two commands are equivalent:
-
------------------------------------------------------------------------
-$ git rev-list A B --not $(git merge-base --all A B)
-$ git rev-list A...B
------------------------------------------------------------------------
+include::rev-list-description.txt[]
 
 'rev-list' is a very essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
diff --git a/Documentation/rev-list-description.txt b/Documentation/rev-list-description.txt
new file mode 100644
index 0000000000..14d78b91aa
--- /dev/null
+++ b/Documentation/rev-list-description.txt
@@ -0,0 +1,38 @@
+List commits that are reachable by following the `parent` links from the
+given commit(s), but exclude commits that are reachable from the one(s)
+given with a '{caret}' in front of them.  The output is given in reverse
+chronological order by default.
+
+You can think of this as a set operation. Commits reachable from any of
+the commits given on the command line form a set, and then commits reachable
+from any of the ones given with '{caret}' in front are subtracted from that
+set.  The remaining commits are what comes out in the command's output.
+Various other options and paths parameters can be used to further limit the
+result.
+
+Thus, the following command:
+
+-----------------------------------------------------------------------
+$ git rev-list foo bar ^baz
+-----------------------------------------------------------------------
+
+means "list all the commits which are reachable from 'foo' or 'bar', but
+not from 'baz'".
+
+A special notation "'<commit1>'..'<commit2>'" can be used as a
+short-hand for "^'<commit1>' '<commit2>'". For example, either of
+the following may be used interchangeably:
+
+-----------------------------------------------------------------------
+$ git rev-list origin..HEAD
+$ git rev-list HEAD ^origin
+-----------------------------------------------------------------------
+
+Another special notation is "'<commit1>'...'<commit2>'" which is useful
+for merges.  The resulting set of commits is the symmetric difference
+between the two operands.  The following two commands are equivalent:
+
+-----------------------------------------------------------------------
+$ git rev-list A B --not $(git merge-base --all A B)
+$ git rev-list A...B
+-----------------------------------------------------------------------
-- 
gitgitgadget

