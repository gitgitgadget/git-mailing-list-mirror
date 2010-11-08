From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] add description parameter to OPT__QUIET
Date: Mon, 8 Nov 2010 13:54:48 -0600
Message-ID: <20101108195448.GA12660@burratino>
References: <4CD83917.3040801@lsrfire.ath.cx>
 <4CD83ABD.30804@lsrfire.ath.cx>
 <20101108181801.GB30428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXoB-0001lL-37
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0KHTzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:55:07 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48780 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0KHTzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:55:06 -0500
Received: by eye27 with SMTP id 27so3055861eye.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kHY/GMdk2ou0gDXUWMRvGafCIGA/wXV64nqRDDe4fO0=;
        b=hyjRS76yxe6MhSkIXbW+YXhUbc1ZijGmiaOaDAyquqOieQV0ifmMpf/QuKmKM6WK6+
         81yXksgG50qgrEZ3pdcVzOmk6Juq1Al7InculhWIN8Pek1uQgV5OqvjaDPzyPgI5m+rL
         9q5pxes/Q9JraGvgWdQKGyAyfas1Bggae/Wkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tBQVzUQW190oXe4013dT9SaCcdKjWrTWeIwVA4V05hEDgH2wYASYqNdVdqbJq+JLDx
         T2ZU47bjXIVHYg0Obx6LbuZwnUNJynWPAbI+ezbDOS9JHgiaGGrcXYmSf4QggZquyR7B
         l7tuPZBbveuUeVvjFQRi2SXwFt0rRT/h63wpE=
Received: by 10.14.45.76 with SMTP id o52mr3722008eeb.43.1289246104697;
        Mon, 08 Nov 2010 11:55:04 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q58sm245547eeh.3.2010.11.08.11.55.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 11:55:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101108181801.GB30428@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160977>

Jeff King wrote:

> Maybe my "don't repeat yourself" spider sense is over-reacting, but of
> 12 callsites, 11 of them will continue to use "be quiet".

Maybe something like this would help alleviate the smell.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout-index.c |    3 ++-
 builtin/checkout.c       |    2 +-
 builtin/clean.c          |    2 +-
 builtin/commit.c         |    4 ++--
 builtin/gc.c             |    2 +-
 builtin/merge-file.c     |    2 +-
 builtin/reset.c          |    2 +-
 builtin/rm.c             |    2 +-
 builtin/show-ref.c       |    3 ++-
 builtin/symbolic-ref.c   |    3 ++-
 10 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 91fb9bf..1ee3044 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -218,7 +218,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('a', "all", &all,
 			"checks out all files in the index"),
 		OPT__FORCE(&force, "forces overwrite of existing files"),
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__QUIET(&quiet,
+			"no warning for existing files and files not in index"),
 		OPT_BOOLEAN('n', "no-create", &not_new,
 			"don't checkout new files"),
 		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ab935fd..07530d7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -686,7 +686,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet, "be quiet"),
+		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
 			   "create and checkout a new branch"),
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
diff --git a/builtin/clean.c b/builtin/clean.c
index 9146bf3..5e47c53 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -48,7 +48,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__QUIET(&quiet, "do not print names of files removed"),
 		OPT__DRY_RUN(&show_only, "dry run"),
 		OPT__FORCE(&force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
diff --git a/builtin/commit.c b/builtin/commit.c
index 97ae1bc..4fd1a16 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -114,8 +114,8 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 }
 
 static struct option builtin_commit_options[] = {
-	OPT__QUIET(&quiet, "be quiet"),
-	OPT__VERBOSE(&verbose, "be verbose"),
+	OPT__QUIET(&quiet, "suppress summary after successful commit"),
+	OPT__VERBOSE(&verbose, "show diff in commit message template"),
 
 	OPT_GROUP("Commit message options"),
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
diff --git a/builtin/gc.c b/builtin/gc.c
index 8f67325..397a1e6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -180,7 +180,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	char buf[80];
 
 	struct option builtin_gc_options[] = {
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__QUIET(&quiet, "suppress progress reporting"),
 		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
 			"prune unreferenced objects",
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 58e4731..9d75ed4 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -39,7 +39,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_UNION),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
 			    "for conflicts, use this marker size"),
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__QUIET(&quiet, "do not warn about conflicts"),
 		OPT_CALLBACK('L', NULL, names, "name",
 			     "set labels for file1/orig_file/file2", &label_cb),
 		OPT_END(),
diff --git a/builtin/reset.c b/builtin/reset.c
index d624207..5de2bce 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -243,7 +243,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	char *reflog_action, msg[1024];
 	const struct option options[] = {
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__QUIET(&quiet, "be quiet, only report errors"),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						"reset HEAD and index", MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
diff --git a/builtin/rm.c b/builtin/rm.c
index 9a59905..c7b7bb3 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -140,7 +140,7 @@ static int ignore_unmatch = 0;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, "dry run"),
-	OPT__QUIET(&quiet, "be quiet"),
+	OPT__QUIET(&quiet, "do not list removed files"),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, "only remove from the index"),
 	OPT__FORCE(&force, "override the up-to-date check"),
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6507f03..45f0340 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -193,7 +193,8 @@ static const struct option show_ref_options[] = {
 	  "only show SHA1 hash using <n> digits",
 	  PARSE_OPT_OPTARG, &hash_callback },
 	OPT__ABBREV(&abbrev),
-	OPT__QUIET(&quiet, "be quiet"),
+	OPT__QUIET(&quiet,
+		   "do not print results to stdout (useful with --verify)"),
 	{ OPTION_CALLBACK, 0, "exclude-existing", &exclude_existing_arg,
 	  "pattern", "show refs from stdin that aren't in local repository",
 	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback },
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 1b28425..dea849c 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -30,7 +30,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	const char *msg = NULL;
 	struct option options[] = {
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__QUIET(&quiet,
+			"suppress error message for non-symbolic (detached) refs"),
 		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
 		OPT_END(),
 	};
-- 
1.7.2.3.557.gab647.dirty
