Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3742E1FF40
	for <e@80x24.org>; Thu, 28 Jul 2016 18:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbcG1SVi (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 14:21:38 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35693 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbcG1SVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 14:21:37 -0400
Received: by mail-pf0-f169.google.com with SMTP id x72so24385963pfd.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 11:21:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vB2R2RKTOUXgeriGivZK/8sF1B1KWBmT+QlpuO/6IGY=;
        b=LBs7fr7MZIIEbNmYI7UkTu3tWzn1qfVogOd6GkAR25AbJEFmWOEYV5ybwqSFQYFp0s
         sD781lgeY7RzEoR+2aWs7sYWmCUJqZHVbPNpOB2ni5LgkODmp7TcNQ9YLqpS30qdpN29
         Wp/oMuoaFGSimBj/tFrBPKyxZZpNQxKJZ/8z110YzDeed2ff8vLpf9ryrkWVPWb4maq0
         XiYw15n3fWN5xSEitDe2nSYNrNhwWEbvyzyCrlPNuD0MW/OdcbPC2pU2V8uibyLCmb51
         ZZcBQHN+HkxHdct3NHJtotmyiCdRv4AkLqvYymFBqlK+qF1WZYgLWWoqZ/XMTvXxVS0D
         IZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vB2R2RKTOUXgeriGivZK/8sF1B1KWBmT+QlpuO/6IGY=;
        b=NrSHXwWUrcc4gHH7atBLpGJmhY7HJTUqTt7XrOZEzXqkplIUsTP23KddpWCE84Ns+q
         wBRbd3UDF4xcnZ/iyv6/EkfHGJQ+vAR+UeK1RPE8PyC66ViTAYzxpIuMzkZLJ+SBxxbY
         WKVa5l4JmDZf9J3VWDMNptWPBMi8Q40+RFGiEdLZ3k4pt5kTtdoah/qpkR5x63PvgwQK
         NcllP0ANGB7LFQIDlLWZkCgu3BcUsAK36CxaUdApsNbsmceIFyf38NgJpqyHzH49sVtT
         +1A6dj8JDqlZ3SHaV7y6jrZDlFWRgN8oHfjLYWTbo4SQbMyFgiUIjDbcYdq4AMq4yEfW
         bTRQ==
X-Gm-Message-State: AEkoouti4tC9gJQIWhuVQ6sujVEdg6iUR08q4fhfoINzqUv5BreN4eks58axHUrFSRn7f1Vv
X-Received: by 10.98.33.72 with SMTP id h69mr60956422pfh.28.1469730096031;
        Thu, 28 Jul 2016 11:21:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id x184sm18782098pfd.70.2016.07.28.11.21.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 11:21:35 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCHv2 2/2] submodule update: allow '.' for branch value
Date:	Thu, 28 Jul 2016 11:21:32 -0700
Message-Id: <20160728182132.25088-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.468.g3d9025b
In-Reply-To: <20160728172641.8376-3-sbeller@google.com>
References: <20160728172641.8376-3-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Gerrit has a "superproject subscription" feature[1], that triggers a
commit in a superproject that is subscribed to its submodules.
Conceptually this Gerrit feature can be done on the client side with
Git via:

    git -C <superproject> submodule update --remote --force
    git -C <superproject> commit -a -m "Update submodules"
    git -C <superproject> push

for each branch in the superproject. To ease the configuration in Gerrit
a special value of "." has been introduced for the submodule.<name>.branch
to mean the same branch as the superproject[2], such that you can create a
new branch on both superproject and the submodule and this feature
continues to work on that new branch.

Now we have find projects in the wild with such a .gitmodules file.
To have Git working well with these, we imitate the behavior and
look up the superprojects branch name if the submodules branch is
configured to ".". In projects that do not use Gerrit, this value
whould be never configured as "." is not a valid branch name.

[1] introduced around 2012-01, e.g.
    https://gerrit-review.googlesource.com/#/c/30810/
[2] excerpt from [1]:
 > The branch value could be '.' if the submodule project branch
 > has the same name as the destination branch of the commit having
 > gitlinks/.gitmodules file.

CC: Avery Pennarun <apenwarr@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This comes with another test that I run into while using this code.
 Please replace patch 2 with this v2.
 
 Thanks,
 Stefan

 git-submodule.sh            |  9 ++++++++-
 t/t7406-submodule-update.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4ec7546..1eb33ad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -590,7 +590,6 @@ cmd_update()
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
 		then
 			update_module=$update
@@ -616,6 +615,14 @@ cmd_update()
 
 		if test -n "$remote"
 		then
+			branch=$(get_submodule_config "$name" branch master)
+			if test "$branch" = "."
+			then
+				if ! branch=$(git symbolic-ref --short -q HEAD)
+				then
+					die "$(eval_gettext "submodule branch configured to inherit branch from superproject, but it's not on any branch")"
+				fi
+			fi
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index bd261ac..953c486 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -209,9 +209,49 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	)
 '
 
-test_expect_success 'local config should override .gitmodules branch' '
+test_expect_success 'submodule update --remote should fetch upstream changes with .' '
+	(cd super &&
+	 git config -f .gitmodules submodule."submodule".branch "." &&
+	 git add .gitmodules &&
+	 git commit -m "submodules: update from the respective superproject branch"
+	) &&
 	(cd submodule &&
+	 echo line4a >> file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m "upstream line4a" &&
+	 git checkout -b test-branch &&
+	 test_commit on-test-branch
+	) &&
+	(cd super &&
+	 git submodule update --remote --force submodule &&
+	 (cd submodule &&
+	  test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline master)"
+	 ) &&
 	 git checkout -b test-branch &&
+	 git submodule update --remote --force submodule &&
+	 (cd submodule &&
+	  test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline test-branch)"
+	 ) &&
+	 git checkout master &&
+	 git branch -d test-branch
+	)
+'
+
+test_expect_success 'branch = . does not confuse the rest of update' '
+	(cd super &&
+	 git checkout --detach &&
+	 # update is not confused by branch="." even if the the superproject
+	 # is not on any branch currently
+	 git submodule update &&
+	 git revert HEAD &&
+	 git checkout master
+	)
+'
+
+test_expect_success 'local config should override .gitmodules branch' '
+	(cd submodule &&
+	 git checkout test-branch &&
 	 echo line5 >> file &&
 	 git add file &&
 	 test_tick &&
-- 
2.9.2.468.g3d9025b

