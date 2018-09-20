Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189631F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeITXsz (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 19:48:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43688 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeITXsz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:55 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so8661943ioa.10
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoFL34O/3WN167HWDTZOjJ7Q5jnYm70lYMA2ykoccJ4=;
        b=UnJSan6/rBz0TwWMrj808HHf9ZgQIlejMem+AadcOd3gwU7M/QPAchXp1ot1O002rt
         K0qn9HJNFUUzbUcJXGZPFSKGqPKTk+9Ov1jWaq5VfoecMLdV5nL2Wq3Qtly24zIgjYQ7
         MB+/RrxNV1G1f7oOpIg5OiZrTsiHkb9J/rLng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoFL34O/3WN167HWDTZOjJ7Q5jnYm70lYMA2ykoccJ4=;
        b=eU5t06aiFAUPfAJ+X6zzU/CdSTpWST6Rjc68aJaSjzits1hOx/fu6AiCDRpLqgV92O
         26tO1pKhxWx3o7VMU9r6LLWCdKewH2gAlE76Vu31GDjTHDl6okeCX8fRlASym0M/mgpk
         L35cT5j+Se9QDWM3GVlAJq2VoqlPihanNoBHAZieEYf8Gp2kCirdcCcK3SXEqCvBulSM
         NCexRlXZUrfpDuiUvdVY/ixhwVLfYn0eHcTBZpTRJHB12TQA5WVGKchD7D+uecibrziG
         p3tsab8WV/Lc0+1Fnv0Eiv7rDNe1q9aUX4hYBsf0vebxU0zq7jLIYucEDPGjE8Jzk4dX
         v/WA==
X-Gm-Message-State: APzg51ArO247zanQNG9FDi88179TONOQsoujRruhZ1FHfTzY9Ol5rAcX
        5xnj7/sC7VIBrWA+jXY2FqSqrg42DrHpcHfLrKa+O8GV3uP9SdonG0EonZD102yMKcwGBpsyddN
        1R5C2nTCvXnhBwhZ5NfzEC5Hh1POXbxnu4sUxtkGSadtGLz+bQwkKonjJYUmLCQ==
X-Google-Smtp-Source: ANB0VdZI81F4Xso7YQsBdA/fxpbsqVeP09hvgHOyYYhTuraI5owuQyu5WSf7g/C7B0KyJ62wryMpaw==
X-Received: by 2002:a24:198c:: with SMTP id b134-v6mr73019itb.125.1537466653159;
        Thu, 20 Sep 2018 11:04:13 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id y25-v6sm922785ita.3.2018.09.20.11.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:04:12 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 20 Sep 2018 14:04:11 -0400
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
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
 Documentation/config.txt |  6 +++++
 t/t5410-receive-pack.sh  | 47 ++++++++++++++++++++++++++++++++++++++++
 transport.c              | 19 ++++++++++++----
 3 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100755 t/t5410-receive-pack.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 112041f407..b908bc5825 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -616,6 +616,12 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.alternateRefsCommand::
+	When listing references from an alternate (e.g., in the case of ".have"), use
+	the shell to execute the specified command instead of
+	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
+	Output must be of the form: `%(objectname) SPC %(refname)`.
+
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
new file mode 100755
index 0000000000..09fb3f39a1
--- /dev/null
+++ b/t/t5410-receive-pack.sh
@@ -0,0 +1,47 @@
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
+		git update-ref -d refs/heads/a &&
+		git update-ref -d refs/heads/b &&
+		git update-ref -d refs/heads/c &&
+		git update-ref -d refs/heads/master &&
+		git update-ref -d refs/tags/one &&
+		git update-ref -d refs/tags/two &&
+		git update-ref -d refs/tags/three &&
+		printf "../../.git/objects" >objects/info/alternates
+	)
+'
+
+extract_haves () {
+	depacketize - | grep -o '^.* \.have'
+}
+
+test_expect_success 'with core.alternateRefsCommand' '
+	test_config -C fork core.alternateRefsCommand \
+		"git --git-dir=\"\$1\" for-each-ref \
+		--format=\"%(objectname) %(refname)\" \
+		refs/heads/a refs/heads/c;:" &&
+	cat >expect <<-EOF &&
+	$(git rev-parse a) .have
+	$(git rev-parse c) .have
+	EOF
+	printf "0000" | git receive-pack fork | extract_haves >actual &&
+	test_cmp expect actual
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
2.19.0

