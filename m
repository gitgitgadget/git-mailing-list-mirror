From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/25] fetch-pack: use a separate flag for fetch in deepening mode
Date: Tue, 23 Feb 2016 20:44:50 +0700
Message-ID: <1456235103-26317-13-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIA-0000Ym-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcBWNqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:08 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35827 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcBWNqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:04 -0500
Received: by mail-pa0-f53.google.com with SMTP id ho8so113750065pac.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fHzn/Fyxvo+decGuKetCQPnmCRQRhVwUW6luH/x9nGE=;
        b=VK8bfYVJD6OBRQX5QLtpeiokcuLVw9A0a/RSNPweBx+5Fa1yUDvJ9D7vyGPPKimRZO
         olYNWyPHm2Bpnn0pyVfPJAqfRz2F0wOxXwK9kOIPENZxmyn38N15mjZ5CCDwF536RrcD
         lMooHEvTcgjRDh6VXKTHnWnjfwh0Ryk9aMkSpKg0h0QyQ3SQILvSrJUWn86SSg0NA/3M
         0bcJBlLvrmsSyR07v+MP3KDRjAb33oOURQ3nQMqmUxzTzsCi0TfA7sXcIeTpTbaA6OmB
         oLOGee0E+1+ER0bE0/KJDv4yNEy9rGqw3mDI5bCzMMeX0XMIPSK1/MxCtA9rnuWfOguh
         i9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=fHzn/Fyxvo+decGuKetCQPnmCRQRhVwUW6luH/x9nGE=;
        b=VfEjxZGP60o9E8FG0hYid+2/X3oIze5EUvXjgSCU2msyarqYCgYaJIWDx5+hXOAXSc
         SjyBkAtJ+D6tuNpfCUlrnyMELrdvJLcm7BBOhv2SYiwX9gPrKEf+xSKh79ru+w8rpMO6
         5hHMJHmZrsVqgZhFrHAHlkKuFj+razINtxonGUrS53rFaNV1LAuT4uBd8RZa/aMY17IY
         AvSOciOnobTuP+BJU7nQI65nZ8Vh9EHtWwo0Yu7uh3Je1oBCx1RejO4HWHMTBQXTryQ/
         3Kyijm2UYgLRqJoyhIJUbQ7RAqZ78QIpM4t/wvxmK/1JfCQ5iCtuDsNe6egixQO86Jpn
         16Lw==
X-Gm-Message-State: AG10YOT3kvWPAceN9sjUuaWPSUUsVXW8Yv+5ue6cCojjKATau8gNyil2ISzWKzHwy3PRlw==
X-Received: by 10.67.23.202 with SMTP id ic10mr38352132pad.127.1456235162802;
        Tue, 23 Feb 2016 05:46:02 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 70sm44431866pfs.78.2016.02.23.05.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:32 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287062>

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
index 4020744..8c37e5f 100644
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
@@ -813,6 +813,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
+	if (args->depth > 0)
+		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, "Server supports multi_ack_detailed");
 		multi_ack =3D 2;
@@ -873,7 +875,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
-	if (args->depth > 0)
+	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 	else if (si->nr_ours || si->nr_theirs)
@@ -940,7 +942,7 @@ static void update_shallow(struct fetch_pack_args *=
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
2.7.1.532.gd9e3aaa
