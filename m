Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0931E1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbdAYWDa (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:30 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34850 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdAYWDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:21 -0500
Received: by mail-pg0-f51.google.com with SMTP id 194so67614237pgd.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qVSyvgUwS0XfL1CIGajUw4WLszAqWpPTrJTvIihA4zY=;
        b=Sooa2a4QXWp21FPf4cHNUsggvFSm4+GBXY/X1mpZsuwAYGwbB9OVHMvcaGQ2TDp+/a
         vU2K+/rXK3B7LkTCGANQQFC7QqK7UpV6OK4ANtFdYjPoiw+FTKxq2YZp6ewm0UQqgDD+
         nIcYOZrjmP8P0EMTd4mt1AFtog+fMmQ6d33dy7wVs2pOBaYeg0YykHRG/guTSI1/lhxp
         mSUd9NXDCtEEN/Y8HVWe5npG8oI1C/Cm32f/R844LFuv80GeU4jVItUJ4VJdC2GU95Iy
         Ht1Oj8C5P+a+zs29KP4Jd1l0oFKb4NeRSJTw11yna+gGKv9C08p/x0HAbdivlT66WXJl
         CJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qVSyvgUwS0XfL1CIGajUw4WLszAqWpPTrJTvIihA4zY=;
        b=LR32JgVm8RpYU+Y8s993+OW/W2p31ZMBjVB2IgmWO0Z2yiZzwxGNLFJR2FAmE2zQJj
         fOrxGf0byCVxAE7GKFzUfVI+Fvc/n2PCKoq+5aPG2fBpNbk8zSaBrd/Is4jVh1nSjMxH
         WNJqLgiAlUqSZzPT67lEVRPRF18S9OO4o48vQoOHZPWSx+1zh3+4MTr4XCVwpd7WoM+g
         22irRBsMIb3qx83tlJvE1jPzayxDqD9hzgk6SE4qlKeuZpzgAWGc6DdJKbVEWODU1vXQ
         Hlc0jUla1QJpv+B6N9IFnCbexlIYe8RwCY6A19o+Auv5ahCyfuTmLGC/+4f8a+StH9yz
         ybxA==
X-Gm-Message-State: AIkVDXJC2VjB+aIJXTiCmPCh2/Q0ZXswc/+inE0wB8EfEdzRzecPfnZf3XQkt/D36U95Tv9A
X-Received: by 10.98.138.155 with SMTP id o27mr49284556pfk.113.1485381800747;
        Wed, 25 Jan 2017 14:03:20 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:20 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 03/14] upload-pack: test negotiation with changing repo
Date:   Wed, 25 Jan 2017 14:02:56 -0800
Message-Id: <afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make upload-pack report "not our ref" errors to the client. (If not, the
client would be left waiting for a response when the server is already
dead.)

Add tests to check the behavior of upload-pack and fetch-pack when
upload-pack is served from a changing repository (for example, when
different servers in a load-balancing agreement participate in the same
stateless RPC negotiation). This forms a baseline of comparison to the
ref-in-want functionality (which will be introduced in subsequent
commits), and ensures that subsequent commits do not change existing
behavior.

As part of this effort, a mechanism to substitute strings in an HTTP
response only on the first invocation is added.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/lib-httpd.sh                     |  1 +
 t/lib-httpd/apache.conf            |  8 ++++
 t/lib-httpd/one-time-sed.sh        |  8 ++++
 t/t5552-upload-pack-ref-in-want.sh | 91 ++++++++++++++++++++++++++++++++++++++
 upload-pack.c                      |  6 ++-
 5 files changed, 113 insertions(+), 1 deletion(-)
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
index 69174c6e3..ef218ff15 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -106,9 +106,14 @@ Alias /auth/dumb/ www/auth/dumb/
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
@@ -118,6 +123,9 @@ ScriptAlias /error/ error.sh/
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
index 000000000..060ec0300
--- /dev/null
+++ b/t/lib-httpd/one-time-sed.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+if [ -e one-time-sed ]; then
+	"$GIT_EXEC_PATH/git-http-backend" | sed "$(cat one-time-sed)"
+	rm one-time-sed
+else
+	"$GIT_EXEC_PATH/git-http-backend"
+fi
diff --git a/t/t5552-upload-pack-ref-in-want.sh b/t/t5552-upload-pack-ref-in-want.sh
index 3496af641..80cf2263a 100755
--- a/t/t5552-upload-pack-ref-in-want.sh
+++ b/t/t5552-upload-pack-ref-in-want.sh
@@ -292,4 +292,95 @@ test_expect_success 'hideRefs with namespaces' '
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
+	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo"
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
+	git -C "$REPO" config uploadpack.advertiseRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	test_must_fail git -C local fetch 2> err &&
+	grep "ERR upload-pack: not our ref" err
+'
+
+test_expect_failure 'server is initially ahead - ref in want' '
+	git -C "$REPO" config uploadpack.advertiseRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify master > expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server is initially behind - no ref in want' '
+	git -C "$REPO" config uploadpack.advertiseRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master^" > expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master > actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'server is initially behind - ref in want' '
+	git -C "$REPO" config uploadpack.advertiseRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master" > expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master > actual &&
+	test_cmp expected actual
+'
+
+stop_httpd
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index b88ed8e26..0678c53d6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -862,9 +862,13 @@ static void receive_needs(struct string_list *wanted_ns_refs)
 		} else if (skip_prefix(line, "want ", &arg) &&
 			   !get_sha1_hex(arg, sha1_buf)) {
 			o = parse_object(sha1_buf);
-			if (!o)
+			if (!o) {
+				packet_write_fmt(1,
+						 "ERR upload-pack: not our ref %s",
+						 sha1_to_hex(sha1_buf));
 				die("git upload-pack: not our ref %s",
 				    sha1_to_hex(sha1_buf));
+			}
 			if (!(o->flags & WANTED)) {
 				o->flags |= WANTED;
 				if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
-- 
2.11.0.483.g087da7b7c-goog

