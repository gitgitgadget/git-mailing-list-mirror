From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/20] log_ref_write_1(): don't depend on logfile
Date: Tue, 16 Feb 2016 14:22:23 +0100
Message-ID: <ba9f9dcc30292fde79f3d6d258bc2287e8cbccc1.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiJ-0003Ac-QU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbcBPNaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:35 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64171 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351AbcBPNab (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:31 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:30:30 EST
X-AuditID: 1207440d-6a3ff7000000068f-27-56c322b68991
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 97.B2.01679.6B223C65; Tue, 16 Feb 2016 08:23:02 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOW028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:01 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLtN6XCYwaMrmhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bCxU1sBW85Kxouz2BrYPzK3sXIySEhYCJxfO4x
	pi5GLg4hga2MEgcn7GCEcE4wSTycuocRpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAI0aJrv3b
	wYqEBRwlDvx4DDaWRUBVomvhbjYQm1cgSmLunXVQ6+QkWn7sZgWxOQUsJE629LKA2EIC5hJ3
	vuxhmsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSJDx7mD8v07m
	EKMAB6MSDy+Hx6EwIdbEsuLK3EOMkhxMSqK8PNyHw4T4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8P57BVTOm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg7VAEGipYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioL4YmAcgKR4gPamgbTzFhck5gJFIVpPMSpK
	ifO6gCQEQBIZpXlwY2Gp4xWjONCXwrzHQap4gGkHrvsV0GAmoME5l0AeKi5JREhJNTDq/lp6
	W3Bb6bat/td8jJy/3hdhnfVPZEJj6HTl0PWPNepTDMqm1k4U2MYWMenlD4N7s9i1og7s9Np3
	95HgIXF9k3eyil4/t9t9Slix3WmPQKjyXpUnjLMmTnEo9vwTsT68+aX65wePTt75 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286380>

It's unnecessary to pass a strbuf holding the reflog path up and down
the call stack now that it is hardly needed by the callers. Remove the
places where log_ref_write_1() uses it, in preparation for making it
internal to log_ref_setup().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 78a6213..dcd19ee 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2705,14 +2705,14 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
-			    strerror(errno));
+		strbuf_addf(err, "unable to append to %s: %s",
+			    git_path("logs/%s", refname), strerror(errno));
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
-			    strerror(errno));
+		strbuf_addf(err, "unable to append to %s: %s",
+			    git_path("logs/%s", refname), strerror(errno));
 		return -1;
 	}
 	return 0;
-- 
2.7.0
