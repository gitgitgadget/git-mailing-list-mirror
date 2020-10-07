Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32115C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FDD207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPMu/wSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgJGH40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgJGH40 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:56:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A8AC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:56:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o25so895853pgm.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KUVDg1750GP5f8BHfYWV+utfSaALBMKu+OfFj06uEJA=;
        b=RPMu/wSin+nYBiCqF01YaLhLlHFccSAbEMQwCgx6WwBunZ2KFDFg9X9yX6XVH2OaLX
         zf7mIiVOGV2EICk4+1ghtqIdwMIYAydQb5tnG635IwA8guTMTxc4DrZKkQEBGVSdrobc
         YoeR22Hps5S1eNzn11Bba61EVJWX5h1cJISykY+NByBpDVPfH+l//iCpZRuHm9IIwOWB
         78qZ+BTeBk7rR2bF9abMiEslUZGQOh6QCLquPIW7FNF6bP7xQmdJuwI2O0Rzt/U2dslS
         N68DabIU1+SiNxnTtbIPYodMvgU7fUGIZIh20KsjXCNIG7xZmVLCs2QlLRoej9uaz5Im
         7eAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUVDg1750GP5f8BHfYWV+utfSaALBMKu+OfFj06uEJA=;
        b=MdkzshW271ynduVLXjptf5O0yULGanycT2Ma6RLqoN2gJEHmjMe/CWT2Lx2dnpY5O6
         /WkmyJRj+/sW41gclxeRXoQviUurFgDFDdqcDO4eumDd1g6ngb2+cSw6oRBerWzkpB/Q
         Fi38x4KNwTGxDjEJ3jG+O03HxCgOYpEc8Mkv627CkLvvx1o6IPS8kUWhp0S7qh/2GPeV
         ZbYdJfrw+qaZbPZ37CaXm2dZAASnk0F8xx6W9A9XxDvrzIJwuFV7lGi1M6gCzuGoDTPz
         5haJwTUz2RZFJHDtLtnKr1RzaZCdmOBTLzFiV83fizgP8fCGeA/PSTZtwJRo3jFZV7NY
         dcRQ==
X-Gm-Message-State: AOAM531mCK+5W586Ud3+KHgzoTd/S/xAvm7OkJbOWww7bkjyJUmUl9mK
        XhNV+WQy6OXEekkRnqbY61WdKvkZOS0=
X-Google-Smtp-Source: ABdhPJzODxQ1ZCrAI8UVHurWp2Gei0FSbxMUfLeVfCpy2pMHfRzb1OM0XsW6Ipk6jO0kCzF2/iGxjQ==
X-Received: by 2002:a63:e63:: with SMTP id 35mr1997253pgo.264.1602057385525;
        Wed, 07 Oct 2020 00:56:25 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id n9sm1909950pgi.2.2020.10.07.00.56.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:56:24 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 0/4] checkout/restore: fix `git checkout -p HEAD...` bug
Date:   Wed,  7 Oct 2020 00:56:14 -0700
Message-Id: <cover.1602057332.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1601814601.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported earlier[0], `git checkout -p HEAD...` results in the following error:

	$ git checkout -p HEAD...
	usage: git diff-index [-m] [--cached] [<common-diff-options>] <tree-ish> [<path>...]
	common diff options:
	  -z            output diff-raw with lines terminated with NUL.
	  -p            output patch format.
	  -u            synonym for -p.
	  --patch-with-raw
			output both a patch and the diff-raw format.
	  --stat        show diffstat instead of patch.
	  --numstat     show numeric diffstat instead of patch.
	  --patch-with-stat
			output a patch and prepend its diffstat.
	  --name-only   show only names of changed files.
	  --name-status show names and status of changed files.
	  --full-index  show full object name on index lines.
	  --abbrev=<n>  abbreviate object names in diff-tree header and diff-raw.
	  -R            swap input file pairs.
	  -B            detect complete rewrites.
	  -M            detect renames.
	  -C            detect copies.
	  --find-copies-harder
			try unchanged files as candidate for copy detection.
	  -l<n>         limit rename attempts up to <n> paths.
	  -O<file>      reorder diffs according to the <file>.
	  -S<string>    find filepair whose only one side contains the string.
	  --pickaxe-all
			show all files diff when -S is used and hit is found.
	  -a  --text    treat all files as text.

	Cannot close git diff-index --cached --numstat --summary HEAD... -- () at <redacted>/libexec/git-core/git-add--interactive line 183.

Since it was decided that <tree-ish> should also officially support the
merge-base revs, fix `git checkout -p <rev>...` and officially document the
support.

Changes since v1:

* Add two NEEDSWORK commits

* Be more precise in the inline code comment

[0]: https://lore.kernel.org/git/20200929061830.GA40759@generichostname/

Denton Liu (4):
  builtin/checkout: fix `git checkout -p HEAD...` bug
  Doc: document "A...B" form for <tree-ish> in checkout and switch
  add-patch: add NEEDSWORK about comparing commits
  t2016: add a NEEDSWORK about the PERL prerequisite

 Documentation/git-checkout.txt |  4 ++++
 Documentation/git-restore.txt  |  4 ++++
 add-patch.c                    |  8 ++++++++
 builtin/checkout.c             | 15 ++++++++++++++-
 git-add--interactive.perl      |  7 +++++++
 t/t2016-checkout-patch.sh      | 11 +++++++++++
 t/t2071-restore-patch.sh       |  8 ++++++++
 7 files changed, 56 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  54f221411f ! 1:  723d74febe builtin/checkout: fix `git checkout -p HEAD...` bug
    @@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
     +		char rev_oid[GIT_MAX_HEXSZ + 1];
     +
     +		/*
    -+		 * Since rev can be in the form of `<a>...<b>`, we must replace
    -+		 * the name with the hex of the commit for the
    -+		 * run_add_interactive() machinery to work properly. However,
    -+		 * there is special logic for the HEAD case so we mustn't
    -+		 * replace that.
    ++		 * Since rev can be in the form of `<a>...<b>` (which is not
    ++		 * recognized by diff-index), we will always replace the name
    ++		 * with the hex of the commit (whether it's in `...` form or
    ++		 * not) for the run_add_interactive() machinery to work
    ++		 * properly. However, there is special logic for the HEAD case
    ++		 * so we mustn't replace that.
     +		 */
     +		if (rev && strcmp(rev, "HEAD"))
     +			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
2:  75920c1a25 = 2:  a0ed2f313d Doc: document "A...B" form for <tree-ish> in checkout and switch
-:  ---------- > 3:  44ee78450e add-patch: add NEEDSWORK about comparing commits
-:  ---------- > 4:  a20544f18a t2016: add a NEEDSWORK about the PERL prerequisite
-- 
2.28.0.942.g77c4c6094c

