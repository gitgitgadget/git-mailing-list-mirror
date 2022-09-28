Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A2CC6FA82
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiI1IlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiI1IkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CF7EFEE
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so1926151wmr.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iS4aofdSIzdS9pVJZ4hp637Rx6OQqW6J/SQPZPLugME=;
        b=mqYQieDJedM156pfgPQbs1EIeZPJy11uOWXcOWWWOoYX+i9g8sAuU/90gugvHcuNtz
         4skwZq/vxAo7tuWSy3AJRfOZ935Ui+QyAMZwszvOZdKHQtQvpmJCGj2wMNXeMG9rQP7n
         IdV6WNujEJIkwuEY8DgfFmlH+blWQbEHGTo/NCmEMlZsq8/EjWHtN66F4UUvpFoK9ZAv
         Tcmu0WcitmKuj/AzSRl/dnq+0f0+v1JledMnip9pU6i8n+Q+smpCaZrDYHzpdKc8Nmqi
         FaUskrpIZDauhBJZEFKYzc2oe0snx0w9wV35fMbWDXpX62FNhtyJOZq9CDx0EkEoZaqM
         ndAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iS4aofdSIzdS9pVJZ4hp637Rx6OQqW6J/SQPZPLugME=;
        b=np4KLbsQYpvLOlAo85M8iIKsI6N5J+L1+Un8tib/YG3JrPCbStleKfv2mHl6JAfZrp
         T2gFYGStrrn5eFvb5dfoXXL+m8/eM3/gW0K0qZBmsgcZcvWBj2Nsr3S3fi637PPOY4P5
         7OAJXljatHhvdRBjlZ6oJIkFBrGU8Y0xn1fcxhXByHiFqeJ/qLkFW4okUczxSV74zzcA
         05EHOOxyZN7qOLNp/AVNoxShPMiOuP2J67Xy3hipAsZKXO2ct6A7pcZHc8DSvB46pNEP
         tnijZk+czlRuGE6mOsT3KvoKaOU1zeK/4MhAMf1gBUAVdXcD1WcFdnnvCFll84lLCPxi
         Ervg==
X-Gm-Message-State: ACrzQf1zrBxJw+UC3Vw5XE3lukJXWcMRz28CwhQFfsD6Sbtx+RTv7LMU
        c1EqVN2L0YkXN36SKV4cSHJSum/WPyxl1A==
X-Google-Smtp-Source: AMsMyM4D3yRM97r+o9e0A/cQ6EwwDoHn0EzCoPL1XzfEjdVe6m9aFwfkD+BbFhnOg1S1DTLOxFXI9Q==
X-Received: by 2002:a05:600c:1d26:b0:3b4:a677:ccc9 with SMTP id l38-20020a05600c1d2600b003b4a677ccc9mr5774178wms.121.1664354399310;
        Wed, 28 Sep 2022 01:39:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 22/35] doc txt & -h consistency: make "read-tree" consistent
Date:   Wed, 28 Sep 2022 10:39:17 +0200
Message-Id: <patch-v2-22.35-fde75be474a-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C version was right to use "()" in place of "[]", let's update
the *.txt version accordingly, and furthermore list the *.c options in
the same order as the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-read-tree.txt | 2 +-
 builtin/read-tree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index b9bfdc0a319..7567955bad8 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -9,7 +9,7 @@ git-read-tree - Reads tree information into the index
 SYNOPSIS
 --------
 [verse]
-'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+'git read-tree' [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)
 		[-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index b3a389e1b1f..f4cbe460b97 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -39,7 +39,7 @@ static int list_tree(struct object_id *oid)
 
 static const char * const read_tree_usage[] = {
 	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
-	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
+	   "              [-u | -i]] [--index-output=<file>] [--no-sparse-checkout]\n"
 	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
-- 
2.38.0.rc1.925.gb61c5ccd7da

