Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B76200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeECAyT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:54:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36422 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeECAyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:54:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id z129-v6so7685197pgz.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WPde5P0TNiZKXiX8P25mH442dw3JKTeDr8CKwtN3bMw=;
        b=GldsTXGQrpHlYeuS7/7Scuk4TbS/usqaOl8ekZaETiaBBYIg3TOVc4CO9RGm8te+QT
         0crF8a8geJYySOdhHbSl+MbK/d+9z27TUustkFzIKPJj6ZkWb2kAT2vcVXvAWZ0ndfEE
         1ejOZhr9W+f9G1dGmRy22EFi0Zz2AWqo9bfG24PP5KDILA/7mQFFyg7NTSEPd3II9e38
         yr25Sdz3/92GkBuWV4FzISiUOILc+u3UB8AetruqOKl5Zinw0TxlMye/ysmAEpQwcJnK
         ixbOAswh6yDmqJ/sxKPptPfZwoWi9X4HuIXrp8X8m+rRYLJWfs/G12f6+5rGt9zQXpUb
         GJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WPde5P0TNiZKXiX8P25mH442dw3JKTeDr8CKwtN3bMw=;
        b=MF2FVGQhKv7s4y04uk4UGUpUqR3wBlszmpg5AerKZnmC/1CEFKTBphJSom4KaKa6tL
         Vp3lDXo0HzuEoEufOvbYYE6dzKRymhw4XtPiG5QmFFEdZbU/4oEV3IhFXBr1VLWoAtcy
         DOqzhp5SPmPx96PYubzy/Daf7wUK4oUWvrGOUxFkw5wYQmQbdKDcan4lYM7v7nBbOhSh
         pw4USG6Ncsdbk8nOAT5XiCdYnHP7P9etp2pH2Muk7iv4crp6gQ2GswyZVMv4popgmv2I
         20tHpD9+Kd5rSB9HIwyVQCz0kFlFGKubbPEbGncsKGdAeU8yN1Vl/9xvF9IUICeX5N+g
         uC3g==
X-Gm-Message-State: ALQs6tCFxo9yDkNph5q2LDZkN/DBWsVQqBvbcYUrun1lhai2VpvC1Mr1
        pgIcAmkxr52VRDjvHcM67z6AqA==
X-Google-Smtp-Source: AB8JxZr27Z80l7sjvVocvrUY7ueJTjlHn0GKMnRU6UWClKC486Or6ubVd/OUtcM3tsGCZmeVHEUDkw==
X-Received: by 2002:a65:6553:: with SMTP id a19-v6mr431249pgw.3.1525308854790;
        Wed, 02 May 2018 17:54:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y24sm11085950pfn.23.2018.05.02.17.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 17:54:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] submodule foreach: correct '$path' in nested submodules from a subdirectory
Date:   Wed,  2 May 2018 17:53:54 -0700
Message-Id: <20180503005358.89082-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180503005358.89082-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
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

There are three different possible solutions that have more value:
(a) The path value is documented as the path from the toplevel of the
    superproject to the mount point of the submodule. If 'the' refers to
    the superproject holding this submodule ('sub' holding 'nested'),
    the path would be expected to be path='nested'.
(b) In case 'the' superproject is referring to the toplevel, which
    is the superproject in which the original command was invoked,
    then path is expected to be path='sub/nested'.
(c) The documentation explains $path as [...] "relative to the
    superproject", following 091a6eb0fe (submodule: drop the
    top-level requirement, 2013-06-16), such that the nested submodule
    would be expected as path='../sub/nested', when "the" superproject
    is the superproject, where the command was run from
(d) or the value of path='nested' is expected if we take the
    intermediate superproject into account. [This is the same as
    (a); it highlights that the documentation is not clear, but
    technically correct if we were to revert 091a6eb0fe.]

The behavior for (c) was introduced in 091a6eb0fe (submodule: drop the
top-level requirement, 2013-06-16) the intent for $path seemed to be
relative to $cwd to the submodule worktree, but that did not work for
nested submodules, as the intermittent submodules were not included in
the path.

If we were to fix the meaning of the $path using (a), (d) such that "path"
is "the path from the intermediate superproject to the mount point of the
submodule", we would break any existing submodule user that runs foreach
from non-root of the superproject as the non-nested submodule
'../sub' would change its path to 'sub'.

If we were to fix the meaning of $path using (b) such that "path"
is "the path from the topmost superproject to the mount point of the
submodule", then we would break any user that uses nested submodules
(even from the root directory) as the 'nested' would become 'sub/nested'.

If we were to fix the meaning of $path using (c) such that "path"
is "the display path from where the original command was invoked to the
submodule", then we would break users that rely on the assumption that
"$toplevel / $path" is the absolute path of the submodule.

All groups can be found in the wild.  The author has no data if one group
outweighs the other by large margin, and offending each one seems equally
bad at first.  However in the authors imagination it is better to go with
(a) as running from a sub directory sounds like it is carried out by a
human rather than by some automation task.  With a human on the keyboard
the feedback loop is short and the changed behavior can be adapted to
quickly unlike some automation that can break silently.

Another argument in favor of (a) is the consistency of the variables
provided, "$toplevel / $path" gives the absolute path of the submodule,
with 'toplevel' (both the variable as well as the documentation) referring
to the immediate superproject of the submodule.

Documentation of the variable is adjusted in a follow-up patch.

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
2.17.0.441.gb46fe60e1d-goog

