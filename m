From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/12] index-pack: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:18:53 -0500
Message-ID: <20100806031853.GM22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 05:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDTq-0000RT-GP
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab0HFDUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:20:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36182 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab0HFDUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:20:16 -0400
Received: by yxg6 with SMTP id 6so2715760yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JDbiSCwhkGnXu8fvl/zYDL8FZrA2t64wVr39f+lYMEs=;
        b=KnRPcH06b2Vo8NXFKIFBcmI1MEOTyBDiC/j+dT95a732Na7uA80t8HxJN0miB0ANs3
         3HRAWP+JEst/cR+7H1KQhraNoCHVScvzbXMDkgPoMETYrrhmluycTrAd5/GRuhIIB+Z5
         Ml3hmUJuEUEPe6bsdUm7zKFg72oJTZo0RiZR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bEjdW9BEN6wXDHgGArYMF2ITPzh3OUQ41EvVSifwhRHWmU6t5h21CpCDx+1+NVIfuJ
         4uEfk10vLsz0gzL1Wv0NAcb2B0cgHbTmisgjDncGOexjkcY3GJzF1R1+/rWlqyigcTBo
         bhN8CnqLcKCtkBYLC5RoxKCOWaCI6h7kiVY2k=
Received: by 10.150.254.17 with SMTP id b17mr13538415ybi.82.1281064815276;
        Thu, 05 Aug 2010 20:20:15 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id 36sm2945578ybr.8.2010.08.05.20.20.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:20:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152754>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

index-pack already runs a repository search unconditionally; running
such a search earlier is not risky and ensures GIT_DIR will be set
correctly if the configuration needs to be accessed from
run_builtin().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Requires the jn/maint-setup-fix topic to apply.  See the cover
letter "[PATCH jn/paginate-fix 0/12] Re: ..." for more on that.

Just like last round, except for the new log message.

 builtin/index-pack.c |    2 --
 git.c                |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 89a1f12..e852890 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -880,12 +880,10 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
-	int nongit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_index_pack_config, NULL);
 	if (prefix && chdir(prefix))
 		die("Cannot come back to cwd");
diff --git a/git.c b/git.c
index e89c010..92ec5d3 100644
--- a/git.c
+++ b/git.c
@@ -339,7 +339,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
-		{ "index-pack", cmd_index_pack },
+		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
--=20
1.7.2.1.544.ga752d.dirty
