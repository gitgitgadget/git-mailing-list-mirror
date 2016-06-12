From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/27] fetch-pack: use a separate flag for fetch in deepening mode
Date: Sun, 12 Jun 2016 17:53:56 +0700
Message-ID: <20160612105409.22156-15-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33g-0003eX-RX
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbcFLKz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36411 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcFLKz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id 62so8490023pfd.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbcyBvU8+bi+0c0Bs+A2eX+RZiRPvDL3MDEq4ymA5r4=;
        b=pnewpaKU5Qh0aXNGqQZIoSGpAPE4nkszCgeuF2pJgFJFLGpwAamEuw361nP7ByLlaN
         Aazf3w28gqC4kfCPp3GNCIQAAnZfA6t8QNZQBZSRwaN8zsKbSyLtnwmQXGVyhCyxOUes
         yn2kqg02oiZITxkNKtGZoe1B3RecZ9UaTh68yQCX/Xs8OG5jzacypUcsZ3VrBzKP69id
         2sGsNqBy+RWDW/OUYmndKQzqK7BSBLLiXoI6UZbgKxGKCWdlCK2pCh3t8209Dia2vrSZ
         ysgmfPJzdAbGmjleWpxoGWWGrbetwZduACzAznzWrHlsW4vI9wYEUTGtH4XTTRlL5/nM
         8UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbcyBvU8+bi+0c0Bs+A2eX+RZiRPvDL3MDEq4ymA5r4=;
        b=MLDCpCUToW/JeM3JhipiaUZbVRgXjGZSXHnH2Qmmqn2G0NnSqYnPppvzbLJach57Zw
         g2wn2WM0nABtf+Z3QsVqjS0hzsXB9A/dHaV+/PUe1phGySBo5bXFaUHfvcIF2HKbtUC0
         fWqx4nhLiMjgmfnL1K6l8kbruPwhyBZTiAiymFP3aUwhlljV3cLB3JtEgt5I9Ze1eIe9
         dYNkYBeYLL39zNyqeVmcaL04W2aNJ2xsQDza8MHiVdOUmlCvS8lHVG0Wq4vHLdI0jCxw
         sdDnDOtat+JHTitXfJ+F8fBwpoc+HftjtPF63+8eI9DZbdWRKMbNf8LL+oS5Y1Csn+tY
         oNPg==
X-Gm-Message-State: ALyK8tKe7ItC89gPqtV2zHK1yFATkfYRYng+uhiF2b1nTb9gVIUpLYYeA9bqdMIMoVY68Q==
X-Received: by 10.98.8.156 with SMTP id 28mr14742559pfi.89.1465728955179;
        Sun, 12 Jun 2016 03:55:55 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id s8sm29692347pav.39.2016.06.12.03.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:50 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297121>

The shallow repo could be deepened or shortened when then user gives
--depth. But in future that won't be the only way to deepen/shorten a
repo. Stop relying on args->depth in this mode. Future deepening
methods can simply set this flag on instead of updating all these if
expressions.

The new name "deepen" was chosen after the command to define shallow
boundary in pack protocol. New commands also follow this tradition.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 14 ++++++++------
 fetch-pack.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 08caf1d..a14d24a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -197,7 +197,7 @@ enum ack_type {
=20
 static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 {
-	if (args->stateless_rpc && args->depth > 0) {
+	if (args->stateless_rpc && args->deepen) {
 		/* If we sent a depth we will get back "duplicate"
 		 * shallow and unshallow commands every time there
 		 * is a block of have lines exchanged.
@@ -348,7 +348,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
-	if (args->depth > 0) {
+	if (args->deepen) {
 		char *line;
 		const char *arg;
 		unsigned char sha1[20];
@@ -557,7 +557,7 @@ static void filter_refs(struct fetch_pack_args *arg=
s,
 		}
=20
 		if (!keep && args->fetch_all &&
-		    (!args->depth || !starts_with(ref->name, "refs/tags/")))
+		    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
 			keep =3D 1;
=20
 		if (keep) {
@@ -627,7 +627,7 @@ static int everything_local(struct fetch_pack_args =
*args,
 		}
 	}
=20
-	if (!args->depth) {
+	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
 		commit_list_sort_by_date(&complete);
@@ -812,6 +812,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die(_("Server does not support shallow clients"));
+	if (args->depth > 0)
+		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, _("Server supports multi_ack_detailed"));
 		multi_ack =3D 2;
@@ -872,7 +874,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
-	if (args->depth > 0)
+	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 	else if (si->nr_ours || si->nr_theirs)
@@ -939,7 +941,7 @@ static void update_shallow(struct fetch_pack_args *=
args,
 	int *status;
 	int i;
=20
-	if (args->depth > 0 && alternate_shallow_file) {
+	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
 			unlink_or_warn(git_path_shallow());
 			rollback_lock_file(&shallow_lock);
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..4d0adb0 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -25,6 +25,7 @@ struct fetch_pack_args {
 	unsigned self_contained_and_connected:1;
 	unsigned cloning:1;
 	unsigned update_shallow:1;
+	unsigned deepen:1;
 };
=20
 /*
--=20
2.8.2.524.g6ff3d78
