Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DEB20966
	for <e@80x24.org>; Fri,  7 Apr 2017 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbdDGRXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 13:23:16 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35785 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934532AbdDGRXM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 13:23:12 -0400
Received: by mail-pg0-f50.google.com with SMTP id 81so72445041pgh.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgZDJIjOSRmoKnO70z0IW4oQYZ8yR7tV9ttXxm2rHwE=;
        b=vn3/UmfV67izRCqOiRT9QnD0HCP2U/cS34Q5KPfDvVa6AeKOL8TQOtU7H28NuynQNC
         yBHmTMJI7AnW5KirCAf3Pt9pX1W1Dk83I/5ZTbF6GSs4HhuO9NYbqAFt1gefMLlp5xVH
         IdvrXw3D8zUxvpgLs/H/883nqBsrt9QEx9VztnZsRSoMZA0tDSRQptRtIY5qKccdF04M
         mN4rkz610Rw73XpulnOLFyyxh+ZtIw1dltzjeg4LvSes6uFAF4wgFYRmvqdde6e96jBT
         AFylbVUQymt1PMdUZMlwrn1orM+jd8z/FEnQkOq6h7wpxsqQjGbKXT8bKW9mj6I6bVQn
         M/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zgZDJIjOSRmoKnO70z0IW4oQYZ8yR7tV9ttXxm2rHwE=;
        b=BVRvy1tfHvNciYb5h+I7ZHf+VQJqo0tJurldZ2u9x4tcsk3SJ71nyb8afmJk9+qcOa
         OcUfZO4xN3niEd2uovrAiPC3HzeJhIvQSXMQ/dzAbK106eDy6yDsxiH3WqrWea7RLAfJ
         HxqqSe0xp32DZVCnehxfp0FfNaGTdNDV0bmJLxYR5F91eh3hDNsWMYGWAIe/+zLzjzwd
         oI/NF2QdhqAmOiC01g4vyce3vhswskccZjuuIqtHcT12HVSLeXiW8Fl5JaK0f2Tp/3Ky
         UlBUOWG0LZpzmVnrF//g160ahbp9YUCIaJK85zUO3/wu3f1Rip8cDbshPMRgPqbWukFS
         K5EQ==
X-Gm-Message-State: AFeK/H1XootSYSNCynwsGO6INQF0GVskOkmT3bo53IGqawP2gZaM/Nt8vQZr1IT0MiF2geq2
X-Received: by 10.98.105.134 with SMTP id e128mr41055078pfc.19.1491585790621;
        Fri, 07 Apr 2017 10:23:10 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id s17sm10769447pgo.27.2017.04.07.10.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 10:23:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, jo@durchholz.org
Subject: [PATCH] submodule: prevent backslash expantion in submodule names
Date:   Fri,  7 Apr 2017 10:23:06 -0700
Message-Id: <20170407172306.172673-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
References: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to add a submodule with backslashes in its name 'git
submodule' fails in a funny way.  We can see that some of the
backslashes are expanded resulting in a bogus path:

git -C main submodule add ../sub\\with\\backslash
fatal: repository '/tmp/test/sub\witackslash' does not exist
fatal: clone of '/tmp/test/sub\witackslash' into submodule path

To solve this, convert calls to 'read' to 'read -r' in git-submodule.sh
in order to prevent backslash expantion in submodule names.

Reported-by: Joachim Durchholz <jo@durchholz.org>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh           | 14 +++++++-------
 t/t7400-submodule-basic.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6ec35e5fc..c0d0e9a4c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -332,7 +332,7 @@ cmd_foreach()
 		git submodule--helper list --prefix "$wt_prefix" ||
 		echo "#unmatched" $?
 	} |
-	while read mode sha1 stage sm_path
+	while read -r mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
 		if test -e "$sm_path"/.git
@@ -441,7 +441,7 @@ cmd_deinit()
 		git submodule--helper list --prefix "$wt_prefix" "$@" ||
 		echo "#unmatched" $?
 	} |
-	while read mode sha1 stage sm_path
+	while read -r mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
@@ -605,7 +605,7 @@ cmd_update()
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-	while read mode sha1 stage just_cloned sm_path
+	while read -r mode sha1 stage just_cloned sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
 
@@ -847,7 +847,7 @@ cmd_summary() {
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
-		while read mod_src mod_dst sha1_src sha1_dst status sm_path
+		while read -r mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
 			if test "$status" = D || test "$status" = T
@@ -873,7 +873,7 @@ cmd_summary() {
 	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
 	sane_egrep '^:([0-7]* )?160000' |
 	cut -c2- |
-	while read mod_src mod_dst sha1_src sha1_dst status name
+	while read -r mod_src mod_dst sha1_src sha1_dst status name
 	do
 		if test -z "$cached" &&
 			test $sha1_dst = 0000000000000000000000000000000000000000
@@ -1020,7 +1020,7 @@ cmd_status()
 		git submodule--helper list --prefix "$wt_prefix" "$@" ||
 		echo "#unmatched" $?
 	} |
-	while read mode sha1 stage sm_path
+	while read -r mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
@@ -1100,7 +1100,7 @@ cmd_sync()
 		git submodule--helper list --prefix "$wt_prefix" "$@" ||
 		echo "#unmatched" $?
 	} |
-	while read mode sha1 stage sm_path
+	while read -r mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cf77a3a35..c2706fe47 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -273,6 +273,20 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'submodule add with \\ in path' '
+	test_when_finished "rm -rf parent sub\\with\\backslash" &&
+
+	# Initialize a repo with a backslash in its name
+	git init sub\\with\\backslash &&
+	touch sub\\with\\backslash/empty.file &&
+	git -C sub\\with\\backslash add empty.file &&
+	git -C sub\\with\\backslash commit -m "Added empty.file" &&
+
+	# Add that repository as a submodule
+	git init parent &&
+	git -C parent submodule add ../sub\\with\\backslash
+'
+
 test_expect_success 'submodule add in subdirectory' '
 	echo "refs/heads/master" >expect &&
 	>empty &&
-- 
2.12.2.715.g7642488e1d-goog

