Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1111F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbeIVAh5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:37:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38988 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:37:57 -0400
Received: by mail-it1-f194.google.com with SMTP id h1-v6so3066703itj.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uwBRAdsZiCrfA7VTi0AOd1WYGt6uOM8bI/XpTa2DQ1U=;
        b=PnzqZij28/AUkCFwmVUL64uCOai/DEnlll7Pp+fkYR6bGYBTed4XezJqiyXYBZMoxd
         Vk5X9ML1tT17TSoacdIMbin3wGWx55uPUthFzTL+mHFLG2IS/y9FuFr4xeTmAWGsbO5X
         sLXAYGSwc71S/KfF5jU5aXNmrGxXexXJLG80MVnpg3yVJhD0awDEV1sYbMM6WNYnq97k
         b4/PTLDP5mQO4p5m6bSpGSx3xTErDGcgel0aYdcwap5f3aHvcWcQKhHJDqMP+ftnyLom
         xGtveIMAHsFfleypYHQMUvofko2A2IFUej5CsvRgAvpbZoPzrnDmZEZryrSU5T5ZCKwI
         8B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uwBRAdsZiCrfA7VTi0AOd1WYGt6uOM8bI/XpTa2DQ1U=;
        b=giYCLoHEycllv9+z6uUSJDLZa4JJqLizYns4cFSf15+rNUYBevHM0WLrXCxy9SpIv9
         sFQmrtj1UySDnucQaYGoTdOfcTEw6mbHPLHZJmpeRNItFhHJz8fIysSe9llfwwHD3Aeb
         MvofxpfN9IlwXdmC02yMq1+g2LytdgWr55XnoIo6N3UJXsFMcn0diOZDaLKwZyM6yJa6
         /meTEy8QmbJ+3rpsON0Xlpv4spGrAQJwxwSHXgaoA7Hl727WuJUp+X4j1guqT2Z0Lf4S
         G9mPN/Abx+1/tcojxC6f3oWPRzCYkdFUmfm+14eOXugu9XlFM1w7k4/B2Ch6yJb9L29G
         0nUA==
X-Gm-Message-State: APzg51A64nkqDNK2ioAghKpPiJjTLyFLtTZz0T3hxkGwNrRwJuv4BqBa
        TySnBkG4vJcTqWcLTHWjnQWn6PXA4JA=
X-Google-Smtp-Source: ANB0VdZoWr5O6b/oXkFbKpozp8iafxetMEDIM2MO911oeGTmmuKd/FVg0S41b5IG3yEIk4q37dHC+g==
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr42463108jaf.70.1537555665126;
        Fri, 21 Sep 2018 11:47:45 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id 68-v6sm977162iou.88.2018.09.21.11.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:47:44 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:47:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537555544.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When in a repository containing one or more alternates, Git would
sometimes like to list references from its alternates. For example, 'git
receive-pack' list the objects pointed to by alternate references as
special ".have" references.

Listing ".have" references is designed to make pushing changes from
upstream to a fork a lightweight operation, by advertising to the pusher
that the fork already has the objects (via its alternate). Thus, the
client can avoid sending them.

However, when the alternate has a pathologically large number of
references, the initial advertisement is too expensive. In fact, it can
dominate any such optimization where the pusher avoids sending certain
objects.

Introduce "core.alternateRefsCommand" in order to provide a facility to
limit or filter alternate references. This can be used, for example, to
filter out "uninteresting" references from the initial advertisement in
the above scenario.

Let the repository that has alternates configure this command to avoid
trusting the alternate to provide us a safe command to run in the shell.
To behave differently on each alternate (e.g., only list tags from
alternate A, only heads from B) provide the path of the alternate as the
first argument.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt | 11 ++++++++
 t/t5410-receive-pack.sh  | 54 ++++++++++++++++++++++++++++++++++++++++
 transport.c              | 19 +++++++++++---
 3 files changed, 80 insertions(+), 4 deletions(-)
 create mode 100755 t/t5410-receive-pack.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 112041f407..526557e494 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -616,6 +616,17 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.alternateRefsCommand::
+	When listing references from an alternate (e.g., in the case of ".have"), use
+	the shell to execute the specified command instead of
+	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
+	Output must be of the form: `%(objectname) SPC %(refname)`.
++
+This is useful when a repository only wishes to advertise some of its
+alternate's references as ".have"'s. For example, to only advertise branch
+heads, configure `core.alternateRefsCommand` to the path of a script which runs
+`git --git-dir="$1" for-each-ref refs/heads`.
+
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
new file mode 100755
index 0000000000..2f21f1cb8f
--- /dev/null
+++ b/t/t5410-receive-pack.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='git receive-pack test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	git update-ref refs/heads/a HEAD &&
+	test_commit two &&
+	git update-ref refs/heads/b HEAD &&
+	test_commit three &&
+	git update-ref refs/heads/c HEAD &&
+	git clone --bare . fork &&
+	git clone fork pusher &&
+	(
+		cd fork &&
+		git config receive.advertisealternates true &&
+		cat <<-EOF | git update-ref --stdin &&
+		delete refs/heads/a
+		delete refs/heads/b
+		delete refs/heads/c
+		delete refs/heads/master
+		delete refs/tags/one
+		delete refs/tags/two
+		delete refs/tags/three
+		EOF
+		echo "../../.git/objects" >objects/info/alternates
+	)
+'
+
+expect_haves () {
+	printf "%s .have\n" $(git rev-parse $@) >expect
+}
+
+extract_haves () {
+	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
+}
+
+test_expect_success 'with core.alternateRefsCommand' '
+	write_script fork/alternate-refs <<-\EOF &&
+		git --git-dir="$1" for-each-ref \
+			--format="%(objectname) %(refname)" \
+			refs/heads/a \
+			refs/heads/c
+	EOF
+	test_config -C fork core.alternateRefsCommand alternate-refs &&
+	expect_haves a c >expect &&
+	printf "0000" | git receive-pack fork >actual &&
+	extract_haves <actual >actual.haves &&
+	test_cmp expect actual.haves
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 24ae3f375d..e7d2cdf00b 100644
--- a/transport.c
+++ b/transport.c
@@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
 static void fill_alternate_refs_command(struct child_process *cmd,
 					const char *repo_path)
 {
-	cmd->git_cmd = 1;
-	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
-	argv_array_push(&cmd->args, "for-each-ref");
-	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
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
+		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
+	}
+
 	cmd->env = local_repo_env;
 	cmd->out = -1;
 }
-- 
2.19.0.221.g150f307af

