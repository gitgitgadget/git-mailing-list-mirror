Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE1C433E3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1329820739
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg/FqFNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgFOMuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgFOMu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC6C05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j10so16987841wrw.8
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KUSW/LMfErEU+o+bgmyqi28zwkmpMAEYMhtQnAQ6sn0=;
        b=Xg/FqFNQUmTdZBuwHeQ5UGXdXVpCPMHLZZPGwYNOxiAraXPJU93VUcN+DA4E2BJvVp
         qfINwz0GNPx9dKwg1Y4e4hKVLbeHguqGFsXDTG9oJP3EOGWFLH6PtQe8irvEX4gbfKHS
         K28X3wCTxL9jSJp6ipBFPDiI8lyYMMaAOtZd1BMHFOYyp0oWr6lJxqlSfW3X93ndwlBK
         OGIaNqdcdS9stDQpNz7q5Go2/WLD8uJXYKOfMcnT/vFtMnyQhAA9dUUbHiknk+T5bfIF
         mdv6drtFFu9OB8CnDOEUK/PRi9h2B2+xXN9OIrxbjzCp+PZwxb+nSFz5KJfvNyrA9OaO
         B7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KUSW/LMfErEU+o+bgmyqi28zwkmpMAEYMhtQnAQ6sn0=;
        b=KV538oZuboTDKZcF8sQWfRork2mE+jBW6QdquAfdeTQCO4hmIdIAj23kGyfPfmngWo
         0y0tdSsZk0eprEQNDNBYE9R0lbHvc7C/H45dgg6ALcpzhKjTWmhBbJ+690FjRHMqDZAQ
         i+5hYtFH1cg839m+3s07m1as3qdmHBvLL9S5dcsa51w5OxOmU41qgKg/JNu84t3MF3Ax
         iCDj94G2F5Lcopkknj2+w64dmk2IQ/mxIrpeaEJA74LVhH7FEPcti2c5AUordBQisVde
         aGmRSKlSBVJcLF9Mb7emXjMeRJJcG6MW2F3qcHcPzSmXqcvt9Jmv2HfHV5YsFHT2cwow
         A4EQ==
X-Gm-Message-State: AOAM533BWdP4KVJVrahXq+OhBgVGu53Q151iWuocNER95YXxQYxifJPB
        T57n2BNaefL/RnRtsdrHA173tEJ2
X-Google-Smtp-Source: ABdhPJwjXnsIwZ07/pQAaifR7NwmURZs/6pAPQAEfQf5tGoWktmk+R6IS+GsZ1LcXxIUsHbkLTg/bg==
X-Received: by 2002:adf:feca:: with SMTP id q10mr26631823wrs.380.1592225426869;
        Mon, 15 Jun 2020 05:50:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm24574873wrn.42.2020.06.15.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:26 -0700 (PDT)
Message-Id: <0e59b6181699abe17eb46fe3ca5a48ce71889780.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:13 +0000
Subject: [PATCH v2 09/12] clone: handle overridden main branch names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When cloning a repository without any branches, Git chooses a default
branch name for the as-yet unborn branch.

As part of the implicit initialization of the local repository, Git
just learned to respect `init.defaultBranch` to choose a different main
branch name. We now really want that branch name to be used as a
fall-back.

At the same time, we also want to make sure that `core.mainBranch` is
set correctly, reflecting the name of the main branch. In case we detect
a main branch, we do have to do that explicitly, otherwise `init_db()`
will already have done that for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/init.txt |  4 ++--
 builtin/clone.c               | 16 +++++++++++++---
 t/t5606-clone-options.sh      | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index 6ae4a38416e..dc77f8c8446 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -3,5 +3,5 @@ init.templateDir::
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
 init.defaultBranch::
-	Allows overriding the default branch name when initializing
-	a new repository.
+	Allows overriding the default branch name e.g. when initializing
+	a new repository or when cloning an empty repository.
diff --git a/builtin/clone.c b/builtin/clone.c
index 487b0a42d75..755fcaeb0ba 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -718,6 +718,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
+		git_config_set("core.mainbranch", head);
 		if (!option_bare) {
 			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
@@ -1264,9 +1265,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head_points_at = NULL;
 		remote_head = NULL;
 		option_no_checkout = 1;
-		if (!option_bare)
-			install_branch_config(0, "master", option_origin,
-					      "refs/heads/master");
+		if (!option_bare) {
+			char *main_branch =
+				git_main_branch_name(MAIN_BRANCH_FULL_NAME);
+			const char *nick;
+
+			if (!skip_prefix(main_branch, "refs/heads/", &nick))
+				BUG("unexpected default branch '%s'",
+				    main_branch);
+			install_branch_config(0, nick, option_origin,
+					      main_branch);
+			free(main_branch);
+		}
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 9e24ec88e67..98b2d8527f6 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -35,4 +35,21 @@ test_expect_success 'redirected clone -v does show progress' '
 
 '
 
+test_expect_success 'chooses correct default main branch name' '
+	git init --bare empty &&
+	git -c init.defaultBranch=up clone empty whats-up &&
+	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
+	test up = $(git -C whats-up config core.mainBranch) &&
+	test refs/heads/up = $(git -C whats-up config branch.up.merge)
+'
+
+test_expect_success 'guesses main branch name correctly' '
+	git init --main-branch=guess main-branch &&
+	test_commit -C main-branch no-spoilers &&
+	git -C main-branch branch abc guess &&
+	git clone main-branch is-it &&
+	test guess = $(git -C is-it config core.mainBranch) &&
+	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
+'
+
 test_done
-- 
gitgitgadget

