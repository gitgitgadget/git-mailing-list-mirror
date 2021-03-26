Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABDCC433E3
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB63261A28
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCZWNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCZWMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 18:12:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4048C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 15:12:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so3681561wmk.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QErIW64FPPPYZPUNVnVu4OEzpevMMSwX526arWBsRpg=;
        b=eg/ckB0p8J+KrrHdYOtD+5Cl7QjZSHx1n82PKD1TfVxoDD3gc+RPiunfCimfhVWIQY
         2J3CLnkuPecs+THdRaQczRX0U1HupuaKIVy1unIo3+dCXx/SZrIZfgpB08Uo1YT1fmad
         zDCyOFlgnMip+aJDoV9kg1G3s+9rk00kQnoHGUFcX6D7LIuwFYjmiH1c3rWk1oNGKP/w
         ZHZH9hbGZDaE4DI6gD2lITlKGauKXcLElD6chrxnva7fFwxTtXEQ8cXRDEz/8BA55T2O
         NfidCdzj5R2r4GRTktgR3HLfJVHkPlrODC1sADFNHkaDhVi0PNLNFjjH6GT5AwQ2ketr
         ZInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QErIW64FPPPYZPUNVnVu4OEzpevMMSwX526arWBsRpg=;
        b=limPnFt7ulVYEPify1msAwKcczQKGg3lZdpkpvbYS4nbQmIPJMoF0w5K3gCk2IRd3x
         UOPcEE3IjSlT8QrGjXStPXQ3iJVoq/zSerjScjGXuyzFTWpWll8uJ5HPh0p9IMVdV3FM
         l2rhCf1MT44g9PPHCaWALl8z0YU0XN64U9gr5poBAyELuD8PTBi9taTYPrY8gZvYfCU4
         xp65Ra/in0ZJFybut3/M0Wvzsj/iZfV9zNR6YKKYMo9hO+4gLMGCTQy6mDSLH6ky34iO
         bTvZV5NNj6JH+mjQNvChIKY4U2W2LNYxZdwV49lAiGBmNK4QwLK0/7PAxNjvmwpgZSNb
         l8lQ==
X-Gm-Message-State: AOAM531DOWr6cJ3mv/lpqGkihNycd9uc41UUyABV3Tvr1Gb/MP7ihieL
        DvDN/yIncuq09uKVKFtp29BXBJ/Gbmw=
X-Google-Smtp-Source: ABdhPJxdOuKgW88pYENMJByhnprx8gcHAcS9j1fjXQAF6iO6KV0ggGbMS8JQ7KGNEOndPGnOpe5q4g==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr14766020wmj.44.1616796769664;
        Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f126sm12499354wmf.17.2021.03.26.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
Message-Id: <41efaaf62864c353f828d1b6f0a8e4203c658e14.1616796767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.917.git.1616796767.gitgitgadget@gmail.com>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 22:12:46 +0000
Subject: [PATCH 2/2] Document how we do embargoed releases
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
