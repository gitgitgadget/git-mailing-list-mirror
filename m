From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/16] ls-files: add --narrow-checkout option to "will checkout" entries
Date: Sun, 14 Sep 2008 20:07:54 +0700
Message-ID: <1221397685-27715-6-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerMa-0005q6-M9
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbYINNIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbYINNIw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:08:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbYINNIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:08:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cW1I2KgnA25cEJsEojV2rH46ON4vbtaPntLbpQWaKkI=;
        b=w2qeXxwj+qkKH8amk5nHYyuC+MxN+jowMotG+3kjEVg/5+43Z6qTsKuF/WTpcVbpNu
         QiC56p58B3ydxAzzmK+gbxF8Jylc6nlOOADN+OF3cPS8TZAYIyugK/GKvyDWCloxeW8s
         b5pAPksGprSqfLYugHFw1iYs1SdS2Iv8/fKSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oyJ4ddthbKRcJGA4Vk3OF5Wkp61ubVKDXKh5RSjifcqcn81b7VDHPRON2ydIcHhBj8
         Q4HctDYlGedsfVpPexd1TnaZslJQgs5gIioatXW8Is/V5LcygB+/Ycu5gWJ1n7qj2RZI
         6Dn57C8D16qelwJzMScUEVfO2MOc0BoNABka0=
Received: by 10.142.140.14 with SMTP id n14mr2257273wfd.164.1221397731342;
        Sun, 14 Sep 2008 06:08:51 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 30sm20011307wff.18.2008.09.14.06.08.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:08:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:43 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95832>

Even in narrow checkout mode, "git ls-files --cached" (and --stage)
will show all entries in index. When those options are used together
with --narrow-checkout, no-checkout entries will be skipped.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |    6 ++++++
 builtin-ls-files.c             |   11 +++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 9f85d60..f74b212 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git ls-files' [-z] [-t] [-v]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])\*
 		(-[c|d|o|i|s|u|k|m])\*
+		[--narrow-checkout]
 		[-x <pattern>|--exclude=3D<pattern>]
 		[-X <file>|--exclude-from=3D<file>]
 		[--exclude-per-directory=3D<file>]
@@ -72,6 +73,11 @@ OPTIONS
 	to file/directory conflicts for checkout-index to
 	succeed.
=20
+--narrow-checkout::
+	When narrow checkout is being used, this option together with other
+	index-based selection options like --cached or --stage, only narrowed
+	portion will be printed out.
+
 -z::
 	\0 line termination on output.
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 068f424..456d41c 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -20,6 +20,7 @@ static int show_unmerged;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int narrow_checkout;
 static int line_terminator =3D '\n';
=20
 static int prefix_len;
@@ -245,6 +246,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
+			if (narrow_checkout && ce_no_checkout(ce))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -424,6 +427,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
=20
 static const char ls_files_usage[] =3D
 	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified])* "
+	"[ --narrow-checkout ] "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
@@ -465,6 +469,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			show_cached =3D 1;
 			continue;
 		}
+		if (!strcmp(arg, "--narrow-checkout")) {
+			narrow_checkout =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted =3D 1;
 			continue;
@@ -596,6 +604,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	      show_killed | show_modified))
 		show_cached =3D 1;
=20
+	if (narrow_checkout && !show_cached && !show_stage)
+		die("ls-files: --narrow-checkout can only be used with either --cach=
ed or --stage");
+
 	read_cache();
 	if (prefix)
 		prune_cache(prefix);
--=20
1.6.0.96.g2fad1.dirty
