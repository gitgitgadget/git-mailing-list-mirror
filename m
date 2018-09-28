Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363D31F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeI1Krb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 06:47:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43433 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1Krb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 06:47:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so3467190pgn.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdAKBB/YujPY1YCvJCWtA3s+Q/iGGV68itQTZJCXFVM=;
        b=H/YFiQp6vhtGGFlr9vDwFh2fhFBmjsae6K13twYYKh03i/k1tIkNHvTldQTFdmcrwV
         T7XD9+foIeLlpTjlJ4qvtpQzYR7KkAFcVeVYse/Kq3qhWJa5TX3w3VFan3Sdke1e+Ta8
         wE5GtHvMcmEkw0cQ4x8UJikZhQrG5ah0Xim5jCXlTbEZFarx1rlYezKDatDKyBL+5nIK
         Pc3V8Ra7DD96BwPHxAxcexNPNx2YUVS+CfFLfRII0ou+Xv6iKSiY7axfh52LNxALmNyV
         e9F21vyIaix86yVWiBpODaXC3OIyBfdeMbwVhUjm5tpaPE2lkogBROMa6BOqEguaBcUe
         M2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdAKBB/YujPY1YCvJCWtA3s+Q/iGGV68itQTZJCXFVM=;
        b=j5hj0JoZ9n6/MtRR+qaY0TvMXUwvWxZ9BoJ2ZS+MLbMpqpur0GWcBioCG6jvVRUR+6
         029Ul4x14JtnDvNn63pCfQbfhY4slh1b693B0PpQKplpLdWOC5HVcVMgKagBKSENRHwi
         rDo4dFLfYKaYSqfumGy6krt/8CVhZwhiMR1pW6qBTma0HTznE7gOW+Dr5/bxxeg/ckm6
         I6Cu4lomg9vmPgpJcr3K6Wya6xNQW2N1y7bWqon6u87lNPpQKGBWCZdoVIvK3Ep5Dk/H
         v8IQEgK8JSRflo32B1f55EBZyS2xO9f/MYuapuKQLEbZYvjJ7F7cGPZb0QXxA7K2f703
         dnfg==
X-Gm-Message-State: ABuFfoiaxd1X+GEZw3ENC49+UigAtw9j8VriW9L3AB8jCV73efjtVPvz
        zCRHujad7eYagDgBYIgz/EfEKYg7V1rOhg==
X-Google-Smtp-Source: ACcGV636RsjIdS/7HQxAf7VZiPPV9bW0h7qBUW+n5LDwW8Kcfeat3dm0do1YKcpfFK7pUvdPMUY7Kw==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr3789324pgm.227.1538108744414;
        Thu, 27 Sep 2018 21:25:44 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id b14-v6sm5779781pfc.178.2018.09.27.21.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 21:25:43 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:25:42 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v3 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <2dbcd5419073f06def007be3746ce90fffaf6a6d.1538108385.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538108385.git.me@ttaylorr.com>
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
To behave differently on each alternate (e.g., only list tags from
alternate A, only heads from B) provide the path of the alternate as the
first argument.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt | 11 +++++++++
 t/t5410-receive-pack.sh  | 49 ++++++++++++++++++++++++++++++++++++++++
 transport.c              | 19 ++++++++++++----
 3 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100755 t/t5410-receive-pack.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..afcb18331a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -616,6 +616,17 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.alternateRefsCommand::
+	When advertising tips of available history from an alternate, use the shell to
+	execute the specified command instead of linkgit:git-for-each-ref[1]. The
+	first argument is the absolute path of the alternate. Output must be of the
+	form: `%(objectname)`, where multiple tips are separated by newlines.
++
+This is useful when a repository only wishes to advertise some of its
+alternate's references as ".have"'s. For example, to only advertise branch
+heads, configure `core.alternateRefsCommand` to the path of a script which runs
+`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
+
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
new file mode 100755
index 0000000000..503dde35a4
--- /dev/null
+++ b/t/t5410-receive-pack.sh
@@ -0,0 +1,49 @@
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
+		git update-ref --stdin <<-\EOF &&
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
+extract_haves () {
+	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
+}
+
+test_expect_success 'with core.alternateRefsCommand' '
+	write_script fork/alternate-refs <<-\EOF &&
+		git --git-dir="$1" for-each-ref \
+			--format="%(objectname)" \
+			refs/heads/a \
+			refs/heads/c
+	EOF
+	test_config -C fork core.alternateRefsCommand alternate-refs &&
+	git rev-parse a c >expect &&
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

