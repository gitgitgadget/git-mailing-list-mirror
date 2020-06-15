Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A05C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC82074D
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGg2pJrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgFOMu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgFOMuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E74C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so16964639wrn.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5eciXjP3A0kZgZdCkbG3UajYVXze7AY+JNBAkYkxsJM=;
        b=cGg2pJrTT8yzDxUEp+rosJenOVi43RSLZ3oPdTNQhOdQreCVo7YJYdusseCDNWVNgd
         /2LJE1WVxThTBNQUOZ5iD4stw9bwVWkut+b1kCeWVlp4rrJc586leGiGkjdy1eyPYAgP
         swolbHg8bx/TIxuX2n/mnByh8R+G7IgeDAKqaD/dSIxOPqjT6J0hzW2pFMfOxCTWOnrR
         RBu54Ej+rYlGIPW75pCIgvUu+kU3WVP7lcl0ynPT6Yc+VZ9IV3YUbQBjqMQ1Qko/fZ/R
         E4B9PiHPftP3MIFI+UEosk41XJv1nryIyec3P4MdBZ4bXb/ToVydHlv4y3rS1/rbXThZ
         WHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5eciXjP3A0kZgZdCkbG3UajYVXze7AY+JNBAkYkxsJM=;
        b=kpSBUhBptKqPOzzS3C21ggMP7fApg6j9elvmu4YqDFkG4dc2rNzINiarvkPrt9XtcY
         kM/Y7ZvDPw/DzmK4GDyTpj9LtOCuTANPI+JKGbGqZarw+fc8qtX99bNanP2+p3mqa8ma
         FWfasp7IleL3/XXJzCh37Ql4oB0YnvTzeOYYi8ARcX128YJw2KrtjuGYkfxXGIdwOeQl
         5GRjbgow8xiT4U4EztfU+uBLTvnaRKKWLaWTZQxvxLdYvmZCyjvTiQC0erO/flKn5Nee
         qBvfFOn2H7rLGIN9C3SQBfmvvnfzTKO/s93g9jsGQFz/SFNPQqM+KwL/rGHE4mAwfxKw
         y8Kg==
X-Gm-Message-State: AOAM531l9ujizwpDbnewqtZSX+WcWNowuHNr67SBd0MthCJgxUHv1aWO
        De+as0WEjap2W4wXZSO4J3GvyLpL
X-Google-Smtp-Source: ABdhPJxgC4/tbUw883BqKh+K7fZFMq5urafAJjaeFDQ4HiA2HaPp6Ei5NA0VMZYxViSTbYgZXRcX9A==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr28658307wrw.295.1592225420584;
        Mon, 15 Jun 2020 05:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm23670828wma.15.2020.06.15.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:19 -0700 (PDT)
Message-Id: <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:06 +0000
Subject: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the main
 branch name
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

There is a growing number of projects and companies desiring to change
the main branch name of their repositories (see e.g.
https://twitter.com/mislav/status/1270388510684598272 for background on
this).

However, there are a couple of hard-coded spots in Git's source code
that make this endeavor harder than necessary. For example, when
formatting the commit message for merge commits, Git appends "into
<branch-name>" unless the current branch is the `master` branch.

Clearly, this is not what one wants when already having gone through all
the steps to manually rename the main branch (and taking care of all the
fall-out such as re-targeting existing Pull Requests).

Let's introduce a way to override Git's hard-coded default:
`core.mainBranch`.

We will start supporting this config option in the `git fmt-merge-msg`
command and successively adjust all other places where the main branch
name is hard-coded.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/core.txt |  5 +++++
 fmt-merge-msg.c               |  6 ++++--
 refs.c                        | 27 +++++++++++++++++++++++++++
 refs.h                        |  7 +++++++
 t/t6200-fmt-merge-msg.sh      |  7 +++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03b..32bb5368ebb 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -626,3 +626,8 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
+
+core.mainBranch::
+	The name of the main (or: primary) branch in the current repository.
+	For historical reasons, `master` is used as the fall-back for this
+	setting.
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 72d32bd73b1..43f4f829242 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 				const char *current_branch)
 {
 	int i = 0;
-	char *sep = "";
+	char *sep = "", *main_branch;
 
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
@@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
-	if (!strcmp("master", current_branch))
+	main_branch = git_main_branch_name();
+	if (!strcmp(main_branch, current_branch))
 		strbuf_addch(out, '\n');
 	else
 		strbuf_addf(out, " into %s\n", current_branch);
+	free(main_branch);
 }
 
 static void fmt_tag_signature(struct strbuf *tagbuf,
diff --git a/refs.c b/refs.c
index 224ff66c7bb..f1854cffa2f 100644
--- a/refs.c
+++ b/refs.c
@@ -560,6 +560,33 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
 		argv_array_pushf(prefixes, *p, len, prefix);
 }
 
+char *repo_main_branch_name(struct repository *r)
+{
+	const char *config_key = "core.mainbranch";
+	const char *config_display_key = "core.mainBranch";
+	const char *fall_back = "master";
+	char *name = NULL, *ret;
+
+	if (repo_config_get_string(r, config_key, &name) < 0)
+		die(_("could not retrieve `%s`"), config_display_key);
+
+	ret = name ? name : xstrdup(fall_back);
+
+	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
+		die(_("invalid branch name: %s = %s"),
+		    config_display_key, name);
+
+	if (name != ret)
+		free(name);
+
+	return ret;
+}
+
+char *git_main_branch_name(void)
+{
+	return repo_main_branch_name(the_repository);
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
diff --git a/refs.h b/refs.h
index a92d2c74c83..a207ef01348 100644
--- a/refs.h
+++ b/refs.h
@@ -154,6 +154,13 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
+/*
+ * Retrieves the name of the main (or: primary) branch of the given
+ * repository.
+ */
+char *git_main_branch_name(void);
+char *repo_main_branch_name(struct repository *r);
+
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index e4c2a6eca43..7a873f4a05c 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -158,6 +158,13 @@ test_expect_success 'setup FETCH_HEAD' '
 	git fetch . left
 '
 
+test_expect_success 'with overridden default branch name' '
+	test_when_finished "git switch master" &&
+	git switch -c default &&
+	git -c core.mainBranch=default fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	! grep "into default" actual
+'
+
 test_expect_success 'merge.log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
-- 
gitgitgadget

