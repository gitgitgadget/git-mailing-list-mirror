From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/27] fetch-pack: use a separate flag for fetch in deepening mode
Date: Fri, 10 Jun 2016 19:27:01 +0700
Message-ID: <20160610122714.3341-15-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:32:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYl-0001BX-OY
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851AbcFJM3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:00 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35370 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbcFJM27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:59 -0400
Received: by mail-pa0-f66.google.com with SMTP id gp3so5024935pac.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbcyBvU8+bi+0c0Bs+A2eX+RZiRPvDL3MDEq4ymA5r4=;
        b=nXy35uLKS93zy3Oz0GNLbrAlhx3ZQKl1aYaiStUiqSeLUTUuHQXa49zAbjSKsSsyoD
         oSugK0P0FCd29QKDV0iVBTC1yY4mVoVbeqHqJwGzIrqAJa7j/HyGr7n3lx0THKCo3v+2
         Rz0Pioj3U7bY9K8brojnJ8K2Z5rjkMVYFZxIyCShZG1soVR0cSSBqR3WwvE3Fak5zLO2
         88miV+cg+bvaS+Wvp6Dz7d7xE08Bd6x4HQjOFDRUNIyX0s5d8DrZQq/UbeqzqcqLbazw
         H4ZwJ1IbwWQ+9HoEoKHsOK4RA00uqruOjVSkFkR1/XCW7ukQtTm3VlKQxkB4ZNQJ1JYq
         ohNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbcyBvU8+bi+0c0Bs+A2eX+RZiRPvDL3MDEq4ymA5r4=;
        b=dUSCpK8Z1wwsj9IDnbAw6TTjyczgLuZvXh2/v1Jf9CoaCpGBzbyzrbHnXNcDzgX07r
         TZfFZcfNcUi7mFvHL/FeccixvnGV4vsmYN9Rr+kwYqaLc3dNsZAR9VW4+u43cP1RxVvF
         RScxvM8gjAKabZ/gY0JIvLtOytNXoM3+duBLRIH+nYtpYK2qb9ZNqrQMy1Pu13wX3mXb
         IXQZ2lFcviDCYUVEt0ZSzFcuzPR2YwcWokJxA5XNQEhLb6ZqyvpExfRQRSIIiXWbN5ao
         AwdsDKx41J6EmH+UW60LP4atiGRpvkBIbkwePDPe3+ML7qEd9GUubKRqwAhA9xCD1gLX
         RmRQ==
X-Gm-Message-State: ALyK8tKaklgO+ytsueb7YmO0MfwaCJPGa9D2z9cJdCgrK5kQzu9RoH8+YYv07j474EtwDw==
X-Received: by 10.66.4.106 with SMTP id j10mr1964322paj.111.1465561738451;
        Fri, 10 Jun 2016 05:28:58 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id b185sm3972023pfb.55.2016.06.10.05.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:53 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296997>

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
