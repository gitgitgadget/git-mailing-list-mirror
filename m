From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 8/9] clone: support narrow checkout with --path option
Date: Fri, 15 Aug 2008 21:27:09 +0700
Message-ID: <20080815142709.GA10765@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0If-00069p-UE
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbYHOO1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756389AbYHOO1Z
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:27:25 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:30238 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbYHOO1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:27:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so740227yxm.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0CK7z4/wvh+8znegE5Ot1Qab/szveCObjAnHuTaQdfA=;
        b=G70wQiOJWbpCwbFQob1DqO3QKnLNnhGp/SztLIVKAMWduo/f2iyaQipDuSzNPP1YgC
         zK2xcRyF7pPgRGMuzUs46cTJE93d5rD3hoTzlpmzM4RKkdETievUlyiYbL5XsihiE54y
         NGXxo5dl2PmTgquaJpqGLZ8Z0AiFR810WKqgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Z++63/b2Q+w+Y2Wb2tNi2roV5DRgeJfng21saAJH9tu6LDEqsi3Vx3lapRCRrL8PRH
         kupFwKTtrKJElCLTFrWUlmDkYF8s+vTSmBBAzIIcrS5Edfo+qjPuyGKqbVYtqjI0jdCB
         APtp2BlB8OV6s3MSDBq7Cs5UvvXQUWnGh7vxg=
Received: by 10.114.184.7 with SMTP id h7mr2558664waf.9.1218810443406;
        Fri, 15 Aug 2008 07:27:23 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id t1sm82329poh.9.2008.08.15.07.27.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:27:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:27:09 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92481>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-clone.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c0e3086..0fcf53d 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -36,6 +36,7 @@ static const char * const builtin_clone_usage[] =3D {
 static int option_quiet, option_no_checkout, option_bare, option_mirro=
r;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
+static char *option_narrow_path;
 static char *option_origin =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
=20
@@ -43,6 +44,8 @@ static struct option builtin_clone_options[] =3D {
 	OPT__QUIET(&option_quiet),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
+	OPT_STRING(0, "path", &option_narrow_path, "prefixes",
+		    "limit checkout to specified paths (narrow checkout)"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
@@ -376,10 +379,15 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
+		if (option_narrow_path)
+			die("--bare and --path options are incompatible.");
 		option_no_checkout =3D 1;
 		use_separate_remote =3D 0;
 	}
=20
+	if (option_no_checkout && option_narrow_path)
+		die("--no-checkout and --path options are incompatible.");
+
 	if (!option_origin)
 		option_origin =3D "origin";
=20
@@ -586,6 +594,11 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		opts.src_index =3D &the_index;
 		opts.dst_index =3D &the_index;
=20
+		if (option_narrow_path) {
+			opts.new_narrow_path =3D 1;
+			opts.narrow_spec =3D option_narrow_path;
+		}
+
 		tree =3D parse_tree_indirect(remote_head->old_sha1);
 		parse_tree(tree);
 		init_tree_desc(&t, tree->buffer, tree->size);
--=20
1.6.0.rc3.250.g8dd0
