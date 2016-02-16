From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/20] rename_tmp_log(): improve error reporting
Date: Tue, 16 Feb 2016 14:22:19 +0100
Message-ID: <e4505a7bde58518dfe968e7e3dc0dadcb7a6ba6b.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhj-0002oV-1I
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbcBPNaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:06 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52077 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932318AbcBPN36 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:29:58 -0500
X-AuditID: 12074412-b07ff70000006da4-49-56c322af94f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 77.4D.28068.FA223C65; Tue, 16 Feb 2016 08:22:55 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOS028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:54 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLte6XCYwYop1hbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8alp1fYC65wVPR+DGlg/M/WxcjJISFgInG68yx7
	FyMXh5DAVkaJW1/WsUI4J5gklq77yAxSxSagK7Gop5kJxBYRUJOY2HaIBaSIWeARo0TX/u2M
	IAlhAQeJ5//+soDYLAKqEltnzABr5hWIkljX+48JYp2cRMuP3awgNqeAhcTJll6weiEBc4k7
	X/YwTWDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJMSEdjCuPyl3
	iFGAg1GJh3eD66EwIdbEsuLK3EOMkhxMSqK8PNyHw4T4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8P57BVTOm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTB26EINFSwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFAPxxcAoAEnxAO1NA2nnLS5IzAWKQrSeYlSU
	Eud1AUkIgCQySvPgxsISxytGcaAvhXm7Qap4gEkHrvsV0GAmoME5l0AeKi5JREhJNTDyMn2Q
	2eN87imj7tPccCFPidR1X7paSl9Vaivn7P4xM7f+7q9lAp/9l/22KWJ4uCOtqybktp3tpfi9
	Fb4snsfdPrpEs+jvdvxkJf3bUfYE/6QFEvVy2jvapJeIl177+H15xybLPwunF7s8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286371>

* Don't capitalize error strings
* Report true paths of affected files

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Maybe these error strings should be internationalized? If so, there
are a bunch of similar error strings in related functions that should
be changed at the same time.

 refs/files-backend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e5f964c..4266da9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2430,10 +2430,11 @@ static int rename_tmp_log(const char *newrefname)
 	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
 	if (ret) {
 		if (true_errno==EISDIR)
-			error("Directory not empty: %s", path);
+			error("directory not empty: %s", path);
 		else
-			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(true_errno));
+			error("unable to move logfile %s to %s: %s",
+			      git_path(TMP_RENAMED_LOG), path,
+			      strerror(true_errno));
 	}
 
 	free(path);
-- 
2.7.0
