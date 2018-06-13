Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BE71F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935843AbeFMVjk (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:40 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:37829 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935813AbeFMVjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:37 -0400
Received: by mail-ua0-f202.google.com with SMTP id z33-v6so1280859uah.4
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=N8yi0LsB4eaKD3FqpL8Od0ghQ/WLjPVfds6yftrAIzk=;
        b=XU7h4ta9ZOhz5KaoPeLh5qLe74K1QNG3gTSctxW4XzWMI+iyx9UUVze9E33SpWWq1x
         CznxxY1YnRcTGm8kbhmNzYfUaBvM8+MJ24Hi0vqOwjBWv1XXaLn385IVHUWNsybvVu5Q
         Ng8vSvQ+LOBGgvgHN3P4m1LAduBy7bwDu/kAUex4ka6DivgNXaVaPQtWBWLn2zIyejOC
         izfpU7lDAD+qwJ2fBl7l0wR8fHyl6MwoHZ3+aBzxolpCJ/LvzhNMCoe+qYbn5R5kiQyB
         iR73OuQNeJEdSwxN3ZupeBnDTZNL9LO2YqxMmXt1sbXbnEuPBflMHHaJ6fKKmd1eFl57
         xIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=N8yi0LsB4eaKD3FqpL8Od0ghQ/WLjPVfds6yftrAIzk=;
        b=QANBVHAZX57uCC/KEyI3lgjYVUvJ9pKem7f1pw7jsmxwgCOVnx+mIC1xbk5X+70WJl
         bCNQuOqUGCIuI9qEshaB3ZDTBAHJ4lq/+pbwsvFXgPAky6lKY3VrqRfxuUHWdx9mjXbe
         qPWQ55IHEWaX7QfItuiCm2aIn9q8KbJj4MiYpWK8VlQAA54sIHDPC5Th7SkbVXA2kyH0
         VNdsGO+pkiYB+hYOp1Bz9ILz7gd0Ba4jSxkPrQS4EgPPauBZepqWTkYuF+IY5gPyZd0B
         /59MBFYsCC3p8BXIJL5uq4OY2qH/J0fv6usumyvHLKeEcqeB01uO2IKVB5QTdyinPW9/
         mAEA==
X-Gm-Message-State: APt69E3GGgLVRoyJjWHa1gE8ly+vCpeiWrpkRWNkUGX62vGeetELid1K
        lrJBdrK7ko2PunTcplmRWpxYu1mVO6GwVeN1ZOUYxwYrirNcdXb2d6uHw4D1xmuHM5Di98loEp4
        15cjY3ta6JfV9UoQjS+Q9Q5yHO0hleHFKu49jZ4joUHSaEvHl4LTibdo4Ng==
X-Google-Smtp-Source: ADUXVKIAwGZTe+9kO7+WMnD2bo6TvH22n/qZGn4OZ7dK8Y0unM6foYTh4SJxMhHWM8mGH5YFSjzx44DYkPQ=
MIME-Version: 1.0
X-Received: by 2002:ab0:78e:: with SMTP id c14-v6mr2876688uaf.74.1528925976546;
 Wed, 13 Jun 2018 14:39:36 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:20 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180613213925.10560-4-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 3/8] upload-pack: test negotiation with changing repository
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to check the behavior of fetching from a repository which
changes between rounds of negotiation (for example, when different
servers in a load-balancing agreement participate in the same stateless
RPC negotiation). This forms a baseline of comparison to the ref-in-want
functionality (which will be introduced to the client in subsequent
commits), and ensures that subsequent commits do not change existing
behavior.

As part of this effort, a mechanism to substitute strings in a single
HTTP response is added.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/lib-httpd.sh                     |  1 +
 t/lib-httpd/apache.conf            |  8 +++
 t/lib-httpd/one-time-sed.sh        | 16 ++++++
 t/t5703-upload-pack-ref-in-want.sh | 92 ++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 t/lib-httpd/one-time-sed.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465..84f8efdd4 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,6 +132,7 @@ prepare_httpd() {
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
 	install_script error.sh
+	install_script one-time-sed.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 724d9ae46..fe68d37bb 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -111,9 +111,14 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+<LocationMatch /one_time_sed/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
+ScriptAliasMatch /one_time_sed/(.*) one-time-sed.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
@@ -123,6 +128,9 @@ ScriptAlias /error/ error.sh/
 <Files error.sh>
   Options ExecCGI
 </Files>
+<Files one-time-sed.sh>
+	Options ExecCGI
+</Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/one-time-sed.sh b/t/lib-httpd/one-time-sed.sh
new file mode 100644
index 000000000..a9c4aa5f4
--- /dev/null
+++ b/t/lib-httpd/one-time-sed.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+if [ -e one-time-sed ]; then
+	"$GIT_EXEC_PATH/git-http-backend" >out
+
+	sed "$(cat one-time-sed)" <out >out_modified
+
+	if diff out out_modified >/dev/null; then
+		cat out
+	else
+		cat out_modified
+		rm one-time-sed
+	fi
+else
+	"$GIT_EXEC_PATH/git-http-backend"
+fi
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 0ef182970..979ab6d03 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -150,4 +150,96 @@ test_expect_success 'want-ref with ref we already have commit for' '
 	check_output
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
+LOCAL_PRISTINE="$(pwd)/local_pristine"
+
+test_expect_success 'setup repos for change-while-negotiating test' '
+	(
+		git init "$REPO" &&
+		cd "$REPO" &&
+		>.git/git-daemon-export-ok &&
+		test_commit m1 &&
+		git tag -d m1 &&
+
+		# Local repo with many commits (so that negotiation will take
+		# more than 1 request/response pair)
+		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
+		cd "$LOCAL_PRISTINE" &&
+		git checkout -b side &&
+		for i in $(seq 1 33); do test_commit s$i; done &&
+
+		# Add novel commits to upstream
+		git checkout master &&
+		cd "$REPO" &&
+		test_commit m2 &&
+		test_commit m3 &&
+		git tag -d m2 m3
+	) &&
+	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
+	git -C "$LOCAL_PRISTINE" config protocol.version 2
+'
+
+inconsistency() {
+	# Simulate that the server initially reports $2 as the ref
+	# corresponding to $1, and after that, $1 as the ref corresponding to
+	# $1. This corresponds to the real-life situation where the server's
+	# repository appears to change during negotiation, for example, when
+	# different servers in a load-balancing arrangement serve (stateless)
+	# RPCs during a single negotiation.
+	printf "s/%s/%s/" \
+	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
+	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
+	       >"$HTTPD_ROOT_PATH/one-time-sed"
+}
+
+test_expect_success 'server is initially ahead - no ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	test_must_fail git -C local fetch 2>err &&
+	grep "ERR upload-pack: not our ref" err
+'
+
+test_expect_failure 'server is initially ahead - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify master >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server is initially behind - no ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master^" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'server is initially behind - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+stop_httpd
+
 test_done
-- 
2.18.0.rc1.242.g61856ae69a-goog

