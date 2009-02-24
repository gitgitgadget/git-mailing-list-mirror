From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Add --format that is a synonym to --pretty
Date: Tue, 24 Feb 2009 13:06:26 +0900
Message-ID: <20090224130626.6117@nanako3.lavabit.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
 <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
 <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 05:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbob2-0002So-Qv
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 05:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZBXEHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 23:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbZBXEHN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 23:07:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49033 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbZBXEHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 23:07:12 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 6F71211B90E;
	Mon, 23 Feb 2009 22:07:10 -0600 (CST)
Received: from 3759.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id QSKD8WOIJW7H; Mon, 23 Feb 2009 22:07:10 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=u3vGtfNvMmfImidwPBBulAew8lY3Y0K6ROv9tEQ3g/aASP7PreNCMIiyazGaX4z3ajW0ZpFBFZmFhE3iXIoPa631vY/Q0h0SctAPacLnK95p61SNHkqbxSI/JxJmf+KKTB0YGxgsPSIYh/0MOfnrX7foTKmf2Cixn9rvL+4Oe+A=;
  h=From:To:Cc:Date:Subject:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111205>

Some people prefer to call the pretty-print styles "format", and get
annoyed to see "git log --format=short" fail.  Introduce it as a synonym
to --pretty so that both can be used interchangeably without breaking
examples in existing web pages or ppeople's expectations.

Having to say --format="format:%h %s" is redundant because none of the
predefined pretty-print styles have per-cent sign in it, so this patch
also makes it possible to say --pretty="%h %s" (and --format="%h %s").

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

I think doing it this way won't risk any compatibility issue.
Please be gentle; this is my first real patch in the C language.

 Documentation/pretty-formats.txt |    9 +++++++++
 Documentation/pretty-options.txt |    1 +
 pretty.c                         |   20 ++++++++++++++------
 revision.c                       |    2 +-
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 159390c..5c6e678 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -152,3 +152,12 @@ $ git log -2 --pretty=tformat:%h 4da45bef \
 4da45be
 7134973
 ---------------------
++
+In addition, any unrecognized string that has a `%` in it is interpreted
+as if it has `tformat:` in front of it.  For example, these two are
+equivalent:
++
+---------------------
+$ git log -2 --pretty=tformat:%h 4da45bef
+$ git log -2 --pretty=%h 4da45bef
+---------------------
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 5f21efe..6596019 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,4 +1,5 @@
 --pretty[='<format>']::
+--format[='<format>']::
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
diff --git a/pretty.c b/pretty.c
index 6cd9149..d739f6d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,15 @@
 
 static char *user_format;
 
+static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
+{
+	free(user_format);
+	user_format = xstrdup(cp);
+	if (is_tformat)
+		rev->use_terminator = 1;
+	rev->commit_format = CMIT_FMT_USERFORMAT;
+}
+
 void get_commit_format(const char *arg, struct rev_info *rev)
 {
 	int i;
@@ -33,12 +42,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		return;
 	}
 	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:")) {
-		const char *cp = strchr(arg, ':') + 1;
-		free(user_format);
-		user_format = xstrdup(cp);
-		if (arg[0] == 't')
-			rev->use_terminator = 1;
-		rev->commit_format = CMIT_FMT_USERFORMAT;
+		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
 		return;
 	}
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
@@ -50,6 +54,10 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 			return;
 		}
 	}
+	if (strchr(arg, '%')) {
+		save_user_format(rev, arg, 1);
+		return;
+	}
 
 	die("invalid --pretty format: %s", arg);
 }
diff --git a/revision.c b/revision.c
index 286e416..556c319 100644
--- a/revision.c
+++ b/revision.c
@@ -1144,7 +1144,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+8, revs);
-	} else if (!prefixcmp(arg, "--pretty=")) {
+	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--graph")) {
-- 
1.6.2.rc1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
