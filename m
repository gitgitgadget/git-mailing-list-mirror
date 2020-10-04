Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B67C4727E
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C91206A1
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 12:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R50KIOlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgJDMap (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgJDMao (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 08:30:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC9C0613CE
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 05:30:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so3967209pgm.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxyZbQ5M6aJ3RRr8T6mh+nAqR7vlf4O9WJUpS0YfyXU=;
        b=R50KIOlrS3Ha3GW1qGYae3Pp7uQrnF9zGwVHvp39oFflW0Swj1JxqzrojFlWB9UzrO
         Pg0HQl8Itdgjtoxpg3b0XD+7/53FiJt7ZdE0pS3bmAc5zRgMpVPn8JVkQ79d6QaK4vSR
         tijGHQFfp3L9W7CAPV4VQ8XSPCoukDiVfPlPHzY7VEIYztQ648hik0SV9zkD7jTzovA3
         5bYYBpMwz23h59Bsgekc1dwPtPFdG3jA6dY6eNQJFjJADue/+1J0ybU13Y3ZhReDl8Dt
         5aWTTzMmEPLECiQhdlTTNS0w+UIfJD+ton+wlcHE5T7tzzF278C5BRYIFLxNHi21GmDr
         08Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxyZbQ5M6aJ3RRr8T6mh+nAqR7vlf4O9WJUpS0YfyXU=;
        b=rFDNZg6iXoCFWYsrAPwy6pyteBlQx5xmVgdAR4yLT8mP8WfS5HOhVD8UdFdxUxJERQ
         wHgeK37wQy0QUk7/eXmCldO3FMWmDitwhtbQXaJufU2iKl1tuujb/qRD8f5225n5FryM
         Tk4LlFG6dSa62saXXOdgTxBOoQbgzmjdC3pkph7aWjn4EpZl52p1fMKLaHJTVDd8PrD2
         wbsTER6ZnyxAxStjAJsHvR3MS9b6emWozbobIC3rIgVmqMBkKJLubvGvzHr3xAGQ4Ypb
         OblPmrilnTA8tx25w4xrImBjiH9lEKdIkk8a/HHGXF93Os+I91tHbF00UAHoTdBGOjaE
         KZZA==
X-Gm-Message-State: AOAM532rXrcnNC1bpdaix7G/X64nzi/RBy0zaz0dqicFNaRZjmIwsG75
        4ymGxdpWV5Ocn8moQe15QBo7XNJp3uw=
X-Google-Smtp-Source: ABdhPJwsk8BuRgV/1DHqcYund0VRzgWeDsJSmQTJfkG/3CnR2ORipkc9AxQjG09D/RTbxJ/+Y3CJRg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr9427855pgk.318.1601814641604;
        Sun, 04 Oct 2020 05:30:41 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e8sm7372299pgj.8.2020.10.04.05.30.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 05:30:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] checkout/restore: fix `git checkout -p HEAD...` bug
Date:   Sun,  4 Oct 2020 05:30:32 -0700
Message-Id: <cover.1601814601.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
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

[0]: https://lore.kernel.org/git/20200929061830.GA40759@generichostname/

Denton Liu (2):
  builtin/checkout: fix `git checkout -p HEAD...` bug
  Doc: document "A...B" form for <tree-ish> in checkout and switch

 Documentation/git-checkout.txt |  4 ++++
 Documentation/git-restore.txt  |  4 ++++
 builtin/checkout.c             | 14 +++++++++++++-
 t/t2016-checkout-patch.sh      |  7 +++++++
 t/t2071-restore-patch.sh       |  8 ++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.28.0.942.g77c4c6094c

