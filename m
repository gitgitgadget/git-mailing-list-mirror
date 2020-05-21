Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A78FC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360C3207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riA6bxjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEUKPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:15:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37EC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w7so6052155wre.13
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=uvDiZRB9i/8mQX9W1o1vE/ZteDfVipFrSTG5fR0SYcA=;
        b=riA6bxjr93Sshud7UjBIZbdrK25LimVQoqWlgdx+l6MKtKXh1suLD5+E1NCUmWYQnv
         P0GdDMmmK8AwzKK0/+mtqvY7WPaCc6rnKxrXT4myWK7IcFPx5Ze5IpYJ+UeD3fZI4buw
         7qwNHN8oXguKqin37bnGE0/nFWmpOqKlmkJrYYF7ouD7x9oPsy8PAN7hXcWUBMLDU8JK
         ZfGk+1FMGOJ0/tjmA+AKtu2cATZq0ockd18N0lmi+73kgaNZMJ9xgf29y/6C8wmyOhAh
         yFJzagdFGSBvl7IGDD5EQfoUffS17sDjOKskjnhcjLsMTgn6naSvgzC2ID6lHnWYrGrg
         LmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=uvDiZRB9i/8mQX9W1o1vE/ZteDfVipFrSTG5fR0SYcA=;
        b=lvJDlZkXgK0L9jqROnt4bngz7pOwxB8yfklRLCMWsjrZlgAnK8MOu816/cKYz7HHnu
         vDe+YZsoWo5v/BHYdGl+VYs8nzhr81fT/jBrCsyzinfCCPAUbqemS3BA8/y4Om4r6bTt
         kdaxwsDgcLJcyT6dnCpLZPoHdVf+TJSpAoBTyUzOs1zFBnXjjHDdiLAbndEpizC0/b31
         Ej04HhR+IAtEhsgHxtc6PuIaMZCOKbSptDOSuq1JWmmzScwSJdo/ql3cedkExA3Y9uoP
         FoO5nCBH0ZKeA8HO5i/kfT7XOyRfGE3PH8cOXmVLDPzu4g0Eg+814ObQgjKp8uJilZFB
         XDoA==
X-Gm-Message-State: AOAM530CcM72FVCpO0id/dYa0SDOCtyYZte8di8V8/wHtCsuocoGWoMg
        UkLjIYFFiVkafgU1LnG3mY0=
X-Google-Smtp-Source: ABdhPJyKpBKGUeiZYw+trSlOrLTdi8mt1xWz+oLw6JGrrBco3s/FUnCOAtAe35JPml3oTvEH1NxxZA==
X-Received: by 2002:adf:face:: with SMTP id a14mr7798267wrs.397.1590056114927;
        Thu, 21 May 2020 03:15:14 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id y5sm656219wrs.63.2020.05.21.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:15:13 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/5] cleanup ra/rebase-i-more-options
Date:   Thu, 21 May 2020 11:14:50 +0100
Message-Id: <20200521101455.63484-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for the feedback on v2, I've updated the documentation as
suggested by Elijah and made the style fixes suggested by Alban but
I've not changed read_author_script() for the reasons explained in
https://lore.kernel.org/git/c6a2711a-96c1-d7ac-9678-20c581408ef5@gmail.com

These patches are based on 9fadedd637 ("Merge branch
'ds/default-pack-use-sparse-to-true'", 2020-03-29)

Phillip Wood (2):
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (3):
  rebase -i: add --ignore-whitespace flag
  sequencer: rename amend_author to author_to_free
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  33 +++-
 builtin/rebase.c                       |  46 ++++--
 sequencer.c                            | 111 ++++++++++++-
 sequencer.h                            |   2 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 209 +++++++++++++++++++++++++
 6 files changed, 379 insertions(+), 24 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

Range-diff against v2:
1:  5ef315240a ! 1:  df8c4ed2e9 rebase -i: add --ignore-whitespace flag
    @@ Documentation/git-rebase.txt: your branch contains commits which were dropped, t
      with `--keep-base` in order to drop those commits from your branch.
      
      --ignore-whitespace::
    -+	Behaves differently depending on which backend is selected.
    ++	Ignore whitespace differences when trying to reconcile
    ++differences. Currently, each backend implements an approximation of
    ++this behavior:
     ++
     +apply backend: When applying a patch, ignore changes in whitespace in
    -+context lines.
    ++context lines. Unfortunately, this means that if the "old" lines being
    ++replaced by the patch differ only in whitespace from the existing
    ++file, you will get a merge conflict instead of a successful patch
    ++application.
     ++
     +merge backend: Treat lines with only whitespace changes as unchanged
    -+when merging.
    ++when merging. Unfortunately, this means that any patch hunks that were
    ++intended to modify whitespace and nothing else will be dropped, even
    ++if the other side had no changes that conflicted.
     +
      --whitespace=<option>::
     -	These flags are passed to the 'git apply' program
2:  55eb3a7efc ! 2:  df44a0bde6 rebase -i: support --committer-date-is-author-date
    @@ Commit message
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-rebase.txt ##
    -@@ Documentation/git-rebase.txt: when merging.
    +@@ Documentation/git-rebase.txt: if the other side had no changes that conflicted.
      See also INCOMPATIBLE OPTIONS below.
      
      --committer-date-is-author-date::
    @@ sequencer.c: static int run_git_commit(struct repository *r,
      
      	if (!(flags & VERIFY_MSG))
     @@ sequencer.c: static int try_to_commit(struct repository *r,
    - 
    - 	if (parse_head(r, &current_head))
    - 		return -1;
    --
    - 	if (flags & AMEND_MSG) {
    - 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
    - 		const char *out_enc = get_commit_output_encoding();
    -@@ sequencer.c: static int try_to_commit(struct repository *r,
      		commit_list_insert(current_head, &parents);
      	}
      
3:  19352fdc22 = 3:  fa3d4856b4 sequencer: rename amend_author to author_to_free
4:  5e971abb74 ! 4:  96657233d4 rebase -i: support --ignore-date
    @@ sequencer.c: static const char *author_date_from_env_array(const struct argv_arr
     +		error(_("malformed ident line '%s'"), author);
     +		return NULL;
     +	}
    ++
     +	len = ident.mail_end - ident.name_begin + 1;
    -+
     +	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
     +	datestamp(&new_author);
     +	return strbuf_detach(&new_author, NULL);
    @@ sequencer.c: static int try_to_commit(struct repository *r,
     +		free(author_to_free);
     +		author_to_free = (char *)author;
     +	}
    ++
      	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
      				 oid, author, opts->gpg_sign, extra)) {
      		res = error(_("failed to write commit object"));
5:  43a097c583 = 5:  828155baba rebase: add --reset-author-date

-- 
2.26.2
