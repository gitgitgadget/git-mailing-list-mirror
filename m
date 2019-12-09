Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18976C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18D42080D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3hzY9uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfLILxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36424 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLILxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so14604287wma.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Pbe5KQ85ZLxENN2+z/4SBlB5jH4XSS0gS13sv4wgVU=;
        b=r3hzY9ujj7+UydULxq38KTphDSVmKN5gG9G3RsIxoU1SF+WlHmR8XrKukkpY6oLZTW
         elz6t/M4kl73uhzyaVmaHjEKCKrT7g4vSUx+wfM8PS5+ZzvQ5Mbhrvd6Ejx9g0nn2r6+
         XcJQCgER9/SBzo2SmZYLzt1fNE9iRTfB2mWOMPlMsDuiR2QpLPkvuKyy47HDa4ZneE/w
         pAIJryyDmQBCG9xTYraZ8eISH050P7Ddb3fCcAs29Zlt3513MajjHIHbaUwL/cC4puqx
         ATivAHCe4Z9Vbis6xeZCeg5NsEBZnrBsdCmIsqBdaaloELeDNyyoAhb7Tc6BRYeyCL00
         kPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Pbe5KQ85ZLxENN2+z/4SBlB5jH4XSS0gS13sv4wgVU=;
        b=tMnnnDyt++VnEr8UjFIj/05WiRIaHSXar3hdttI3g+2sCJhBXKm0QDFh3NrACTFXlT
         a2L6jtWCE1bao8h6TynK+ulgojgLLkMDnFER1Zgw/PCGbFSkD7P3m2yRMzVIbFHCtDP+
         TJ1wuymZHvIZMuox1+sxGBTFJydOJ1fPKVyk872taFWplT0hEdiLbuw/s1vFS9mGHn/H
         kxten+8k/povsXy7NLAQ4CGZ/a6HNQNjkNNkDhg++3eCYdHa/l7HuAwEvARStRqa5Txe
         ChBLr+JUEYqlHQK19CobM5LXK82w6oNfxy2kVFk9LZXDR7+NWGNtOgD0zTqE/fJIZjVo
         ozZQ==
X-Gm-Message-State: APjAAAUhudMJ7ZEsnE3D+h3w/04lXXsCGbEaaXc0WUBTSVJiEvVxVaTt
        mbutiQG1M9GCcnX4wLZdIXg=
X-Google-Smtp-Source: APXvYqwXt298g+8y5AIuNmZ6qMhISi6vn54zETt8NYZ9WCscuA9PkdJHUJA0Xfzqf3aPbzn72nvPEw==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr23841987wma.97.1575892389802;
        Mon, 09 Dec 2019 03:53:09 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 06/14] t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
Date:   Mon,  9 Dec 2019 12:52:50 +0100
Message-Id: <20191209115258.9281-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'builtin/name-rev.c' in the name_rev() function there is a loop
iterating over all parents of the given commit, and the loop body
looks like this:

  if (parent_number > 1) {
      if (generation > 0)
          // branch #1
          new_name = ...
      else
          // branch #2
          new_name = ...
      name_rev(parent, new_name, ...);
  } else {
      // branch #3
      name_rev(...);
  }

These conditions are not covered properly in the test suite.  As far
as purely test coverage goes, they are all executed several times over
in 't6120-describe.sh'.  However, they don't directly influence the
command's output, because the repository used in that test script
contains several branches and tags pointing somewhere into the middle
of the commit DAG, and thus result in a better name for the
to-be-named commit.  This can hide bugs: e.g. by replacing the
'new_name' parameter of the first recursive name_rev() call with
'tip_name' (effectively making both branch #1 and #2 a noop) 'git
name-rev --all' shows thousands of bogus names in the Git repository,
but the whole test suite still passes successfully.  In an early
version of a later patch in this series I managed to mess up all three
branches (at once!), but the test suite still passed.

So add a new test case that operates on the following history:

  A--------------master
   \            /
    \----------M2
     \        /
      \---M1-C
       \ /
        B

and names the commit 'B' to make sure that all three branches are
crucial to determine 'B's name:

  - There is only a single ref, so all names are based on 'master',
    without any undesired interference from other refs.

  - Each time name_rev() follows the second parent of a merge commit,
    it appends "^2" to the name.  Following 'master's second parent
    right at the start ensures that all commits on the ancestry path
    from 'master' to 'B' have a different base name from the original
    'tip_name' of the very first name_rev() invocation.  Currently,
    while name_rev() is recursive, it doesn't matter, but it will be
    necessary to properly cover all three branches after the recursion
    is eliminated later in this series.

  - Following 'M2's second parent makes sure that branch #2 (i.e. when
    'generation = 0') affects 'B's name.

  - Following the only parent of the non-merge commit 'C' ensures that
    branch #3 affects 'B's name, and that it increments 'generation'.

  - Coming from 'C' 'generation' is 1, thus following 'M1's second
    parent makes sure that branch #1 affects 'B's name.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index a2988fa0c2..0d119e9652 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -438,4 +438,45 @@ test_expect_success 'name-rev a rev shortly after epoch' '
 	test_cmp expect actual
 '
 
+# A--------------master
+#  \            /
+#   \----------M2
+#    \        /
+#     \---M1-C
+#      \ /
+#       B
+test_expect_success 'name-rev covers all conditions while looking at parents' '
+	git init repo &&
+	(
+		cd repo &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		A=$(git rev-parse HEAD) &&
+
+		git checkout --detach &&
+		echo B >file &&
+		git commit -m B file &&
+		B=$(git rev-parse HEAD) &&
+
+		git checkout $A &&
+		git merge --no-ff $B &&  # M1
+
+		echo C >file &&
+		git commit -m C file &&
+
+		git checkout $A &&
+		git merge --no-ff HEAD@{1} && # M2
+
+		git checkout master &&
+		git merge --no-ff HEAD@{1} &&
+
+		echo "$B master^2^2~1^2" >expect &&
+		git name-rev $B >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.24.0.801.g241c134b8d

