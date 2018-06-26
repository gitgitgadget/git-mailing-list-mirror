Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1501F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeFZUzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:55:00 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:41946 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbeFZUyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:50 -0400
Received: by mail-qk0-f201.google.com with SMTP id 123-v6so8489950qkg.8
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mjFuCN5HLFBtkKMe1Aqgf7TtmuDLLaQq0NeqVk0G1Ow=;
        b=mzGYwjJXdn4KwxzyFuwqCRePu3XHPL2dS+rJ4+EF8FifwTlO5QHlS5vXUuSTChaNpr
         yL+QqL0DVqMgMkcU3AEa1x94NRIQo7q+wPM6y2PgAzoPcf5bMRzyc+PLk2Zp3shCn59x
         mHRVl/FmL3qZtgh9JRNz00BMT7dATBC5ZYPJ3Wn6nArry0n3bJx0Vrh6SqH3VjFZBoHd
         6Cdk+RCdmXQ+h4u+2T30zCa3h1coQaAmvz8bE0jUbdZv9iUxAcb0bTZxaEwMyFO6sUg4
         /seMr1Z3rfLErbqa3gS24bDB7mDGayo1zOhJEe/RcgWK5lV8iAUweVgzqFY6oLhiIfFI
         OcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mjFuCN5HLFBtkKMe1Aqgf7TtmuDLLaQq0NeqVk0G1Ow=;
        b=pu6vih6vmOq5YVTIzKXBb1BJh4UPwzcFxe7RCHMcABuulGsO2v/S5JDmX/g8B9cHWf
         EL7LvJWXBhxJ3em8w/IJSbJFy5pjyw3uWFGKxRDbrHmYjW8m1iH2pymDSICn3uKp3KsZ
         Lv+0ptngGGqfPwoj+MTZvt8qnPR4eLjgm5D7B97kotGqCqyuYYkNph7FW7CgKk2aDanw
         k3HzjeyZsu+YdmMkq0nMd4IbSVCgB8F0nl2LDOMjwxk9mweaopv495Eo0NspAJTlteP5
         ZZj6W9T0ngl7+Gp/BKLMYHRs8ZLOj9mHE5tpa80ARaiAq7k26UcL9enZopb9qHOr6rU0
         g37Q==
X-Gm-Message-State: APt69E0YxBG3kdbxa5LBTFyShWbyDQCY6sAx4VQloBjlUkwyNFO7sieH
        /LCrO3s4W/YnhDxE1ZglFDAArQMDu0PG+8IzQ9U+THV7F0CIv+Hd6xN04pQ7jW1AUUlKb+iQdW3
        2/aj/ZAR4XmaD7HrvXPbsov9lPBcBChF/LKFSlkW4hfePG1mIVgj1oZiqTg==
X-Google-Smtp-Source: AAOMgpfkF9S9iarLJHh2UN2QhDrAPX1BSFgKXB7bhMMw4T1Yet/jzmFXfEtMOgu9HTRzMklz7BgODZfVFK4=
MIME-Version: 1.0
X-Received: by 2002:a0c:c348:: with SMTP id j8-v6mr1665764qvi.55.1530046489464;
 Tue, 26 Jun 2018 13:54:49 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:33 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180626205438.110764-4-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 3/8] upload-pack: test negotiation with changing repository
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
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
 t/lib-httpd/apache.conf            |  8 ++++
 t/lib-httpd/one-time-sed.sh        | 22 ++++++++++
 t/t5703-upload-pack-ref-in-want.sh | 68 ++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)
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
index 000000000..8a9a5aca0
--- /dev/null
+++ b/t/lib-httpd/one-time-sed.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+# If "one-time-sed" exists in $HTTPD_ROOT_PATH, run sed on the HTTP response,
+# using the contents of "one-time-sed" as the sed command to be run. If the
+# response was modified as a result, delete "one-time-sed" so that subsequent
+# HTTP responses are no longer modified.
+# 
+# This can be used to simulate the effects of the repository changing in
+# between HTTP request-response pairs.
+if [ -e one-time-sed ]; then "$GIT_EXEC_PATH/git-http-backend" >out
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
index 0ef182970..a4fe0e7e4 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -150,4 +150,72 @@ test_expect_success 'want-ref with ref we already have commit for' '
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
+stop_httpd
+
 test_done
-- 
2.18.0.rc2.346.g013aa6912e-goog

