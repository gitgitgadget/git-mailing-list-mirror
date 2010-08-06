From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/12] setup: remember whether repository was found
Date: Thu, 5 Aug 2010 21:46:33 -0500
Message-ID: <20100806024633.GF22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 04:48:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhCyk-0000PS-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 04:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935304Ab0HFCsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 22:48:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55084 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935268Ab0HFCsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 22:48:07 -0400
Received: by yxg6 with SMTP id 6so2710896yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jwNkVNXw8LKLjOz+0NrqjeKt2U0LJCbHvfCNpN0a64o=;
        b=Pn8hlAhH8qlieWv1wnmPHMNDpGn462UmFVw5dZEMYi+P8V9fekSGnwSftZHgDM/vUf
         boF/GF5Wv3K9W3utpXuKDmbLL0AqSwQGRBtM6p2FG9Ah88n+wFm/wggPM6jB86VOJTBT
         VnQFu5A27Rv0Il+02Rn3JExUX7VknK9EMsUIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ULnT7YJZI9I48+fBmf86otNv3K6q9DRplnRvRkFaYU9h0sNbbq0hpnDq0Lo9XRqzze
         AHqwM7WTApwqJfkueLoeMrPv6TV6i1hajyrnV1XTFqbYbVmaMy3DD7leBcmMMpHYKKAc
         9Xc+Z2L1GgSO7bMB6Aqz0VRYgZzqrrJI9VsLg=
Received: by 10.100.35.18 with SMTP id i18mr12966526ani.139.1281062885046;
        Thu, 05 Aug 2010 19:48:05 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t24sm1251032ano.12.2010.08.05.19.48.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 19:48:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152747>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

As v1.7.2~16^2 (git --paginate: paginate external commands
again, 2010-07-14) explains, builtins (like git config) that
do not use RUN_SETUP are not finding GIT_DIR set correctly when
it is time to launch the pager from run_builtin().  If they
were to search for a repository sooner, then the outcome of such
early repository accesses would be more predictable and reliable.

The cmd_*() functions learn whether a repository was found through the
*nongit_ok return value from setup_git_directory_gently().  If
run_builtin() is to take care of the repository search itself, that
datum needs to be retrievable from somewhere else.  Use the
startup_info struct for this.

As a bonus, this information becomes available to functions such as
git_config() which might want to avoid trying to access a repository
when none is present.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Tweaked the log message a bit.

 cache.h |    1 +
 setup.c |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 0822c3b..f9e82a8 100644
--- a/cache.h
+++ b/cache.h
@@ -1099,6 +1099,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
=20
 /* git.c */
 struct startup_info {
+	int have_repository;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index 7e04602..1e32fb7 100644
--- a/setup.c
+++ b/setup.c
@@ -315,7 +315,7 @@ const char *read_gitfile_gently(const char *path)
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
  */
-const char *setup_git_directory_gently(int *nongit_ok)
+static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
@@ -470,6 +470,16 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	return cwd + offset;
 }
=20
+const char *setup_git_directory_gently(int *nongit_ok)
+{
+	const char *prefix;
+
+	prefix =3D setup_git_directory_gently_1(nongit_ok);
+	if (startup_info)
+		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+	return prefix;
+}
+
 int git_config_perm(const char *var, const char *value)
 {
 	int i;
--=20
1.7.2.1.544.ga752d.dirty
