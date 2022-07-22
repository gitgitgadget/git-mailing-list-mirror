Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC69C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiGVFPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVFPs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D6522BFD
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k11so4545214wrx.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mL9oVfG86p3DAKttt+iJ9E4Co7ui4oydfsmrNVDna6Q=;
        b=eMa3kzJZecVNpadxe1WrsHq0ncZmp9CHcf2mG9xEZP4zB7uCYXiKvAnKtGC8aNJlhK
         SAMsHY+1JTwWOLNQFN4ZYSCMnNHte3MCTrc41ETBBvoNKnzOXmUi40E45Pzu/JH6FcLC
         mlM8jI2Jobuy7zl7O735LZ+aQ9uj9/sLMPAFLdwDxng+ct8we38xPK8vOAe4lEE3ah96
         YNw+tZhMBs4Qy/3z+1VGYDp0L1RbvC/QcppwWSrs43CpMMfq7BhsaGm0o4p1STt3DBHl
         JOQpwBjeXgnAEuQVYK4rWi1bezI+MUCgfs1S2WV7vaxwS6MHlLUNn/3PeeIwszEdPpJO
         klMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mL9oVfG86p3DAKttt+iJ9E4Co7ui4oydfsmrNVDna6Q=;
        b=TU4Hfqzd0yXuTnNfUwdI9TASExds5GRfYuWTkqob8sPHMKAOLT8Ug1ludu0NrTZhS8
         88R8w8DsAu3wDdBESdBd0dxIw8Z3wQKFe/ZkAQgFD9SNFn2BpyGIWh/YSPPOtZUCBu1s
         5RTXK3vMzkFVhnKb4RAyjIqvSwqn8/7LNdyHsdz913g7+qMhChq+hQ6PrqpQqm5Uy6Tb
         rsR7T39hvh6IxjI4uTLU7iLF7u+qfkhHk2V11OSwhZKpol3lyQccvzMpWdda+41g60NQ
         hbhJ2Y94WZkrhohmakunVJojmnqY7lwVp9kIxz7CDRzrHapQ+9/vA9jqFxiEh3fkll+V
         1bcA==
X-Gm-Message-State: AJIora8HFXgLbS/gIQyVpeqwUI4DodNjju61P+dZ6xkmLSlkG3pbGb5J
        BLbapfHKyWlg3sOyyaHoUDFBt2NC+xg=
X-Google-Smtp-Source: AGRyM1u8N1JEZOWl9jhgvNruvgd08IQqNGe4JUvr6jymcdZLOQTUmus1mXLroi7t8W0wevCCYwSm1w==
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id bw12-20020a0560001f8c00b0021d7e9851bamr1052375wrb.442.1658466944064;
        Thu, 21 Jul 2022 22:15:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600c150400b003a2fb1224d9sm3497216wmg.19.2022.07.21.22.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:43 -0700 (PDT)
Message-Id: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:35 +0000
Subject: [PATCH v4 0/7] Fix merge restore state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as a simple series to fix restore_state() in builtin/merge.c,
fixing an issue reported by ZheNing Hu[3]. It's grown so much it's hard to
call it simple. Anyway...

Changes since v3:

 * Removed some accidental &nbsp; characters from a commit message
 * Made use of the error() function to simplify the first patch

[1]
https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com/

Elijah Newren (7):
  merge-ort-wrappers: make printed message match the one from recursive
  merge-resolve: abort if index does not match HEAD
  merge: do not abort early if one strategy fails to handle the merge
  merge: fix save_state() to work when there are stat-dirty files
  merge: make restore_state() restore staged state too
  merge: ensure we can actually restore pre-merge state
  merge: do not exit restore_state() prematurely

 builtin/merge.c                          | 59 ++++++++++++++++++------
 git-merge-resolve.sh                     | 10 ++++
 merge-ort-wrappers.c                     |  4 +-
 t/t6402-merge-rename.sh                  |  2 +-
 t/t6424-merge-unrelated-index-changes.sh | 58 +++++++++++++++++++++++
 t/t6439-merge-co-error-msgs.sh           |  1 +
 t/t7607-merge-state.sh                   | 32 +++++++++++++
 7 files changed, 150 insertions(+), 16 deletions(-)
 create mode 100755 t/t7607-merge-state.sh


base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1231%2Fnewren%2Ffix-merge-restore-state-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1231/newren/fix-merge-restore-state-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1231

Range-diff vs v3:

 1:  e39b2e15ece ! 1:  bd36d16c8d9 merge-ort-wrappers: make printed message match the one from recursive
     @@ Commit message
          being processed by another function that made additional changes:
            * It added an implicit "error: " prefix
            * It added an implicit trailing newline
     -
     -    Add these things, but do so in a couple extra steps to avoid having
     -    translators need to translate another not-quite-identical string.
     +    We can get these things by making use of the error() function.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort-wrappers.c: static int unclean(struct merge_options *opt, struct tree
       
       	if (head && repo_index_has_changes(opt->repo, head, &sb)) {
      -		fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     -+		struct strbuf err = STRBUF_INIT;
     -+		strbuf_addstr(&err, "error: ");
     -+		strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     - 		    sb.buf);
     -+		strbuf_addch(&err, '\n');
     -+		fputs(err.buf, stderr);
     -+		strbuf_release(&err);
     +-		    sb.buf);
     ++		error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
     ++		      sb.buf);
       		strbuf_release(&sb);
       		return -1;
       	}
 2:  2810dec7608 = 2:  b79f44e54b9 merge-resolve: abort if index does not match HEAD
 3:  b41853e3f99 = 3:  02930448ea1 merge: do not abort early if one strategy fails to handle the merge
 4:  64700338a28 = 4:  daf8d224160 merge: fix save_state() to work when there are stat-dirty files
 5:  91c495c770e ! 5:  f401bd5ad0d merge: make restore_state() restore staged state too
     @@ Commit message
          Unfortunately, if users had staged changes before calling `git merge`,
          builtin/merge.c could do the following:
      
     -       * stash the changes, in order to clean up after the strategies
     -       * try all the merge strategies in turn, each of which report they
     +       * stash the changes, in order to clean up after the strategies
     +       * try all the merge strategies in turn, each of which report they
               cannot function due to the index not matching HEAD
     -       * restore the changes via "git stash apply"
     +       * restore the changes via "git stash apply"
      
          But that last step would have the net effect of unstaging the user's
          changes.  Fix this by adding the "--index" option to "git stash apply".
 6:  887967c1f3f = 6:  ad5354c219c merge: ensure we can actually restore pre-merge state
 7:  81c40492a62 = 7:  6212d572604 merge: do not exit restore_state() prematurely

-- 
gitgitgadget
