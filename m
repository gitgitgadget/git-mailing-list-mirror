From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/8] rename_ref(): inline calls to write_ref_sha1() from this function
Date: Sun, 10 May 2015 04:45:34 +0200
Message-ID: <1431225937-10456-6-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 04:46:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHFu-0001a1-R1
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 04:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbEJCp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 22:45:59 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50554 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752112AbbEJCp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 22:45:57 -0400
X-AuditID: 1207440c-f79376d00000680a-89-554ec6643c6d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.26.26634.466CE455; Sat,  9 May 2015 22:45:56 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxd015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:55 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqJtyzC/U4MJqU4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8bu+7tZC/7zVDRu+sXewHiOq4uRk0NCwESi8fxtdghbTOLCvfVsILaQ
	wGVGie9HdLoYOYDs40wSCxlBwmwCuhKLepqZQMIiAl4SbTOLuxi5OJgFehklHi1+BVYjLBAp
	sfjMdiYQm0VAVeL6pDksIPW8Ai4SM1d4QWySkzh//CcziM0p4Cpx+8xcZoitLhKNS5tYJjDy
	LmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokRElw8Oxi/rZM5xCjAwajE
	wztji1+oEGtiWXFl7iFGSQ4mJVFem4VAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8J9cD5XhT
	EiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwXjgA1ChalpqdWpGXmlCCk
	mTg4QYZzSYkUp+alpBYllpZkxINiIr4YGBUgKR6gvTZHQfYWFyTmAkUhWk8xKkqJ83qBJARA
	EhmleXBjYSnjFaM40JfCvIEgVTzAdAPX/QpoMBPQ4L/FPiCDSxIRUlINjFUC7fxNrPf3me9y
	Cgy5nqzfOcnVQTf2QY3X9funbXzNp659z+lbt+XCzW+Pne9sq4l/P801p/GAyuZHfBlnyrt5
	J22eVJ77O7LAlHXbdKf/YSsNZvZlZe077vHBd2pXbaTpivhN7plrlRg2T9fYeeWo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268719>

Most of what it does is unneeded from these call sites.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7661db9..18ce8e6 100644
--- a/refs.c
+++ b/refs.c
@@ -2799,8 +2799,9 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	return ret;
 }
 
-static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
-			  const char *logmsg);
+static int write_ref_to_lockfile(struct ref_lock *lock, const unsigned char *sha1);
+static int commit_ref_update(struct ref_lock *lock,
+			     const unsigned char *sha1, const char *logmsg);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -2859,7 +2860,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	}
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+
+	if (write_ref_to_lockfile(lock, orig_sha1) ||
+	    commit_ref_update(lock, orig_sha1, logmsg)) {
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
@@ -2876,7 +2879,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
+	if (write_ref_to_lockfile(lock, orig_sha1) ||
+	    commit_ref_update(lock, orig_sha1, NULL))
 		error("unable to write current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
 
-- 
2.1.4
