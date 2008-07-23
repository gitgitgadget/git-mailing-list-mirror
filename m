From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 02/12] git-grep: support --no-external-grep
Date: Wed, 23 Jul 2008 21:55:49 +0700
Message-ID: <20080723145549.GA29067@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfmJ-0002M7-Tb
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYGWO4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbYGWO4K
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:56:10 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbYGWO4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:56:09 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=rE6ObepgVSdsGWsuYy0szTmQkf1HvKm+gdtxTnDcxl4=;
        b=K4gsN0DlsIgBedv+W6PfG/zeIPUfwgJFgTvG3ZX9L69wohxJy7xcAMzrrSnpErDepw
         VXA0D4q6hGmWb40x8JBhCqBLIaNANkTLCXXBSPXwY9wkStTuU96kMoeQ8OTYHy0Xi/it
         WPWu1mJm4pUafXBDlU73MOB6RpJIAgbBIUS/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=xaT/7DLg07hwFB8kwdYNJPXXO/DxrrJQgss9C8vkkkcKWVYYwGi4Hts3yid72XycHJ
         5NF5r/PklUeveBzz1AjXUtgOPlcz9Zz6GtSagwtYD/EoYKBVdJNxvyuKjsfcmk7QGgoo
         uCqS0sgnUF0l1zCmPG0IEu8GPyqZRXZmpUBkM=
Received: by 10.110.41.17 with SMTP id o17mr124073tio.18.1216824968217;
        Wed, 23 Jul 2008 07:56:08 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id i9sm15505677tid.15.2008.07.23.07.56.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:56:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:55:49 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89671>

this one is mainly for testing builtin grep

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index cc9ba6b..ee96d01 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -20,6 +20,8 @@
 #endif
 #endif
=20
+static int no_external_grep;
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
@@ -386,7 +388,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached)
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
 	 */
-	if (!cached) {
+	if (!cached && !no_external_grep) {
 		hit =3D external_grep(opt, paths, cached);
 		if (hit >=3D 0)
 			return hit;
@@ -544,6 +546,10 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			cached =3D 1;
 			continue;
 		}
+		if (!strcmp("--no-external-grep", arg)) {
+			no_external_grep =3D 1;
+			continue;
+		}
 		if (!strcmp("-a", arg) ||
 		    !strcmp("--text", arg)) {
 			opt.binary =3D GREP_BINARY_TEXT;
--=20
1.5.5.GIT
