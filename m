Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13476C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjEJVho (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEJVhn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:37:43 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A93A80
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:41 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1929818d7faso47260783fac.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683754660; x=1686346660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuLhwV9TFl4CWLkHqD6RtfrRvn8ACm3zmR4UpCtj3sM=;
        b=HocT54PZQCYqVWjRyHMCp/H91hRjw2cWhfENuHkC+nvTZqUnoF1rfH8AYLGH1IYjCC
         R+IFRpTf+Xwor0ANGC9/eIWAUz5xAcLBPnhEl9gdelYRGMLC40rRf4BbbTHpmtJzclft
         4hkxiW854a8nR5Pqff1EzthzF/DATu/9NQTjRrmeX8gRjmI+ja5cUxXsVwG9hjtdG6zN
         KHdZ4NSK3ZqOeDX6h6yed/y1Ef5pGddaQqWq4o0v5xHYqqxtJWahM3nYdAfoSZAg7iDp
         gCwUO59w3emlKtkV8lqq6giW77zS1DOl0BZQkQ/jnuKpXdg7Qcz0052iwvnGJfVxC+co
         7orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754660; x=1686346660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuLhwV9TFl4CWLkHqD6RtfrRvn8ACm3zmR4UpCtj3sM=;
        b=RorLzMIIKtp05/14GPW08PNHAUA69u+b61O7UUqh1nkoj8pLl3cRCotjfeLhh1wkiG
         eoo7S5CG/q23woblftcAWSbAb5ztAcx/SpXp9fVWYV9viEtiHF/BWFFm2TwL1M2m+PVH
         VoqrOuBtMxf7MXGCTDfeEu8pDtSkkRfDvMMwN0IQiG1+GX13v0Hz4dH4fkJIEjPXkZLi
         50LRdcKktcz3hoIXmC+p6NeiBVTsVL0qbpHncLq0MLoO47IaO/tmRFWCGw5trRbkwEND
         WEGDuyvg4bE7jSGq56x9e7XYgc/tnQ88eE+ftfnOmGmcnhMkrT9aQaL2XJh6zFCbZQYi
         wpUA==
X-Gm-Message-State: AC+VfDx9Fv/XNak+Z1tbs5K9x1F8P5dqK5gOI4o+xQgV6Ze3+pmlTw92
        eVG9jaJB3sHP4mw1Uf78004+/ECKkSA=
X-Google-Smtp-Source: ACHHUZ6mdK/0OgPCXvYKcCGdV208U3I8AGaDoeU4XY6LZYfC/FhZDM0wWao+d9pa1t33VhczBG+hVg==
X-Received: by 2002:aca:de82:0:b0:38e:c4a9:e17e with SMTP id v124-20020acade82000000b0038ec4a9e17emr3258799oig.7.1683754660256;
        Wed, 10 May 2023 14:37:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u2-20020a056870184200b0018b182ce317sm7411077oaf.55.2023.05.10.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:37:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/4] Generic conflict style fixes
Date:   Wed, 10 May 2023 15:37:34 -0600
Message-Id: <20230510213738.505241-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sent v2 of this series almost 2 years ago [1] and received zero
feedback. This is the same version except rebased on top of master.

In v1 the idea was to change the default conflictstyle, but that
proposal got stuck due to a variety of reasons (including unnecessary
personal drama).

v2 should not have been controversial, and neither is v3.

[1] https://lore.kernel.org/git/20210622002714.1720891-1-felipe.contreras@gmail.com/

Felipe Contreras (4):
  test: add merge style config test
  merge-tree: fix merge.conflictstyle handling
  notes: fix merge.conflictstyle handling
  test: document broken merge.conflictStyle handling

 builtin/merge-tree.c               |   4 +
 builtin/notes.c                    |   3 +-
 t/t6440-config-conflict-markers.sh | 116 +++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100755 t/t6440-config-conflict-markers.sh

Range-diff against v2:
1:  51351f1a77 = 1:  6867f22f49 test: add merge style config test
2:  1fccf561ed ! 2:  60bf233000 merge-tree: fix merge.conflictstyle handling
    @@ Commit message
     
      ## builtin/merge-tree.c ##
     @@
    - #include "blob.h"
    - #include "exec-cmd.h"
      #include "merge-blobs.h"
    + #include "quote.h"
    + #include "tree.h"
     +#include "config.h"
     +#include "xdiff-interface.h"
      
    - static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
    + static int line_termination = '\n';
      
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
    - 	if (argc != 4)
    - 		usage(merge_tree_usage);
    + 	if (argc != expected_remaining_argc)
    + 		usage_with_options(merge_tree_usage, mt_options);
      
     +	git_config(git_xmerge_config, NULL);
     +
    - 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
    - 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
    - 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
    + 	/* Do the relevant type of merge */
    + 	if (o.mode == MODE_REAL)
    + 		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
     
      ## t/t6440-config-conflict-markers.sh ##
     @@ t/t6440-config-conflict-markers.sh: test_expect_success 'merge' '
3:  3bb872e3cd ! 3:  cf8cabaae3 notes: fix merge.conflictstyle handling
    @@ Commit message
     
      ## builtin/notes.c ##
     @@
    - #include "notes-merge.h"
      #include "notes-utils.h"
      #include "worktree.h"
    + #include "write-or-die.h"
     +#include "xdiff-interface.h"
      
      static const char * const git_notes_usage[] = {
    @@ builtin/notes.c: int cmd_notes(int argc, const char **argv, const char *prefix)
     -	git_config(git_default_config, NULL);
     +	git_config(git_xmerge_config, NULL);
      	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
    - 			     PARSE_OPT_STOP_AT_NON_OPTION);
    - 
    + 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
    + 	if (!fn) {
     
      ## t/t6440-config-conflict-markers.sh ##
     @@ t/t6440-config-conflict-markers.sh: test_expect_success 'merge-tree' '
4:  a767bc68e6 = 4:  5959fea3c4 test: document broken merge.conflictStyle handling
-- 
2.40.0+fc1

