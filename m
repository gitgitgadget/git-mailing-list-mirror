Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B1DC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2643F2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZjJosk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKBXzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgKBXzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:55:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A2C061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:55:12 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g12so16506871wrp.10
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wzUnSiHc1wEyqkUF7cPfJmW/h65MlkPGhznlurSy5FE=;
        b=fZjJosk6fuYuFD8nfhzazZ+jAT0Ncb1QjLOPhirMTW49f7JVWjF+cM1FD5N+5C0VZi
         IAUdlu7R1rKwnTxpf5uqZHeJ+OyDZ7n5MxcTMJlGNC/h50kCKT53trzz1g+ScQ27IC0O
         TjCU6GglN42V6TvAAgEt1lzSHBp20msKiB3Sm5mcYBzrtkXiiCPpiB9weuDW1NqmFkL1
         gu0CxgyGLizsFteeiIkxF8s80vPLfBoi3R2hAst9azNrtEp3QeLNehFWA1KYe9sbHbxW
         6c4OGFbYkdtJyeqbHUALmPg/GUjIFbHo0qBSerTCtHqShX6JvqlQkpDU0c/F4pPxijK2
         FDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wzUnSiHc1wEyqkUF7cPfJmW/h65MlkPGhznlurSy5FE=;
        b=jDuUR0qvR6XuB9+bQaZnb+1RH+ZaaWfoFAk5ln4KEDq2eY/+OG0bjOjr3J33wbMFAO
         ijln62HiWWAApANmhHOixBk/QIpbF8HkRG/X/d7/CaNDK5+mNqeGntXzmOYtlP1xS68Y
         94tK/vQzRvgty2QNrTSe5E7RwQoFkucRUmjdwFhjPwPpsXMqSvSYs0o9ni3h/U2KZtMV
         TpBD1uMZp+LjsEPPEW3o++7qOf2GyTzWcxLXqVyK79nyT7ROgSueGJLPGz1BxMT+aall
         4E/rkwiAJA4mnYmAsmmeckHmcp4GfFMS5jclIu81KXYv+CtGDfCuYPEWeGnEYGqZd3Q0
         D+LA==
X-Gm-Message-State: AOAM533WjrUsbHj8z8QaufdNgZEOns9IksjnWB4pzsF1GqChOy3a1Mpl
        fObiQUSUEfbyHEjk57GxOObK9Jp3+74=
X-Google-Smtp-Source: ABdhPJzttF+zORQ79OOH9FyAqmaMXlFN3VfSQhEipfvBADKPUv3rdSXth25rdOvbKDDSxG1/PYojoA==
X-Received: by 2002:a5d:664b:: with SMTP id f11mr21664359wrw.195.1604361310389;
        Mon, 02 Nov 2020 15:55:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm13687740wro.44.2020.11.02.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:55:09 -0800 (PST)
Message-Id: <b55eeb80b203b6e44921e6757631653fb02c4f91.1604361307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.761.git.1604361307.gitgitgadget@gmail.com>
References: <pull.761.git.1604361307.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:55:05 +0000
Subject: [PATCH 2/4] t5515: use `main` as the name of the main branch for
 testing (part 2)
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

We just started preparing t5515 for the upcoming change of the default
branch name to `main`. This patch adjusts roughly half of the supporting
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
	-- t/t5515/fetch.*

In addition to that, we need to adjust some file _names_ in `t/t5515/`
because they encode the branch name:

    eval "$(git ls-files t/t5515/fetch.\* | sed -n \
	-e 's/\(.*\)master\(.*\)/git mv & \1main\2;/p')"

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5515/fetch.br-branches-default                     |  4 ++--
 t/t5515/fetch.br-branches-default-merge               |  4 ++--
 .../fetch.br-branches-default-merge_branches-default  |  4 ++--
 t/t5515/fetch.br-branches-default-octopus             |  4 ++--
 ...fetch.br-branches-default-octopus_branches-default |  4 ++--
 t/t5515/fetch.br-branches-default_branches-default    |  4 ++--
 t/t5515/fetch.br-branches-one                         |  2 +-
 t/t5515/fetch.br-branches-one-merge                   |  2 +-
 t/t5515/fetch.br-branches-one-merge_branches-one      |  2 +-
 t/t5515/fetch.br-branches-one-octopus                 |  2 +-
 t/t5515/fetch.br-branches-one-octopus_branches-one    |  2 +-
 t/t5515/fetch.br-branches-one_branches-one            |  2 +-
 t/t5515/fetch.br-config-explicit                      |  4 ++--
 t/t5515/fetch.br-config-explicit-merge                |  4 ++--
 .../fetch.br-config-explicit-merge_config-explicit    |  4 ++--
 t/t5515/fetch.br-config-explicit-octopus              |  4 ++--
 .../fetch.br-config-explicit-octopus_config-explicit  |  4 ++--
 t/t5515/fetch.br-config-explicit_config-explicit      |  4 ++--
 t/t5515/fetch.br-config-glob                          |  4 ++--
 t/t5515/fetch.br-config-glob-merge                    |  4 ++--
 t/t5515/fetch.br-config-glob-merge_config-glob        |  4 ++--
 t/t5515/fetch.br-config-glob-octopus                  |  4 ++--
 t/t5515/fetch.br-config-glob-octopus_config-glob      |  4 ++--
 t/t5515/fetch.br-config-glob_config-glob              |  4 ++--
 t/t5515/fetch.br-remote-explicit                      |  4 ++--
 t/t5515/fetch.br-remote-explicit-merge                |  4 ++--
 .../fetch.br-remote-explicit-merge_remote-explicit    |  4 ++--
 t/t5515/fetch.br-remote-explicit-octopus              |  4 ++--
 .../fetch.br-remote-explicit-octopus_remote-explicit  |  4 ++--
 t/t5515/fetch.br-remote-explicit_remote-explicit      |  4 ++--
 t/t5515/fetch.br-remote-glob                          |  4 ++--
 t/t5515/fetch.br-remote-glob-merge                    |  4 ++--
 t/t5515/fetch.br-remote-glob-merge_remote-glob        |  4 ++--
 t/t5515/fetch.br-remote-glob-octopus                  |  4 ++--
 t/t5515/fetch.br-remote-glob-octopus_remote-glob      |  4 ++--
 t/t5515/fetch.br-remote-glob_remote-glob              |  4 ++--
 t/t5515/fetch.br-unconfig                             |  4 ++--
 t/t5515/fetch.br-unconfig_--tags_.._.git              |  2 +-
 ...nconfig_.._.git_one_tag_tag-one_tag_tag-three-file |  2 +-
 ...config_.._.git_tag_tag-one-tree_tag_tag-three-file |  2 +-
 ...etch.br-unconfig_.._.git_tag_tag-one_tag_tag-three |  2 +-
 t/t5515/fetch.br-unconfig_branches-default            |  4 ++--
 t/t5515/fetch.br-unconfig_branches-one                |  2 +-
 t/t5515/fetch.br-unconfig_config-explicit             |  4 ++--
 t/t5515/fetch.br-unconfig_config-glob                 |  4 ++--
 t/t5515/fetch.br-unconfig_remote-explicit             |  4 ++--
 t/t5515/fetch.br-unconfig_remote-glob                 |  4 ++--
 t/t5515/{fetch.master => fetch.main}                  |  6 +++---
 ...aster_--tags_.._.git => fetch.main_--tags_.._.git} |  4 ++--
 t/t5515/{fetch.master_.._.git => fetch.main_.._.git}  |  2 +-
 ...etch.master_.._.git_one => fetch.main_.._.git_one} |  2 +-
 ...h.main_.._.git_one_tag_tag-one_tag_tag-three-file} |  4 ++--
 ...ter_.._.git_one_two => fetch.main_.._.git_one_two} |  2 +-
 ....main_.._.git_tag_tag-one-tree_tag_tag-three-file} |  4 ++--
 ...e => fetch.main_.._.git_tag_tag-one_tag_tag-three} |  4 ++--
 ...r_branches-default => fetch.main_branches-default} |  6 +++---
 ...ch.master_branches-one => fetch.main_branches-one} |  4 ++--
 ...ter_config-explicit => fetch.main_config-explicit} |  6 +++---
 ...etch.master_config-glob => fetch.main_config-glob} |  6 +++---
 ...ter_remote-explicit => fetch.main_remote-explicit} |  6 +++---
 t/t5515/fetch.main_remote-glob                        | 11 +++++++++++
 t/t5515/fetch.master_remote-glob                      | 11 -----------
 62 files changed, 122 insertions(+), 122 deletions(-)
 rename t/t5515/{fetch.master => fetch.main} (78%)
 rename t/t5515/{fetch.master_--tags_.._.git => fetch.main_--tags_.._.git} (81%)
 rename t/t5515/{fetch.master_.._.git => fetch.main_.._.git} (73%)
 rename t/t5515/{fetch.master_.._.git_one => fetch.main_.._.git_one} (74%)
 rename t/t5515/{fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file => fetch.main_.._.git_one_tag_tag-one_tag_tag-three-file} (77%)
 rename t/t5515/{fetch.master_.._.git_one_two => fetch.main_.._.git_one_two} (83%)
 rename t/t5515/{fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file => fetch.main_.._.git_tag_tag-one-tree_tag_tag-three-file} (74%)
 rename t/t5515/{fetch.master_.._.git_tag_tag-one_tag_tag-three => fetch.main_.._.git_tag_tag-one_tag_tag-three} (75%)
 rename t/t5515/{fetch.master_branches-default => fetch.main_branches-default} (69%)
 rename t/t5515/{fetch.master_branches-one => fetch.main_branches-one} (81%)
 rename t/t5515/{fetch.master_config-explicit => fetch.main_config-explicit} (78%)
 rename t/t5515/{fetch.master_config-glob => fetch.main_config-glob} (77%)
 rename t/t5515/{fetch.master_remote-explicit => fetch.main_remote-explicit} (78%)
 create mode 100644 t/t5515/fetch.main_remote-glob
 delete mode 100644 t/t5515/fetch.master_remote-glob

diff --git a/t/t5515/fetch.br-branches-default b/t/t5515/fetch.br-branches-default
index a1bc3d53a6..0bed09cc12 100644
--- a/t/t5515/fetch.br-branches-default
+++ b/t/t5515/fetch.br-branches-default
@@ -1,6 +1,6 @@
 # br-branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
index 12ab08e8ac..59eef63527 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -1,7 +1,7 @@
 # br-branches-default-merge
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
index 54427522dd..490186c158 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -1,7 +1,7 @@
 # br-branches-default-merge branches-default
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
index 498a761aae..d484138c27 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -1,8 +1,8 @@
 # br-branches-default-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 0857f134e1..b79a5fe2c3 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -1,8 +1,8 @@
 # br-branches-default-octopus branches-default
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-default_branches-default b/t/t5515/fetch.br-branches-default_branches-default
index 8cbd718936..1c866d85e6 100644
--- a/t/t5515/fetch.br-branches-default_branches-default
+++ b/t/t5515/fetch.br-branches-default_branches-default
@@ -1,6 +1,6 @@
 # br-branches-default branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-one b/t/t5515/fetch.br-branches-one
index c98f670526..6925a775b6 100644
--- a/t/t5515/fetch.br-branches-one
+++ b/t/t5515/fetch.br-branches-one
@@ -1,6 +1,6 @@
 # br-branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
index 54a77420d5..85257031ce 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -1,7 +1,7 @@
 # br-branches-one-merge
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
index b4d1bb0b0b..3a63a7f450 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -1,7 +1,7 @@
 # br-branches-one-merge branches-one
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-branches-one-octopus
index 97c4b544b8..46af763fec 100644
--- a/t/t5515/fetch.br-branches-one-octopus
+++ b/t/t5515/fetch.br-branches-one-octopus
@@ -1,7 +1,7 @@
 # br-branches-one-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus_branches-one b/t/t5515/fetch.br-branches-one-octopus_branches-one
index df705f74c7..becfde9ddd 100644
--- a/t/t5515/fetch.br-branches-one-octopus_branches-one
+++ b/t/t5515/fetch.br-branches-one-octopus_branches-one
@@ -1,7 +1,7 @@
 # br-branches-one-octopus branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-branches-one_branches-one b/t/t5515/fetch.br-branches-one_branches-one
index 96890e5bd9..9ba34c6754 100644
--- a/t/t5515/fetch.br-branches-one_branches-one
+++ b/t/t5515/fetch.br-branches-one_branches-one
@@ -1,6 +1,6 @@
 # br-branches-one branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-explicit b/t/t5515/fetch.br-config-explicit
index 68fc927263..7466a73214 100644
--- a/t/t5515/fetch.br-config-explicit
+++ b/t/t5515/fetch.br-config-explicit
@@ -1,9 +1,9 @@
 # br-config-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge b/t/t5515/fetch.br-config-explicit-merge
index 5ce764a06e..9375b7d21d 100644
--- a/t/t5515/fetch.br-config-explicit-merge
+++ b/t/t5515/fetch.br-config-explicit-merge
@@ -1,9 +1,9 @@
 # br-config-explicit-merge
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge_config-explicit b/t/t5515/fetch.br-config-explicit-merge_config-explicit
index b1152b76dc..6335e2b113 100644
--- a/t/t5515/fetch.br-config-explicit-merge_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-merge_config-explicit
@@ -1,9 +1,9 @@
 # br-config-explicit-merge config-explicit
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus b/t/t5515/fetch.br-config-explicit-octopus
index 110577bb67..c379aa9b31 100644
--- a/t/t5515/fetch.br-config-explicit-octopus
+++ b/t/t5515/fetch.br-config-explicit-octopus
@@ -1,9 +1,9 @@
 # br-config-explicit-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus_config-explicit b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
index a29dd8baba..7fb3a3eef8 100644
--- a/t/t5515/fetch.br-config-explicit-octopus_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
@@ -1,9 +1,9 @@
 # br-config-explicit-octopus config-explicit
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-explicit_config-explicit b/t/t5515/fetch.br-config-explicit_config-explicit
index b19b0162e1..86045a79d4 100644
--- a/t/t5515/fetch.br-config-explicit_config-explicit
+++ b/t/t5515/fetch.br-config-explicit_config-explicit
@@ -1,9 +1,9 @@
 # br-config-explicit config-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-glob b/t/t5515/fetch.br-config-glob
index 946d70ca07..bfeef2b716 100644
--- a/t/t5515/fetch.br-config-glob
+++ b/t/t5515/fetch.br-config-glob
@@ -1,9 +1,9 @@
 # br-config-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge b/t/t5515/fetch.br-config-glob-merge
index 89f2596cb9..5376a4ac1d 100644
--- a/t/t5515/fetch.br-config-glob-merge
+++ b/t/t5515/fetch.br-config-glob-merge
@@ -1,9 +1,9 @@
 # br-config-glob-merge
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge_config-glob b/t/t5515/fetch.br-config-glob-merge_config-glob
index 2ba4832160..7dfc2feb35 100644
--- a/t/t5515/fetch.br-config-glob-merge_config-glob
+++ b/t/t5515/fetch.br-config-glob-merge_config-glob
@@ -1,9 +1,9 @@
 # br-config-glob-merge config-glob
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-config-glob-octopus
index 64994df7e2..10840309ef 100644
--- a/t/t5515/fetch.br-config-glob-octopus
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -1,9 +1,9 @@
 # br-config-glob-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515/fetch.br-config-glob-octopus_config-glob
index 681a725adc..839866daf3 100644
--- a/t/t5515/fetch.br-config-glob-octopus_config-glob
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -1,9 +1,9 @@
 # br-config-glob-octopus config-glob
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-config-glob_config-glob b/t/t5515/fetch.br-config-glob_config-glob
index 19daf0cb77..7b0cb91e51 100644
--- a/t/t5515/fetch.br-config-glob_config-glob
+++ b/t/t5515/fetch.br-config-glob_config-glob
@@ -1,9 +1,9 @@
 # br-config-glob config-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-explicit b/t/t5515/fetch.br-remote-explicit
index ab44bc5519..d6619e7fc0 100644
--- a/t/t5515/fetch.br-remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit
@@ -1,9 +1,9 @@
 # br-remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-remote-explicit-merge
index d018b3515f..5b49b7c4c5 100644
--- a/t/t5515/fetch.br-remote-explicit-merge
+++ b/t/t5515/fetch.br-remote-explicit-merge
@@ -1,9 +1,9 @@
 # br-remote-explicit-merge
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
index 0d3d780dd0..417261d8eb 100644
--- a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
@@ -1,9 +1,9 @@
 # br-remote-explicit-merge remote-explicit
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.br-remote-explicit-octopus
index 6f843044ed..2edef64473 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus
+++ b/t/t5515/fetch.br-remote-explicit-octopus
@@ -1,9 +1,9 @@
 # br-remote-explicit-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
index 3546a83713..ceb8752e1f 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
@@ -1,9 +1,9 @@
 # br-remote-explicit-octopus remote-explicit
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-explicit_remote-explicit b/t/t5515/fetch.br-remote-explicit_remote-explicit
index 01e014e6a0..b7abbd227c 100644
--- a/t/t5515/fetch.br-remote-explicit_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit_remote-explicit
@@ -1,9 +1,9 @@
 # br-remote-explicit remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-glob b/t/t5515/fetch.br-remote-glob
index 09bfcee00f..645412c73f 100644
--- a/t/t5515/fetch.br-remote-glob
+++ b/t/t5515/fetch.br-remote-glob
@@ -1,9 +1,9 @@
 # br-remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remote-glob-merge
index 7e1a433a64..8512cfd8d3 100644
--- a/t/t5515/fetch.br-remote-glob-merge
+++ b/t/t5515/fetch.br-remote-glob-merge
@@ -1,9 +1,9 @@
 # br-remote-glob-merge
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge_remote-glob b/t/t5515/fetch.br-remote-glob-merge_remote-glob
index 53571bb4ec..7394164d85 100644
--- a/t/t5515/fetch.br-remote-glob-merge_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-merge_remote-glob
@@ -1,9 +1,9 @@
 # br-remote-glob-merge remote-glob
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
index c7c8b6d7f4..0ca4719ef8 100644
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -1,9 +1,9 @@
 # br-remote-glob-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
index 36076fba0c..7e7b0ba5f5 100644
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -1,9 +1,9 @@
 # br-remote-glob-octopus remote-glob
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-remote-glob_remote-glob b/t/t5515/fetch.br-remote-glob_remote-glob
index 20ba5cb172..7bae5ecfb7 100644
--- a/t/t5515/fetch.br-remote-glob_remote-glob
+++ b/t/t5515/fetch.br-remote-glob_remote-glob
@@ -1,9 +1,9 @@
 # br-remote-glob remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig b/t/t5515/fetch.br-unconfig
index 887ccfc41f..ccaa54fed2 100644
--- a/t/t5515/fetch.br-unconfig
+++ b/t/t5515/fetch.br-unconfig
@@ -1,9 +1,9 @@
 # br-unconfig
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_--tags_.._.git b/t/t5515/fetch.br-unconfig_--tags_.._.git
index 0f70f66c70..3afb4f850d 100644
--- a/t/t5515/fetch.br-unconfig_--tags_.._.git
+++ b/t/t5515/fetch.br-unconfig_--tags_.._.git
@@ -1,6 +1,6 @@
 # br-unconfig --tags ../.git
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
index 74115361ba..525713a2ab 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -2,7 +2,7 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
index 7726983818..18c871f512 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -1,7 +1,7 @@
 # br-unconfig ../.git tag tag-one-tree tag tag-three-file
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
index 7b3750ce5c..7328d30c67 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
@@ -1,7 +1,7 @@
 # br-unconfig ../.git tag tag-one tag tag-three
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899		tag 'tag-three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-default b/t/t5515/fetch.br-unconfig_branches-default
index da30e3c62c..3d82f94376 100644
--- a/t/t5515/fetch.br-unconfig_branches-default
+++ b/t/t5515/fetch.br-unconfig_branches-default
@@ -1,6 +1,6 @@
 # br-unconfig branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-one b/t/t5515/fetch.br-unconfig_branches-one
index e4614314c5..948ed0c3d9 100644
--- a/t/t5515/fetch.br-unconfig_branches-one
+++ b/t/t5515/fetch.br-unconfig_branches-one
@@ -1,6 +1,6 @@
 # br-unconfig branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_config-explicit b/t/t5515/fetch.br-unconfig_config-explicit
index ed323c9871..65aaec8a7b 100644
--- a/t/t5515/fetch.br-unconfig_config-explicit
+++ b/t/t5515/fetch.br-unconfig_config-explicit
@@ -1,9 +1,9 @@
 # br-unconfig config-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_config-glob b/t/t5515/fetch.br-unconfig_config-glob
index 2372ed03c5..1aa3d4598a 100644
--- a/t/t5515/fetch.br-unconfig_config-glob
+++ b/t/t5515/fetch.br-unconfig_config-glob
@@ -1,9 +1,9 @@
 # br-unconfig config-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-explicit b/t/t5515/fetch.br-unconfig_remote-explicit
index 6318dd11b4..16438d2085 100644
--- a/t/t5515/fetch.br-unconfig_remote-explicit
+++ b/t/t5515/fetch.br-unconfig_remote-explicit
@@ -1,9 +1,9 @@
 # br-unconfig remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-glob b/t/t5515/fetch.br-unconfig_remote-glob
index 1d9afad7d8..7a01d2e0f6 100644
--- a/t/t5515/fetch.br-unconfig_remote-glob
+++ b/t/t5515/fetch.br-unconfig_remote-glob
@@ -1,9 +1,9 @@
 # br-unconfig remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master b/t/t5515/fetch.main
similarity index 78%
rename from t/t5515/fetch.master
rename to t/t5515/fetch.main
index 9b29d67200..819ed33bf5 100644
--- a/t/t5515/fetch.master
+++ b/t/t5515/fetch.main
@@ -1,9 +1,9 @@
-# master
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+# main
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master_--tags_.._.git b/t/t5515/fetch.main_--tags_.._.git
similarity index 81%
rename from t/t5515/fetch.master_--tags_.._.git
rename to t/t5515/fetch.main_--tags_.._.git
index ab473a6e1f..ddf67a613b 100644
--- a/t/t5515/fetch.master_--tags_.._.git
+++ b/t/t5515/fetch.main_--tags_.._.git
@@ -1,6 +1,6 @@
-# master --tags ../.git
+# main --tags ../.git
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master_.._.git b/t/t5515/fetch.main_.._.git
similarity index 73%
rename from t/t5515/fetch.master_.._.git
rename to t/t5515/fetch.main_.._.git
index 66d1aaddae..285e57eaf5 100644
--- a/t/t5515/fetch.master_.._.git
+++ b/t/t5515/fetch.main_.._.git
@@ -1,2 +1,2 @@
-# master ../.git
+# main ../.git
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
diff --git a/t/t5515/fetch.master_.._.git_one b/t/t5515/fetch.main_.._.git_one
similarity index 74%
rename from t/t5515/fetch.master_.._.git_one
rename to t/t5515/fetch.main_.._.git_one
index 35deddbd2c..f9f511efbc 100644
--- a/t/t5515/fetch.master_.._.git_one
+++ b/t/t5515/fetch.main_.._.git_one
@@ -1,2 +1,2 @@
-# master ../.git one
+# main ../.git one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
diff --git a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/fetch.main_.._.git_one_tag_tag-one_tag_tag-three-file
similarity index 77%
rename from t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
rename to t/t5515/fetch.main_.._.git_one_tag_tag-one_tag_tag-three-file
index 0672d1292f..187643e2ce 100644
--- a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/fetch.main_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -1,8 +1,8 @@
-# master ../.git one tag tag-one tag tag-three-file
+# main ../.git one tag tag-one tag tag-three-file
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_one_two b/t/t5515/fetch.main_.._.git_one_two
similarity index 83%
rename from t/t5515/fetch.master_.._.git_one_two
rename to t/t5515/fetch.main_.._.git_one_two
index 35ec5782c8..048ad97a15 100644
--- a/t/t5515/fetch.master_.._.git_one_two
+++ b/t/t5515/fetch.main_.._.git_one_two
@@ -1,3 +1,3 @@
-# master ../.git one two
+# main ../.git one two
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/fetch.main_.._.git_tag_tag-one-tree_tag_tag-three-file
similarity index 74%
rename from t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
rename to t/t5515/fetch.main_.._.git_tag_tag-one-tree_tag_tag-three-file
index 0fd737cf81..df5f2a7d5f 100644
--- a/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
+++ b/t/t5515/fetch.main_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -1,7 +1,7 @@
-# master ../.git tag tag-one-tree tag tag-three-file
+# main ../.git tag tag-one-tree tag tag-three-file
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three b/t/t5515/fetch.main_.._.git_tag_tag-one_tag_tag-three
similarity index 75%
rename from t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
rename to t/t5515/fetch.main_.._.git_tag_tag-one_tag_tag-three
index e488986653..a40b72817b 100644
--- a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/fetch.main_.._.git_tag_tag-one_tag_tag-three
@@ -1,7 +1,7 @@
-# master ../.git tag tag-one tag tag-three
+# main ../.git tag tag-one tag tag-three
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899		tag 'tag-three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-default b/t/t5515/fetch.main_branches-default
similarity index 69%
rename from t/t5515/fetch.master_branches-default
rename to t/t5515/fetch.main_branches-default
index 2eedd3bfa4..e3466e8329 100644
--- a/t/t5515/fetch.master_branches-default
+++ b/t/t5515/fetch.main_branches-default
@@ -1,6 +1,6 @@
-# master branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+# main branches-default
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master_branches-one b/t/t5515/fetch.main_branches-one
similarity index 81%
rename from t/t5515/fetch.master_branches-one
rename to t/t5515/fetch.main_branches-one
index 901ce21d33..a94f11af4c 100644
--- a/t/t5515/fetch.master_branches-one
+++ b/t/t5515/fetch.main_branches-one
@@ -1,6 +1,6 @@
-# master branches-one
+# main branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master_config-explicit b/t/t5515/fetch.main_config-explicit
similarity index 78%
rename from t/t5515/fetch.master_config-explicit
rename to t/t5515/fetch.main_config-explicit
index 251c826aa9..16d04c14d2 100644
--- a/t/t5515/fetch.master_config-explicit
+++ b/t/t5515/fetch.main_config-explicit
@@ -1,9 +1,9 @@
-# master config-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+# main config-explicit
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master_config-glob b/t/t5515/fetch.main_config-glob
similarity index 77%
rename from t/t5515/fetch.master_config-glob
rename to t/t5515/fetch.main_config-glob
index 27c158e332..f6a6f56991 100644
--- a/t/t5515/fetch.master_config-glob
+++ b/t/t5515/fetch.main_config-glob
@@ -1,9 +1,9 @@
-# master config-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+# main config-glob
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.master_remote-explicit b/t/t5515/fetch.main_remote-explicit
similarity index 78%
rename from t/t5515/fetch.master_remote-explicit
rename to t/t5515/fetch.main_remote-explicit
index b3cfe6b98b..bf4fd65e00 100644
--- a/t/t5515/fetch.master_remote-explicit
+++ b/t/t5515/fetch.main_remote-explicit
@@ -1,9 +1,9 @@
-# master remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+# main remote-explicit
+b4ab76b1a01ea602209932134a44f1e6bd610832		branch 'main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
diff --git a/t/t5515/fetch.main_remote-glob b/t/t5515/fetch.main_remote-glob
new file mode 100644
index 0000000000..91dc2e26ef
--- /dev/null
+++ b/t/t5515/fetch.main_remote-glob
@@ -0,0 +1,11 @@
+# main remote-glob
+b4ab76b1a01ea602209932134a44f1e6bd610832	not-for-merge	branch 'main' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
+ecf3b3627b498bdcb735cc4343bf165f76964e9a	not-for-merge	tag 'tag-main' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-glob b/t/t5515/fetch.master_remote-glob
deleted file mode 100644
index 118befd1e4..0000000000
--- a/t/t5515/fetch.master_remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# master remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
-- 
gitgitgadget

