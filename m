Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F8120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 23:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLKXto (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 18:49:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38549 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLKXtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 18:49:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so18592801qtl.5
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 15:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fl//SosWD9V3LGcQpdy9Q7CqmvlVv+Wc6+3GcdJQII0=;
        b=WputaopfU/A242uDFwRb5jrmBmh42V3ivabkta4tBDag47tzdMW7wqfu6sxzz8REqh
         RgPYfwe+Si2td8oebH33Myh3Qj+sluQIExMzx+uZlfwvAkd1Qf8drKKkfcbyX20XqLXO
         gkpttcOpp+m66mUEKAv56lAQYKT2VYC9SAci+T/6Y6ITUUNYEr/dFX0bN3yf8wDbnO6j
         V1on0if1KdvhxrlUgX1SbpPwd6DpMxEJVEZlf67layDY1TXMMmpuV4skS6lKk0dQiphN
         4gN3dqUudPcZusaZhOflkKqqc5SBcnrFwfIBkSuRq3Re2WQTd2I2vjIGcagE4BwIqkfW
         QnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=fl//SosWD9V3LGcQpdy9Q7CqmvlVv+Wc6+3GcdJQII0=;
        b=Cz8CTtEFf0bbYwcDavAhi6QdfA0qOP89t1CxOJugOkf5ugvohGLrFkDrpm6VYIsqUL
         /k/dPrtAv7PsLLxANl5GpQ/SrtUAo80Jb7jnZMQBxGAT+OB1FmD/wpy+QtIf3jk5jycJ
         oHKgmHbz2coIO09BOz8x6K/zPfJCFur21MeLwKiKr4R69R0ALlnm8l8ARrVs7/0l13pl
         lJchiOKJsGHaDrC+h12M6GQUGgD3mcoqlEey7CQzHXDXTgi+Cke+uczaxTQT8kzH9S++
         AkIHdw4VpDjoIexxiAe7LM9Bhi2LRkeccwp77nPryC43CatHRXFT93ZoGerKAwu8zZR7
         L9lw==
X-Gm-Message-State: AA+aEWYWpyjsygNt/qNY86l5bCDFjTX5FbcsEnIOki4cUMvfnLZAiSVY
        CeAsod0rFzqb8WGya+o4ySVVgMl4
X-Google-Smtp-Source: AFSGD/UQQmE06BDa/9xhotryBpvbA37QqCxlsai+0QsUba68tUsITEdmEIXW3vPM4wjOIuQqzKzF9A==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr17494333qvr.115.1544572181329;
        Tue, 11 Dec 2018 15:49:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:fd8f])
        by smtp.gmail.com with ESMTPSA id o21sm10759544qto.18.2018.12.11.15.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:49:40 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com, Tejun Heo <htejun@fb.com>
Subject: [PATCH 5/5] notes: Implement xref-cherry-picks hooks and tests
Date:   Tue, 11 Dec 2018 15:49:09 -0800
Message-Id: <20181211234909.2855638-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211234909.2855638-1-tj@kernel.org>
References: <20181211234909.2855638-1-tj@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tejun Heo <htejun@fb.com>

Add post-cherry-pick.sample and post-fetch.sample which, when enabled,
will keep refs/notes/xref-cherry-picks up-to-date as new cherry-picks
are created and fetched.  Also, add tests to verify xref-cherry-picks.

Signed-off-by: Tejun Heo <htejun@fb.com>
---
 Documentation/git-reverse-trailer-xrefs.txt |   9 ++
 t/t3321-notes-xref-cherry-picks.sh          | 124 ++++++++++++++++++++
 templates/hooks--post-cherry-pick.sample    |   8 ++
 templates/hooks--post-fetch.sample          |  30 +++++
 4 files changed, 171 insertions(+)
 create mode 100644 t/t3321-notes-xref-cherry-picks.sh
 create mode 100644 templates/hooks--post-cherry-pick.sample
 create mode 100644 templates/hooks--post-fetch.sample

diff --git a/Documentation/git-reverse-trailer-xrefs.txt b/Documentation/git-reverse-trailer-xrefs.txt
index 20d260486..651ecdce1 100644
--- a/Documentation/git-reverse-trailer-xrefs.txt
+++ b/Documentation/git-reverse-trailer-xrefs.txt
@@ -131,6 +131,15 @@ ddd1bf2 commit A
 ------------
 
 
+Keeping xref-cherry-picks up-to-date
+------------------------------------
+
+Reverse-maps can be kept-up incrementally with hooks. For example, to
+keep xref-cherry-picks up-to-date, `git-reverse-trailer-xrefs` should
+be invoked on new cherry-picks and fetched commits. See
+`hooks/post-cherry-pick.sample` and `hooks/post-fetch.sample`.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/t/t3321-notes-xref-cherry-picks.sh b/t/t3321-notes-xref-cherry-picks.sh
new file mode 100644
index 000000000..96b6731c9
--- /dev/null
+++ b/t/t3321-notes-xref-cherry-picks.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='Verify xref-cherry-picks handling
+
+Assume the following git repository.
+
+	  D*---E** release-B
+	 /
+	C*      E* release-D
+       /       /
+  A---B---C---D---E master
+
+which contains the following cherry-picks.
+
+  C -> C*
+  D -> D*
+  E -> E* -> E**
+
+1. Build the above repository using `git-cherry-pick -x` with the
+   sample post-cherry-pick hook enabled.  Verify that the
+   xref-cherry-picks notes are populated correctly.
+
+2. Clear the notes and rebuild them by directly running
+   git-reverse-xref-trailers and verify the output.
+
+3. Run it again and check the output still agrees to verify duplicate
+   handling.
+
+4. Build a cloned repository using per-branch fetches with the sample
+   post-fetch hook enabled. Verify that the xref-cherry-picks notes
+   are populatec correctly.
+'
+
+TEST_NO_CREATE_REPO=1
+
+. ./test-lib.sh
+
+GIT_AUTHOR_EMAIL=bogus_email_address
+export GIT_AUTHOR_EMAIL
+
+test_expect_success \
+    'Build repo with cherry-picks and verify xref-cherry-picks' \
+    'test_create_repo main &&
+     cd main &&
+     mkdir -p .git/hooks &&
+     mv .git/hooks-disabled/post-cherry-pick.sample .git/hooks/post-cherry-pick &&
+
+     test_tick &&
+     echo A >> testfile &&
+     git update-index --add testfile &&
+     git commit -am "A" &&
+     echo B >> testfile &&
+     git commit -am "B" &&
+     echo C >> testfile &&
+     git commit -am "C" &&
+     echo D >> testfile &&
+     git commit -am "D" &&
+     echo E >> testfile &&
+     git commit -am "E" &&
+
+     test_tick &&
+     git checkout -b release-D master^ &&
+     git cherry-pick -x master &&
+
+     test_tick &&
+     git checkout -b release-B master^^^ &&
+     git cherry-pick -x release-D^^ &&
+     git cherry-pick -x release-D^ &&
+     git cherry-pick -x release-D &&
+
+     cat > expect <<-EOF &&
+master E
+Notes (xref-cherry-picks):
+    Cherry-picked-to: release-D
+    Cherry-picked-to:   release-B
+
+master~1 D
+Notes (xref-cherry-picks):
+    Cherry-picked-to: release-B~1
+
+master~2 C
+Notes (xref-cherry-picks):
+    Cherry-picked-to: release-B~2
+
+master~3 B
+master~4 A
+EOF
+
+     git log --pretty=oneline --notes=xref-cherry-picks master | git name-rev --name-only --stdin > actual &&
+     test_cmp expect actual
+'
+
+test_expect_success \
+    'Clear, rebuild and verify xref-cherry-picks' \
+    'git reverse-trailer-xrefs --xref-cherry-picks --all --clear &&
+     git reverse-trailer-xrefs --xref-cherry-picks --all &&
+     git log --pretty=oneline --notes=xref-cherry-picks master | git name-rev --name-only --stdin > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success \
+    'Build it again to verify duplicate handling' \
+    'git reverse-trailer-xrefs --xref-cherry-picks --all &&
+     git log --pretty=oneline --notes=xref-cherry-picks master | git name-rev --name-only --stdin > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success \
+    'Build a clone through per-branch fetches and verify xref-cherry-picks' \
+    'cd .. &&
+     test_create_repo clone &&
+     cd clone &&
+     mkdir -p .git/hooks &&
+     mv .git/hooks-disabled/post-fetch.sample .git/hooks/post-fetch &&
+
+     git fetch -fu ../main master:master &&
+     git fetch -fu ../main release-D:release-D &&
+     git fetch -fu ../main release-B:release-B &&
+
+     git log --pretty=oneline --notes=xref-cherry-picks master | git name-rev --name-only --stdin > actual &&
+    test_cmp ../main/expect actual
+'
+
+test_done
diff --git a/templates/hooks--post-cherry-pick.sample b/templates/hooks--post-cherry-pick.sample
new file mode 100644
index 000000000..3af8b5d23
--- /dev/null
+++ b/templates/hooks--post-cherry-pick.sample
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# An example hook script to reverse map new cherry-picks. See
+# git-reverse-trailer-xrefs(1) for details.
+#
+# To enable this hook, rename this file to "post-cherry-pick".
+
+git reverse-trailer-xrefs --xref-cherry-picks $1..$2
diff --git a/templates/hooks--post-fetch.sample b/templates/hooks--post-fetch.sample
new file mode 100644
index 000000000..6b98a5c10
--- /dev/null
+++ b/templates/hooks--post-fetch.sample
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# An example hook script to reverse map cherry-picks in newly fetched
+# commits. See git-reverse-trailer-xrefs(1) for details.
+#
+# To enable this hook, rename this file to "post-fetch".
+
+z40=0000000000000000000000000000000000000000
+
+while read ref old_sha remote new_sha
+do
+    case $ref in
+    refs/heads/*)
+	;;
+    *)
+	continue
+    esac
+
+    if [ $new_sha == $z40 ]
+    then
+	continue
+    fi
+
+    if [ $old_sha != $z40 ]
+    then
+	git reverse-trailer-xrefs --xref-cherry-picks $old_sha..$new_sha
+    else
+	git reverse-trailer-xrefs --xref-cherry-picks $new_sha
+    fi
+done
-- 
2.17.1

