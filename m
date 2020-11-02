Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DFDC2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5222084C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptoEyXKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKBXzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgKBXzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:55:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C50C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:55:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a9so16505866wrg.12
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2cxS9ulC3ZmE3oDlHxTrWAuW8eQ5DcC9+50naVAatSA=;
        b=ptoEyXKm393XsT1SEM8LgkV28LgA3vS4DO0DCHyv89HfURV3UGMK3FpveyFnz9WACn
         kH0eVmRiz/WByhcC1YSh2IsHkzT0UugJ+MXq+keBPvTHCvhdFKUmrxnPD2CqcbH34f6S
         fCgvuRAQL74lJJMjKYXAbTDvcwA9J6Fq+97MScwwpcqQm4ZXAcMEykSzaK8ZNEeRHSFJ
         DU19l0c3Ze4NHJACsQ2tL6UVdbq93nOFErunEtNSf+7iY3cKChNnzXZzS/4kQhhaDlqT
         w/xvjXzz70ZbahhvYxt/4bIwg9gKbrWjiECqU9JIcaUTHYm1CtAT2qo1n25IGCfQ6Dr1
         8fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2cxS9ulC3ZmE3oDlHxTrWAuW8eQ5DcC9+50naVAatSA=;
        b=s+Isa6xANx+cTp0vlioluVV1qh0amA7OEd5/+ArB9Ul8T45fkImWNBMbumDJbQY/gx
         DiEFRiumf+WeOzb9kKKbg2A9NM2GkiOPVO1xQ6QjQ6PsCom/TV13pLojyMMes3XtbuW+
         oA2DMBlqYdlkmmf1MSTT6TmszH7ifDdHAmaZVKQ/I4N1KDMLOLH3/APggY6AS3FnMvu+
         pl29ch8yZcPioqRBdWVkOtz0+LqtrOHpFGCQ+v+ZVEAOsMAgGI+zFFH1yVW53F/VeaIS
         FoMed28EJQ8oTG5yT8LaDBb5yI2Jq12lwfV5CpPueR34INBF9i6yG+RTsX7RFRu2G4iA
         qqbA==
X-Gm-Message-State: AOAM530gt7x0LXBFvSBoMidq/h0yHQ7W201j4e5Xob9uh0Vpw9jPn7r5
        tHXa+OHOT9Zut//hQ/p86H11MPrk9/M=
X-Google-Smtp-Source: ABdhPJw0zNdaGAfQHBlRKSy07XpB3LT2QflGvLdUA3vAl7SqziVDsgFsXIXPljs/Bp9MtMfvoTsVKw==
X-Received: by 2002:adf:eace:: with SMTP id o14mr23445135wrn.308.1604361311391;
        Mon, 02 Nov 2020 15:55:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a128sm11639wmf.5.2020.11.02.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:55:10 -0800 (PST)
Message-Id: <140940d5c240871ebe00ebccf54ad4dffcd58e81.1604361307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.761.git.1604361307.gitgitgadget@gmail.com>
References: <pull.761.git.1604361307.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:55:06 +0000
Subject: [PATCH 3/4] t5515: use `main` as the name of the main branch for
 testing (part 3)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the previous two commits, We just started preparing the `t5515` script
and part of `t/t5515/` for the upcoming change of the default
branch name to `main`. This patch adjusts the remainder of the supporting
material in `t/t5515/` (the patch adjusting all of `t/t5515/` would have
weighed more than 100kB and therefore not made it to the Git mailing
list for review).

Similar to what we did for the `t5515` script itself in the previous
commit, this patch was generated via:

    sed -i -e 's/master/main/g' -e 's/Master/Main/g' \
        -e 's/6c9dec2b923228c9ff994c6cfe4ae16c12408dc5/ecf3b3627b498bdcb735cc4343bf165f76964e9a/g' \
	-e 's/8521c3072461fcfe8f32d67f95cc6e6b832a2db2fa29769ffc788bce85ebcd75/fff666109892bb4b1c80cd1649d2d8762a0663db8b5d46c8be98360b64fbba5f/g' \
	-e 's/754b754407bf032e9a2f9d5a9ad05ca79a6b228f/b4ab76b1a01ea602209932134a44f1e6bd610832/g' \
	-e 's/6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0/380ebae0113f877ce46fcdf39d5bc33e4dc0928db5c5a4d5fdc78381c4d55ae3/g' \
	-- t/t5515/refs.*

In addition to that, we need to adjust some file _names_ in `t/t5515/`
because they encode the branch name:

    eval "$(git ls-files t/t5515/refs.\* | sed -n \
	-e 's/\(.*\)master\(.*\)/git mv & \1main\2;/p')"

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5515/refs.br-branches-default                      |  6 +++---
 t/t5515/refs.br-branches-default-merge                |  6 +++---
 .../refs.br-branches-default-merge_branches-default   |  6 +++---
 t/t5515/refs.br-branches-default-octopus              |  6 +++---
 .../refs.br-branches-default-octopus_branches-default |  6 +++---
 t/t5515/refs.br-branches-default_branches-default     |  6 +++---
 t/t5515/refs.br-branches-one                          |  4 ++--
 t/t5515/refs.br-branches-one-merge                    |  4 ++--
 t/t5515/refs.br-branches-one-merge_branches-one       |  4 ++--
 t/t5515/refs.br-branches-one-octopus                  |  4 ++--
 t/t5515/refs.br-branches-one-octopus_branches-one     |  4 ++--
 t/t5515/refs.br-branches-one_branches-one             |  4 ++--
 t/t5515/refs.br-config-explicit                       |  6 +++---
 t/t5515/refs.br-config-explicit-merge                 |  6 +++---
 t/t5515/refs.br-config-explicit-merge_config-explicit |  6 +++---
 t/t5515/refs.br-config-explicit-octopus               |  6 +++---
 .../refs.br-config-explicit-octopus_config-explicit   |  6 +++---
 t/t5515/refs.br-config-explicit_config-explicit       |  6 +++---
 t/t5515/refs.br-config-glob                           |  6 +++---
 t/t5515/refs.br-config-glob-merge                     |  6 +++---
 t/t5515/refs.br-config-glob-merge_config-glob         |  6 +++---
 t/t5515/refs.br-config-glob-octopus                   |  6 +++---
 t/t5515/refs.br-config-glob-octopus_config-glob       |  6 +++---
 t/t5515/refs.br-config-glob_config-glob               |  6 +++---
 t/t5515/refs.br-remote-explicit                       |  6 +++---
 t/t5515/refs.br-remote-explicit-merge                 |  6 +++---
 t/t5515/refs.br-remote-explicit-merge_remote-explicit |  6 +++---
 t/t5515/refs.br-remote-explicit-octopus               |  6 +++---
 .../refs.br-remote-explicit-octopus_remote-explicit   |  6 +++---
 t/t5515/refs.br-remote-explicit_remote-explicit       |  6 +++---
 t/t5515/refs.br-remote-glob                           |  6 +++---
 t/t5515/refs.br-remote-glob-merge                     |  6 +++---
 t/t5515/refs.br-remote-glob-merge_remote-glob         |  6 +++---
 t/t5515/refs.br-remote-glob-octopus                   |  6 +++---
 t/t5515/refs.br-remote-glob-octopus_remote-glob       |  6 +++---
 t/t5515/refs.br-remote-glob_remote-glob               |  6 +++---
 t/t5515/refs.br-unconfig                              |  4 ++--
 t/t5515/refs.br-unconfig_--tags_.._.git               |  4 ++--
 t/t5515/refs.br-unconfig_.._.git                      |  2 +-
 t/t5515/refs.br-unconfig_.._.git_one                  |  2 +-
 ...nconfig_.._.git_one_tag_tag-one_tag_tag-three-file |  4 ++--
 t/t5515/refs.br-unconfig_.._.git_one_two              |  2 +-
 ...config_.._.git_tag_tag-one-tree_tag_tag-three-file |  4 ++--
 ...refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three |  4 ++--
 t/t5515/refs.br-unconfig_branches-default             |  6 +++---
 t/t5515/refs.br-unconfig_branches-one                 |  4 ++--
 t/t5515/refs.br-unconfig_config-explicit              |  6 +++---
 t/t5515/refs.br-unconfig_config-glob                  |  6 +++---
 t/t5515/refs.br-unconfig_remote-explicit              |  6 +++---
 t/t5515/refs.br-unconfig_remote-glob                  |  6 +++---
 t/t5515/{refs.master => refs.main}                    |  4 ++--
 ...master_--tags_.._.git => refs.main_--tags_.._.git} |  4 ++--
 ...{refs.master_.._.git_one_two => refs.main_.._.git} |  2 +-
 .../{refs.master_.._.git => refs.main_.._.git_one}    |  2 +-
 ...s.main_.._.git_one_tag_tag-one_tag_tag-three-file} |  4 ++--
 ...s.master_.._.git_one => refs.main_.._.git_one_two} |  2 +-
 ....main_.._.git_tag_tag-one-tree_tag_tag-three-file} |  4 ++--
 t/t5515/refs.main_.._.git_tag_tag-one_tag_tag-three   | 11 +++++++++++
 ...er_branches-default => refs.main_branches-default} |  6 +++---
 ...efs.master_branches-one => refs.main_branches-one} |  4 ++--
 ...ster_config-explicit => refs.main_config-explicit} |  6 +++---
 ...{refs.master_config-glob => refs.main_config-glob} |  6 +++---
 ...ster_remote-explicit => refs.main_remote-explicit} |  6 +++---
 ...{refs.master_remote-glob => refs.main_remote-glob} |  6 +++---
 t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three | 11 -----------
 65 files changed, 171 insertions(+), 171 deletions(-)
 rename t/t5515/{refs.master => refs.main} (81%)
 rename t/t5515/{refs.master_--tags_.._.git => refs.main_--tags_.._.git} (81%)
 rename t/t5515/{refs.master_.._.git_one_two => refs.main_.._.git} (79%)
 rename t/t5515/{refs.master_.._.git => refs.main_.._.git_one} (79%)
 rename t/t5515/{refs.master_.._.git_one_tag_tag-one_tag_tag-three-file => refs.main_.._.git_one_tag_tag-one_tag_tag-three-file} (81%)
 rename t/t5515/{refs.master_.._.git_one => refs.main_.._.git_one_two} (79%)
 rename t/t5515/{refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file => refs.main_.._.git_tag_tag-one-tree_tag_tag-three-file} (81%)
 create mode 100644 t/t5515/refs.main_.._.git_tag_tag-one_tag_tag-three
 rename t/t5515/{refs.master_branches-default => refs.main_branches-default} (74%)
 rename t/t5515/{refs.master_branches-one => refs.main_branches-one} (83%)
 rename t/t5515/{refs.master_config-explicit => refs.main_config-explicit} (79%)
 rename t/t5515/{refs.master_config-glob => refs.main_config-glob} (79%)
 rename t/t5515/{refs.master_remote-explicit => refs.main_remote-explicit} (79%)
 rename t/t5515/{refs.master_remote-glob => refs.main_remote-glob} (79%)
 delete mode 100644 t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three

diff --git a/t/t5515/refs.br-branches-default b/t/t5515/refs.br-branches-default
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-branches-default
+++ b/t/t5515/refs.br-branches-default
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-default-merge b/t/t5515/refs.br-branches-default-merge
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-branches-default-merge
+++ b/t/t5515/refs.br-branches-default-merge
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-default-merge_branches-default b/t/t5515/refs.br-branches-default-merge_branches-default
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-branches-default-merge_branches-default
+++ b/t/t5515/refs.br-branches-default-merge_branches-default
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-default-octopus b/t/t5515/refs.br-branches-default-octopus
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-branches-default-octopus
+++ b/t/t5515/refs.br-branches-default-octopus
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-default-octopus_branches-default b/t/t5515/refs.br-branches-default-octopus_branches-default
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-branches-default-octopus_branches-default
+++ b/t/t5515/refs.br-branches-default-octopus_branches-default
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-default_branches-default b/t/t5515/refs.br-branches-default_branches-default
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-branches-default_branches-default
+++ b/t/t5515/refs.br-branches-default_branches-default
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-one b/t/t5515/refs.br-branches-one
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-branches-one
+++ b/t/t5515/refs.br-branches-one
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-one-merge b/t/t5515/refs.br-branches-one-merge
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-branches-one-merge
+++ b/t/t5515/refs.br-branches-one-merge
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-one-merge_branches-one b/t/t5515/refs.br-branches-one-merge_branches-one
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-branches-one-merge_branches-one
+++ b/t/t5515/refs.br-branches-one-merge_branches-one
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-one-octopus b/t/t5515/refs.br-branches-one-octopus
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-branches-one-octopus
+++ b/t/t5515/refs.br-branches-one-octopus
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-one-octopus_branches-one b/t/t5515/refs.br-branches-one-octopus_branches-one
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-branches-one-octopus_branches-one
+++ b/t/t5515/refs.br-branches-one-octopus_branches-one
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-branches-one_branches-one b/t/t5515/refs.br-branches-one_branches-one
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-branches-one_branches-one
+++ b/t/t5515/refs.br-branches-one_branches-one
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-explicit b/t/t5515/refs.br-config-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-explicit
+++ b/t/t5515/refs.br-config-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-explicit-merge b/t/t5515/refs.br-config-explicit-merge
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-explicit-merge
+++ b/t/t5515/refs.br-config-explicit-merge
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-explicit-merge_config-explicit b/t/t5515/refs.br-config-explicit-merge_config-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-explicit-merge_config-explicit
+++ b/t/t5515/refs.br-config-explicit-merge_config-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-explicit-octopus b/t/t5515/refs.br-config-explicit-octopus
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-explicit-octopus
+++ b/t/t5515/refs.br-config-explicit-octopus
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-explicit-octopus_config-explicit b/t/t5515/refs.br-config-explicit-octopus_config-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-explicit-octopus_config-explicit
+++ b/t/t5515/refs.br-config-explicit-octopus_config-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-explicit_config-explicit b/t/t5515/refs.br-config-explicit_config-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-explicit_config-explicit
+++ b/t/t5515/refs.br-config-explicit_config-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-glob b/t/t5515/refs.br-config-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-glob
+++ b/t/t5515/refs.br-config-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-glob-merge b/t/t5515/refs.br-config-glob-merge
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-glob-merge
+++ b/t/t5515/refs.br-config-glob-merge
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-glob-merge_config-glob b/t/t5515/refs.br-config-glob-merge_config-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-glob-merge_config-glob
+++ b/t/t5515/refs.br-config-glob-merge_config-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-glob-octopus b/t/t5515/refs.br-config-glob-octopus
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-glob-octopus
+++ b/t/t5515/refs.br-config-glob-octopus
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-glob-octopus_config-glob b/t/t5515/refs.br-config-glob-octopus_config-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-glob-octopus_config-glob
+++ b/t/t5515/refs.br-config-glob-octopus_config-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-config-glob_config-glob b/t/t5515/refs.br-config-glob_config-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-config-glob_config-glob
+++ b/t/t5515/refs.br-config-glob_config-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-explicit b/t/t5515/refs.br-remote-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-explicit
+++ b/t/t5515/refs.br-remote-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-explicit-merge b/t/t5515/refs.br-remote-explicit-merge
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-explicit-merge
+++ b/t/t5515/refs.br-remote-explicit-merge
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-explicit-merge_remote-explicit b/t/t5515/refs.br-remote-explicit-merge_remote-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-explicit-merge_remote-explicit
+++ b/t/t5515/refs.br-remote-explicit-merge_remote-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-explicit-octopus b/t/t5515/refs.br-remote-explicit-octopus
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-explicit-octopus
+++ b/t/t5515/refs.br-remote-explicit-octopus
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-explicit-octopus_remote-explicit b/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
+++ b/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-explicit_remote-explicit b/t/t5515/refs.br-remote-explicit_remote-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-explicit_remote-explicit
+++ b/t/t5515/refs.br-remote-explicit_remote-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-glob b/t/t5515/refs.br-remote-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-glob
+++ b/t/t5515/refs.br-remote-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-glob-merge b/t/t5515/refs.br-remote-glob-merge
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-glob-merge
+++ b/t/t5515/refs.br-remote-glob-merge
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-glob-merge_remote-glob b/t/t5515/refs.br-remote-glob-merge_remote-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-glob-merge_remote-glob
+++ b/t/t5515/refs.br-remote-glob-merge_remote-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-glob-octopus b/t/t5515/refs.br-remote-glob-octopus
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-glob-octopus
+++ b/t/t5515/refs.br-remote-glob-octopus
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-glob-octopus_remote-glob b/t/t5515/refs.br-remote-glob-octopus_remote-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/refs.br-remote-glob-octopus_remote-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-remote-glob_remote-glob b/t/t5515/refs.br-remote-glob_remote-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-remote-glob_remote-glob
+++ b/t/t5515/refs.br-remote-glob_remote-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig b/t/t5515/refs.br-unconfig
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.br-unconfig
+++ b/t/t5515/refs.br-unconfig
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_--tags_.._.git b/t/t5515/refs.br-unconfig_--tags_.._.git
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.br-unconfig_--tags_.._.git
+++ b/t/t5515/refs.br-unconfig_--tags_.._.git
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_.._.git b/t/t5515/refs.br-unconfig_.._.git
index 70962eaac1..4a74b68029 100644
--- a/t/t5515/refs.br-unconfig_.._.git
+++ b/t/t5515/refs.br-unconfig_.._.git
@@ -1,5 +1,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.br-unconfig_.._.git_one b/t/t5515/refs.br-unconfig_.._.git_one
index 70962eaac1..4a74b68029 100644
--- a/t/t5515/refs.br-unconfig_.._.git_one
+++ b/t/t5515/refs.br-unconfig_.._.git_one
@@ -1,5 +1,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_.._.git_one_two b/t/t5515/refs.br-unconfig_.._.git_one_two
index 70962eaac1..4a74b68029 100644
--- a/t/t5515/refs.br-unconfig_.._.git_one_two
+++ b/t/t5515/refs.br-unconfig_.._.git_one_two
@@ -1,5 +1,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
+++ b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_branches-default b/t/t5515/refs.br-unconfig_branches-default
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.br-unconfig_branches-default
+++ b/t/t5515/refs.br-unconfig_branches-default
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_branches-one b/t/t5515/refs.br-unconfig_branches-one
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.br-unconfig_branches-one
+++ b/t/t5515/refs.br-unconfig_branches-one
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_config-explicit b/t/t5515/refs.br-unconfig_config-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-unconfig_config-explicit
+++ b/t/t5515/refs.br-unconfig_config-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_config-glob b/t/t5515/refs.br-unconfig_config-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-unconfig_config-glob
+++ b/t/t5515/refs.br-unconfig_config-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_remote-explicit b/t/t5515/refs.br-unconfig_remote-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-unconfig_remote-explicit
+++ b/t/t5515/refs.br-unconfig_remote-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.br-unconfig_remote-glob b/t/t5515/refs.br-unconfig_remote-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.br-unconfig_remote-glob
+++ b/t/t5515/refs.br-unconfig_remote-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master b/t/t5515/refs.main
similarity index 81%
rename from t/t5515/refs.master
rename to t/t5515/refs.main
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.master
+++ b/t/t5515/refs.main
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_--tags_.._.git b/t/t5515/refs.main_--tags_.._.git
similarity index 81%
rename from t/t5515/refs.master_--tags_.._.git
rename to t/t5515/refs.main_--tags_.._.git
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.master_--tags_.._.git
+++ b/t/t5515/refs.main_--tags_.._.git
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_.._.git_one_two b/t/t5515/refs.main_.._.git
similarity index 79%
rename from t/t5515/refs.master_.._.git_one_two
rename to t/t5515/refs.main_.._.git
index 70962eaac1..4a74b68029 100644
--- a/t/t5515/refs.master_.._.git_one_two
+++ b/t/t5515/refs.main_.._.git
@@ -1,5 +1,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.master_.._.git b/t/t5515/refs.main_.._.git_one
similarity index 79%
rename from t/t5515/refs.master_.._.git
rename to t/t5515/refs.main_.._.git_one
index 70962eaac1..4a74b68029 100644
--- a/t/t5515/refs.master_.._.git
+++ b/t/t5515/refs.main_.._.git_one
@@ -1,5 +1,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/refs.main_.._.git_one_tag_tag-one_tag_tag-three-file
similarity index 81%
rename from t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file
rename to t/t5515/refs.main_.._.git_one_tag_tag-one_tag_tag-three-file
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/refs.main_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_.._.git_one b/t/t5515/refs.main_.._.git_one_two
similarity index 79%
rename from t/t5515/refs.master_.._.git_one
rename to t/t5515/refs.main_.._.git_one_two
index 70962eaac1..4a74b68029 100644
--- a/t/t5515/refs.master_.._.git_one
+++ b/t/t5515/refs.main_.._.git_one_two
@@ -1,5 +1,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/refs.main_.._.git_tag_tag-one-tree_tag_tag-three-file
similarity index 81%
rename from t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file
rename to t/t5515/refs.main_.._.git_tag_tag-one-tree_tag_tag-three-file
index 13e4ad2e46..f2ab01f68b 100644
--- a/t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file
+++ b/t/t5515/refs.main_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -1,9 +1,9 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.main_.._.git_tag_tag-one_tag_tag-three b/t/t5515/refs.main_.._.git_tag_tag-one_tag_tag-three
new file mode 100644
index 0000000000..f2ab01f68b
--- /dev/null
+++ b/t/t5515/refs.main_.._.git_tag_tag-one_tag_tag-three
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_branches-default b/t/t5515/refs.main_branches-default
similarity index 74%
rename from t/t5515/refs.master_branches-default
rename to t/t5515/refs.main_branches-default
index 21917c1e5d..dc4f2b7a4e 100644
--- a/t/t5515/refs.master_branches-default
+++ b/t/t5515/refs.main_branches-default
@@ -1,10 +1,10 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/heads/branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_branches-one b/t/t5515/refs.main_branches-one
similarity index 83%
rename from t/t5515/refs.master_branches-one
rename to t/t5515/refs.main_branches-one
index 8a705a5df2..e8f79bf4b1 100644
--- a/t/t5515/refs.master_branches-one
+++ b/t/t5515/refs.main_branches-one
@@ -1,10 +1,10 @@
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_config-explicit b/t/t5515/refs.main_config-explicit
similarity index 79%
rename from t/t5515/refs.master_config-explicit
rename to t/t5515/refs.main_config-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.master_config-explicit
+++ b/t/t5515/refs.main_config-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_config-glob b/t/t5515/refs.main_config-glob
similarity index 79%
rename from t/t5515/refs.master_config-glob
rename to t/t5515/refs.main_config-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.master_config-glob
+++ b/t/t5515/refs.main_config-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_remote-explicit b/t/t5515/refs.main_remote-explicit
similarity index 79%
rename from t/t5515/refs.master_remote-explicit
rename to t/t5515/refs.main_remote-explicit
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.master_remote-explicit
+++ b/t/t5515/refs.main_remote-explicit
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_remote-glob b/t/t5515/refs.main_remote-glob
similarity index 79%
rename from t/t5515/refs.master_remote-glob
rename to t/t5515/refs.main_remote-glob
index 9bbbfd9fc5..a28fa5f56e 100644
--- a/t/t5515/refs.master_remote-glob
+++ b/t/t5515/refs.main_remote-glob
@@ -1,13 +1,13 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/origin/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+b4ab76b1a01ea602209932134a44f1e6bd610832 refs/remotes/rem/main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+ecf3b3627b498bdcb735cc4343bf165f76964e9a refs/tags/tag-main
 8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
 22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
 c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
diff --git a/t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three b/t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three
deleted file mode 100644
index 13e4ad2e46..0000000000
--- a/t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three
+++ /dev/null
@@ -1,11 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
-- 
gitgitgadget

