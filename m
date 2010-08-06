From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/12] git wrapper: introduce startup_info struct
Date: Thu, 5 Aug 2010 21:40:35 -0500
Message-ID: <20100806024034.GC22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 04:42:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhCsv-0007VS-DU
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 04:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935261Ab0HFCmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 22:42:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51157 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab0HFCmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 22:42:04 -0400
Received: by gyg10 with SMTP id 10so2707221gyg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 19:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6alu0GPfa01PLRPK8lxUh90cR1N1uC6J75DDGUPAykE=;
        b=xS31ai/JAGYBFwbbMIb2A5VIwKsJC7ZsXRbcXuwqM3B0A4TSbE7ogNLd8zpVkAaTOJ
         o0hTwrQDtLYpPVEImMlRp8imri2OcNe9keC/w0nzUulaVN1O7R/zxr/6O7m0W+e8Y/RF
         5oYD8j0ppsGDWCkmaj8balaAI1CTDTsYs0kjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bZLYbG4b6WdMax6ZucJbfAoLSpi8U8F+/+tnM/zVigFUNb2KvqqPAHMuR+WTvBNqWx
         IVXkrEn4m/Cu4kNwngFHX+nxQQADH1y5u1FWqp9jW69L0daKDL/yqX/YUs/EJX7oxhA2
         m2ngccdGB3pU5CdZJMV3HArnXTUnUBS1LtSKE=
Received: by 10.101.180.20 with SMTP id h20mr12844662anp.223.1281062522350;
        Thu, 05 Aug 2010 19:42:02 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c6sm1238504anj.31.2010.08.05.19.41.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 19:42:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152746>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The startup_info struct will collect information managed by the git
setup code, such as the prefix for relative paths passed on the
command line (i.e., path to the starting cwd from the toplevel of
the work tree) and whether a git repository has been found.

In other words, startup_info is intended to be a collection of global
variables with results that were previously returned from setup
functions.  This state is global anyway (since the cwd is), even
if it is not currently tracked that way.  Letting these values persist
means there is more flexibility in deciding when to run setup.

=46or now, the struct is empty.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes from last round:
 - commit message
 - remove unnecessary memset (since statics are already automatically
   zero-initialized)

 cache.h       |    5 +++++
 environment.c |    1 +
 git.c         |    3 +++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index c9fa3df..0822c3b 100644
--- a/cache.h
+++ b/cache.h
@@ -1097,6 +1097,11 @@ void overlay_tree_on_cache(const char *tree_name=
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
index 83d38d3..eeb2687 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+struct startup_info *startup_info;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/git.c b/git.c
index 99517dd..8a8d2b2 100644
--- a/git.c
+++ b/git.c
@@ -14,6 +14,7 @@ const char git_usage_string[] =3D
 const char git_more_info_string[] =3D
 	"See 'git help COMMAND' for more information on a specific command.";
=20
+static struct startup_info git_startup_info;
 static int use_pager =3D -1;
 struct pager_config {
 	const char *cmd;
@@ -489,6 +490,8 @@ int main(int argc, const char **argv)
 {
 	const char *cmd;
=20
+	startup_info =3D &git_startup_info;
+
 	cmd =3D git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd =3D "git-help";
--=20
1.7.2.1.544.ga752d.dirty
