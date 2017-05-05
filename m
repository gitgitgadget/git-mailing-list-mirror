Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5531A207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdEEXq4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:46:56 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34324 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdEEXqx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:46:53 -0400
Received: by mail-pf0-f181.google.com with SMTP id e64so9024059pfd.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=thEDeqlAEJZx0STckWcBUK2RcLulrIkv4MA4A7eNza8=;
        b=Bfkw9zEoutEi8hC6wdK8ANrtxpYnTVZ/mQeyIxfno2vmtUQq6KHago0WVQP91Bw4PY
         2UtIDLTinuW5wCt2VSzLjvr++IWznpnIp3MOPfR612lhP63idPK/CslyM/zJOigFKXRr
         g04vyJHDSy0eQVlWnjChaCy9Ivel5mk0YE8DC2Vpq4VTwjEYuCRemKuzK7qlJxaKbQxm
         Uz5+pYp1u7XY0D4hXLvAdsvGLOwVoBZXYMrn37Sk/V46h0ORvO8hmeptNPzb8eLYjpuI
         WTxPuNP9vhzbkBi7daFod1kEuEb0LOR/DHhO8Oe3+izcROOVWXNqBhCxXdILo5fZ6LJt
         R7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=thEDeqlAEJZx0STckWcBUK2RcLulrIkv4MA4A7eNza8=;
        b=CDgL9BkhpyZwhNHCWmpI9lyuMWtO7kBwXbc8ACohSxHbmoYORRPl4kBea87xLMNUUc
         ykByJs32fyq3e4K2GBx1mY068eXpQQZTOyYFkdnIp6R3Pzs0IheytxXlzVBibcXhBGKy
         7Em0n+7VXim19vgTMFkbH4d6V0Pmp+lxkYfD7N9qRiJoW3YWXXPvy4fGFJi1+UfE3jBH
         +VlKrLTzDeVutOhgN12AKiiL43PjjCt6+8wDOSp/o2y5EjekuEuM2qjzWr3vHC5DQlMf
         Qk+heCk7TrECOEPQsEy4H0GT+SBOsZTw8FmC+227lvQbqUmwjRvFCIt04i2pZcfYQlvH
         PTrg==
X-Gm-Message-State: AN3rC/6uuWwPaQ/eTeYgyxRu7YA9IW0VNyj6JV45nvML5UsoneUzP3nu
        Qx63YVOo0L5AwC8F
X-Received: by 10.84.237.8 with SMTP id s8mr68609690plk.163.1494028012438;
        Fri, 05 May 2017 16:46:52 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c77sm11096576pfe.37.2017.05.05.16.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 16:46:51 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 2/3] receive-pack: verify push options in cert
Date:   Fri,  5 May 2017 16:46:43 -0700
Message-Id: <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit f6a4e61 ("push: accept push options", 2016-07-14), send-pack
was taught to include push options both within the signed cert (if the
push is a signed push) and outside the signed cert; however,
receive-pack ignores push options within the cert, only handling push
options outside the cert.

Teach receive-pack, in the case that push options are provided for a
signed push, to verify that the push options both within the cert and
outside the cert are consistent, and to provide the results of that
verification to the receive hooks as an environment variable (just like
it currently does for the nonce verification).

This sets in stone the requirement that send-pack redundantly send its
push options in 2 places, but I think that this is better than the
alternatives. Sending push options only within the cert is
backwards-incompatible with existing Git servers (which read push
options only from outside the cert), and sending push options only
outside the cert means that the push options are not signed for.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-receive-pack.txt | 10 ++++++++
 builtin/receive-pack.c             | 49 ++++++++++++++++++++++++++++++++++----
 t/t5534-push-signed.sh             | 15 ++++++++++++
 3 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 86a4b32f0..f50ca0f29 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -106,6 +106,16 @@ the following environment variables:
 	Also read about `receive.certNonceSlop` variable in
 	linkgit:git-config[1].
 
+`GIT_PUSH_CERT_OPTION_STATUS`::
+`BAD`;;
+	For backwards compatibility reasons, when accepting a signed
+	push, receive-pack requires that push options be written both
+	inside and outside the certificate. ("git push" does this
+	automatically.) `BAD` is returned if they are inconsistent.
+`OK`;;
+	The push options inside and outside the certificate are
+	consistent.
+
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f96834f42..fe26c2f72 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -81,6 +81,9 @@ static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
+static const char *PUSH_OPTION_BAD = "BAD";
+static const char *PUSH_OPTION_OK = "OK";
+
 static enum {
 	KEEPALIVE_NEVER = 0,
 	KEEPALIVE_AFTER_NUL,
@@ -473,7 +476,8 @@ static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
  * after dropping "_commit" from its name and possibly moving it out
  * of commit.c
  */
-static char *find_header(const char *msg, size_t len, const char *key)
+static char *find_header(const char *msg, size_t len, const char *key,
+			 const char **next_line)
 {
 	int key_len = strlen(key);
 	const char *line = msg;
@@ -486,6 +490,8 @@ static char *find_header(const char *msg, size_t len, const char *key)
 		if (line + key_len < eol &&
 		    !memcmp(line, key, key_len) && line[key_len] == ' ') {
 			int offset = key_len + 1;
+			if (next_line)
+				*next_line = *eol ? eol + 1 : eol;
 			return xmemdupz(line + offset, (eol - line) - offset);
 		}
 		line = *eol ? eol + 1 : NULL;
@@ -495,7 +501,7 @@ static char *find_header(const char *msg, size_t len, const char *key)
 
 static const char *check_nonce(const char *buf, size_t len)
 {
-	char *nonce = find_header(buf, len, "nonce");
+	char *nonce = find_header(buf, len, "nonce", NULL);
 	unsigned long stamp, ostamp;
 	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
@@ -575,9 +581,40 @@ static const char *check_nonce(const char *buf, size_t len)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static const char *check_push_option(const char *buf, size_t len,
+				     const struct string_list *push_options)
+{
+	int options_seen = 0;
+	char *option;
+	const char *next_line;
+	const char *retval = PUSH_OPTION_OK;
+
+	while ((option = find_header(buf, len, "push-option", &next_line))) {
+		len -= (next_line - buf);
+		buf = next_line;
+		options_seen++;
+		if (options_seen > push_options->nr
+		    || strcmp(option,
+			      push_options->items[options_seen - 1].string)) {
+			retval = PUSH_OPTION_BAD;
+			goto leave;
+		}
+		free(option);
+	}
+
+	if (options_seen != push_options->nr)
+		retval = PUSH_OPTION_BAD;
+
+leave:
+	free(option);
+	return retval;
+}
+
+static void prepare_push_cert_sha1(struct child_process *proc,
+				   const struct string_list *push_options)
 {
 	static int already_done;
+	static const char *push_option_status;
 
 	if (!push_cert.len)
 		return;
@@ -609,6 +646,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		strbuf_release(&gpg_output);
 		strbuf_release(&gpg_status);
 		nonce_status = check_nonce(push_cert.buf, bogs);
+		push_option_status = check_push_option(push_cert.buf, bogs,
+						       push_options);
 	}
 	if (!is_null_sha1(push_cert_sha1)) {
 		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
@@ -631,6 +670,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 						 nonce_stamp_slop);
 		}
+		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_OPTION_STATUS=%s",
+				 push_option_status);
 	}
 }
 
@@ -683,7 +724,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 		proc.err = muxer.in;
 	}
 
-	prepare_push_cert_sha1(&proc);
+	prepare_push_cert_sha1(&proc, feed_state->push_options);
 
 	code = start_command(&proc);
 	if (code) {
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index ecb8d446a..2607b8797 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -124,6 +124,21 @@ test_expect_success GPG 'signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPG 'signed push reports push option status in receive hook' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config receive.certnonceseed sekrit &&
+	git -C dst config receive.advertisepushoptions 1 &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+		# record the push option status
+		echo "$GIT_PUSH_CERT_OPTION_STATUS" > ../push-option-status
+	EOF
+
+	git push --push-option="foo" --push-option="bar" --signed dst noop ff &&
+
+	test "$(cat dst/push-option-status)" = "OK"
+'
+
 test_expect_success GPG 'fail without key and heed user.signingkey' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
-- 
2.13.0.rc1.294.g07d810a77f-goog

