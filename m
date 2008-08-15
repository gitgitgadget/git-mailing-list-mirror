From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 3/9] ls-files: add --checkout option to show checked out
	files
Date: Fri, 15 Aug 2008 21:25:48 +0700
Message-ID: <20080815142548.GA10680@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0Gk-0005IQ-OE
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbYHOO0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbYHOO0G
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:26:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:41324 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbYHOO0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:26:03 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1101041wxd.4
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nJ4VTedFibBFOPCgz+e9qmu9aza7wvQ4TxmQ4jahIJ0=;
        b=uFauE9wigroxMKPWvgRhmsiBv6nbU1eYmuM1DG06qJECW91a1yL0DuVlMiPvp1vssD
         +H+Q9Sss0Etfa/fjypfiaJ3+HmPgTbNlfKeNy6bgKnytoTSVKlAZOylrqrc6Z68ovAos
         YlaBLKJOUFB5Z/IQsBdkc15rqTh8MTXgMF/ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h1DI6QRPhRARRX6CbScjlURSWnOEdKPJO93z7xs1Ol4BIeaoAkohb/8JSa2DCszko0
         yKNbWcwrlcGtHF8DD9ReBo4jddZo0y4vr+bhjh1Dx7xiRIoW3JLw3Gn89pG4msn/gPYl
         w6tWntz6OgMSXl8LAWucFHOABkyurcSPubgOA=
Received: by 10.114.144.1 with SMTP id r1mr2553983wad.140.1218810362066;
        Fri, 15 Aug 2008 07:26:02 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id z15sm56985pod.2.2008.08.15.07.25.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:26:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:25:48 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92476>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e8d568e..bcb1536 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -14,6 +14,7 @@
 static int abbrev;
 static int show_deleted;
 static int show_cached;
+static int show_checkout;
 static int show_others;
 static int show_stage;
 static int show_unmerged;
@@ -235,7 +236,7 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (show_cached | show_stage) {
+	if (show_cached | show_stage | show_checkout) {
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			int dtype =3D ce_to_dtype(ce);
@@ -245,6 +246,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
+			if (show_checkout && ce_no_checkout(ce))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -423,7 +426,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
 }
=20
 static const char ls_files_usage[] =3D
-	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified])* "
+	"git ls-files [-z] [-t] [-v] (--[cached|checkout|deleted|others|stage=
|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
@@ -465,6 +468,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			show_cached =3D 1;
 			continue;
 		}
+		if (!strcmp(arg, "--checkout")) {
+			show_checkout =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted =3D 1;
 			continue;
@@ -593,7 +600,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
=20
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified))
+	      show_killed | show_modified | show_checkout))
 		show_cached =3D 1;
=20
 	read_cache();
--=20
1.6.0.rc3.250.g8dd0
