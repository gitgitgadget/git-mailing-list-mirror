Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD211F453
	for <e@80x24.org>; Tue,  2 Oct 2018 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJBJEw (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 05:04:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40453 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBJEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 05:04:51 -0400
Received: by mail-io1-f67.google.com with SMTP id w16-v6so544284iom.7
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=blRkCCa7jL7XzjUtbh8l5A7KQ8skfIx6dW2/MvHuV1g=;
        b=UCJz6nI5Fxt/UCZjs8Vk+gRN8x+CuRpWUWYlc1R5yyj323dX2m8Du0eX7MkH3L7tKl
         2CRxZ28W2sIicB44XkycikSC77UjCh0CBLL0wpMX+xjO3gn4Afv1cpf9uXlDQuJ2ez7s
         pEV89zIXeRwBnp/p/Az66+JwA6Q3uhHE4EM8UjVrJcwu+IdTa5/lr7BMrMbEvbg5RX3e
         9I/FcJ5a3TqJSu0MH2ACq8VfsaeW6KGucuD5f0SmaPqeikXWiu9ErqLfJ8aS89mVrNW9
         xPnpKhFvYNdGZosdedzQT2wrPkGuwnmrvinVGDn6QW9+2vlfvnxqc4+gyzsxncFgxF7S
         JbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blRkCCa7jL7XzjUtbh8l5A7KQ8skfIx6dW2/MvHuV1g=;
        b=FpmMofeF+hJnRPf+c88auVHEKCcajNnUZt7p+DxXccd7RttgNs1lUcem/+fITDjN9l
         7o9Yo5ADcPr70m4zMf6wbJg9UhuCRrQ2wzUCnLhNyAgmCgrkjUjR77PZYZMgxhH3cZ7J
         O0vF611hWIZUncRkjdS9GnspmvsAiZ9JgNlm8RE2Mey4MWJ0qjTXNy5I2SfoZLvJsHk2
         FhfIJGzY5fcUC4C8sOG5OHS6qD5Vx/hFiDM99lE353ioit3hpPycz+Elt9hyQs6TeEcl
         GEWSYJruPc/N3HHEj5JbfSreU5Rjt4F924OvcRyUK9Q1liDY1g2bNpa3APyjgp7ewCc6
         Bz9A==
X-Gm-Message-State: ABuFfog3NTfMeHaL7gCfCla0nPepC4Ozb3/46eY2x1vH42OLjQPpWN22
        zsTrsli08ZQB5O+ubpU37iR71V0DNBI89w==
X-Google-Smtp-Source: ACcGV62jLKR9CvjuORIgmhl7AU1hyIErvAQN5dBETz4w9JbYDw787VIN1jHUCFE/c8GM1py3w1+1mQ==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1-v6mr14005318pli.301.1538447040684;
        Mon, 01 Oct 2018 19:24:00 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id h19-v6sm28878222pfk.71.2018.10.01.19.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:23:59 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:23:58 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v4 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <aadb27c0106d8f1a49dd35e7a040131aecaef2c1.1538446827.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538446826.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When in a repository containing one or more alternates, Git would
sometimes like to list references from those alternates. For example,
'git receive-pack' lists the "tips" pointed to by references in those
alternates as special ".have" references.

Listing ".have" references is designed to make pushing changes from
upstream to a fork a lightweight operation, by advertising to the pusher
that the fork already has the objects (via its alternate). Thus, the
client can avoid sending them.

However, when the alternate (upstream, in the previous example) has a
pathologically large number of references, the initial advertisement is
too expensive. In fact, it can dominate any such optimization where the
pusher avoids sending certain objects.

Introduce "core.alternateRefsCommand" in order to provide a facility to
limit or filter alternate references. This can be used, for example, to
filter out references the alternate does not wish to send (for space
concerns, or otherwise) during the initial advertisement.

Let the repository that has alternates configure this command to avoid
trusting the alternate to provide us a safe command to run in the shell.
To find the alternate, pass its absolute path as the first argument.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt           | 16 +++++++++++++++
 t/t5410-receive-pack-alternates.sh | 33 ++++++++++++++++++++++++++++++
 transport.c                        | 19 +++++++++++++----
 3 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100755 t/t5410-receive-pack-alternates.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..ac0577d288 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -616,6 +616,22 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.alternateRefsCommand::
+	When advertising tips of available history from an alternate, use the shell to
+	execute the specified command instead of linkgit:git-for-each-ref[1]. The
+	first argument is the absolute path of the alternate. Output must contain one
+	hex object id per line (i.e., the same as produce by `git for-each-ref
+	--format='%(objectname)'`).
++
+This is useful when a repository only wishes to advertise some of its
+alternate's references as `.have`'s. For example, to only advertise branch
+heads, configure `core.alternateRefsCommand` to the path of a script which runs
+`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
++
+Note that the configured value is executed in a shell, and thus
+linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
+the path argument specially.
+
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
new file mode 100755
index 0000000000..49d0fe44fb
--- /dev/null
+++ b/t/t5410-receive-pack-alternates.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='git receive-pack with alternate ref filtering'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit base &&
+	git clone -s --bare . fork &&
+	git checkout -b public/branch master &&
+	test_commit public &&
+	git checkout -b private/branch master &&
+	test_commit private
+'
+
+extract_haves () {
+	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
+}
+
+test_expect_success 'with core.alternateRefsCommand' '
+	write_script fork/alternate-refs <<-\EOF &&
+		git --git-dir="$1" for-each-ref \
+			--format="%(objectname)" \
+			refs/heads/public/
+	EOF
+	test_config -C fork core.alternateRefsCommand alternate-refs &&
+	git rev-parse public/branch >expect &&
+	printf "0000" | git receive-pack fork >actual &&
+	extract_haves <actual >actual.haves &&
+	test_cmp expect actual.haves
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 2825debac5..e271b66603 100644
--- a/transport.c
+++ b/transport.c
@@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
 static void fill_alternate_refs_command(struct child_process *cmd,
 					const char *repo_path)
 {
-	cmd->git_cmd = 1;
-	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
-	argv_array_push(&cmd->args, "for-each-ref");
-	argv_array_push(&cmd->args, "--format=%(objectname)");
+	const char *value;
+
+	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
+		cmd->use_shell = 1;
+
+		argv_array_push(&cmd->args, value);
+		argv_array_push(&cmd->args, repo_path);
+	} else {
+		cmd->git_cmd = 1;
+
+		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
+		argv_array_push(&cmd->args, "for-each-ref");
+		argv_array_push(&cmd->args, "--format=%(objectname)");
+	}
+
 	cmd->env = local_repo_env;
 	cmd->out = -1;
 }
-- 
2.19.0.221.g150f307af

