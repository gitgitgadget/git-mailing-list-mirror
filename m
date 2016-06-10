From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/27] fetch-pack: use a common function for verbose printing
Date: Fri, 10 Jun 2016 19:26:59 +0700
Message-ID: <20160610122714.3341-13-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:28:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYU-0000zf-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbcFJM2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:50 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36381 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbcFJM2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:49 -0400
Received: by mail-pa0-f65.google.com with SMTP id fg1so5022053pad.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPsKR5K/HusQdEK0JGwOzPTy5Qcqu8J0mVDuLnVWRNQ=;
        b=dES8GAZLRKLLA9KNd0wb9QAmBCOQZigmTJQgejNAnEkbfEtBlZMmT/Lw3STIFG2F8L
         +4nzeknqInHIidqZPNPvbeuVVX1qr2kHp7msne+GCe33CAl7KSYnPBFuC1AbOf88qyFz
         CJ3UZunOHTkbMVl9E1Zho979TVioTjTr+bWX1hQml/GDLe8KahHpdJ7WRJedbQOGxwT3
         uLeNohArWi6fGvuxtfgiLLUHQ6uQCEhJ4LtwbmSNOvC13GYj1Y7aiEk74dUUV0FfeEh9
         Pqf3hiAzkFN9AyZ6/KilDOKmLjC0TXwuuHcgguhyxryyu4p7d4Pf9OsDpKcy/j/Brpjf
         NZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPsKR5K/HusQdEK0JGwOzPTy5Qcqu8J0mVDuLnVWRNQ=;
        b=LhouE3bKiU87+Tqhq11JIATfW+Z369CUi/Gh4TKqBR/ifHwGbNwExZQPMwNsDt3+Z8
         7RD3sGqHYTJgGTKEKCOThabypsKo7TL6I+Zvh+FyfPDJqIHjWOA2UAoSBIDlOi4yPCb0
         o3DeWQbG/tW12+ZgS0B+KfIam/dsehO3XSF3tcogH5DdOR4AioGlnOmQxpG/2naWGTCH
         o+UDCGhpdaoN04HnpnXrvy9t8t7D4xF2DkmM92Br343/telQDQwbHszoJhg+WeoD3PDI
         lWH4jdO/Me/NY76ksYXvfLc4p2R40JXgc07vzG90waDFvZe+Wrf0394Oq/N8lIlAS1+3
         q9pw==
X-Gm-Message-State: ALyK8tLcxdD6bcoCjlrBjC7eWKrlKfR9AuGFTH+CK6djdc8c4Fn27X3SlOrMvQ0Vu7gK7A==
X-Received: by 10.66.167.168 with SMTP id zp8mr2068967pab.20.1465561728635;
        Fri, 10 Jun 2016 05:28:48 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 189sm17567921pfd.18.2016.06.10.05.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:44 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296977>

This reduces the number of "if (verbose)" which makes it a bit easier
to read imo. It also makes it easier to redirect all these printouts,
to a file for example.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 88 +++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 01e34b6..4020744 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -50,6 +50,21 @@ static int non_common_revs, multi_ack, use_sideband;
 #define ALLOW_REACHABLE_SHA1	02
 static unsigned int allow_unadvertised_object_request;
=20
+__attribute__((format (printf, 2, 3)))
+static inline void print_verbose(const struct fetch_pack_args *args,
+				 const char *fmt, ...)
+{
+	va_list params;
+
+	if (!args->verbose)
+		return;
+
+	va_start(params, fmt);
+	vfprintf(stderr, fmt, params);
+	va_end(params);
+	fputc('\n', stderr);
+}
+
 static void rev_list_push(struct commit *commit, int mark)
 {
 	if (!(commit->object.flags & mark)) {
@@ -375,8 +390,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	retval =3D -1;
 	while ((sha1 =3D get_rev())) {
 		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		if (args->verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		print_verbose(args, "have %s", sha1_to_hex(sha1));
 		in_vain++;
 		if (flush_at <=3D ++count) {
 			int ack;
@@ -397,9 +411,9 @@ static int find_common(struct fetch_pack_args *args=
,
 			consume_shallow_list(args, fd[0]);
 			do {
 				ack =3D get_ack(fd[0], result_sha1);
-				if (args->verbose && ack)
-					fprintf(stderr, "got ack %d %s\n", ack,
-							sha1_to_hex(result_sha1));
+				if (ack)
+					print_verbose(args, "got ack %d %s", ack,
+						      sha1_to_hex(result_sha1));
 				switch (ack) {
 				case ACK:
 					flushes =3D 0;
@@ -438,8 +452,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			} while (ack);
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
-				if (args->verbose)
-					fprintf(stderr, "giving up\n");
+				print_verbose(args, "giving up");
 				break; /* give up */
 			}
 		}
@@ -449,8 +462,7 @@ done:
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
 	}
-	if (args->verbose)
-		fprintf(stderr, "done\n");
+	print_verbose(args, "done");
 	if (retval !=3D 0) {
 		multi_ack =3D 0;
 		flushes++;
@@ -462,9 +474,8 @@ done:
 	while (flushes || multi_ack) {
 		int ack =3D get_ack(fd[0], result_sha1);
 		if (ack) {
-			if (args->verbose)
-				fprintf(stderr, "got ack (%d) %s\n", ack,
-					sha1_to_hex(result_sha1));
+			print_verbose(args, "got ack (%d) %s", ack,
+				      sha1_to_hex(result_sha1));
 			if (ack =3D=3D ACK)
 				return 0;
 			multi_ack =3D 1;
@@ -509,9 +520,8 @@ static void mark_recent_complete_commits(struct fet=
ch_pack_args *args,
 					 unsigned long cutoff)
 {
 	while (complete && cutoff <=3D complete->item->date) {
-		if (args->verbose)
-			fprintf(stderr, "Marking %s as complete\n",
-				oid_to_hex(&complete->item->object.oid));
+		print_verbose(args, "Marking %s as complete",
+			      oid_to_hex(&complete->item->object.oid));
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
 }
@@ -652,18 +662,12 @@ static int everything_local(struct fetch_pack_arg=
s *args,
 		o =3D lookup_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval =3D 0;
-			if (!args->verbose)
-				continue;
-			fprintf(stderr,
-				"want %s (%s)\n", sha1_to_hex(remote),
-				ref->name);
+			print_verbose(args, "want %s (%s)", sha1_to_hex(remote),
+				      ref->name);
 			continue;
 		}
-		if (!args->verbose)
-			continue;
-		fprintf(stderr,
-			"already have %s (%s)\n", sha1_to_hex(remote),
-			ref->name);
+		print_verbose(args, "already have %s (%s)", sha1_to_hex(remote),
+			      ref->name);
 	}
 	return retval;
 }
@@ -810,39 +814,32 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports multi_ack_detailed\n");
+		print_verbose(args, "Server supports multi_ack_detailed");
 		multi_ack =3D 2;
 		if (server_supports("no-done")) {
-			if (args->verbose)
-				fprintf(stderr, "Server supports no-done\n");
+			print_verbose(args, "Server supports no-done");
 			if (args->stateless_rpc)
 				no_done =3D 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports multi_ack\n");
+		print_verbose(args, "Server supports multi_ack");
 		multi_ack =3D 1;
 	}
 	if (server_supports("side-band-64k")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports side-band-64k\n");
+		print_verbose(args, "Server supports side-band-64k");
 		use_sideband =3D 2;
 	}
 	else if (server_supports("side-band")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports side-band\n");
+		print_verbose(args, "Server supports side-band");
 		use_sideband =3D 1;
 	}
 	if (server_supports("allow-tip-sha1-in-want")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
+		print_verbose(args, "Server supports allow-tip-sha1-in-want");
 		allow_unadvertised_object_request |=3D ALLOW_TIP_SHA1;
 	}
 	if (server_supports("allow-reachable-sha1-in-want")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports allow-reachable-sha1-in-want\n");
+		print_verbose(args, "Server supports allow-reachable-sha1-in-want");
 		allow_unadvertised_object_request |=3D ALLOW_REACHABLE_SHA1;
 	}
 	if (!server_supports("thin-pack"))
@@ -851,17 +848,16 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 		args->no_progress =3D 0;
 	if (!server_supports("include-tag"))
 		args->include_tag =3D 0;
-	if (server_supports("ofs-delta")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports ofs-delta\n");
-	} else
+	if (server_supports("ofs-delta"))
+		print_verbose(args, "Server supports ofs-delta");
+	else
 		prefer_ofs_delta =3D 0;
=20
 	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
 		agent_supported =3D 1;
-		if (args->verbose && agent_len)
-			fprintf(stderr, "Server version is %.*s\n",
-				agent_len, agent_feature);
+		if (agent_len)
+			print_verbose(args, "Server version is %.*s",
+				      agent_len, agent_feature);
 	}
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
--=20
2.8.2.524.g6ff3d78
