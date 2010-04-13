From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] builtin: introduce startup_info struct
Date: Mon, 12 Apr 2010 21:27:46 -0500
Message-ID: <20100413022746.GE4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vqz-00089n-32
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab0DMC1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:27:48 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:33176 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0DMC1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:27:47 -0400
Received: by pzk42 with SMTP id 42so4373814pzk.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Og4ikAZ+3luFLDr0jyOChD14JqBk+xGyfxUoHGpGs4M=;
        b=XlxfbZTJmQ2Vc0M+kftM9hpZnPgEcyx3UK49+0jXJJnqNUQl7Zjw8fLQHzR55v0ocS
         dxQXdah3FW57PHumpxD9NNZS1wfQwJKlqpdH+efveJ/huROmuKR0xg2ZjPBk86iQ59J9
         OQ+/6bHHXJbNfPOXK1ph0RkJSsuDiiYrUFAYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SL50Gbe93/iGahCiPBE9bJXGDLGseoVO5eBsvGbjoXWQNav5nRtvsYLKG7wM6UBH0V
         07EGWLifQor5Fls0IQSWIXve5l8dtKSpkPzPuFcJ7U2giWFetxm+/HV1N7cVBDodyQcl
         2N2CruECe87KQcpmblE9ySDFyBfSTBW0pQi9E=
Received: by 10.141.139.14 with SMTP id r14mr882525rvn.160.1271125666825;
        Mon, 12 Apr 2010 19:27:46 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 20sm4487985iwn.5.2010.04.12.19.27.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:27:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144784>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The startup_info struct will collect information managed by the git
setup code, such as the prefix for relative paths passed on the
command line (i.e., path to the starting cwd from the toplevel of
the work tree) and whether a git repository has been found.

In other words, startup_info is intended to be a collection of global
variables representing results that were previously returned from
setup functions.  Letting these values persist means there is more
flexibility in deciding when to run setup.

=46or now, the struct is empty.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Creation of struct split off from its population, mostly for
reviewability.  Feel free to merge this patch with the next one
if you prefer.

 cache.h       |    5 +++++
 environment.c |    1 +
 git.c         |    4 ++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 5eb0573..1479824 100644
--- a/cache.h
+++ b/cache.h
@@ -1058,6 +1058,11 @@ void overlay_tree_on_cache(const char *tree_name=
, const char *prefix);
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
=20
+/* git.c */
+struct startup_info {
+};
+extern struct startup_info *startup_info;
+
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
=20
diff --git a/environment.c b/environment.c
index 876c5e5..c36c902 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+struct startup_info *startup_info;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/git.c b/git.c
index 32720e5..b1d51c9 100644
--- a/git.c
+++ b/git.c
@@ -13,6 +13,7 @@ const char git_usage_string[] =3D
 const char git_more_info_string[] =3D
 	"See 'git help COMMAND' for more information on a specific command.";
=20
+static struct startup_info git_startup_info;
 static int use_pager =3D -1;
 struct pager_config {
 	const char *cmd;
@@ -477,6 +478,9 @@ int main(int argc, const char **argv)
 {
 	const char *cmd;
=20
+	memset(&git_startup_info, 0, sizeof(git_startup_info));
+	startup_info =3D &git_startup_info;
+
 	cmd =3D git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd =3D "git-help";
--=20
1.7.0.4
