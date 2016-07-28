Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2761F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbcG1R04 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:26:56 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34904 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161025AbcG1R0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:26:54 -0400
Received: by mail-pf0-f180.google.com with SMTP id x72so24003056pfd.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 10:26:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96+xjCk/YXfHqBwh7oK3mxCjl45sA9DlMXSA7YbTWD8=;
        b=aCmRNWBSbh69sqr+pUoWeYVfptScUwwaj7HBrDqnDxSPU+CMcawyfN6fns2WswDkA4
         NPXjNcSx59PQmMTswnmOFqhXPIuDpT5JUlwLVJLkWxbkarD1xCR33vBUuVUt/uMgcTA6
         bsVorMgDiibUKhHf2UDP0rKBU3WZH6K1Rgs3EZi/13ffKfzEgu0x1tKmjgNv5ds0V3rd
         tV39ZhvuLvdMBpukoGc2b4DgYmPSgiPY3w5TlTZZdlWr1mfYB11bpO3qs+OLVTPgqwkA
         S23f+9EOmzascexpPLS11XFdc0TDTHOEoXdUeibIppSJUOpDJPA+RRWAw5sPgEm3iU9R
         jE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96+xjCk/YXfHqBwh7oK3mxCjl45sA9DlMXSA7YbTWD8=;
        b=GFNhi43L7tTexZ7bZ2fKYyOt9Y6UwrxfQ1gTne65NY+Kx/m0KqjpNOF5QLR8vDs3zX
         qa+Aly4kZxtjYCSbvLhDd5Ue7tFzEjHt1NKfVnsona4fFmmU3rp+4+DzxLyFuczmS2hc
         bo/Iupzox9kVyXyzgf16Ektx+SHU2P9ktYLZmM0Puj5r8LwXwnr2sAcwU+qWiG1CdEVr
         6/tPkbdyvmEfHzerDrgiqUlseti4bK1AxVwf6V3B1n9CDYHKRu9rANwxUkGnagBsajby
         XH0mW06xHPxFOKriHudiRUiKoZWq0SedvIT2HKgQ7q4ABK5B8mpcxP11+ELuJKBVLAx8
         IXIg==
X-Gm-Message-State: AEkoouvu5d5dzfHwV9q5oxektfmJ30i5NcI1AwI/AkVC1yeZjtT1MESyZhV14QJWIW0L+upq
X-Received: by 10.98.36.134 with SMTP id k6mr60434527pfk.116.1469726812334;
        Thu, 28 Jul 2016 10:26:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id j21sm18563842pfj.75.2016.07.28.10.26.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 10:26:51 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 2/2] submodule update: allow '.' for branch value
Date:	Thu, 28 Jul 2016 10:26:41 -0700
Message-Id: <20160728172641.8376-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.466.g8c6d1f9.dirty
In-Reply-To: <20160728172641.8376-1-sbeller@google.com>
References: <20160728172641.8376-1-sbeller@google.com>
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
 git-submodule.sh            |  7 +++++++
 t/t7406-submodule-update.sh | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4ec7546..12bb9e8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -591,6 +591,13 @@ cmd_update()
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
+		if test "$branch" = "."
+		then
+			if ! branch=$(git symbolic-ref --short -q HEAD)
+			then
+				die "$(eval_gettext "submodule branch configured to inherit branch from superproject, but it's not on any branch")"
+			fi
+		fi
 		if ! test -z "$update"
 		then
 			update_module=$update
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index bd261ac..41d69e4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -209,9 +209,39 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
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
 	 git checkout -b test-branch &&
+	 test_commit on-test-branch
+	) &&
+	(cd super &&
+	 git submodule update --remote --force submodule &&
+	 (cd submodule &&
+	  test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline master)"
+	 ) &&
+	 git checkout -b test-branch &&
+	 git submodule update --remote --force submodule &&
+	 (cd submodule &&
+	  test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline test-branch)"
+	 ) &&
+	 git checkout master &&
+	 git branch -d test-branch &&
+	 git revert HEAD
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
2.9.2.466.g8c6d1f9.dirty

