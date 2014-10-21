From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 6/8] receive-pack.c: add a receive.preferatomicpush configuration variable
Date: Tue, 21 Oct 2014 13:46:38 -0700
Message-ID: <1413924400-15418-7-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:47:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKd-00058Q-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933511AbaJUUqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:50 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:46208 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933496AbaJUUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:45 -0400
Received: by mail-ie0-f201.google.com with SMTP id rl12so309437iec.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oyYgvXkRWzQ4EJP5IQBb59mpPZi4wWyK7TetiCiZBJc=;
        b=Ndozwex3bWu71UBKASz7HNd26B1h+vzSiKtqK3s0twJFyxiOpNYg93wXfRJ9botDIZ
         cbwYraA864XsIYFZr2Q8XJN96jDv4/AygageDNpCW3DoJrc3liln2lFaLKq0qhVy4Uvx
         MKSjhZ4/Ep9SfYX5TiQ0peClyXbrAlwmzu2OzNPQ8WyY0V3VAgLuiQYW3jUk+9Imr4UR
         DnxfRnVg4e1cIWZofN6quVfQKGhjjBAKnoKWyWc/KgOYTKkZfDIjZZz3Igx0pI2ZBZno
         vPrvXt7lP3++6o5KfbVRL2IZn1o+Rm3pCyHE6X33NaJIJNtC4+VbkHhyKWurr0W7QvBF
         stIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oyYgvXkRWzQ4EJP5IQBb59mpPZi4wWyK7TetiCiZBJc=;
        b=h533Tk0kHYF6lVRTQloDaKDuGCIhW6hMGBXJIt6hNsGAcXqv5lcS2CDtDNGaZvro+e
         3aGgMJOqEccc/c1NDCjuIr4VH2mTB+kV/fySdMZmoBveT2Th9zAMivYid0ckbI/vom6V
         PzKZ0reey3tBM1iI4DSqcFC67kyrrRWfNkNC4BwVP6DvWMZxSQ2eJKGfg+dg/mq/1WPz
         hLamiFTEY1KQw/s/IV2/1tLvD2IKYUicSOvDy1vc+9TGBm/llUQ5SMCNvMpOPWuOuAKP
         OKI3N2zEQsns/PgNxM7imuiu8H820FSwNRRIXikNMct2U1YTm7GGpYimldsdY+PvjxXZ
         6SpA==
X-Gm-Message-State: ALoCoQk/FO4gpUc501iMafuGkYxH7ILuBwOFYSHGRiAHHqNFiVntaKVgOE/7glPBkz84a0xo3dhC
X-Received: by 10.182.98.232 with SMTP id el8mr24690562obb.42.1413924404597;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si595351yho.5.2014.10.21.13.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 4ipb23G8.1; Tue, 21 Oct 2014 13:46:44 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 84E7EE1006; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add receive.preferatomicpush setting to receive-pack.c. This triggers
a new capability "prefer-atomic-push" to be sent back to the send-pack
client, requesting the client, if it supports it, to request
an atomic push.

This is an alternative way to trigger an atomic push instead of having
to rely of the user using the --atomic-push command line argument.
For backward compatibility, this is only a hint to the client that is should
request atomic pushes if it can. Old clients that do not support atomic pushes
will just ignore this capability and use a normal push.

The reason we need to signal this capability back to the client is due
to that send_pack() has push failure modes where it will detect that
certain refs can not be pushed and fail them early. Those refs would not
even be sent by the client unless atomic-pushes are activated.
This means that IF we activate this feature from the server side we must
tell the client to not fail refs early and use an atomic push. We can not
enforce this on the server side only.

Change-Id: I6677cd565f48a09bb552fe3f4c00bbb6d343c224
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/config.txt                          |  4 +++
 Documentation/technical/protocol-capabilities.txt | 13 ++++++---
 builtin/receive-pack.c                            |  8 ++++++
 send-pack.c                                       |  2 ++
 t/t5543-atomic-push.sh                            | 32 +++++++++++++++++++++++
 5 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 400dcad..78c427e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2135,6 +2135,10 @@ receive.shallowupdate::
 	If set to true, .git/shallow can be updated when new refs
 	require new shallow roots. Otherwise those refs are rejected.
 
+receive.preferatomicpush::
+	This option is used in receive-pack to tell the client to try
+	to use an atomic push, if the client supports it.
+
 remote.pushdefault::
 	The remote to push to by default.  Overrides
 	`branch.<name>.remote` for all branches, and is overridden by
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 26bc5b1..78c5469 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -18,9 +18,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'atomic-push', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
-capabilities are sent and recognized by the receive-pack (push to server)
-process.
+The 'atomic-push', 'report-status', 'delete-refs', 'prefer-atomic-push',
+'quiet', and 'push-cert' capabilities are sent and recognized by the
+receive-pack (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' capability
@@ -252,6 +252,13 @@ If the server sends the 'atomic-push' capability, it means it is
 capable of accepting atomic pushes. If the pushing client requests this
 capability, the server will update the refs in one single atomic transaction.
 
+prefer-atomic-push
+------------------
+
+If the receive-pack server advertises the 'prefer-atomic-push' capability,
+it means that the client should use an atomic push, if the client supports it,
+even if the user did not request it explicitly.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6991d22..697f102 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -52,6 +52,7 @@ static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
+static int prefer_atomic_push;
 static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static unsigned char push_cert_sha1[20];
@@ -160,6 +161,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.preferatomicpush") == 0) {
+		prefer_atomic_push = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -178,6 +184,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			      "atomic-push");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
+		if (prefer_atomic_push)
+			strbuf_addstr(&cap, " prefer-atomic-push");
 		if (push_cert_nonce)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
diff --git a/send-pack.c b/send-pack.c
index 5208305..c5e0539 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -325,6 +325,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic-push"))
 		atomic_push_supported = 1;
+	if (server_supports("prefer-atomic-push"))
+		args->use_atomic_push = 1;
 	if (args->push_cert) {
 		int len;
 
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 4903227..3feb22e 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -98,4 +98,36 @@ test_expect_success 'atomic push fails if one branch fails' '
 	test "$master_second" != "$mirror_second"
 '
 
+test_expect_success 'atomic push fails (receive.preferatomicpush)' '
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git checkout second &&
+		echo two >foo && git add foo && git commit -m two &&
+		echo three >foo && git add foo && git commit -m three &&
+		echo four >foo && git add foo && git commit -m four &&
+		git push --mirror up
+		git reset --hard HEAD~2 &&
+		git checkout master
+		echo five >foo && git add foo && git commit -m five
+	) &&
+	(
+		cd mirror &&
+		git config --add receive.preferatomicpush true
+	) &&
+	(
+		cd master &&
+		! git push --atomic-push --all up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" != "$mirror_master" &&
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" != "$mirror_second"
+'
+
 test_done
-- 
2.1.0.rc2.206.gedb03e5
