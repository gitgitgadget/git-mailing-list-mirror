Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA657C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85434207E8
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3/bejLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGCDic (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDic (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:38:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C289BC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:38:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so30970026wru.6
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XWuhBgeCDVaOtqg8/q7gbYcRmH8isvfJSeTWdTDhFFM=;
        b=a3/bejLjD6VfkM+6jKQyoKw5etV+B2tu+kSzBo2HrhZRUSlJp1R890+UXmaPuf/iTi
         +ex+VvdDniBaO9F+EGi73uZ02i18s35Dop61j39jVNV2ZowB7okpaVXDBzxmHooKaUnJ
         Lz6xUsHGc/sIJ3fIYB/zsKVQv6qUoiEzi7od+wh8lc1kYMaXjU5NNhZyxvOMpxfb7v8c
         ngTPtEIH68iiool427/TGsXAeOZySayIdjolxiQRgt2W9G3o5k+uiRV6hHdNAFOwxRop
         JMh2HUX4kvpRd2I9L66awax9VBXyNiQsFdMPGtwMBPOWe5rnRLLa2aDE6pYpTMicSNGu
         QWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XWuhBgeCDVaOtqg8/q7gbYcRmH8isvfJSeTWdTDhFFM=;
        b=UzDuGaE9X9/95MUT8Nc/mOt7YL4OnZHc0/HOYmR/VzELvSfZS5uccnlAT64+yXuNu4
         yajPeJdyyi/6TNJmDmFhsXANrzm4nn8SIpgCYKiLVDUpUwpNdl8M+Pp6jvigkRFGcS47
         PTKsbL7eeYW132516exBs6V28Cnuq5wu1n70FQP00caDmJ/UA7C1mJlA8vIP0BBMRScv
         t6lZQe14or0QX2DpUfFP+NQIolZrkE3ksFPJFmhGDPPE/gTHeXF/zhdulRpxIMmlfK8E
         OfbwwapF/VIb3PQx/JRg8Tefyoz486QmcMd3lsla/J7MpCxdNPIvz2fk3tqNoXjWX1PY
         JpsQ==
X-Gm-Message-State: AOAM532ZIKuoEuGGgGPLoujKZDfYXxxD5e8LGlXzwIGqvMeflsxcQ7nw
        2dCP1RkZI8FGgUgzMsvs1hKRe/oG
X-Google-Smtp-Source: ABdhPJwDogWsfuQrOLj6NjB1+tqwM9E1FVFqow35fRjwZDRcByCFzBeyQaUw/ObL5AhwoyM2xs1LvA==
X-Received: by 2002:adf:f445:: with SMTP id f5mr35286004wrp.339.1593747510294;
        Thu, 02 Jul 2020 20:38:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm13068045wrd.58.2020.07.02.20.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 20:38:29 -0700 (PDT)
Message-Id: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 03:38:25 +0000
Subject: [PATCH v2 0/4] doc: include git rev-list description in git log doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series moves the nice explanation in the 'Description' section of the 
git rev-list man page to a separate file and includes this file in the git
log man page.

This goal is to make readers more aware that they can write e.g.

git log branch1 branch2 branch3 branch4 --not master

to see commits on each of branch1-4, that are not on master, since this is
not immediately obvious (at least to me) in the git log man page. 

Note that I made several commits for ease of reviewing, I'll squash some if
this would be preferred.

Changes since v1: took a completely different approach following the
comments received from Junio and Taylor.

Philippe Blain (4):
  git-log.txt: add links to 'rev-list' and 'diff' docs
  git-rev-list.txt: move description to separate file
  git-log.txt: include rev-list-description.txt
  rev-list-description.txt: fix Asciidoc syntax

 Documentation/git-log.txt              |  7 ++-
 Documentation/git-rev-list.txt         | 40 +----------------
 Documentation/rev-list-description.txt | 61 ++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/rev-list-description.txt


base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-590%2Fphil-blain%2Fdoc-log-multiple-ranges-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-590/phil-blain/doc-log-multiple-ranges-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/590

Range-diff vs v1:

 1:  16b8cdb55c ! 1:  59c48282a0 doc: log takes multiple revision ranges
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    doc: log takes multiple revision ranges
     +    git-log.txt: add links to 'rev-list' and 'diff' docs
      
     -    `git log` accepts multiple revision ranges, but makes no mention of that
     -    in its documentation. Currently readers have to go to the `git
     -    rev-list` documentation to discover this useful feature.
     -
     -    Mention it and adjust the synopsys in the doc and in the short
     -    help for `git log`.
     -
     -    Also add links to the documentation for `git rev-list` and `git diff`
     +    Add links to the documentation for `git rev-list` and `git diff`
          instead of simply mentioning them, to make it easier for readers to reach
          these documentation pages. Let's link to `git diff` as this is the
          porcelain command, and the rest of the family (`diff-index`, `diff-tree` and
     @@ Commit message
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Documentation/git-log.txt ##
     -@@ Documentation/git-log.txt: git-log - Show commit logs
     - SYNOPSIS
     - --------
     - [verse]
     --'git log' [<options>] [<revision range>] [[--] <path>...]
     -+'git log' [<options>] [<revision range>...] [[--] <path>...]
     - 
     - DESCRIPTION
     +@@ Documentation/git-log.txt: DESCRIPTION
       -----------
       Shows the commit logs.
       
     @@ Documentation/git-log.txt: git-log - Show commit logs
       each commit introduces are shown.
       
       
     -@@ Documentation/git-log.txt: include::line-range-format.txt[]
     - 	<revision range> is specified, it defaults to `HEAD` (i.e. the
     - 	whole history leading to the current commit).  `origin..HEAD`
     - 	specifies all the commits reachable from the current commit
     --	(i.e. `HEAD`), but not from `origin`. For a complete list of
     --	ways to spell <revision range>, see the 'Specifying Ranges'
     --	section of linkgit:gitrevisions[7].
     -+	(i.e. `HEAD`), but not from `origin`. You can give more than 
     -+	one revision range. For a complete list of ways to spell <revision range>,
     -+	see the 'Specifying Ranges' section of linkgit:gitrevisions[7]. 
     - 
     - [--] <path>...::
     - 	Show only commits that are enough to explain how the files
     -
     - ## builtin/log.c ##
     -@@ builtin/log.c: static const char *fmt_patch_subject_prefix = "PATCH";
     - static const char *fmt_pretty;
     - 
     - static const char * const builtin_log_usage[] = {
     --	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
     -+	N_("git log [<options>] [<revision-range>...] [[--] <path>...]"),
     - 	N_("git show [<options>] <object>..."),
     - 	NULL
     - };
 -:  ---------- > 2:  daf00d9398 git-rev-list.txt: move description to separate file
 -:  ---------- > 3:  eeaf4fe5dc git-log.txt: include rev-list-description.txt
 -:  ---------- > 4:  3b923780c1 rev-list-description.txt: fix Asciidoc syntax

-- 
gitgitgadget
