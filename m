From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 2/4] This exports the update() function from builtin-add.c as
Date: Thu, 27 Sep 2007 00:50:30 -0400
Message-ID: <1190868632-29287-2-git-send-email-krh@redhat.com>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 27 07:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IalcN-0004Kg-82
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbXI0FIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 01:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbXI0FIs
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:08:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbXI0FIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:08:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58jKg031468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2007 01:08:45 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58iO2001667;
	Thu, 27 Sep 2007 01:08:44 -0400
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58gMr002271;
	Thu, 27 Sep 2007 01:08:43 -0400
X-Mailer: git-send-email 1.5.3.2.1119.gab6f-dirty
In-Reply-To: <1190868632-29287-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59259>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-add.c |    8 ++++----
 commit.h      |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5e30380..966e145 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -107,7 +107,7 @@ static void update_callback(struct diff_queue_struc=
t *q,
 	}
 }
=20
-static void update(int verbose, const char *prefix, const char **files=
)
+void add_files_to_cache(int verbose, const char *prefix, const char **=
files)
 {
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
@@ -116,8 +116,6 @@ static void update(int verbose, const char *prefix,=
 const char **files)
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	rev.diffopt.format_callback_data =3D &verbose;
-	if (read_cache() < 0)
-		die("index file corrupt");
 	run_diff_files(&rev, 0);
 }
=20
@@ -218,7 +216,9 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 	if (take_worktree_changes) {
-		update(verbose, prefix, argv + i);
+		if (read_cache() < 0)
+			die("index file corrupt");
+		add_files_to_cache(verbose, prefix, argv + i);
 		goto finish;
 	}
=20
diff --git a/commit.h b/commit.h
index cc8d890..89caa12 100644
--- a/commit.h
+++ b/commit.h
@@ -130,6 +130,8 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 int in_merge_bases(struct commit *, struct commit **, int);
=20
 extern int interactive_add(void);
+extern void add_files_to_cache(int verbose,
+			       const char *prefix, const char **files);
 extern int rerere(void);
=20
 #endif /* COMMIT_H */
--=20
1.5.2.GIT
