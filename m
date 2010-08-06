From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/12] shortlog: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:01:37 -0500
Message-ID: <20100806030135.GH22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 05:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDDM-0004Vp-SK
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935308Ab0HFDDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:03:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61390 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935307Ab0HFDDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:03:01 -0400
Received: by yxg6 with SMTP id 6so2713036yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zG0Qqk6X56uWmWMpbmwiS6K4oa5h8RPhXJUuM8nqoBg=;
        b=iT7t/H2jJ3H6nmU+qjZNR9W9JJwMZlbP3sGVycPWxx8YyKrqMfttKXml2cdB1w5wnL
         hyc9NUUZKKFBIftuT78E85ZCMKqTmKDoZFgYUKNWL1x0OzKPpFFVd9Ua8HNXqwobA1MU
         zA+wfwIkqjVZXeonuxifaiKJpSq2uKSVB/zbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=d56jnKubVQ1T6LsENKWqx1nGoDGd8ZbztNIWqQU8KNGNcHLuUqtwt6RMhIF0YeQk1S
         jxJToBt2BBbTff8C8jGGJF4c6TG6rLMImnL3kVNdJ99Sia8nqljUkTtAWSaM4iIOLrzS
         gkus0H4p0NBatx2LhPKJJjczn2xyJEGSEoU2o=
Received: by 10.150.195.12 with SMTP id s12mr4980115ybf.414.1281063780879;
        Thu, 05 Aug 2010 20:03:00 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id x3sm2925856ybl.22.2010.08.05.20.02.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:03:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152749>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

shortlog already runs a repository search unconditionally;
running such a search earlier is not very risky.

Without this change, the =E2=80=9C[pager] shortlog=E2=80=9D configurati=
on
is not respected at all: =E2=80=9Cgit shortlog=E2=80=9D unconditionally=
 paginates.

The tests are a bit slow.  Running the full battery like this
for all built-in commands would be counterproductive; the intent is
rather to test shortlog as a representative example command using
=2E.._gently().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Clarified commit message; simplified diff by keeping the nongit
variable; added tests.

 builtin/shortlog.c |    3 +--
 git.c              |    2 +-
 t/t7006-pager.sh   |    9 +++++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 5089502..36cb24b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -249,7 +249,7 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
 {
 	static struct shortlog log;
 	static struct rev_info rev;
-	int nongit;
+	int nongit =3D !startup_info->have_repository;
=20
 	static const struct option options[] =3D {
 		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
@@ -265,7 +265,6 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
=20
 	struct parse_opt_ctx_t ctx;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
diff --git a/git.c b/git.c
index c46c996..b821058 100644
--- a/git.c
+++ b/git.c
@@ -384,7 +384,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, USE_PAGER },
+		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 9215c2f..084dfdb 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -377,4 +377,13 @@ test_GIT_PAGER_overrides  expect_success test_must=
_fail 'git -p'
=20
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsen=
se'
=20
+test_pager_choices                       'git shortlog'
+test_expect_success 'setup: configure shortlog not to paginate' '
+	git config pager.shortlog false
+'
+test_doesnt_paginate      expect_success 'git shortlog'
+test_no_local_config_subdir expect_success 'git shortlog'
+test_default_pager        expect_success 'git -p shortlog'
+test_core_pager_subdir    expect_success 'git -p shortlog'
+
 test_done
--=20
1.7.2.1.544.ga752d.dirty
