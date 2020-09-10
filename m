Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130DFC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13082078B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4bDTg/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgIJHc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgIJHcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 03:32:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ACC061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so4121542pfa.10
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X07fjBNoq01iqUUTr4DhWgRcLn6b5141lFlA0uWwMWw=;
        b=m4bDTg/jgHaF2pVgCNtYYhBf/nv0XH9L/A7V4Coixq2XjzHiAoWLoEVFoPqtIVGHKw
         EsYrzGCwur5KuyfDZafEhTfgDeqkAkyi1zdHukLP2YUTbM0wFkMtuJFdJcg2jfVsnY42
         wFz/CtbvkRe1wRT9knq950Va6xCsRl5fmC9M3yV5xJLF6rs6FXUywaQcsHvuz+8ccWjD
         ny3E079ddhS4CZTNRU/tjjEw41uyYV3N7gmJol1CNrryV0tg/FA6BzL1S5A4o6KVa+uV
         ZdJ4Ra8FghSF0AzkJtKxVAsqW9Hc2NMfA7+faH2pJhI7pUW90k0GISWNl6ZwYVfCplY4
         uRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X07fjBNoq01iqUUTr4DhWgRcLn6b5141lFlA0uWwMWw=;
        b=kW6imEB1PTlo6lIRns5gwYSWliK4znE4mBOHqK6cyXwGsoaaaDQ9j3zfpSvwSnFeNN
         /R6aCJwMQ3Jrvd9iP7QVAIXSPMRVho5TPHjdYudo8Uiox98opFODy0ZOxhm3BRpyIiXd
         u7g+o/OfjaRyCLSgmilJZPCFfIMeA7gKJYkJVmLXq43kKiaGn0Xs3qi7axx0S1n/wovg
         htqZlnJv87d0QSKPg/edYzcfiyAsMDvTnKQs4SDBuiFDXd6GKhkemlILXaBYe3F1ctFC
         4CgJaJ8Sofp2V7XCkO7AcpNXF83/m1tfzMMqjX52FgwikyNwwiSkFH4VlDSj62Yj57MD
         7HlA==
X-Gm-Message-State: AOAM530drCH7/81zKhUb75OOT5SfOpIskhm3fSiTX2xMrONhE8u3YSJ4
        ij6FuZ7FTITZLbtpEp/7aZgHxVfGuLc=
X-Google-Smtp-Source: ABdhPJxwTmpxDgUBIA2IgOe3j4NkxOe5xkr6Y9CvnZ8yuoIQWEzWQ7parr95BaD1vWgXqbnGk0iYpA==
X-Received: by 2002:a62:878f:: with SMTP id i137mr3948185pfe.24.1599723161235;
        Thu, 10 Sep 2020 00:32:41 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id q127sm4990550pfb.61.2020.09.10.00.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:32:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] builtin/diff: learn --merge-base
Date:   Thu, 10 Sep 2020 00:32:16 -0700
Message-Id: <cover.1599723087.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599332861.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-notation in `git diff` has been cited as a mistake since diff
compares two endpoints, not whole ranges.[0]  In fact, the ranges seem
to take on the opposite meanings when compared to range notation in
`git log`.

In an effort to reduce the use of range notation as much as possible,
introduce the `--merge-base` flag, slightly modified from a suggestion
by Jonathan Nieder.[1] This flag allows us to replace the first commit
given on the command-line with its merge base between the first and
second commits. This allows us to gently deprecate the `...` form
entirely, although that is left as an exercise to the reader ;)

One additional bonus is that this flag allows the "after" side to be not
just constrained to a commit (like with `...` notation). It can now be
the working tree or the index as well.

The `--merge-base` name isn't very satisfying. If anyone has any better
suggestions, please let me know.

Changes since v1:

* Implement Junio's documentation suggestions

* Update git diff's usage to include this option

[0]: https://lore.kernel.org/git/xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com/
[1]: https://lore.kernel.org/git/20191223215928.GB38316@google.com/

Denton Liu (4):
  t4068: remove unnecessary >tmp
  git-diff.txt: backtick quote command text
  builtin/diff: parse --no-index using parse_options()
  builtin/diff: learn --merge-base

 Documentation/git-diff.txt | 40 +++++++++++-----
 builtin/diff.c             | 94 +++++++++++++++++++++++++++++++++-----
 diff-no-index.c            | 15 ++----
 t/t4068-diff-symmetric.sh  | 89 ++++++++++++++++++++++++++++++++++--
 4 files changed, 198 insertions(+), 40 deletions(-)

Range-diff against v1:
1:  231ba3f661 ! 1:  4f219cf0d1 builtin/diff: learn --merge-base
    @@ Commit message
     
         Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
     
    +
    + ## Notes ##
    +    The `--merge-base` name isn't very satisfying. If anyone has any
    +    suggestions for alternative names, please let me know.
    +
      ## Documentation/git-diff.txt ##
     @@ Documentation/git-diff.txt: SYNOPSIS
      'git diff' [<options>] [<commit>] [--] [<path>...]
    @@ Documentation/git-diff.txt: files on disk.
     +equivalent to `git diff $(git merge-base A B) B`.
     ++
     +In the case where one commit is given, a diff is displayed between the
    -+merge base and the working tree or the index if `--cached` is given.
    -+`git diff --merge-base A` is equivalent to `git diff $(git merge-base A
    -+HEAD)`.
    ++merge base of the commit and the HEAD and the working tree or the index
    ++if `--cached` is given. `git diff --merge-base A` is equivalent to `git
    ++diff $(git merge-base A HEAD)`.
     ++
     +In the case where no commits are given, this form behaves identically to
     +as if no `--merge-base` were supplied.
    @@ builtin/diff.c
      
      #define DIFF_NO_INDEX_EXPLICIT 1
      #define DIFF_NO_INDEX_IMPLICIT 2
    +@@ builtin/diff.c: static const char builtin_diff_usage[] =
    + "git diff [<options>] [<commit>] [--] [<path>...]\n"
    + "   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
    + "   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
    +-"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
    ++"   or: git diff [<options>] --merge-base [<commit> [<commit>]] [--] [<path>...]\n"
    + "   or: git diff [<options>] <blob> <blob>]\n"
    + "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
    + COMMON_DIFF_OPTIONS_HELP;
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
      	int blobs = 0, paths = 0;
      	struct object_array_entry *blob[2];
    @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
      			   DIFF_NO_INDEX_EXPLICIT,
      			   PARSE_OPT_NONEG),
     +		OPT_BOOL(0, "merge-base", &merge_base,
    -+			 N_("use the merge base between the two commits as the diff base")),
    ++			 N_("compare with the merge base between two commits")),
      		OPT_END(),
      	};
      
-- 
2.28.0.618.gf4bc123cb7

