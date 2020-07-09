Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EFAC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDFF206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDwrvoql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGICQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGICQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21DC08C5C1
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l17so281465wmj.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j/ZQ3Mfv+NnSqDFiY+ZVR1r97dDrj3t5ju7jr66SV0w=;
        b=VDwrvoqlakCs4qMCkzCNN2JXwowG5HYWEiIDmNr9YaB0UddQvJS1F9z9Eokg9FB7/z
         ulzOJkKv3lvzv9QKHhKKtvXofYqwo3zmub0qfomo9lQrAvPXuuDuuI2C5j1Eau/CAsHl
         9LkHf9BKZR7ffT8htFJPCw7cclLAneqyOMPFTkRIuuGdqy1biY/IRGbGzS65mxg8SXG5
         Lzb8G5fNcNheH9TmcXsdH+HAlqSQWzvEs3M2s3W12YLxINOZhIZ7+HDfeDdmKVzdndx2
         uxFJI8Hsy61Zaw2aXJdxoXVJM7m4UJ26Qjl4BULiRfVEYOdqV1xZWf9pL7ajQ9OxUbCo
         H1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j/ZQ3Mfv+NnSqDFiY+ZVR1r97dDrj3t5ju7jr66SV0w=;
        b=jDOYqskmyCnHTlCv6mYNNZjgIVJOFEwqmNNbZ7Si/KNJ4zRdiaLA23VlY1KRun++RZ
         GmxVd08rTUNz7StBO01tt5M7+piTfyG/dTYVaRw8ionjHNvamrftGu5UZYReom0FJRxH
         lxnVyjJWtl8lG/4jkjA1udKOSOsjCcxiBLO/QotPNAW+OxsZCdUrW2VKfwim3ZSBkRXo
         9hAFeLJuwiTotEz++WEWE958LESYW1f8POu65zcTI293K5l6LLTAkIDB6Ol7TaC6ef2F
         hSr3wx0imc00j7YOH6ZTuSBPdGNv8WDQzCF21ha2uVzrpdkCRylt9PHupYfhOo8IETZz
         +2ow==
X-Gm-Message-State: AOAM533ddpFaFEtI4HIKh6VgaU5AmPWKa9jtrCOWXWJpeizrTnHha0Iy
        voRAYD/wCkFC2fQMlc9jXtQ1QpTt
X-Google-Smtp-Source: ABdhPJxBDsm4MyxQObIU+qn+MneHsZ7BobyeBv71NSKAVhDosvfrHosiLAFiKaWWhN9jjjG2rf0gRw==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr11286796wmi.7.1594261009574;
        Wed, 08 Jul 2020 19:16:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm2511222wmj.9.2020.07.08.19.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:48 -0700 (PDT)
Message-Id: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:42 +0000
Subject: [PATCH v3 0/6] doc: include git rev-list description in git log doc
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
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * applied Junio's suggestions 
 * added a preparatory commit tweaking the wording of one sentence in the 
   git rev-list description
 * added a new commit adding a sentence in revisions.txt to mention
   explicitly what it means to list several revisions to form a range.

v2: This series moves the nice explanation in the 'Description' section of
the git rev-list man page to a separate file and includes this file in the 
git log man page.

This goal is to make readers more aware that they can write e.g.

git log branch1 branch2 branch3 branch4 --not master

to see commits on each of branch1-4, that are not on master, since this is
not immediately obvious (at least to me) in the git log man page. 

Note that I made several commits for ease of reviewing, I'll squash some if
this would be preferred.

Changes since v1: took a completely different approach following the
comments received from Junio and Taylor.

Philippe Blain (6):
  git-log.txt: add links to 'rev-list' and 'diff' docs
  revisions.txt: describe 'rev1 rev2 ...' meaning for ranges
  git-rev-list.txt: fix Asciidoc syntax
  git-rev-list.txt: tweak wording in set operations
  git-rev-list.txt: move description to separate file
  git-log.txt: include rev-list-description.txt

 Documentation/git-log.txt              |  7 ++-
 Documentation/git-rev-list.txt         | 40 +----------------
 Documentation/rev-list-description.txt | 61 ++++++++++++++++++++++++++
 Documentation/revisions.txt            |  3 ++
 4 files changed, 71 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/rev-list-description.txt


base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-590%2Fphil-blain%2Fdoc-log-multiple-ranges-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-590/phil-blain/doc-log-multiple-ranges-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/590

Range-diff vs v2:

 1:  59c48282a0 ! 1:  59027b0f6a git-log.txt: add links to 'rev-list' and 'diff' docs
     @@ Documentation/git-log.txt: DESCRIPTION
      +The command takes options applicable to the linkgit:git-rev-list[1]
       command to control what is shown and how, and options applicable to
      -the `git diff-*` commands to control how the changes
     -+the linkgit:git-diff[1] family of commands to control how the changes
     ++the linkgit:git-diff[1] command to control how the changes
       each commit introduces are shown.
       
       
 -:  ---------- > 2:  3c573695a8 revisions.txt: describe 'rev1 rev2 ...' meaning for ranges
 4:  3b923780c1 ! 3:  b8ee4a743c rev-list-description.txt: fix Asciidoc syntax
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    rev-list-description.txt: fix Asciidoc syntax
     +    git-rev-list.txt: fix Asciidoc syntax
      
          Using '{caret}' inside double quotes and immediately following with a
          single quoted word does not create the desired output: '<commit1>'
     @@ Commit message
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     - ## Documentation/rev-list-description.txt ##
     -@@ Documentation/rev-list-description.txt: Thus, the following command:
     + ## Documentation/git-rev-list.txt ##
     +@@ Documentation/git-rev-list.txt: to further limit the result.
     + Thus, the following command:
       
     - ifdef::git-rev-list[]
       -----------------------------------------------------------------------
      -	$ git rev-list foo bar ^baz
      +$ git rev-list foo bar ^baz
       -----------------------------------------------------------------------
     - endif::git-rev-list[]
     - ifdef::git-log[]
     - -----------------------------------------------------------------------
     --	$ git log foo bar ^baz
     -+$ git log foo bar ^baz
     - -----------------------------------------------------------------------
     - endif::git-log[]
       
     -@@ Documentation/rev-list-description.txt: means "list all the commits which are reachable from 'foo' or 'bar', but
     + means "list all the commits which are reachable from 'foo' or 'bar', but
       not from 'baz'".
       
       A special notation "'<commit1>'..'<commit2>'" can be used as a
     @@ Documentation/rev-list-description.txt: means "list all the commits which are re
      +short-hand for "^'<commit1>' '<commit2>'". For example, either of
       the following may be used interchangeably:
       
     - ifdef::git-rev-list[]
       -----------------------------------------------------------------------
      -	$ git rev-list origin..HEAD
      -	$ git rev-list HEAD ^origin
      +$ git rev-list origin..HEAD
      +$ git rev-list HEAD ^origin
       -----------------------------------------------------------------------
     - endif::git-rev-list[]
     - ifdef::git-log[]
     - -----------------------------------------------------------------------
     --	$ git log origin..HEAD
     --	$ git log HEAD ^origin
     -+$ git log origin..HEAD
     -+$ git log HEAD ^origin
     - -----------------------------------------------------------------------
     - endif::git-log[]
       
     -@@ Documentation/rev-list-description.txt: between the two operands.  The following two commands are equivalent:
     + Another special notation is "'<commit1>'...'<commit2>'" which is useful
     +@@ Documentation/git-rev-list.txt: for merges.  The resulting set of commits is the symmetric difference
     + between the two operands.  The following two commands are equivalent:
       
     - ifdef::git-rev-list[]
       -----------------------------------------------------------------------
      -	$ git rev-list A B --not $(git merge-base --all A B)
      -	$ git rev-list A...B
      +$ git rev-list A B --not $(git merge-base --all A B)
      +$ git rev-list A...B
       -----------------------------------------------------------------------
     - endif::git-rev-list[]
     - ifdef::git-log[]
     - -----------------------------------------------------------------------
     --	$ git log A B --not $(git merge-base --all A B)
     --	$ git log A...B
     -+$ git log A B --not $(git merge-base --all A B)
     -+$ git log A...B
     - -----------------------------------------------------------------------
     - endif::git-log[]
     + 
     + 'rev-list' is a very essential Git command, since it
 -:  ---------- > 4:  cf934ddf33 git-rev-list.txt: tweak wording in set operations
 2:  daf00d9398 ! 5:  f61bbb57cb git-rev-list.txt: move description to separate file
     @@ Documentation/git-rev-list.txt: SYNOPSIS
      -given with a '{caret}' in front of them.  The output is given in reverse
      -chronological order by default.
      -
     --You can think of this as a set operation.  Commits given on the command
     --line form a set of commits that are reachable from any of them, and then
     --commits reachable from any of the ones given with '{caret}' in front are
     --subtracted from that set.  The remaining commits are what comes out in the
     --command's output.  Various other options and paths parameters can be used
     --to further limit the result.
     +-You can think of this as a set operation. Commits reachable from any of
     +-the commits given on the command line form a set, and then commits reachable
     +-from any of the ones given with '{caret}' in front are subtracted from that
     +-set.  The remaining commits are what comes out in the command's output.
     +-Various other options and paths parameters can be used to further limit the
     +-result.
      -
      -Thus, the following command:
      -
      ------------------------------------------------------------------------
     --	$ git rev-list foo bar ^baz
     +-$ git rev-list foo bar ^baz
      ------------------------------------------------------------------------
      -
      -means "list all the commits which are reachable from 'foo' or 'bar', but
      -not from 'baz'".
      -
      -A special notation "'<commit1>'..'<commit2>'" can be used as a
     --short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
     +-short-hand for "^'<commit1>' '<commit2>'". For example, either of
      -the following may be used interchangeably:
      -
      ------------------------------------------------------------------------
     --	$ git rev-list origin..HEAD
     --	$ git rev-list HEAD ^origin
     +-$ git rev-list origin..HEAD
     +-$ git rev-list HEAD ^origin
      ------------------------------------------------------------------------
      -
      -Another special notation is "'<commit1>'...'<commit2>'" which is useful
     @@ Documentation/git-rev-list.txt: SYNOPSIS
      -between the two operands.  The following two commands are equivalent:
      -
      ------------------------------------------------------------------------
     --	$ git rev-list A B --not $(git merge-base --all A B)
     --	$ git rev-list A...B
     +-$ git rev-list A B --not $(git merge-base --all A B)
     +-$ git rev-list A...B
      ------------------------------------------------------------------------
      +include::rev-list-description.txt[]
       
     @@ Documentation/rev-list-description.txt (new)
      +given with a '{caret}' in front of them.  The output is given in reverse
      +chronological order by default.
      +
     -+You can think of this as a set operation.  Commits given on the command
     -+line form a set of commits that are reachable from any of them, and then
     -+commits reachable from any of the ones given with '{caret}' in front are
     -+subtracted from that set.  The remaining commits are what comes out in the
     -+command's output.  Various other options and paths parameters can be used
     -+to further limit the result.
     ++You can think of this as a set operation. Commits reachable from any of
     ++the commits given on the command line form a set, and then commits reachable
     ++from any of the ones given with '{caret}' in front are subtracted from that
     ++set.  The remaining commits are what comes out in the command's output.
     ++Various other options and paths parameters can be used to further limit the
     ++result.
      +
      +Thus, the following command:
      +
      +-----------------------------------------------------------------------
     -+	$ git rev-list foo bar ^baz
     ++$ git rev-list foo bar ^baz
      +-----------------------------------------------------------------------
      +
      +means "list all the commits which are reachable from 'foo' or 'bar', but
      +not from 'baz'".
      +
      +A special notation "'<commit1>'..'<commit2>'" can be used as a
     -+short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
     ++short-hand for "^'<commit1>' '<commit2>'". For example, either of
      +the following may be used interchangeably:
      +
      +-----------------------------------------------------------------------
     -+	$ git rev-list origin..HEAD
     -+	$ git rev-list HEAD ^origin
     ++$ git rev-list origin..HEAD
     ++$ git rev-list HEAD ^origin
      +-----------------------------------------------------------------------
      +
      +Another special notation is "'<commit1>'...'<commit2>'" which is useful
     @@ Documentation/rev-list-description.txt (new)
      +between the two operands.  The following two commands are equivalent:
      +
      +-----------------------------------------------------------------------
     -+	$ git rev-list A B --not $(git merge-base --all A B)
     -+	$ git rev-list A...B
     ++$ git rev-list A B --not $(git merge-base --all A B)
     ++$ git rev-list A...B
      +-----------------------------------------------------------------------
 3:  eeaf4fe5dc ! 6:  d04b6c62a3 git-log.txt: include rev-list-description.txt
     @@ Documentation/git-log.txt: DESCRIPTION
      +
       The command takes options applicable to the linkgit:git-rev-list[1]
       command to control what is shown and how, and options applicable to
     - the linkgit:git-diff[1] family of commands to control how the changes
     + the linkgit:git-diff[1] command to control how the changes
      
       ## Documentation/git-rev-list.txt ##
      @@ Documentation/git-rev-list.txt: SYNOPSIS
     @@ Documentation/git-rev-list.txt: SYNOPSIS
       'rev-list' is a very essential Git command, since it
      
       ## Documentation/rev-list-description.txt ##
     -@@ Documentation/rev-list-description.txt: to further limit the result.
     +@@ Documentation/rev-list-description.txt: result.
       
       Thus, the following command:
       
      +ifdef::git-rev-list[]
       -----------------------------------------------------------------------
     - 	$ git rev-list foo bar ^baz
     + $ git rev-list foo bar ^baz
       -----------------------------------------------------------------------
      +endif::git-rev-list[]
      +ifdef::git-log[]
      +-----------------------------------------------------------------------
     -+	$ git log foo bar ^baz
     ++$ git log foo bar ^baz
      +-----------------------------------------------------------------------
      +endif::git-log[]
       
       means "list all the commits which are reachable from 'foo' or 'bar', but
       not from 'baz'".
      @@ Documentation/rev-list-description.txt: A special notation "'<commit1>'..'<commit2>'" can be used as a
     - short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
     + short-hand for "^'<commit1>' '<commit2>'". For example, either of
       the following may be used interchangeably:
       
      +ifdef::git-rev-list[]
       -----------------------------------------------------------------------
     - 	$ git rev-list origin..HEAD
     - 	$ git rev-list HEAD ^origin
     + $ git rev-list origin..HEAD
     + $ git rev-list HEAD ^origin
       -----------------------------------------------------------------------
      +endif::git-rev-list[]
      +ifdef::git-log[]
      +-----------------------------------------------------------------------
     -+	$ git log origin..HEAD
     -+	$ git log HEAD ^origin
     ++$ git log origin..HEAD
     ++$ git log HEAD ^origin
      +-----------------------------------------------------------------------
      +endif::git-log[]
       
     @@ Documentation/rev-list-description.txt: A special notation "'<commit1>'..'<commi
       
      +ifdef::git-rev-list[]
       -----------------------------------------------------------------------
     - 	$ git rev-list A B --not $(git merge-base --all A B)
     - 	$ git rev-list A...B
     + $ git rev-list A B --not $(git merge-base --all A B)
     + $ git rev-list A...B
       -----------------------------------------------------------------------
      +endif::git-rev-list[]
      +ifdef::git-log[]
      +-----------------------------------------------------------------------
     -+	$ git log A B --not $(git merge-base --all A B)
     -+	$ git log A...B
     ++$ git log A B --not $(git merge-base --all A B)
     ++$ git log A...B
      +-----------------------------------------------------------------------
      +endif::git-log[]

-- 
gitgitgadget
