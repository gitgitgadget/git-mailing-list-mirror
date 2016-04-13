From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/26] remote-curl.c: convert fetch_git() to use argv_array
Date: Wed, 13 Apr 2016 19:54:45 +0700
Message-ID: <1460552110-5554-2-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKJ-0003tz-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966056AbcDMMzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35109 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965750AbcDMMzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so4085002pfr.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q94+z+Bw5S1YnfXWh+2oODXVmPRWhGsx1tpNSM5OJaA=;
        b=BO6wrd4hvzvgObqviTcHRM4UBzefk3Thp8bGq8UL+gRxFucmV2vG1+l2jFmIgPoooH
         6ynmVEd3V/rfJQblwmshqE+JzRo3SSC8exVN/LDrfYvcDcGlIEXUVWMyV5pPQF0ctb8B
         Ij0jS1rCrj9GdNuJ4UizA1SF+da7prxxS4B9s08tfcf4xnE/Fy4hR4o6IYJ4Q3evCOzC
         UEvJgRMNsAdnb1JocXMz4SztT4GLL+bS3QESJJJlmBRoZ+H7ufGT3K984tsS8o/yG10s
         KCclQkBLTWXQrgg2rRK2p30yR+mVm7n3DnZDNEm0TfIl39mmWzo4gSmc2AF8LnlJIRd9
         vmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q94+z+Bw5S1YnfXWh+2oODXVmPRWhGsx1tpNSM5OJaA=;
        b=SCa6E1FCz8W70AxzH7fFLUB+swwto5qNTwF6qx87LJqtOjeljHfB6gOaJDvzhgeNow
         DavSy+Y/XnpkkC7akjfNDz635qbuxsfLVRGFr6ozlH5AARzbzHazFClxnXN4adhlUW3u
         ccJ6gv5y/DQemhteiNOkFLQQcNcxid5HV3/pQEqqxGPS8BmKUgOumzXmqfICA3ycNq5P
         Oonn3AnAVP91O29QxpBQbQYVXQ+dkFYTqzP4W2yXXYCOqxAuy0+kWCEKZvH6K+yDznpo
         X4JttPsYeydTA+vKoIRyMLjD4/QK0cYvV3QSUdVyULWvHw8nWBHUd8wySgP2/GOIrKuf
         or0Q==
X-Gm-Message-State: AOPr4FUDFSQthyl3HqDS1t5oSD295j8Bdc23t1QDQMAysx1Zh1WCdTnFtIVyxX463C1IkQ==
X-Received: by 10.98.17.151 with SMTP id 23mr12473263pfr.37.1460552113857;
        Wed, 13 Apr 2016 05:55:13 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id ch2sm51172788pad.28.2016.04.13.05.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:19 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291395>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote-curl.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index c704857..4289c20 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -726,37 +726,30 @@ static int fetch_git(struct discovery *heads,
 	struct rpc_state rpc;
 	struct strbuf preamble =3D STRBUF_INIT;
 	char *depth_arg =3D NULL;
-	int argc =3D 0, i, err;
-	const char *argv[17];
+	int i, err;
+	struct argv_array args =3D ARGV_ARRAY_INIT;
=20
-	argv[argc++] =3D "fetch-pack";
-	argv[argc++] =3D "--stateless-rpc";
-	argv[argc++] =3D "--stdin";
-	argv[argc++] =3D "--lock-pack";
+	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
+			 "--stdin", "--lock-pack", NULL);
 	if (options.followtags)
-		argv[argc++] =3D "--include-tag";
+		argv_array_push(&args, "--include-tag");
 	if (options.thin)
-		argv[argc++] =3D "--thin";
+		argv_array_push(&args, "--thin");
 	if (options.verbosity >=3D 3) {
-		argv[argc++] =3D "-v";
-		argv[argc++] =3D "-v";
+		argv_array_push(&args, "-v");
+		argv_array_push(&args, "-v");
 	}
 	if (options.check_self_contained_and_connected)
-		argv[argc++] =3D "--check-self-contained-and-connected";
+		argv_array_push(&args, "--check-self-contained-and-connected");
 	if (options.cloning)
-		argv[argc++] =3D "--cloning";
+		argv_array_push(&args, "--cloning");
 	if (options.update_shallow)
-		argv[argc++] =3D "--update-shallow";
+		argv_array_push(&args, "--update-shallow");
 	if (!options.progress)
-		argv[argc++] =3D "--no-progress";
-	if (options.depth) {
-		struct strbuf buf =3D STRBUF_INIT;
-		strbuf_addf(&buf, "--depth=3D%lu", options.depth);
-		depth_arg =3D strbuf_detach(&buf, NULL);
-		argv[argc++] =3D depth_arg;
-	}
-	argv[argc++] =3D url.buf;
-	argv[argc++] =3D NULL;
+		argv_array_push(&args, "--no-progress");
+	if (options.depth)
+		argv_array_pushf(&args, "--depth=3D%lu", options.depth);
+	argv_array_push(&args, url.buf);
=20
 	for (i =3D 0; i < nr_heads; i++) {
 		struct ref *ref =3D to_fetch[i];
@@ -769,7 +762,7 @@ static int fetch_git(struct discovery *heads,
=20
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name =3D "git-upload-pack",
-	rpc.argv =3D argv;
+	rpc.argv =3D args.argv;
 	rpc.stdin_preamble =3D &preamble;
 	rpc.gzip_request =3D 1;
=20
@@ -779,6 +772,7 @@ static int fetch_git(struct discovery *heads,
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
+	argv_array_clear(&args);
 	return err;
 }
=20
--=20
2.8.0.rc0.210.gd302cd2
