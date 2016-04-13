From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/26] fetch-pack: use a separate flag for fetch in deepening mode
Date: Wed, 13 Apr 2016 19:54:57 +0700
Message-ID: <1460552110-5554-14-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKLM-0004M0-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030768AbcDMM4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35872 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030757AbcDMM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id q129so4049651pfb.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ar6nFncniqDFeKYuri93abzYpwtAw793LXh2drkulZI=;
        b=DBAnbeDbaDxqXlsNx9fFeG9/0JLB3ySvMyaRXnLz0XqiYEYToXAAOJiNBcV7lu782v
         alE15QL35ZUem2PCl/KT8EODKiqWNficR29hvyE4p16QfhD97XXwjX/umuZdJxPDwkSU
         CIR65r/nqY/QKU+UZGtgKFmEcB3tF4nhi4f19liCOr99/5bqKtXVfx67Z9AlwdJ7p9Aa
         pPjxImnnaVRJ353KBTh3cbv+lpd1VIcgKrKJxSE6tfGeXXTQHrwEiyJj+BgVe3958USW
         xRjKR1b0TAb4SS98w7EkH5ehT2+m9AGx7U1AtWc9vIm6CAWDbbrc7F1kzazd4Z/yZTYQ
         06oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ar6nFncniqDFeKYuri93abzYpwtAw793LXh2drkulZI=;
        b=ga7jjt13HymRctX7hpGoEMuA96EhhGMf5F5U7kDZfi/btFeshgI339rdD/unoeTIMH
         xsz3pREoJLZfxdUFIHlRBLZVcYGBrtsqGYY5gAHMnzIRMjFmnW3vQRtyISINMsSLYQtm
         N+m3odJORU4SQCVCPcG0lPfUhJFENBqJxSOCy2f8HLUrrddNghkVNUvRUh70zKvP/mPl
         ST+ytQMnQlXadhve8ixLI8FgwqVImsL7L+adY7NkJ53cdOFPcqz8OK3HY6lad/mLht+S
         FSHZvyv1gkQXl743qTenDcWmxsNtWdyJAd16orRo2p7B/PquRAoB7K8gHT7hEuWy+mwy
         GuDg==
X-Gm-Message-State: AOPr4FUhJp3W1CNm9/eKnV5JD9bcSWr33A0BaZI/QaFxwwS0XGlMZBPNr/KN4UE1/V96IQ==
X-Received: by 10.98.7.153 with SMTP id 25mr12796649pfh.38.1460552180118;
        Wed, 13 Apr 2016 05:56:20 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id r191sm51068968pfr.36.2016.04.13.05.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:26 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291407>

The shallow repo could be deepened or shortened when then user gives
--depth. But in future that won't be the only way to deepen/shorten a
repo. Stop relying on args->depth in this mode. Future deepening
methods can simply set this flag on instead of updating all these if
expressions.

The new name "deepen" was chosen after the command to define shallow
boundary in pack protocol. New commands also follow this tradition.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.8.0.rc0.210.gd302cd2
