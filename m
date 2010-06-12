From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] grep -O: allow optional argument specifying the pager
 (or editor)
Date: Sat, 12 Jun 2010 11:39:46 -0500
Message-ID: <20100612163946.GD5657@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:40:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTkU-0008Ma-Af
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab0FLQjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 12:39:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56715 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0FLQjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:39:52 -0400
Received: by iwn9 with SMTP id 9so1596254iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fIvpANgLSqOx1yLEAcfSSDvFXs92FscFQ9a5mFKIqBI=;
        b=kDWx5soFt737K2ZmcMC0qg4du0aVj/IkIQseXFXARgwKQIYP747dT5zxYIwAcmyXDJ
         PNzSLtkF3BH6HYxDsILV1ScYwit/d8nJztV1LGnUGY0RVvGU1LoyLlfV1+ouIVutveiw
         dxXScM6Qw8ieHl5S3SR1cqyXT0miru+0YzaVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uzaKXCjF1Ab5ZBCJYJqtdGA5XlLE+UGZsj9/cGJtCCyQ+VvHxS25+jshVc+5nZ0WCT
         sWAGTLbUCk7IhPqsqgt6pufL7ySPHklmP+OfYQ7Y+IEMgseUOGnojPffESRWz5Gd77Wf
         gy2fUB9+7sifmaLGabkEJw8nqel104A9eDG6c=
Received: by 10.231.188.150 with SMTP id da22mr3358491ibb.191.1276360791761;
        Sat, 12 Jun 2010 09:39:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm11145917ibg.3.2010.06.12.09.39.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 09:39:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100612162945.GB1406@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149020>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Suppose you want to edit all files that contain a specific search term.
Of course, you can do something totally trivial such as

	git grep -z -e <term> | xargs -0r vi +/<term>

but maybe you are happy that the same will be achieved by

	git grep -Ovi <term>

now.

[jn: rebased and added tests]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.  Thanks for reading.

 Documentation/git-grep.txt |    6 +++---
 builtin/grep.c             |   26 ++++++++++++--------------
 t/t7811-grep-open.sh       |    9 ++++++---
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8fdd8e1..d89ec32 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
-	   [-O | --open-files-in-pager]
+	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -105,8 +105,8 @@ OPTIONS
 	For better compatibility with 'git diff', `--name-only` is a
 	synonym for `--files-with-matches`.
 
--O::
---open-files-in-pager::
+-O [<pager>]::
+--open-files-in-pager [<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
diff --git a/builtin/grep.c b/builtin/grep.c
index 1e8b946..f32fbbc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -828,7 +828,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int cached = 0;
 	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
-	int show_in_pager = 0;
+	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
@@ -916,8 +916,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('O', "open-files-in-pager", &show_in_pager,
-			"show matching files in the pager"),
+		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
+			"pager", "show matching files in the pager",
+			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
@@ -993,18 +994,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
+	if (show_in_pager == default_pager)
+		show_in_pager = git_pager(1);
 	if (show_in_pager) {
-		const char *pager = git_pager(1);
-		if (!pager) {
-			show_in_pager = 0;
-		} else {
-			opt.name_only = 1;
-			opt.null_following_name = 1;
-			opt.output_priv = &path_list;
-			opt.output = append_path;
-			string_list_append(pager, &path_list);
-			use_threads = 0;
-		}
+		opt.name_only = 1;
+		opt.null_following_name = 1;
+		opt.output_priv = &path_list;
+		opt.output = append_path;
+		string_list_append(show_in_pager, &path_list);
+		use_threads = 0;
 	}
 
 	if (!opt.pattern_list)
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index fcfc56e..8db4fc8 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -99,7 +99,11 @@ test_expect_success 'git grep -O jumps to line in less' '
 
 	GIT_PAGER=./less git grep -O GREP_PATTERN >out &&
 	test_cmp expect actual &&
-	test_cmp empty out
+	test_cmp empty out &&
+
+	git grep -O./less GREP_PATTERN >out2 &&
+	test_cmp expect actual &&
+	test_cmp empty out2
 '
 
 test_expect_success 'modified file' '
@@ -135,8 +139,7 @@ test_expect_success 'run from subdir' '
 		export GIT_PAGER &&
 		GIT_PAGER='\''printf "%s\n" >../args'\'' &&
 		git grep -O "enum grep_pat_token" >../out &&
-		GIT_PAGER="pwd >../dir; :" &&
-		git grep -O "enum grep_pat_token" >../out2
+		git grep -O"pwd >../dir; :" "enum grep_pat_token" >../out2
 	) &&
 	case $(cat dir) in
 	*subdir)
-- 
1.7.1
