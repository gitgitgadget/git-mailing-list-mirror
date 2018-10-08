Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458A91F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJIBW0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:22:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35538 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:22:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so4362365pff.2
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OO+NGL0PaPgxh3RgxL9DTPFybWyOW8DwyS8Nrz7R4Ug=;
        b=Wv2RrVbXjofcv/EMwkT9qKrc/Gp3gE0lSxa0nv0+NR4vRFToY/Qb4XyMyIBA2wYa1M
         DfnxefLO9W9wgMyDgte3syC09nJF8G8ZbN9SteWt6MXpahgjQeqH7zQMclhkGBSqHrdv
         GbZvG8X9KsGGEZ8C3qt2VTU/qA8kIVE7G5XfPedf3/8PemSacYF9ie0pvlAy4w0bhw4g
         dhn9Uz25S2XCjzRWjv/JNlmVASkDnUKY28DPErSmEauH3Gt6/qWXAeLLcYmMVVqoDCOA
         j3vDMtSXSZPOfeloC7M9PmkVJR2+0To5IhsRp/qUrRFkxdzsZUpJ2h99UctdAH0t3Bwr
         zP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OO+NGL0PaPgxh3RgxL9DTPFybWyOW8DwyS8Nrz7R4Ug=;
        b=HqSTmV7aMPgTbQlHQqWE3X6/glyw2mUbwR/ZQ9q4V4f0MO3lM5z7NFBN2qWNGU8HM1
         Wq0NV9xaaJWowmHu99De+mMRt9oityQ2ttWLYZFVPIJs5LClMWoNvfOER0sH+TGWEPr2
         Mwbz8ZME8anmrZs9TFNj+BA376KMNpNwGfc1Rnvv60vM8SnLq9MwF3U13k2a9q2zWjcB
         YRK779KBFtAowMHzN/Hla5ZTxk+15oPc14BcKeE6NlPn87iWWvCAAKQXCWRVpHipcDKb
         5bK+iF+DYL+DxCWlGu7P2w+jmjqI1xgJSGYWLAZzhK1SJdgHXlG6mLbp8ZPjlH0iDiOC
         zZBQ==
X-Gm-Message-State: ABuFfoj96yoDQ4DwOYIvl6leHyd1FV2Yf/XiIQ0sM2u/9kfhlphauZAE
        HdSvFrn4TbwueyQ10lU0irLQQH9Kkjw=
X-Google-Smtp-Source: ACcGV61S/XMwMTADGxUkxHMDPtKZhLNjlBryWLofrPi6/sNlXwDc/ZVsyuX0EfU7QQNh3YWoo4F50w==
X-Received: by 2002:a62:6506:: with SMTP id z6-v6mr11666527pfb.20.1539022169364;
        Mon, 08 Oct 2018 11:09:29 -0700 (PDT)
Received: from localhost ([205.175.107.112])
        by smtp.gmail.com with ESMTPSA id r1-v6sm25493611pfb.41.2018.10.08.11.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:09:28 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:09:28 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v5 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <7451b4872a0fd66d84cbe492fdfe7a9a8e81eab7.1539021825.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1539021825.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539021825.git.me@ttaylorr.com>
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
 Documentation/config.txt           | 11 ++++++++++
 t/t5410-receive-pack-alternates.sh | 33 ++++++++++++++++++++++++++++++
 transport.c                        | 19 +++++++++++++----
 3 files changed, 59 insertions(+), 4 deletions(-)
 create mode 100755 t/t5410-receive-pack-alternates.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..c51e82d8a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -616,6 +616,17 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.alternateRefsCommand::
+	When advertising tips of available history from an alternate, use the shell to
+	execute the specified command instead of linkgit:git-for-each-ref[1]. The
+	first argument is the absolute path of the alternate. Output must contain one
+	hex object id per line (i.e., the same as produce by `git for-each-ref
+	--format='%(objectname)'`).
++
+Note that you cannot generally put `git for-each-ref` directly into the config
+value, as it does not take a repository path as an argument (but you can wrap
+the command above in a shell script).
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

