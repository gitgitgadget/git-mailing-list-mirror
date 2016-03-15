From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/16] ref-filter: modify "%(objectname:short)" to take length
Date: Tue, 15 Mar 2016 22:17:04 +0530
Message-ID: <1458060436-1215-5-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8F-0000lK-7e
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbcCOQrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35952 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934545AbcCOQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:33 -0400
Received: by mail-pf0-f179.google.com with SMTP id u190so35739416pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bAP+bDFpAiveQ8gJbYc3cjGi/6iMIpwngtPlu+M02Ug=;
        b=Nqu2P//+ruMSSz7WkysMETD5oEFSgqXa9HZLzrbZy5sM8cm73pRVppcwb3xBzQKDLs
         JPzCIQstJ31Ngl3UPIC1k8+ERddZ4VW8VQqQrZFs8IWB+kzwwGLFqcPn7pdAlGlnTf8B
         Y24Ze+UQY16A9v5R260IDfnmHJAL97uqRpNQ4XFcodbx0bIuSwA3W74eSt727b7wcq8o
         kVngv+Qrv0Ar0nKtZX4/OzPt81jvUySubGzbyYmx5bt1NesZz0xglEGkztIQ6LkkwcUr
         yUzdvkbh6R/ZlId0aNKbLv/esfAqjOFCCN5kYXytCmpDFKKb/2rlxZkekf1LKNEWFqrr
         kn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bAP+bDFpAiveQ8gJbYc3cjGi/6iMIpwngtPlu+M02Ug=;
        b=FcWozzGKh7sLaRhP4a0zX2o7Nalk9hDcUSFFsZek74suBgeblSj6mdtpuZAsxMP7gH
         v77UDV8gKKIDtEv/76EhBHxKAuwJeMLJ1710d6KxUii0vAmPSa5vfNMN2rc61nxwPDtD
         GxZNNothc285xYmQQLtA9T2NoL8W08KaYxYLHUMpW7YSVIJtMU7ChWC+w7lH7rYabGxl
         x/0d5IKWTgH1gGk2C9fm21zrx6fTIWt/bDUrgoeMqARvrFAzohi9K1JsgFhdszln9c/G
         2fwHm1pQYxLCtchE1hZpYjFJSSeRI3xDkHZtzSPHwGTS3p5m0/xEGl9k0LNgfTAkUbI5
         34Wg==
X-Gm-Message-State: AD7BkJIkW+g0i8OSNAUln3tT/loE0aU3RJOg8kVxXolSPE865jvkcnCJ45PHPk3G4V74gQ==
X-Received: by 10.66.220.162 with SMTP id px2mr48073016pac.15.1458060452279;
        Tue, 15 Mar 2016 09:47:32 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:31 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288868>

Add support for %(objectname:short=<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified 7 is used. The minimum length is 'MINIMUM_ABBREV'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c            | 25 +++++++++++++++++++------
 t/t6300-for-each-ref.sh | 10 ++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 857a8b5..17f781d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,7 +55,10 @@ static struct used_atom {
 			const char *if_equals,
 				*not_equals;
 		} if_then_else;
-		enum { O_FULL, O_SHORT } objectname;
+		struct {
+			enum { O_FULL, O_LENGTH, O_SHORT } option;
+			unsigned int length;
+		} objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -118,10 +121,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		atom->u.objectname = O_FULL;
+		atom->u.objectname.option = O_FULL;
 	else if (!strcmp(arg, "short"))
-		atom->u.objectname = O_SHORT;
-	else
+		atom->u.objectname.option = O_SHORT;
+	else if (skip_prefix(arg, "short=", &arg)) {
+		atom->u.contents.option = O_LENGTH;
+		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
+		    atom->u.objectname.length == 0)
+			die(_("positive value expected objectname:short=%s"), arg);
+		if (atom->u.objectname.length < MINIMUM_ABBREV)
+			atom->u.objectname.length = MINIMUM_ABBREV;
+	} else
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
@@ -591,12 +601,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 			   struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, "objectname")) {
-		if (atom->u.objectname == O_SHORT) {
+		if (atom->u.objectname.option == O_SHORT) {
 			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			return 1;
-		} else if (atom->u.objectname == O_FULL) {
+		} else if (atom->u.objectname.option == O_FULL) {
 			v->s = xstrdup(sha1_to_hex(sha1));
 			return 1;
+		} else if (atom->u.objectname.option == O_LENGTH) {
+			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
+			return 1;
 		} else
 			die("BUG: unknown %%(objectname) option");
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 19a2823..2be0a3f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -60,6 +60,8 @@ test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom head tree $(git rev-parse refs/heads/master^{tree})
 test_atom head parent ''
 test_atom head numparent 0
@@ -99,6 +101,8 @@ test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom tag tree ''
 test_atom tag parent ''
 test_atom tag numparent ''
@@ -164,6 +168,12 @@ test_expect_success 'Check invalid format specifiers are errors' '
 	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
+test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
+	test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
+	test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
+	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
+'
+
 test_date () {
 	f=$1 &&
 	committer_date=$2 &&
-- 
2.7.3
