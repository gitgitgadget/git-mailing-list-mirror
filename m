Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E6C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhLTXfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:35:20 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F5C06173F
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:19 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p6-20020a63ab06000000b0033fcc84d4f6so5737576pgf.5
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jcr7b7U5owUgVF2fxw0unuqYaKDi7EB2CvpoPhyZzr0=;
        b=Sjmwa1SZk2/nO43qLcEgIJEu0vuukJjKt5eCijS1IZjqYAevPv7T/bzWuPL3ccCOBx
         HzYKBPa91E+bR2KeN0KsrX8YyI3Y2xDSbPpaOonkysudCaA2SWglATBan+vE84uw2k32
         t3O9kaTi4leWIgRD7geTxPij9e3S6pgzpmW5neqOKhIDguGKtKuieSy5Tc/h7Ao5Ljxj
         jrmFO9tZvCeeM9fk3ai1mspqQL9d6j5Oxw1ZauR+PCnGYSmsSNch40Lz/LRCTPea3bt/
         3pRyy4A6EOiHDgGSSz/0NmNdua86iha/iZ7eQjfhxNIM+bvNaU5bb+e3Sr1HestOmnFP
         /PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jcr7b7U5owUgVF2fxw0unuqYaKDi7EB2CvpoPhyZzr0=;
        b=UBrFN+CPpgZWdmUZbfnv4E7SA1n1rRVMUDywaGv5AGn/wvAeqMpQQbsApEJNd4Gl5V
         BESAiA5TQ7YRcYB0iXbGKo5xCIX4u2OHsiCbemiZRTrWfDJFlzx+BJka1VMBpDrm/2PU
         mJsejKNSAtSqk/+XRT4JrsOdnpfCxdbLeDbM826dX91r0eXmKGq+BSxWIIzztznDtM2D
         HFdvqN0SpYOgt0T8W9gMGuZ0wkXUSnU1JxfbPqcdSG62HV2qAHvsU1ejssRAwr4+S+YW
         WipVClwC2WSNsdRl/JRKaT30eLsiwFsaKEMclpUoVGVuA9NJy0/mzykd/qF+XCAdM6mC
         63YA==
X-Gm-Message-State: AOAM532I6/Ong5fNsDax0WiSBPu5ZPHqBNgsoL3yRBx8BM8W2PEssHk0
        0/rVBNVDfqIajFtDhvdCzQ5P/JwIEAThEXieqLXzZzxZi7OpSgdBBymn8pF9Ph7SuaxKruXtbcX
        c4r0nD0Z4eoX/aVKKg4Bp0hz3PSugPWY6FGqAExIyC3Le1cZFtWOSmFJpiO4S7IA=
X-Google-Smtp-Source: ABdhPJxQ8IUKEKUFNsHfRVTM9+lOv+RBz6gj8qYwsjHgsF/8X6lTez5+JGDnUrONMyL3zWPnWpynXpUVyUnMBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8b8a:b0:148:bd36:94ed with SMTP
 id ay10-20020a1709028b8a00b00148bd3694edmr233731plb.44.1640043319048; Mon, 20
 Dec 2021 15:35:19 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:34:58 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com>
Message-Id: <20211220233459.45739-5-chooglen@google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com> <20211220233459.45739-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v6 4/5] builtin/branch: clean up action-picking logic in cmd_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a variable to cmd_branch() that will tell us whether or not
cmd_branch() will default to creating a branch (instead of performing
another action). Besides making the function more explicit, this allows
us to validate options that can only be used when creating a branch.
Such an option does not exist yet, but one will be introduced in a
subsequent commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9b300cf42f..3b010c1d2c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -616,14 +616,15 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
-	int show_current = 0;
-	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
+	/* possible actions */
+	int delete = 0, rename = 0, copy = 0, list = 0,
+	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	const char *new_upstream = NULL;
+	int noncreate_actions = 0;
+	/* possible options */
+	int reflog = 0, quiet = 0, icase = 0, force = 0;
 	enum branch_track track;
 	struct ref_filter filter;
-	int icase = 0;
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -708,8 +709,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
 		list = 1;
 
-	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
-	    list + edit_description + unset_upstream > 1)
+	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
+			    !!show_current + !!list + !!edit_description +
+			    !!unset_upstream;
+	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (filter.abbrev == -1)
@@ -849,7 +852,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
-	} else if (argc > 0 && argc <= 2) {
+	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
-- 
2.33.GIT

