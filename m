Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A75C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B7361959
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhC2NnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhC2NnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:43:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D0C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:43:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v4so12884705wrp.13
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QErIW64FPPPYZPUNVnVu4OEzpevMMSwX526arWBsRpg=;
        b=ep1DeKDCWWCQSdal/kTWT69CXeqyyMEhMFAYJEaGiUtggRkvyMAlzh2cmp5/a7PqHX
         rGryIY27+T3VeZAM3FAU6J9/w7RICA0wow+lWEaFW8RM93bVgcCvczNuJVb0snHeqcp9
         4Ah8tSEf08rlCvAVPKf6+GSMzULQluAfB1vk8d6BrMJsB1tAOJ4ze2dLkPgOrTD7omnb
         LfgE9R4XqG2UvS3ElDpMZCbmiLCWrS1hvERxdF9YYOb71rwUL73PWjrxteHJQi8BB3dO
         JbJT7hxpU0BaYSsEcwnYRiwjuTxCPQP6uW7nNuO+pf2qRWzAF/qHiJCGrPY5/u2iadzx
         3wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QErIW64FPPPYZPUNVnVu4OEzpevMMSwX526arWBsRpg=;
        b=NK4OrtwQgyG2MMawWsDvwktGJNU1POOGKWX3kSv2Qei0TL68/qTx4XHbhwESNOrHyo
         EtW4jWQ+OZNywBSRYSFpokhWopJZ2QVVEOFVWO9dGXuTJ0LLGlcEFe9R+bDeQC+dF01Z
         J0Bcz9/pvzn+ViAUnFeDwHK5bZrZLrnEtpVPVvydgS9CSmAdpdTa+hHQlOUXDKY0Cjvl
         Hp1u/l9OKBu4/2VED8sUYRl5w4WmpG4LACVkizLOQuehoufTi4yATLhJo2OP5SkEkgMj
         vS2dhGvmrLcfgNbj4eC3CflqIfQJsbaqgYiQigufcGdAI1YAANxIoPlScJtGkBNRooy5
         ePIQ==
X-Gm-Message-State: AOAM530oC3b0LJ2FrGS2qRmwQfP8gkKcngFMEtYyn7+dqzFwStSAxg1w
        X4DSRc1FUuwGT2U+1wCXjGWZTmFzoXk=
X-Google-Smtp-Source: ABdhPJxf8OA4Rf6rUE12VvY5lcdruA5O65A542vUp5CWjHVIE9CtPqTwyU/v6LNwAxzR/6OjuDxfzg==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr28609683wrj.224.1617025387968;
        Mon, 29 Mar 2021 06:43:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j26sm29950716wrh.57.2021.03.29.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:43:07 -0700 (PDT)
Message-Id: <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
        <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 13:43:04 +0000
Subject: [PATCH v2 2/2] Document how we do embargoed releases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Whenever we fix critical vulnerabilities, we follow some sort of
protocol (e.g. setting a coordinated release date, keeping the fix under
embargo until that time, coordinating with packagers and/or hosting
sites, etc).

Similar in spirit to `Documentation/howto/maintain-git.txt`, let's
formalize the details in a document.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/Makefile                        |   1 +
 .../howto/coordinate-embargoed-releases.txt   | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/howto/coordinate-embargoed-releases.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a049b..874a01d7a86e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,6 +76,7 @@ SP_ARTICLES += howto/rebuild-from-update-hook
 SP_ARTICLES += howto/rebase-from-internal-branch
 SP_ARTICLES += howto/keep-canonical-history-correct
 SP_ARTICLES += howto/maintain-git
+SP_ARTICLES += howto/coordinate-embargoed-releases
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
new file mode 100644
index 000000000000..601aae88e9a3
--- /dev/null
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -0,0 +1,131 @@
+Content-type: text/asciidoc
+Abstract: When a critical vulnerability is discovered and fixed, we follow this
+ script to coordinate a public release.
+
+How we coordinate embargoed releases
+====================================
+
+To protect Git users from critical vulnerabilities, we do not just release
+fixed versions like regular maintenance releases. Instead, we coordinate
+releases with packagers, keeping the fixes under an embargo until the release
+date. That way, users will have a chance to upgrade on that date, no matter
+what Operating System or distribution they run.
+
+Open a Security Advisory draft
+------------------------------
+
+The first step is to https://github.com/git/git/security/advisories/new[open an
+advisory]. Technically, it is not necessary, but it is convenient and saves a
+bit of hassle. This advisory can also be used to obtain the CVE number and it
+will give us a private fork associated with it that can be used to collaborate
+on a fix.
+
+Release date of the embargoed version
+-------------------------------------
+
+If the vulnerability affects Windows users, we want to have our friends over at
+Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
+second Tuesday of the month), at the minimum three weeks from heads-up to
+coordinated release.
+
+If the vulnerability affects the server side, or can benefit from scans on the
+server side (i.e. if `git fsck` can detect an attack), it is important to give
+all involved Git repository hosting sites enough time to scan all of those
+repositories.
+
+Notifying the Linux distributions
+---------------------------------
+
+At most two weeks before release date, we need to send a notification to
+distros@vs.openwall.org, preferably less than 7 days before the release date.
+This will reach most (all?) Linux distributions. See an example below, and the
+guidelines for this mailing list at
+https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists[here].
+
+Once the version has been published, we send a note about that to oss-security.
+As an example, see https://www.openwall.com/lists/oss-security/2019/12/13/1[the
+v2.24.1 mail];
+https://oss-security.openwall.org/wiki/mailing-lists/oss-security[Here] are
+their guidelines.
+
+The mail to oss-security should also describe the exploit, and give credit to
+the reporter(s): security researchers still receive too little respect for the
+invaluable service they provide, and public credit goes a long way to keep them
+paid by their respective organizations.
+
+Technically, describing any exploit can be delayed up to 7 days, but we usually
+refrain from doing that, including it right away.
+
+As a courtesy we typically attach a Git bundle (as `.tar.xz` because the list
+will drop `.bundle` attachments) in the mail to distros@ so that the involved
+parties can take care of integrating/backporting them. This bundle is typically
+created using a command like this:
+
+	git bundle create cve-xxx.bundle ^origin/master vA.B.C vD.E.F
+	tar cJvf cve-xxx.bundle.tar.xz cve-xxx.bundle
+
+Example mail to distros@vs.openwall.org
+---------------------------------------
+
+....
+To: distros@vs.openwall.org
+Cc: git-security@googlegroups.com, <other people involved in the report/fix>
+Subject: [vs] Upcoming Git security fix release
+
+Team,
+
+The Git project will release new versions on <date> at 10am Pacific Time or
+soon thereafter. I have attached a Git bundle (embedded in a `.tar.xz` to avoid
+it being dropped) which you can fetch into a clone of
+https://github.com/git/git via `git fetch --tags /path/to/cve-xxx.bundle`,
+containing the tags for versions <versions>.
+
+You can verify with `git tag -v <tag>` that the versions were signed by
+the Git maintainer, using the same GPG key as e.g. v2.24.0.
+
+Please use these tags to prepare `git` packages for your various
+distributions, using the appropriate tagged versions. The added test cases
+help verify the correctness.
+
+The addressed issues are:
+
+<list of CVEs with a short description, typically copy/pasted from Git's
+release notes, usually demo exploit(s), too>
+
+Credit for finding the vulnerability goes to <reporter>, credit for fixing
+it goes to <developer>.
+
+Thanks,
+<name>
+
+....
+
+Example mail to oss-security@lists.openwall.com
+-----------------------------------------------
+
+....
+To: oss-security@lists.openwall.com
+Cc: git-security@googlegroups.com, <other people involved in the report/fix>
+Subject: git: <copy from security advisory>
+
+Team,
+
+The Git project released new versions on <date>, addressing <CVE>.
+
+All supported platforms are affected in one way or another, and all Git
+versions all the way back to <version> are affected. The fixed versions are:
+<versions>.
+
+Link to the announcement: <link to lore.kernel.org/git>
+
+We highly recommend to upgrade.
+
+The addressed issues are:
+* <list of CVEs and their explanations, along with demo exploits>
+
+Credit for finding the vulnerability goes to <reporter>, credit for fixing
+it goes to <developer>.
+
+Thanks,
+<name>
+....
-- 
gitgitgadget
