From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH v4] fetch-pack: fix object_id of exact sha1
Date: Fri,  4 Mar 2016 22:11:38 -0300
Message-ID: <1457140298-2400-1-git-send-email-gabrielfrancosouza@gmail.com>
References: <20160304005000.GA1074@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 05 02:12:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac0lF-0004Jw-Oc
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 02:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759765AbcCEBL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 20:11:58 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:32964 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759049AbcCEBL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 20:11:57 -0500
Received: by mail-yk0-f172.google.com with SMTP id z13so29950606ykd.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 17:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvwv3nae3lYyoVmlNxOgDYRich9scQpO4H3sQsw0gKU=;
        b=NusjTog+ULxBqXnCYSuhn6nKd8wSYwFrXEkjlNLJlv6OP2JFAUa5SG+tANIsUhvSvl
         IdVwHR2u1FrkcApTLkH4trxiOpL/WKdJD5EXiAo9KV1++1DlRC97dFpOFOpPqsXUI93j
         AKYn5dSi/Wgpwgd5vtaS0+6Mn2n8gQ+O473s9UlSYKHP3NAT84iih1TAwMLXJe/oD0Ev
         sljyc3RdoN6DK+Zh2z8/NW0RoiEDEG8A7NwSpFiW+EIcIa3/OsNboR+W7gyskN8uL8X0
         yWZoMpNMyU/SiI3QNxu+EEnJ+U3jHPdhdFXcw1GnDC5ZxWXZiv8/c0+50s3qdg3JYRSS
         ZdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvwv3nae3lYyoVmlNxOgDYRich9scQpO4H3sQsw0gKU=;
        b=W+uVGOz4N2+cS19qlATilH0vrRbbrgcZhBtcTWL58Pf1bdxQxfgUQxDCgBgk5WEBGP
         N6scZLaDuXwSEQ5HDzSLNAWNUCTwoEvt9kmLIXHWka8NCpUMvWP9q9ky6jDTAmuMFOGU
         nZZpVbr1tRSZsv96h3YJuj5qO7H2VojnDOQitIB3OogvpB2sSo7g2scmvKRqhh23Ty5L
         EEO4AShTpGwsHwH9KwGXVuFbkz2RE1aD/rrVE3To2+oxxPlOot0zc4O2q+kVB8jUvYFq
         hVQ77oYNYuEeBoD4xn6LkIMsmE6dhUDR1+rqkAGrOjwrrv5fIVHJc7rU/kP+9HHR1rwb
         yZNg==
X-Gm-Message-State: AD7BkJJ+1P/h3E+kke/YIEJn3IZBuw9QAM4qh5CIJRAk/x7iZrLehWw+wOJmvzNXbE31OA==
X-Received: by 10.37.64.204 with SMTP id n195mr3174435yba.63.1457140316371;
        Fri, 04 Mar 2016 17:11:56 -0800 (PST)
Received: from ghost.localdomain ([201.82.54.180])
        by smtp.gmail.com with ESMTPSA id u190sm4833751ywd.17.2016.03.04.17.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 17:11:55 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <20160304005000.GA1074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288287>

Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
2013-12-05) added support for specifying a SHA-1 as well as a ref name.
Add support for specifying just a SHA-1 and set the ref name to the same
value in this case.

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
---
 Documentation/git-fetch-pack.txt |  4 ++++
 builtin/fetch-pack.c             | 16 +++++++++++++---
 t/t5500-fetch-pack.sh            | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 8680f45..239623c 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -104,6 +104,10 @@ be in a separate packet, and the list must end with a flush packet.
 	The remote heads to update from. This is relative to
 	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
++
+If the remote has enabled the options `uploadpack.allowTipSHA1InWant` or
+`uploadpack.allowReachableSHA1InWant`, they may alternatively be 40-hex
+sha1s present on the remote.
 
 SEE ALSO
 --------
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 79a611f..50c9901 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -16,10 +16,20 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	struct ref *ref;
 	struct object_id oid;
 
-	if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
-		name += GIT_SHA1_HEXSZ + 1;
-	else
+	if (!get_oid_hex(name, &oid)) {
+		if (name[GIT_SHA1_HEXSZ] == ' ') {
+			/* <sha1> <ref>, find refname */
+			name += GIT_SHA1_HEXSZ + 1;
+		} else if (name[GIT_SHA1_HEXSZ] == '\0') {
+			/* <sha1>, leave sha1 as name */
+		} else {
+			/* <ref>, clear cruft from oid */
+			oidclr(&oid);
+		}
+	} else {
+		/* <ref>, clear cruft from get_oid_hex */
 		oidclr(&oid);
+	}
 
 	ref = alloc_ref(name);
 	oidcpy(&ref->old_oid, &oid);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..9b9bec4 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -531,6 +531,20 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
 		git fsck
 	)
 '
+
+test_expect_success 'fetch-pack can fetch a raw sha1' '
+	git init hidden &&
+	(
+		cd hidden &&
+		test_commit 1 &&
+		test_commit 2 &&
+		git update-ref refs/hidden/one HEAD^ &&
+		git config transfer.hiderefs refs/hidden &&
+		git config uploadpack.allowtipsha1inwant true
+	) &&
+	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
-- 
2.7.2
