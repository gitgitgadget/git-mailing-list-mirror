From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 03/10] Make get_git_dir() and 'git rev-parse --git-dir'
	absolute path
Date: Sun, 2 Mar 2008 17:33:48 +0700
Message-ID: <20080302103348.GA8929@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:34:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlWk-0003E2-J0
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYCBKeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbYCBKeD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:34:03 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:54970 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbYCBKeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:34:01 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2353724gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=CR6ndRXxJrAwV/BoFIR9SLt36IpRUxpUjHOA1opSN+g=;
        b=SWFrB8gO3ijrCHxh1WTSyDHR9dEQgAlJm+4u+hCFT4LDxoMxy13tC7brhdxvr+rpxM01ZwSv/xcCdyIwGg1coI8wt7zNDKGTSJvOmMCYU9j08DyXRulhuZm7V+Fan6LXEm5NTsZlwhv2R7FJHmhvFElzbNjLTa97rKWYJKQ8/z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=ttlRCld60vmtdf9Vks1sWCRVqxFjy00UJZE54v3B7KN2u5lwYZEX5OoD7Pa9ChAoIDSqg6dCQqn2lZogMIL0Eez4+FG7/GjZVrf4nvMbsciPBk94vY3OEw7fONOeMEKOVrmgVzSSgjAEkGQqrKnevbBYSfpBSgvzFsUIHn/n7Jo=
Received: by 10.114.60.19 with SMTP id i19mr1390525waa.142.1204454037967;
        Sun, 02 Mar 2008 02:33:57 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id l23sm23144965waf.5.2008.03.02.02.33.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:33:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:33:48 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75763>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-rev-parse.c    |   14 +-------------
 environment.c          |    1 +
 t/t1300-repo-config.sh |    2 +-
 t/t1400-update-ref.sh  |    4 ++--
 t/t9300-fast-import.sh |    2 +-
 5 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 90dbb9d..13412b4 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -496,19 +496,7 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-dir")) {
-				const char *gitdir =3D getenv(GIT_DIR_ENVIRONMENT);
-				static char cwd[PATH_MAX];
-				if (gitdir) {
-					puts(gitdir);
-					continue;
-				}
-				if (!prefix) {
-					puts(".git");
-					continue;
-				}
-				if (!getcwd(cwd, PATH_MAX))
-					die("unable to get current working directory");
-				printf("%s/.git\n", cwd);
+				puts(get_git_dir());
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
diff --git a/environment.c b/environment.c
index 6739a3f..ab7e54c 100644
--- a/environment.c
+++ b/environment.c
@@ -51,6 +51,7 @@ static void setup_git_env(void)
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+	git_dir =3D xstrdup(make_absolute_path(git_dir));
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4928a57..45b26d5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -497,7 +497,7 @@ test_expect_success numbers '
 '
=20
 cat > expect <<EOF
-fatal: bad config value for 'aninvalid.unit' in .git/config
+fatal: bad config value for 'aninvalid.unit' in $(pwd)/.git/config
 EOF
=20
 test_expect_success 'invalid unit' '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 78cd412..4099c66 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -169,7 +169,7 @@ test_expect_success \
 	'rm -f o e
 	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	 test '"$B"' =3D $(cat o) &&
-	 test "warning: Log .git/logs/'"$m has gap after $gd"'." =3D "$(cat e=
)"'
+	 test "warning: Log '"$(pwd)"'/.git/logs/'"$m has gap after $gd"'." =3D=
 "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
 	'rm -f o e
@@ -187,7 +187,7 @@ test_expect_success \
 	'rm -f o e
 	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	 test '"$D"' =3D $(cat o) &&
-	 test "warning: Log .git/logs/'"$m unexpectedly ended on $ld"'." =3D =
"$(cat e)"'
+	 test "warning: Log '"$(pwd)"'/.git/logs/'"$m unexpectedly ended on $=
ld"'." =3D "$(cat e)"'
=20
=20
 rm -f .git/$m .git/logs/$m expect
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index cceedbb..98a0cdf 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -510,7 +510,7 @@ test_expect_success \
     'git-fast-import --export-pack-edges=3Dedges.list <input'
=20
 cat >expect <<EOF
-.git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
+$(pwd)/.git/objects/pack/pack-.pack: `git rev-parse --verify export-bo=
undary`
 EOF
 test_expect_success \
 	'I: verify edge list' \
--=20
1.5.4.2.281.g28d0e
