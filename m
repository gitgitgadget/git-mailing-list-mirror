From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/3] merge-file: add option to specify the marker size
Date: Sun, 28 Feb 2010 20:56:19 +0100
Message-ID: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlpFj-0003G6-HH
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 20:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031940Ab0B1T4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 14:56:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:50896 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031932Ab0B1T43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 14:56:29 -0500
Received: by fg-out-1718.google.com with SMTP id d23so664722fga.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bdY+xMndqzbpkY6+EeB/K2ysxRZjy4ACd5QMuQLtpmU=;
        b=UVVosY4mvMV15Dn+dbjwvJ5zPo+3erCHXftLc5p+u2DOLXna3r9Bf4GJ3y0f2hi8eG
         y2wFTWc2kqEjvQedSYW5/hVN5Zj08PrEhjIZ1b0uwk6cqKqvQb3Lz8oXRRXTyWLJJa4x
         wJv8Jxd0AIz0Z3L1tgedNvHeVV/Fzj641H/O4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MPuq5VzbsNvsSwQImMTolrf/7wnlC3sB/ZaQjU+vlB3EhqBz0H0tzbzftJRxAw/7m+
         favkf6N2aMngEBreEtJ5ucu/Ah0xoklerX7OUI3I59+Bx6Axka7hK2XPNMetRXRHxRHb
         JboZN//0SW3CPvRdHrK5SURpvhSZMxchD1D+A=
Received: by 10.103.126.40 with SMTP id d40mr2810287mun.23.1267386983648;
        Sun, 28 Feb 2010 11:56:23 -0800 (PST)
Received: from localhost (p5B0F7A0D.dip.t-dialin.net [91.15.122.13])
        by mx.google.com with ESMTPS id 7sm13830655mup.3.2010.02.28.11.56.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Feb 2010 11:56:22 -0800 (PST)
X-Mailer: git-send-email 1.7.0.584.g2da2b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141262>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

This can probably improved in a way, that the marker size will be taken
from attributes. This could be done by an explicit --marker-size-by-path
option or an option which names one of the three input files as a git
path.

For example:

 $ echo "foo conflict-marker-size=32" > .gitattributes
 $ git merge-file --marker-size-by-path=foo fileA fileB fileC

=> marker size would be 32

Or:

 $ echo "fileC conflict-marker-size=32" > .gitattributes
 $ git merge-file --marker-size-by-source=theirs fileA fileB fileC

=> marker size would be 32

 Documentation/git-merge-file.txt |    5 +++--
 builtin-merge-file.c             |    1 +
 t/t6023-merge-file.sh            |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 234269a..a5b9c1f 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
-	[--ours|--theirs] [-p|--stdout] [-q|--quiet]
+	[--ours|--theirs] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
 	<current-file> <base-file> <other-file>
 
 
@@ -37,7 +37,8 @@ normally outputs a warning and brackets the conflict with lines containing
 If there are conflicts, the user should edit the result and delete one of
 the alternatives.  When `--ours` or `--theirs` option is in effect, however,
 these conflicts are resolved favouring lines from `<current-file>` or
-lines from `<other-file>` respectively.
+lines from `<other-file>` respectively.  The length of the conflict markers
+can be given with the `--marker-size` option.
 
 The exit value of this program is negative on error, and the number of
 conflicts otherwise. If the merge was clean, the exit value is 0.
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 1e70073..57d757c 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -39,6 +39,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &favor, "for conflicts, use their version",
 			    XDL_MERGE_FAVOR_THEIRS),
+		OPT_INTEGER(0, "marker-size", &xmp.marker_size, "for conflicts, use this marker size"),
 		OPT__QUIET(&quiet),
 		OPT_CALLBACK('L', NULL, names, "name",
 			     "set labels for file1/orig_file/file2", &label_cb),
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index d605024..5034dd1 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -215,4 +215,41 @@ test_expect_success '"diff3 -m" style output (2)' '
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Dominus regit me,
+<<<<<<<<<< new8.txt
+et nihil mihi deerit;
+
+
+
+
+In loco pascuae ibi me collocavit;
+super aquam refectionis educavit me.
+||||||||||
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+==========
+et nihil mihi deerit,
+
+
+
+
+In loco pascuae ibi me collocavit --
+super aquam refectionis educavit me,
+>>>>>>>>>> new9.txt
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam TU mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+
+test_expect_success 'marker size' '
+	test_must_fail git merge-file -p --marker-size=10 \
+		new8.txt new5.txt new9.txt >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.0.584.g2da2b
