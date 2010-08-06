From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/12] merge-file: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:27:43 -0500
Message-ID: <20100806032742.GP22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:29:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDcP-0002Vt-GX
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385Ab0HFD3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:29:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41534 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759092Ab0HFD3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:29:05 -0400
Received: by gwb20 with SMTP id 20so2676770gwb.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Sn0WWllgbhuRaP3omfm7TD97wayNDZFJ/XzGoox5mSg=;
        b=nyP7JvPQEfTvZvKw4/zYGQCslnKjz7FI7+1oh2dBWEHlwFvji16SINBH+njcazQVlt
         ZsrjrLl5+09ZU/5bJgI+3VEUbiyzcB2R9j9iTQUuoV8FnKE7VBpYr3lUuSldhbdem/pl
         n3ucA5oVa4rCo65sZAcdGcDYfRnU8ao9p/XH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y6eoqpLiKM1TMrZNrVVXltBdnFtDC0RMGDQjz8hppEc33mZQbWaFj7dnf1o53xYRPq
         db9Fpl3bRfh0UOhYrcsQ6dkzs/IwZujf5A3UJQBzp43NXXn7W9WHzsae4Zqmq61d2FAc
         TpFuA5TbmIGva00GYZnTEjaDYMPP5zTq4zwmc=
Received: by 10.101.57.6 with SMTP id j6mr13035859ank.89.1281065344461;
        Thu, 05 Aug 2010 20:29:04 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w6sm1307364anb.23.2010.08.05.20.29.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:29:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152758>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Part of a campaign to make repository-local configuration
available early (simplifying the startup sequence for
built-in commands).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before (except the commit message).

Well, that=E2=80=99s it.  There=E2=80=99s also a separate fix for
"check-ref-format --branch", which I=E2=80=99ll send under separate
cover.

Still to be considered are various commands that currently
do not do an unconditional repository search, especially
low-level commands that are not about the current repository:
verify-pack, mailinfo, hash-object, archive --remote,
check-ref-format, diff --no-index, help, and all the others.
Let=E2=80=99s bite off one thing at a time. :)

Thanks for reading; I hope the patches were not too dull.
Thoughts (especially improvements) welcome, as always.

 builtin/merge-file.c |    4 +---
 git.c                |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index b8e9e5b..b6664d4 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -28,7 +28,6 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	xmparam_t xmp =3D {{0}};
 	int ret =3D 0, i =3D 0, to_stdout =3D 0;
 	int quiet =3D 0;
-	int nongit;
 	struct option options[] =3D {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard out=
put"),
 		OPT_SET_INT(0, "diff3", &xmp.style, "use a diff3 based merge", XDL_M=
ERGE_DIFF3),
@@ -50,8 +49,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	xmp.style =3D 0;
 	xmp.favor =3D 0;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
 		if (0 <=3D git_xmerge_style)
diff --git a/git.c b/git.c
index 84bef76..5433875 100644
--- a/git.c
+++ b/git.c
@@ -350,7 +350,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
-		{ "merge-file", cmd_merge_file },
+		{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 		{ "merge-index", cmd_merge_index, RUN_SETUP },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE=
 },
--=20
1.7.2.1.544.ga752d.dirty
