From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] for-each-ref: refname:short utilize core.warnAmbiguousRefs
Date: Sat, 11 Apr 2009 22:35:18 +0200
Message-ID: <1239482118-31702-1-git-send-email-bert.wesarg@googlemail.com>
References: <36ca99e90904111250t7f4563e6x495937d8f3f45d40@mail.gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsjwe-0007Hp-Ft
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 22:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZDKUfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 16:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbZDKUfX
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 16:35:23 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61005 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZDKUfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 16:35:22 -0400
Received: by fxm2 with SMTP id 2so1548462fxm.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6/eMikd5WCWcUvgf1NoZ8S8RrQkOFYr/xL48pcSvh4k=;
        b=NIw8ZXvgTITO5fCROpIWBRp7hLyhYwWkFEKgIGxCH5B3KVByGAjcxnvNf+9vdY7y+y
         7NtV7JBhzb2MjhQce0vzXtGk+bQ/eWA5iOy+ir4WHV9aeq/mZHFoywjFLKeV7+HuJZe6
         kUdNju+TzzYnRM9CuD0nKUCNSnGh9/m8zxnbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wKDqNcNjXWMRB3YyfDFRrBhUoE0K2rEuxuTPvcLUCrAlWzEZU2kgwFtO6JqbtLXtC8
         rCKLoGOK3laOp7Ys3HEGAUm94zLN7cMboKzoYKqeN193NVBKVpysSBiIhNK8UmlhPGLK
         wSkSgyfrISrqg1EM+BsHF/+eIQunT6PhHznn0=
Received: by 10.86.93.19 with SMTP id q19mr2080637fgb.55.1239482120169;
        Sat, 11 Apr 2009 13:35:20 -0700 (PDT)
Received: from localhost (p5B0F4C72.dip.t-dialin.net [91.15.76.114])
        by mx.google.com with ESMTPS id 3sm4064182fge.4.2009.04.11.13.35.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 13:35:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
In-Reply-To: <36ca99e90904111250t7f4563e6x495937d8f3f45d40@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116344>

core.warnAmbiguousRefs is used to select strict mode for the
abbreviation for the "refname:short" format.

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
index 5061d3e..42cfad9 100644
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
index 2f323c6..f2af55a 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -696,7 +696,8 @@ static void populate_value(struct refinfo *ref)
 			if (formatp) {
 				formatp++;
 				if (!strcmp(formatp, "short"))
-					refname = get_short_ref(ref, 0);
+					refname = get_short_ref(ref,
+						warn_ambiguous_refs);
 				else
 					die("unknown refname format %s",
 					    formatp);
@@ -1013,6 +1014,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		sort = default_sort();
 	sort_atom_limit = used_atom_cnt;
 
+	/* for warn_ambiguous_refs */
+	git_config(git_default_config, NULL);
+
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
 	for_each_ref(grab_single_ref, &cbdata);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8bfae44..f83be5d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -279,10 +279,11 @@ test_expect_success 'Check for invalid refname format' '
 
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
@@ -294,11 +295,22 @@ test_expect_success 'Check ambiguous head and tag refs' '
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
tg: (6750239..) bw/utilize-it (depends on: bw/short_ref-warnAmbiguousRefs)
