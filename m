From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/25] fetch-pack: use a separate flag for fetch in deepening mode
Date: Thu,  4 Feb 2016 16:03:49 +0700
Message-ID: <1454576641-29615-14-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFra-0007AS-MB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965557AbcBDJFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:05:51 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35438 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965453AbcBDJF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:29 -0500
Received: by mail-pf0-f181.google.com with SMTP id 65so38491686pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HQNqoEccBVshVmI5ut6MRlj2WPRqUtqC/rQxmKj1EoI=;
        b=d6Xex8jOfQXkXmlH6mneVt0dpz//F6BCSKD3OgYF6kuT3oy/wZoPfHvijUzFHmyLq4
         cZ8VKtcmNCz9Sbsmqk9d369BxcPPWcXa7+qQVtvBcA/nMm73i2JH6L39U2chzN2yUbkM
         3s4aQcmuav5XDlTlAFIfKiIk+Ln75QQWKl1QgllTHUwYDkqAJnD5WUkGBOI559GcBF7w
         Z61hiU+W5kIifjIUUI3LDpOlEWCmIWaGcEvyZJq5DvyguBnfFNzyhRX3mW7iSunSktAe
         tlCeScQEmvws7MTgUJWflU2sO/+/jmzl54pK6TuAz84MLuu0/HqXK43NJYPBGGeHjs3m
         Xy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HQNqoEccBVshVmI5ut6MRlj2WPRqUtqC/rQxmKj1EoI=;
        b=m4XTfOKZLIBzQR01ueR6sVr7VaEV7pQoyHVT+w4zC/OZZk2EcWklU+d77bwK7DtSqs
         skb7A6DWEDufpJOrjIk/SBZqPvnG/1SO9yXvWJIXa92DmEHA6fXClj60fo4Ljy28OYLv
         McBzGjLruIIjrDoRZZSOOAyDNfezqY2p+dk3Z2g71pfDKb2utRjcZyQtLqKRgR4JkXzJ
         Hadle1TonyG2+f/1sPJ+TZ8u9QbLcG6uDp4NIouLJWjcENbEjiz4i71K9QFJU/hQaoQw
         paskbXl1Wt0k3UxKlm13LRJGgSNAHnLO9+uKUmLS6Y92IEEQ6MVempdcwr7CwLpHBDng
         RuJQ==
X-Gm-Message-State: AG10YOTJiWq/CzaI3h53ZmRWyHAPckfiZauzG5C4YAqXTsmr08BbCnJpXT5YpxBaOsyFtQ==
X-Received: by 10.98.79.28 with SMTP id d28mr9211041pfb.77.1454576728728;
        Thu, 04 Feb 2016 01:05:28 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id tv6sm15462108pab.4.2016.02.04.01.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:41 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285429>

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
index 16917f9..e947514 100644
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
2.7.0.377.g4cd97dd
