From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/12] config: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:15:09 -0500
Message-ID: <20100806031509.GL22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 05:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDQC-0007nN-DR
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab0HFDQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:16:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37310 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab0HFDQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:16:30 -0400
Received: by yxg6 with SMTP id 6so2715232yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BDJue6329AYaqrNoB7mBIujsTEW4rlOkbKjF1V26f8Q=;
        b=nnOYRwNNu15NjjnCnA4Us8WeORb9AZtzmXnpmlFtuXMw2pnzJTguGVC4HiBwQqCgV3
         AkeHN99Y1g8/qMk/EnWayGDDWrmD7XP8SxWtHZcp/+skogr/6F9Ljkc6pPp+UYNPG3qN
         UCtzcfjL8ARQin4kjwgYnflp58w/bIuyuT3v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fFjYf3j5cD4G0njn7ow1vwEbauU+5dlXny7zTgUKNQ5ks1hm8L8TOzeB6uKjBIB2gB
         EarCAwtTE79fGMN77Iq0mrwCZsOIJRz4+jM4Ms5hKawqCO+5gF9DOscCDjvQWUndvHbm
         g88aLnRNbh785wwjaIHD8/dfLD6AZj+Ogbs+4=
Received: by 10.101.186.15 with SMTP id n15mr12897988anp.171.1281064590161;
        Thu, 05 Aug 2010 20:16:30 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c19sm1291103ana.22.2010.08.05.20.16.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:16:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152753>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

=46or the pager choice (and the choice to paginate) to reflect the
current repository configuration, the repository needs to be
located first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Relative to the previous round, this simplifies the patch by retaining
the nongit var; squashes in a test; and adds some words of explanation
to the log message.

 builtin/config.c |    5 ++---
 git.c            |    4 ++--
 t/t7006-pager.sh |    8 ++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index f3d1660..3f8ef91 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -330,11 +330,10 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
=20
-int cmd_config(int argc, const char **argv, const char *unused_prefix)
+int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
+	int nongit =3D !startup_info->have_repository;
 	char *value;
-	const char *prefix =3D setup_git_directory_gently(&nongit);
=20
 	config_exclusive_filename =3D getenv(CONFIG_ENVIRONMENT);
=20
diff --git a/git.c b/git.c
index 94bb1e3..f57003d 100644
--- a/git.c
+++ b/git.c
@@ -319,7 +319,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config },
+		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
@@ -376,7 +376,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_config },
+		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 6680668..dbbe8d9 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -133,6 +133,14 @@ test_expect_success TTY 'configuration can disable=
 pager' '
 	! test -e paginated.out
 '
=20
+test_expect_success 'git config uses a pager if configured to' '
+	rm -f paginated.out &&
+	git config pager.config true &&
+	test_when_finished "git config --unset pager.config" &&
+	test_terminal git config --list &&
+	test -e paginated.out
+'
+
 test_expect_success 'configuration can enable pager (from subdir)' '
 	rm -f paginated.out &&
 	mkdir -p subdir &&
--=20
1.7.2.1.544.ga752d.dirty
