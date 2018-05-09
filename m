Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2091F424
	for <e@80x24.org>; Wed,  9 May 2018 00:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeEIAaG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:30:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37915 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeEIAaC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 20:30:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id c11-v6so3206790plr.5
        for <git@vger.kernel.org>; Tue, 08 May 2018 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EYI4DowIBKLrsXo1WHAEhFYlUr9q3K81tl7PcudQfjo=;
        b=i6pA0kwglUu2cHQ4yd66I65r8B/ivr74jTpkaqyaYu41GliciPLgvpLu5BW2LtA173
         tO6tJzGgCpRcIIzjnMECDmalQ+MAj5k2wnxyO233dw+c3n0FjKY8yL7UwXX3s+hzypyD
         Ko/6GuJmHJUzK1sWLWfYtGvsJN1397INtQUmXObWUVqhYE6WixiMe2zEdNLgNdpdw/Mu
         6frhJ3ojUyscqFBkLTBMYaG8BrWgPJw4wCOao85IuZ+Y/K7qdRih7qGpCBjKLXUrIGLW
         JXNEKCNGVdtGscpmBRtgWF+Vd2puc8Gn/X4DAAUaquX3eWxFMV3zfP7V6yU8/89SGCbu
         /Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EYI4DowIBKLrsXo1WHAEhFYlUr9q3K81tl7PcudQfjo=;
        b=j6lTFE73u68pjFzLSDT5VW4PCxx28gcTuME9P5SjPDi+Z/Xyq2iTLgQ4G/ZAuSbP7+
         Fih0xlIW0cxJNS4IUf+/Wjru2VYDXEGHVQjUWf88EP+3aQXQQQkU6GVfsoJmwIXOMkY2
         V0qNg1iFJlcJUeeCy2Koca0UWioGYV66rt/94xJCHdfjoREWgC1MOOPxnNuS7eYp+4Jq
         TsrJY6rRj0/mxEb3+Y+lFL8jqDjZqetNNk7N2+RM1QEWtYWVVDL5Bju6hnAKfAewb/N9
         pFL9fsg7wsnOBgMyouA+nvfYGt7JiGo/TWY3JMLmm9iacx8Q9RkvV+aKXcvC+bIw0r8C
         sVkA==
X-Gm-Message-State: ALQs6tC3IqfaIbKmH4zS5ush/Q3qDuCXecLXa+rxXanETttGkCHGfFSa
        SjN+BjIohYym6F9l/FZxhqnbbg==
X-Google-Smtp-Source: AB8JxZqzN95A82VwlDTLjZTQjfTljXQmu9Xt1YSglVDAMm409hIe+WSWPysZCSf52vVtkM/RUPIBCQ==
X-Received: by 2002:a17:902:b949:: with SMTP id h9-v6mr42941445pls.146.1525825802067;
        Tue, 08 May 2018 17:30:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v16sm49271899pfl.12.2018.05.08.17.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 17:30:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, pc44800@gmail.com
Subject: [PATCH 1/4] submodule foreach: correct '$path' in nested submodules from a subdirectory
Date:   Tue,  8 May 2018 17:29:49 -0700
Message-Id: <20180509002952.172347-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180509002952.172347-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
 <20180509002952.172347-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

When running 'git submodule foreach --recursive' from a subdirectory of
your repository, nested submodules get a bogus value for $path:
For a submodule 'sub' that contains a nested submodule 'nested',
running 'git -C dir submodule foreach echo $path' from the root of the
superproject would report path='../nested' for the nested submodule.
The first part '../' is derived from the logic computing the relative
path from $pwd to the root of the superproject. The second part is the
submodule path inside the submodule. This value is of little use and is
hard to document.

Also, in git-submodule.txt, $path is documented to be the "name of the
submodule directory relative to the superproject", but "the
superproject" is ambiguous.

To resolve both these issues, we could:
(a) Change "the superproject" to "its immediate superproject", so
    $path would be "nested" instead of "../nested".
(b) Change "the superproject" to "the superproject the original
    command was run from", so $path would be "sub/nested" instead of
    "../nested".
(c) Change "the superproject" to "the directory the original command
    was run from", so $path would be "../sub/nested" instead of
    "../nested".

The behavior for (c) was attempted to be introduced in 091a6eb0fe
(submodule: drop the top-level requirement, 2013-06-16) with the intent
for $path to be relative from $pwd to the submodule worktree, but that
did not work for nested submodules, as the intermittent submodules
were not included in the path.

If we were to fix the meaning of the $path using (a), we would break
any existing submodule user that runs foreach from non-root of the
superproject as the non-nested submodule '../sub' would change its
path to 'sub'.

If we were to fix the meaning of $path using (b), then we would break
any user that uses nested submodules (even from the root directory)
as the 'nested' would become 'sub/nested'.

If we were to fix the meaning of $path using (c), then we would break
the same users as in (b) as 'nested' would become 'sub/nested' from
the root directory of the superproject.

All groups can be found in the wild.  The author has no data if one group
outweighs the other by large margin, and offending each one seems equally
bad at first.  However in the authors imagination it is better to go with
(a) as running from a sub directory sounds like it is carried out by a
human rather than by some automation task.  With a human on the keyboard
the feedback loop is short and the changed behavior can be adapted to
quickly unlike some automation that can break silently.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  1 -
 t/t7407-submodule-foreach.sh | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963ca2..331d71c908b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -345,7 +345,6 @@ cmd_foreach()
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42ee..5144cc6926b 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -82,9 +82,9 @@ test_expect_success 'test basic "submodule foreach" usage' '
 
 cat >expect <<EOF
 Entering '../sub1'
-$pwd/clone-foo1-../sub1-$sub1sha1
+$pwd/clone-foo1-sub1-$sub1sha1
 Entering '../sub3'
-$pwd/clone-foo3-../sub3-$sub3sha1
+$pwd/clone-foo3-sub3-$sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach" from subdirectory' '
@@ -196,6 +196,38 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	) &&
 	test_i18ncmp expect actual
 '
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+toplevel: $pwd/clone2 name: nested1 path: nested1 hash: $nested1sha1
+Entering '../nested1/nested2'
+toplevel: $pwd/clone2/nested1 name: nested2 path: nested2 hash: $nested2sha1
+Entering '../nested1/nested2/nested3'
+toplevel: $pwd/clone2/nested1/nested2 name: nested3 path: nested3 hash: $nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+toplevel: $pwd/clone2/nested1/nested2/nested3 name: submodule path: submodule hash: $submodulesha1
+Entering '../sub1'
+toplevel: $pwd/clone2 name: foo1 path: sub1 hash: $sub1sha1
+Entering '../sub2'
+toplevel: $pwd/clone2 name: foo2 path: sub2 hash: $sub2sha1
+Entering '../sub3'
+toplevel: $pwd/clone2 name: foo3 path: sub3 hash: $sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2/untracked &&
+		git submodule foreach --recursive "echo toplevel: \$toplevel name: \$name path: \$sm_path hash: \$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
 
 cat > expect <<EOF
 nested1-nested1
-- 
2.17.0.255.g8bfb7c0704

