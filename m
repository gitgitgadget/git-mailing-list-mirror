Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C641F404
	for <e@80x24.org>; Wed,  5 Sep 2018 22:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIFDU4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 23:20:56 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:55889 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeIFDU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 23:20:56 -0400
Received: by mail-yw1-f74.google.com with SMTP id j71-v6so6064488ywb.22
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eozGZbTOcLszAS8WUto0HzcoOzwL6x06v+hcVZJWQ30=;
        b=LbCSq8XgFb4V5/T5GbhSBiIXHDZewvoRBUZExOt4S0HrkL9bSIMpuJfLOPB9RcYgYR
         i0EOmviR20CJhARJDUnXvUi1ZJSe1Tj8OdFYHJg/MNy1cIKZnez9p0CirHEbz8guZbCG
         IHlgeLsJ8dBHQup+VkoNldcNtqPxpHuOyIpSYjNHxUUJQ2FfUYmPkU6mkSolXWstOo96
         yVvWP0VNjZTZqE286F6JpsK3r17XHUzq/0thkPFLUGfgPbdRGwnzt34TN5ARcynbtKIb
         iDqOuZLFfuCAsTunUC/6hVB8gr/BgIDV6vXFcRMoCfHACyTHFxZTGbBuLrrot2XBx9tc
         yRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eozGZbTOcLszAS8WUto0HzcoOzwL6x06v+hcVZJWQ30=;
        b=TW2xjPf6DnVFtzpUf/iqTsgBg5y4hn2PyXBiegJLZC+u4M6dLUz9PzPlRKaNfQrTis
         8IFhM41JxvXeO3p54eY+Ssj2t1mQDerUHRuSRODg3yge3t9KsZTvSMBvSMGL6H4k353I
         iyg6bR3sIgNgJ+Tb9M+eGwMoEsLpR8WD6Y44FCOeCwT+/blMsAKThHGBnLCyalOceGZb
         mPHJ0G5wJEHtafmHAizXr5AUmROmWOSbAYwmJa5IZ10riknIhWORhLlGMw4bt6HVl2V/
         DKj88mZVvmGXvFJs5Ke44kbeHm+zDd5thWj9eh/OF90t7zcAEM6JhxB5iKLuLD7e8USW
         XPmA==
X-Gm-Message-State: APzg51DX1uIOXnlbyWVfR3RATEw7qjCo+bE/azQEK31QUPbaGT/rlW/A
        AKeot5ZvQAR8Loh8QpPSuDi8n8tAUtWOK/LU0wzMQJwoBI20lmc9YR3HKNQZHp6jVQMPVExXUxn
        c4Zj6J3fExfjuw6LgwGdUM3PKuQsZSBlMbw/EePdOax0LR4Lwac64UyAgHfri
X-Google-Smtp-Source: ANB0VdbMVzHgaF5Ic92FKKzTasZCv1waVwBmliSxSKKVJyhu5rtT6G0ru4SiC1dHszhVfysRGne4aL5OGP34
X-Received: by 2002:a81:e801:: with SMTP id a1-v6mr10299622ywm.71.1536187714704;
 Wed, 05 Sep 2018 15:48:34 -0700 (PDT)
Date:   Wed,  5 Sep 2018 15:48:25 -0700
Message-Id: <20180905224825.13564-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] submodule.sh update --remote: default to oid instead of master
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitmodules(5) sayeth:

   submodule.<name>.branch
       A remote branch name for tracking updates in the upstream
       submodule. If the option is not specified, it defaults to master.

This doesn't allow having a "pinned" submodule that should not be updated
from upstream. We should change this to have no default --- if branch is
not specified, don't update that submodule, just like in Gerrit's
corresponding feature[1].

[1] https://gerrit-review.googlesource.com/Documentation/user-submodules.html#_defining_the_submodule_branch

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitmodules.txt | 11 ++++++-----
 git-submodule.sh             | 19 +++++++++++--------
 t/t7406-submodule-update.sh  | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4d63def2069..3b8739f8294 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -50,11 +50,12 @@ submodule.<name>.update::
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-	If the option is not specified, it defaults to 'master'.  A special
-	value of `.` is used to indicate that the name of the branch in the
-	submodule should be the same name as the current branch in the
-	current repository.  See the `--remote` documentation in
-	linkgit:git-submodule[1] for details.
+	A special value of `.` is used to indicate that the name of the
+	branch in the submodule should be the same name as the current
+	branch in the current repository.  See the `--remote` documentation
+	in linkgit:git-submodule[1] for details.
+	If the option is not specified, do not update to any branch but
+	the object id of the remote.
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
diff --git a/git-submodule.sh b/git-submodule.sh
index f7fd80345cd..342050ae934 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -568,16 +568,19 @@ cmd_update()
 		if test -n "$remote"
 		then
 			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
+			if test -n "$branch"
 			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				if test -z "$nofetch"
+				then
+					# Fetch remote before determining tracking $sha1
+					fetch_in_submodule "$sm_path" $depth ||
+					die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				fi
+				remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
+				sha1=$(sanitize_submodule_env; cd "$sm_path" &&
+					git rev-parse --verify "${remote_name}/${branch}") ||
+				die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
 		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 10dc91620a6..f04884743fd 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -260,6 +260,28 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
 	)
 '
 
+test_expect_success 'submodule update --remote should not fetch upstream when no branch is set' '
+	(
+		cd super &&
+		test_might_fail git config --unset -f .gitmodules submodule."submodule".branch &&
+		git add .gitmodules &&
+		git commit --allow-empty -m "submodules: pin in superproject branch"
+	) &&
+	(
+		cd submodule &&
+		echo line4b >>file &&
+		git add file &&
+		test_tick &&
+		git commit -m "upstream line4b"
+	) &&
+	(
+		cd super &&
+		git submodule update --remote --force submodule &&
+		git -C submodule log -1 --oneline >actual &&
+		! grep line4b actual
+	)
+'
+
 test_expect_success 'local config should override .gitmodules branch' '
 	(cd submodule &&
 	 git checkout test-branch &&
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

