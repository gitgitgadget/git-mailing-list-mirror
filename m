Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F2D206FB
	for <e@80x24.org>; Thu,  3 Nov 2016 00:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbcKCAuj (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 20:50:39 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36080 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbcKCAui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 20:50:38 -0400
Received: by mail-pf0-f173.google.com with SMTP id 189so20792426pfz.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=++zgEp7LxKHUdHA2WjMuL2Jjjh/tNHVuSBA9eFYt1oo=;
        b=PzaoF2BsCwkoSh9WIGHji+rdZDlOs8P5uB0WnaojGvjhgTbc9YSbijSpfg9mE6S0qz
         FDLEKHvOfm/wahzh4JuUJs52K77DPEGQhb2gpm1NNnVOuPiXn18B+nqOkc7RpiB9asK4
         AYP3j+XQJw3ZXKwJpTpJLSRSBmjAEYq2h0oOenaQaz5PnzNvz37rrp1tx9Tjefx+kaFv
         Xx98jPWNL3WIVB5o6qi3uuFbwWqelxd4dE9tvRtu5tV3KtV2fs8J2i0yQY2Do+rKA4iE
         G3w8w43TpoUrzqY96j3oYsTBQduNWqnSRKqZfX8m50JAK0FzX9uVz+dl9ArLxaUP2eA/
         TCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=++zgEp7LxKHUdHA2WjMuL2Jjjh/tNHVuSBA9eFYt1oo=;
        b=BKYoWk/EeF0nSdfpMHAKCYzu1ai/ezgJhFVtSbuRWjczuQBzL8ZhEyD1/CTveWbTqU
         de/pGzaIGz/n4qbx4Pfuy3l4uoktNNuyUwfkXbCWP3/MbhdASOjV1q6pyMAn7HZJRy2K
         0Xp5YDemqYxdiZ/fQvR7tvRhSalh6gUO3WjL+kR5RbkMhsdmNiP0Z/X6QlHhZomWcKSm
         MxAnFPgEiu5/kJXet5jbWFaDRrHdMoWO+zC61/M9CJQXCoC1XcTUnWTM4Xnxb3rhnCcC
         Br82Qemq6JMNVyerz5mMIE3pb63HKTGTUKdOqKc8H+JMKfrt9YVcg+PcPS4pWZqK4dFH
         5yGA==
X-Gm-Message-State: ABUngvf/YJDCB0wwFj02Bl0HmI8LSYRmndYnH6B3uEer9qWJ2lKe6eQboEXXyWuVV4dHOOBX
X-Received: by 10.99.218.21 with SMTP id c21mr9798740pgh.67.1478134237316;
        Wed, 02 Nov 2016 17:50:37 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 21sm7420221pfs.88.2016.11.02.17.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 17:50:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        bburky@bburky.com, peff@peff.net, jrnieder@gmail.com
Subject: [PATCH v2] transport: add core.allowProtocol config option
Date:   Wed,  2 Nov 2016 17:50:15 -0700
Message-Id: <1478134215-61707-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478125247-62372-1-git-send-email-bmwill@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add configuration option 'core.allowProtocol' to allow users to create a
whitelist of allowed protocols for fetch/push/clone in their gitconfig.

For git-submodule.sh, fallback to default whitelist only if the user
hasn't explicitly set `GIT_ALLOW_PROTOCOL` or doesn't have a whitelist
in their gitconfig.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt    |  8 ++++++++
 Documentation/git.txt       |  6 ++++--
 git-submodule.sh            |  3 ++-
 t/lib-proto-disable.sh      | 27 +++++++++++++++++++++++++++
 t/t5815-submodule-protos.sh | 22 ++++++++++++++++++++++
 transport.c                 |  6 ++++++
 6 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27069ac..78c97e3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -455,6 +455,14 @@ core.sshCommand::
 	the `GIT_SSH_COMMAND` environment variable and is overridden
 	when the environment variable is set.
 
+core.allowProtocol::
+	Provide a colon-separated list of protocols which are allowed to be
+	used with fetch/push/clone.  Any protocol not mentioned will be
+	disallowed (i.e., this is a whitelist, not a blacklist).  If the
+	`GIT_ALLOW_PROTOCOL` environment variable is set, it is used as the
+	protocol whitelist instead of this config option.  If neither is set,
+	all protocols are enabled. See git(1) for more details.
+
 core.ignoreStat::
 	If true, Git will avoid using lstat() calls to detect if files have
 	changed by setting the "assume-unchanged" bit for those tracked files
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ab7215e..a86ec16 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1155,8 +1155,10 @@ of clones and fetches.
 	restrict recursive submodule initialization from an untrusted
 	repository. Any protocol not mentioned will be disallowed (i.e.,
 	this is a whitelist, not a blacklist). If the variable is not
-	set at all, all protocols are enabled.  The protocol names
-	currently used by git are:
+	set at all, all protocols are enabled.  The exception to this is when
+	running `git-submodule` which will use a default list of known-safe
+	protocols (file:git:http:https:ssh) in the event no whitelist is
+	provided.  The protocol names currently used by git are:
 
 	  - `file`: any local file-based path (including `file://` URLs,
 	    or local paths)
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a13..bfbfb8e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -27,7 +27,8 @@ cd_to_toplevel
 #
 # If the user has already specified a set of allowed protocols,
 # we assume they know what they're doing and use that instead.
-: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
+whitelist=$(git config core.allowProtocol) || whitelist=file:git:http:https:ssh
+: ${GIT_ALLOW_PROTOCOL=$whitelist}
 export GIT_ALLOW_PROTOCOL
 
 command=
diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index b0917d9..e8820a6 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -62,6 +62,33 @@ test_proto () {
 			test_must_fail git clone --bare "$url" tmp.git
 		)
 	'
+
+	# Run tests again using the gitconfig method for setting a whitelist
+	test_expect_success "clone $1 (enabled)" '
+		rm -rf tmp.git &&
+		git -c core.allowProtocol="$proto" clone --bare "$url" tmp.git
+	'
+
+	test_expect_success "fetch $1 (enabled)" '
+		git -C tmp.git -c core.allowProtocol="$proto" fetch
+	'
+
+	test_expect_success "push $1 (enabled)" '
+		git -C tmp.git -c core.allowProtocol="$proto" push origin HEAD:pushed
+	'
+
+	test_expect_success "push $1 (disabled)" '
+		test_must_fail git -C tmp.git -c core.allowProtocol=none push origin HEAD:pushed
+	'
+
+	test_expect_success "fetch $1 (disabled)" '
+		test_must_fail git -C tmp.git -c core.allowProtocol=none fetch
+	'
+
+	test_expect_success "clone $1 (disabled)" '
+		rm -rf tmp.git &&
+		test_must_fail git -C tmp.git -c core.allowProtocol=none clone --bare "$url" tmp.git
+	'
 }
 
 # set up an ssh wrapper that will access $host/$repo in the
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 06f55a1..f85e71c 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -40,4 +40,26 @@ test_expect_success 'user can override whitelist' '
 	GIT_ALLOW_PROTOCOL=ext git -C dst submodule update ext-module
 '
 
+test_expect_success 'reset dst repo for config tests' '
+	rm -rf dst &&
+	git clone . dst &&
+	git -C dst submodule init
+'
+
+test_expect_success 'update of ssh not allowed when not in config whitelist' '
+	test_must_fail git -C dst -c core.allowProtocol=none submodule update ssh-module
+'
+
+test_expect_success 'update of ssh allowed via config whitelist' '
+	git -C dst -c core.allowProtocol="ssh:http:https" submodule update ssh-module
+'
+
+test_expect_success 'update of ext not allowed' '
+	test_must_fail git -C dst -c core.allowProtocol=ssh submodule update ext-module
+'
+
+test_expect_success 'user can override whitelist' '
+	git -C dst -c core.allowProtocol=ext submodule update ext-module
+'
+
 test_done
diff --git a/transport.c b/transport.c
index d57e8de..e3d8e88 100644
--- a/transport.c
+++ b/transport.c
@@ -652,10 +652,16 @@ static const struct string_list *protocol_whitelist(void)
 
 	if (enabled < 0) {
 		const char *v = getenv("GIT_ALLOW_PROTOCOL");
+		char *w = NULL;
 		if (v) {
 			string_list_split(&allowed, v, ':', -1);
 			string_list_sort(&allowed);
 			enabled = 1;
+		} else if (!git_config_get_string("core.allowProtocol", &w)) {
+			string_list_split(&allowed, w, ':', -1);
+			string_list_sort(&allowed);
+			enabled = 1;
+			free(w);
 		} else {
 			enabled = 0;
 		}
-- 
2.8.0.rc3.226.g39d4020

