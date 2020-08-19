Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1ABC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2801320888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOlmdb5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHSPPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHSPPd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:15:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB1C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y3so21923027wrl.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eDDb+RffVPP8SscVrg3MkZDoF2946irSOaaInCLB10o=;
        b=NOlmdb5ck0WNz63fbDEQSvH0kXVezMgTug25RF3h80VXFMdznBT+67kGAtJYf7KuD/
         gwyOkUS6//pz28ntDN7izPVG4eij/YQGOBnM9L9rNt5+hniIji5zF4WO9YAqImgOAF78
         yL5rvtwaw8xb0w61BXysbfMTusHO4qPJQmhc0S7zqW7iqsN9DEFjhZ6KceRdoYBVUkrw
         tjGml3LlLiRGz9zwvDqaUdW+hjM55vhGJDRAI35Ye+jYCTDhOxvRk8EoTR3c2B1KgFbb
         4Kv7zMM2r013zEWwcbQWVGf2qYvq/qdDwslyN+UQJ299sZ0LrRs5ch2hymmYykzpQVXb
         caXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eDDb+RffVPP8SscVrg3MkZDoF2946irSOaaInCLB10o=;
        b=nK3S42+O/ecoEkAcnMqrbDx3Ub6yEDaXpV7S53gtktVYnPpqETBrFZ9FLSFym3L2uo
         5UtdiuiGAxRVzuVGvx07q622eEC4xVB5R2ZK5gRfcBjEoAkc5nbEriWwdtdYqx1rHVFZ
         upkqYTIoY3u1DMKwsUBJb8H6DaRwGnfpJJnOHnZ5E14hiFbKLg8LtfMC7cQgKydwnjwV
         GYfZacGd/u4+nQX1lkF33RfSYvCFO2X6biQXao8eMKL24WN4/jJt6RgGzE6jJtNURG1V
         Pu1LtSig9DgvRjaK8kpTbOuikhl1XqsOVCCOmO7y0V19ZgK9TbERb5KLf5L7VahsKNbe
         Fxiw==
X-Gm-Message-State: AOAM530MieVC9a4BZUsr/JgDRZ6HAdm44uq0aU0VYEmtfdQ3yCg97BHU
        uXeQCz3+RYqMQuSY/D7Q9bSg5DO2lR4=
X-Google-Smtp-Source: ABdhPJymTpUaNgJE0kqVTVHvq8JmoLiHUCRF4wKpzQy+VbJih23wzO4W++8oiQSxlnzIb6nRcO9iHQ==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr25973442wrw.135.1597850130897;
        Wed, 19 Aug 2020 08:15:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 126sm6440287wme.42.2020.08.19.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:15:29 -0700 (PDT)
Message-Id: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.git.1597753075.gitgitgadget@gmail.com>
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 15:15:23 +0000
Subject: [PATCH v2 0/4] Use refs API for handling sundry pseudorefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the handling of CHERRY_PICK_HEAD and REVERT_HEAD to use
the refs API, as a preliminary refactor for reftable. 

No functional changes.

Han-Wen Nienhuys (4):
  refs: make refs_ref_exists public
  sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
  builtin/commit: suggest update-ref for pseudoref removal
  sequencer: treat REVERT_HEAD as a pseudo ref

 builtin/commit.c | 30 +++++++++++++-------------
 builtin/merge.c  |  2 +-
 path.c           |  2 --
 path.h           |  9 ++++----
 refs.c           |  2 +-
 refs.h           |  2 ++
 sequencer.c      | 56 +++++++++++++++++++++++++++++-------------------
 wt-status.c      |  6 +++---
 8 files changed, 60 insertions(+), 49 deletions(-)


base-commit: 2befe97201e1f3175cce557866c5822793624b5a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-706%2Fhanwen%2Fstray-pseudorefs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-706/hanwen/stray-pseudorefs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/706

Range-diff vs v1:

 1:  5e29fa74dc ! 1:  a8467a0d66 Make refs_ref_exists public
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Make refs_ref_exists public
     +    refs: make refs_ref_exists public
     +
     +    This will be necessary to replace file existence checks for pseudorefs.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
 2:  06a8e8cbd1 ! 2:  2797e98446 Treat CHERRY_PICK_HEAD as a pseudo ref
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Treat CHERRY_PICK_HEAD as a pseudo ref
     +    sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
      
          Check for existence and delete CHERRY_PICK_HEAD through ref functions.
          This will help cherry-pick work with alternate ref storage backends.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## builtin/commit.c ##
     -@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     - 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
     - 				!merge_contains_scissors)
     - 				wt_status_add_cut_line(s->fp);
     --			status_printf_ln(s, GIT_COLOR_NORMAL,
     --			    whence == FROM_MERGE
     --				? _("\n"
     --					"It looks like you may be committing a merge.\n"
     --					"If this is not correct, please remove the file\n"
     --					"	%s\n"
     --					"and try again.\n")
     --				: _("\n"
     --					"It looks like you may be committing a cherry-pick.\n"
     --					"If this is not correct, please remove the file\n"
     --					"	%s\n"
     --					"and try again.\n"),
     --				whence == FROM_MERGE ?
     --					git_path_merge_head(the_repository) :
     --					git_path_cherry_pick_head(the_repository));
     -+			if (whence == FROM_MERGE)
     -+				status_printf_ln(
     -+					s, GIT_COLOR_NORMAL,
     -+
     -+					_("\n"
     -+					  "It looks like you may be committing a merge.\n"
     -+					  "If this is not correct, please remove the file\n"
     -+					  "	%s\n"
     -+					  "and try again.\n"),
     -+					git_path_merge_head(the_repository));
     -+			else
     -+				status_printf_ln(
     -+					s, GIT_COLOR_NORMAL,
     -+
     -+					_("\n"
     -+					  "It looks like you may be committing a cherry-pick.\n"
     -+					  "If this is not correct, please run\n"
     -+					  "	git cherry-pick --abort\n"
     -+					  "and try again.\n"));
     - 		}
     - 
     - 		fprintf(s->fp, "\n");
     -
       ## builtin/merge.c ##
      @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
       		else
 -:  ---------- > 3:  2681638651 builtin/commit: suggest update-ref for pseudoref removal
 3:  173d81dbb4 ! 4:  9dcc10f807 Treat REVERT_HEAD as a pseudo ref
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Treat REVERT_HEAD as a pseudo ref
     +    sequencer: treat REVERT_HEAD as a pseudo ref
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      

-- 
gitgitgadget
