Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBD51F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKLKil (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKLKij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so2366639wmc.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxQJMVMvd806F3eiPo0ttLu51dBwa15NS2dBeMSGmZM=;
        b=dw6/noehkdl17KhdgLDWEMCKfOg0cihRYSPHg982CDGiL3Vm0+eB/TdIXqsYYal9J3
         eAEuN/I180Talyyr29lbjhnbRk2Rwb9BV8puHWWGEJJLrGQy7NiI2kaTxEuKP347n6bP
         E/ZLC+5I2DonMHN8bVkRYoWOF2fCtF/i5EXkvk/e0F1Kbs7M6Q91etF6qbbrE+sP4mZh
         2Pii0BEWwQ9S55FY06rPQknNb5lj8UZXg2LP7YSJVtYif/dmgy+UH4xBkNBA41Zb4se3
         9fg5etLoATAD2trwTabqmeJ8NoeGPncrNiV8W9xvatUEJ/vXE2iMko4V+BBEcB9xLzIL
         57kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxQJMVMvd806F3eiPo0ttLu51dBwa15NS2dBeMSGmZM=;
        b=OsuZ2xg3mC0nwLi+xED24aRbKnJ2algKpI7rQFdo7gV+Ahrw3lgqtmeZhexjyJQMc8
         NyjomuP138pi1dlr01ajzIhuhMX1odJZDiwKkZf4Tn7y0piH18cmdDtSotAOcR5LDoHc
         4RWDzvgg07452iDs3rf0U29uD9YHiXZ7r8yB9GJwjvX6YUkuS/afK/r8p9x2h3ALuujD
         xKVa5hi08MSxFQAXukTY44kcgwnuIGLVYn2cwTNKA22f+h9PwGz9Mpv1iZZOIRCWPVQc
         rIVA7jWbbcBmR138dPbm16zQT3cExHyUpveg3kzdd32adnQwd6s/2ZrEeXK88FblQIJw
         Dgiw==
X-Gm-Message-State: APjAAAWjXI4JbYzy6sibdUYtErEteZKg95DWvpP37wDK+Si7AirNqXX8
        cAXR8Zx1yzbmYX+/9+5gr5o=
X-Google-Smtp-Source: APXvYqw0gTyr5VLy5pOd5gAmBpqRCfZt3bKYcyPxfWxUucdl9IsDdwWZ6P9PiUjK+463MgAPtFot+Q==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr3118048wmi.107.1573555116548;
        Tue, 12 Nov 2019 02:38:36 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/13] t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
Date:   Tue, 12 Nov 2019 11:38:14 +0100
Message-Id: <20191112103821.30265-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
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
2.24.0.388.gde53c094ea

