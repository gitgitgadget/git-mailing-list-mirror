Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336071FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbdEHVeD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:34:03 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34006 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdEHVeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:34:01 -0400
Received: by mail-pg0-f46.google.com with SMTP id u28so29434173pgn.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9fexETmyJKIJHwij51YCvDygsf6eoCPrIYhth4a2/Q4=;
        b=aMWLFvXZ+AeXd2sEuTo0m5PUwbUZJ2+IGkgZCk1IcSFDdLmnWl0scJTdLirvGxoaQf
         w+UQCVIHuP528vczBV/ziCy+nDv4tQQik2C8TRYtAsQDQsgALXA677Oos8Ah/uH9XcKg
         6TndxCpVMXHsnsmg8mSff3HCJuoU7TDvlEOR93A7PgCCz8SeOno7Vq20t7iQys4tWpqM
         bKQA8Rl2PHz6eMUkOdxJK7pY4GK7I+twwPB1lKL8ym53tQ/aSeyb0Kyj3UBfdEFmVs3u
         rHUvPVm5QgRJwuu0auE5D0lWEGfEbmNsZi9mlIJ301+u1qwy504eiOHkuVQIk4h4Lt1X
         sc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9fexETmyJKIJHwij51YCvDygsf6eoCPrIYhth4a2/Q4=;
        b=B/iRuerY0pxclAl1nQGILp6txgcPeaFwo/ifHW/8LdGZd10Hj7KdgpU3ZPSuiDemoC
         pCp+qOSw4GUole+8oun3H6cQ1f9s4EvK0+d0en8wxEamIUo2KBe2/2qTcUN31nMgY71U
         Kdh4dfiBFok0JWYeMtjqxjI55/5zn8wp3AQFR0za86I/oi3Nq7y5iuBvpEYjyxrRtcbz
         J/nyUrjADTTV0bd1M4nOXRAl/CKc06sXXn9iPiW4rYIfbhJW6p3Ep0KscCTjkXMy2SYP
         YTvIlukNCHcNK/IXcv4p1iDWP7xaNKlrw9Xq8je6C3D1Bja3Qfc4ytYzBephdzSk1gGr
         NXJQ==
X-Gm-Message-State: AN3rC/4o8dfE6do/iFU570pEYkURiZLAefCOK9pYgMqQeDIHrZEFfM+T
        fxp2niDFYD+ilISa
X-Received: by 10.99.95.79 with SMTP id t76mr20501891pgb.82.1494279240129;
        Mon, 08 May 2017 14:34:00 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c196sm11229854pga.23.2017.05.08.14.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 May 2017 14:33:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, gitster@pobox.com
Subject: [PATCH v2 2/2] receive-pack: verify push options in cert
Date:   Mon,  8 May 2017 14:33:51 -0700
Message-Id: <cc21a5566dcf10e4683465ac253c76370b7b6a7f.1494279020.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <cover.1494279020.git.jonathantanmy@google.com>
References: <cover.1494279020.git.jonathantanmy@google.com>
In-Reply-To: <cover.1494279020.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com> <cover.1494279020.git.jonathantanmy@google.com>
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
outside the cert are consistent.

This sets in stone the requirement that send-pack redundantly send its
push options in 2 places, but I think that this is better than the
alternatives. Sending push options only within the cert is
backwards-incompatible with existing Git servers (which read push
options only from outside the cert), and sending push options only
outside the cert means that the push options are not signed for.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/pack-protocol.txt | 32 +++++++++++++++----
 builtin/receive-pack.c                    | 51 +++++++++++++++++++++++++++++--
 t/t5534-push-signed.sh                    | 37 ++++++++++++++++++++++
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 5b0ba3ef2..a34917153 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -473,13 +473,10 @@ that it wants to update, it sends a line listing the obj-id currently on
 the server, the obj-id the client would like to update it to and the name
 of the reference.
 
-This list is followed by a flush-pkt. Then the push options are transmitted
-one per packet followed by another flush-pkt. After that the packfile that
-should contain all the objects that the server will need to complete the new
-references will be sent.
+This list is followed by a flush-pkt.
 
 ----
-  update-request    =  *shallow ( command-list | push-cert ) [packfile]
+  update-requests   =  *shallow ( command-list | push-cert )
 
   shallow           =  PKT-LINE("shallow" SP obj-id)
 
@@ -500,12 +497,35 @@ references will be sent.
 		      PKT-LINE("pusher" SP ident LF)
 		      PKT-LINE("pushee" SP url LF)
 		      PKT-LINE("nonce" SP nonce LF)
+		      *PKT-LINE("push-option" SP push-option LF)
 		      PKT-LINE(LF)
 		      *PKT-LINE(command LF)
 		      *PKT-LINE(gpg-signature-lines LF)
 		      PKT-LINE("push-cert-end" LF)
 
-  packfile          = "PACK" 28*(OCTET)
+  push-option       =  1*( VCHAR | SP )
+----
+
+If the server has advertised the 'push-options' capability and the client has
+specified 'push-options' as part of the capability list above, the client then
+sends its push options followed by a flush-pkt.
+
+----
+  push-options      =  *PKT-LINE(push-option) flush-pkt
+----
+
+For backwards compatibility with older Git servers, if the client sends a push
+cert and push options, it MUST send its push options both embedded within the
+push cert and after the push cert. (Note that the push options within the cert
+are prefixed, but the push options after the cert are not.) Both these lists
+MUST be the same, modulo the prefix.
+
+After that the packfile that
+should contain all the objects that the server will need to complete the new
+references will be sent.
+
+----
+  packfile          =  "PACK" 28*(OCTET)
 ----
 
 If the receiving end does not support delete-refs, the sending end MUST
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f96834f42..fff5c7a54 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -473,7 +473,8 @@ static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
  * after dropping "_commit" from its name and possibly moving it out
  * of commit.c
  */
-static char *find_header(const char *msg, size_t len, const char *key)
+static char *find_header(const char *msg, size_t len, const char *key,
+			 const char **next_line)
 {
 	int key_len = strlen(key);
 	const char *line = msg;
@@ -486,6 +487,8 @@ static char *find_header(const char *msg, size_t len, const char *key)
 		if (line + key_len < eol &&
 		    !memcmp(line, key, key_len) && line[key_len] == ' ') {
 			int offset = key_len + 1;
+			if (next_line)
+				*next_line = *eol ? eol + 1 : eol;
 			return xmemdupz(line + offset, (eol - line) - offset);
 		}
 		line = *eol ? eol + 1 : NULL;
@@ -495,7 +498,7 @@ static char *find_header(const char *msg, size_t len, const char *key)
 
 static const char *check_nonce(const char *buf, size_t len)
 {
-	char *nonce = find_header(buf, len, "nonce");
+	char *nonce = find_header(buf, len, "nonce", NULL);
 	unsigned long stamp, ostamp;
 	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
@@ -575,6 +578,45 @@ static const char *check_nonce(const char *buf, size_t len)
 	return retval;
 }
 
+/*
+ * Return 1 if there is no push_cert or if the push options in push_cert are
+ * the same as those in the argument; 0 otherwise.
+ */
+static int check_cert_push_options(const struct string_list *push_options)
+{
+	const char *buf = push_cert.buf;
+	int len = push_cert.len;
+
+	char *option;
+	const char *next_line;
+	int options_seen = 0;
+
+	int retval = 1;
+
+	if (!len)
+		return 1;
+
+	while ((option = find_header(buf, len, "push-option", &next_line))) {
+		len -= (next_line - buf);
+		buf = next_line;
+		options_seen++;
+		if (options_seen > push_options->nr
+		    || strcmp(option,
+			      push_options->items[options_seen - 1].string)) {
+			retval = 0;
+			goto leave;
+		}
+		free(option);
+	}
+
+	if (options_seen != push_options->nr)
+		retval = 0;
+
+leave:
+	free(option);
+	return retval;
+}
+
 static void prepare_push_cert_sha1(struct child_process *proc)
 {
 	static int already_done;
@@ -1929,6 +1971,11 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 		if (use_push_options)
 			read_push_options(&push_options);
+		if (!check_cert_push_options(&push_options)) {
+			struct command *cmd;
+			for (cmd = commands; cmd; cmd = cmd->next)
+				cmd->error_string = "inconsistent push options";
+		}
 
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index ecb8d446a..0ef6f66b5 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -124,6 +124,43 @@ test_expect_success GPG 'signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPG 'inconsistent push options in signed push not allowed' '
+	# First, invoke receive-pack with dummy input to obtain its preamble.
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	git -C dst config receive.advertisepushoptions 1 &&
+	printf xxxx | test_might_fail git receive-pack dst >preamble &&
+
+	# Then, invoke push. Simulate a receive-pack that sends the preamble we
+	# obtained, followed by a dummy packet.
+	write_script myscript <<-\EOF &&
+		cat preamble &&
+		printf xxxx &&
+		cat >push
+	EOF
+	test_might_fail git push --push-option="foo" --push-option="bar" \
+		--receive-pack="\"$(pwd)/myscript\"" --signed dst --delete ff &&
+
+	# Replay the push output on a fresh dst, checking that ff is truly
+	# deleted.
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	git -C dst config receive.advertisepushoptions 1 &&
+	git receive-pack dst <push &&
+	test_must_fail git -C dst rev-parse ff &&
+
+	# Tweak the push output to make the push option outside the cert
+	# different, then replay it on a fresh dst, checking that ff is not
+	# deleted.
+	sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	git -C dst config receive.advertisepushoptions 1 &&
+	git receive-pack dst <push >out &&
+	git -C dst rev-parse ff &&
+	grep "inconsistent push options" out
+'
+
 test_expect_success GPG 'fail without key and heed user.signingkey' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
-- 
2.13.0.rc1.294.g07d810a77f-goog

