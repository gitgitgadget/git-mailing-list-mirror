Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02F31F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbcG2Aob (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:31 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34087 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcG2Ao2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:28 -0400
Received: by mail-pf0-f177.google.com with SMTP id p64so26870025pfb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKLRsEQHGa8QxWUV7kBHWaj8RvYlgV+sVL1vONG99/Y=;
        b=SPJRmMYtnZN09xZpn6/wCtiqtccdsDkG0GPoc5R4D5o2EklWz20lKFJyeVWRVjYjk3
         jTgI2ysggrETe+NOw5mOiRZopO8Y6NELTtT76LNOIpkiUbsT2DPpQx1G95u9Ghba8USM
         2vAFdlQcONFqNtMgs4HWvUqG8tbswUYqhbpbdVJq+8F2Ux/e0SqTgnJHUuhG8Qi7fAqV
         +SHAjvm0FJANGB9VsVQELx1kiPwIkDpf9iGTGs7xI754kuBfzc/Xtwz4/4rtBvDQih4b
         nxrVbRz5RE6WEmHA7TxyMr2VT4AE07kV9EnkQ7dVZPt0z2VIqLES4j+NN0zsEuGb3C6G
         T/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKLRsEQHGa8QxWUV7kBHWaj8RvYlgV+sVL1vONG99/Y=;
        b=YaxSMlFMe5lYf/C6wnRAkIeTTkhOdIT/cyF4/fwdc1pr38O+ja5lUXDeX+4RGlU8gV
         m0i5Apd8E1JT4dySAk6kXlPpK8BL06F80ryzlwBEKnlbnn+uX6NIGp6v7dLzJnXf7XF7
         26MeU9lySLcwRaIgoV/IgPWodlSf0nMhbq9co36XKmL+GgOuW3snM9jVQhydI/L005kD
         L0DYyKDW+3CG+WhyvZz0QUxibRXIMTe7KD0C8owhfsUSXrfSauC5MzxlC1/QQgXdgqNg
         kFkhc0QBkQ8nEJNJYn2k9k4NRBVnuwS4aRbtTUZneUx0gF/cge7mX/bZolrRLJ1Gu/kJ
         wSnw==
X-Gm-Message-State: AEkoouvdDYhIACJhanE0RR6WnGtflJ+mVmfmwQjBiTwHm/xzcVFptKgCEgbeCQNnLv1DRkmg
X-Received: by 10.98.68.148 with SMTP id m20mr60207631pfi.0.1469753067983;
        Thu, 28 Jul 2016 17:44:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id t126sm19879590pfd.28.2016.07.28.17.44.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:27 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 7/7] submodule update: allow '.' for branch value
Date:	Thu, 28 Jul 2016 17:44:09 -0700
Message-Id: <20160729004409.2072-8-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Gerrit has a "superproject subscription" feature[1], that triggers a
commit in a superproject that is subscribed to its submodules.
Conceptually this Gerrit feature can be done on the client side with
Git via (except for raciness, error handling etc):

  while [ true ]; do
    git -C <superproject> submodule update --remote --force
    git -C <superproject> commit -a -m "Update submodules"
    git -C <superproject> push
  done

for each branch in the superproject. To ease the configuration in Gerrit
a special value of "." has been introduced for the submodule.<name>.branch
to mean the same branch as the superproject[2], such that you can create a
new branch on both superproject and the submodule and this feature
continues to work on that new branch.

Now we find projects in the wild with such a .gitmodules file.
The .gitmodules used in these Gerrit projects do not conform
to Gits understanding of how .gitmodules should look like.
This teaches Git to deal gracefully with this syntax as well.

The redefinition of "." does no harm to existing projects unaware of
this change, as "." is an invalid branch name in Git, so we do not
expect such projects to exist.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 18 ++++++++++++++++++
 t/t7406-submodule-update.sh | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 710048f..ae88eff 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -909,6 +909,24 @@ static const char *remote_submodule_branch(const char *path)
 	if (!sub->branch)
 		return "master";
 
+	if (!strcmp(sub->branch, ".")) {
+		unsigned char sha1[20];
+		const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
+
+		if (!refname)
+			die(_("No such ref: %s"), "HEAD");
+
+		/* detached HEAD */
+		if (!strcmp(refname, "HEAD"))
+			die(_("Submodule (%s) branch configured to inherit "
+			      "branch from superproject, but the superproject "
+			      "is not on any branch"), sub->name);
+
+		if (!skip_prefix(refname, "refs/heads/", &refname))
+			die(_("Expecting a full ref name, got %s"), refname);
+		return refname;
+	}
+
 	return sub->branch;
 }
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1bb1f43..1c4c1f2 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -209,9 +209,43 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	)
 '
 
+test_expect_success 'submodule update --remote should fetch upstream changes with .' '
+	(
+		cd super &&
+		git config -f .gitmodules submodule."submodule".branch "." &&
+		git add .gitmodules &&
+		git commit -m "submodules: update from the respective superproject branch"
+	) &&
+	(
+		cd submodule &&
+		echo line4a >> file &&
+		git add file &&
+		test_tick &&
+		git commit -m "upstream line4a" &&
+		git checkout -b test-branch &&
+		test_commit on-test-branch
+	) &&
+	(
+		cd super &&
+		git submodule update --remote --force submodule &&
+		git -C submodule log -1 --oneline >actual
+		git -C ../submodule log -1 --oneline master >expect
+		test_cmp expect actual &&
+		git checkout -b test-branch &&
+		git submodule update --remote --force submodule &&
+		git -C submodule log -1 --oneline >actual
+		git -C ../submodule log -1 --oneline test-branch >expect
+		test_cmp expect actual &&
+		git checkout master &&
+		git branch -d test-branch &&
+		#~ git -C ../submodule branch -d test-branch &&
+		git reset --hard HEAD^
+	)
+'
+
 test_expect_success 'local config should override .gitmodules branch' '
 	(cd submodule &&
-	 git checkout -b test-branch &&
+	 git checkout test-branch &&
 	 echo line5 >> file &&
 	 git add file &&
 	 test_tick &&
-- 
2.9.2.472.g1ffb07c.dirty

