From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] for-each-ref: utilize core.warnAmbiguousRefs for :short-format
Date: Mon, 13 Apr 2009 12:25:47 +0200
Message-ID: <1239618347-17158-2-git-send-email-bert.wesarg@googlemail.com>
References: <1239618347-17158-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 12:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtJOd-0001U2-OX
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 12:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbZDMKZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 06:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755768AbZDMKZz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 06:25:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:24564 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbZDMKZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 06:25:54 -0400
Received: by fg-out-1718.google.com with SMTP id e12so622863fga.17
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=y35SE8GZxph7SxxAjEFkgU1amf2b6zu2dBNZ4WJQLAg=;
        b=r6lcKS4GiSzQ+2VPLuy84laQQP0HclfW/xQtWvsi2MwDgg8n/r9jAjkJ7GDqT/vF9N
         8YSjND3XZk87vCZsv/hq+XfWbZfJWU1I//dKazTY0iryJjI9/+L7aogam9S43zzA5YwA
         iQ8TOofsO/FANVw74k9jHSxXRl46LFM2ElxPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u/KObbkXHdAYgK6m1DVxrCVeZj0v8ef922MnLP8Q2mQ4QvV5BwFuZRZSrFYz/6s+n1
         H+UqShUvAAkwoiTG2NCZOqxNa+p6shSoMyML9oMMs+50UbDtdGGigl/Chzyvegou5qTF
         EpDhN2pelbIvJdtbAykB3O9+614bjgtRxYqfY=
Received: by 10.86.90.2 with SMTP id n2mr3657328fgb.39.1239618352607;
        Mon, 13 Apr 2009 03:25:52 -0700 (PDT)
Received: from localhost (p5B0F4888.dip.t-dialin.net [91.15.72.136])
        by mx.google.com with ESMTPS id d6sm6434835fga.22.2009.04.13.03.25.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 03:25:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
In-Reply-To: <1239618347-17158-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116423>

core.warnAmbiguousRefs is used to select strict mode for the
abbreviation for the ":short" format specifier of "refname" and "upstream".

In strict mode, the abbreviated ref will never trigger the
'warn_ambiguous_refs' warning. I.e. for these refs:

  refs/heads/xyzzy
  refs/tags/xyzzy

the abbreviated forms are:

  heads/xyzzy
  tags/xyzzy

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Cc: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: "Shawn O. Pearce" <spearce@spearce.org>

 Documentation/git-for-each-ref.txt |    2 ++
 builtin-for-each-ref.c             |    6 +++++-
 t/t6300-for-each-ref.sh            |   18 +++++++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b362e9e..8dc873f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -75,6 +75,8 @@ For all objects, the following names can be used:
 refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
+	The option core.warnAmbiguousRefs is used to select the strict
+	abbreviation mode.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index cfff686..91e8f95 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -601,7 +601,8 @@ static void populate_value(struct refinfo *ref)
 		if (formatp) {
 			formatp++;
 			if (!strcmp(formatp, "short"))
-				refname = shorten_unambiguous_ref(refname, 0);
+				refname = shorten_unambiguous_ref(refname,
+						      warn_ambiguous_refs);
 			else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
@@ -917,6 +918,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		sort = default_sort();
 	sort_atom_limit = used_atom_cnt;
 
+	/* for warn_ambiguous_refs */
+	git_config(git_default_config, NULL);
+
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
 	for_each_ref(grab_single_ref, &cbdata);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index daf02d5..8052c86 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -301,10 +301,11 @@ test_expect_success 'Check for invalid refname format' '
 
 cat >expected <<\EOF
 heads/master
-master
+tags/master
 EOF
 
-test_expect_success 'Check ambiguous head and tag refs' '
+test_expect_success 'Check ambiguous head and tag refs (strict)' '
+	git config --bool core.warnambiguousrefs true &&
 	git checkout -b newtag &&
 	echo "Using $datestamp" > one &&
 	git add one &&
@@ -316,11 +317,22 @@ test_expect_success 'Check ambiguous head and tag refs' '
 '
 
 cat >expected <<\EOF
+heads/master
+master
+EOF
+
+test_expect_success 'Check ambiguous head and tag refs (loose)' '
+	git config --bool core.warnambiguousrefs false &&
+	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
 heads/ambiguous
 ambiguous
 EOF
 
-test_expect_success 'Check ambiguous head and tag refs II' '
+test_expect_success 'Check ambiguous head and tag refs II (loose)' '
 	git checkout master &&
 	git tag ambiguous testtag^0 &&
 	git branch ambiguous testtag^0 &&
-- 
tg: (c4ae76d..) bw/utilize-it (depends on: bw/short_ref-warnAmbiguousRefs)
