From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/18] struct nonmatching_ref_data: store a refname instead of a ref_entry
Date: Mon, 11 May 2015 17:25:09 +0200
Message-ID: <1431357920-25090-8-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:33:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrphU-0005xR-ER
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbbEKPc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:32:56 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62883 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839AbbEKPcz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:32:55 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2015 11:32:55 EDT
X-AuditID: 12074411-f79fa6d000006b8a-c8-5550c9f5c553
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 22.5A.27530.5F9C0555; Mon, 11 May 2015 11:25:41 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnJ002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:39 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPv1ZECoQeNFDouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8b9jZvZCn5zViw9dYu1gbGdo4uRk0NCwESi/ctRJghbTOLCvfVsXYxc
	HEIClxklJnXsYYRwjjNJrNp6lxGkik1AV2JRTzNYh4iAmsTEtkMsIEXMArsYJe4tncoCkhAW
	iJXo2LcEzGYRUJXYeqQDzOYVcJE4NPsgO8Q6OYnzx38yg9icAq4SS69eBqsRAqppenyPZQIj
	7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIWEmuINxxkm5Q4wCHIxK
	PLwGF/xDhVgTy4orcw8xSnIwKYny/tobECrEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFd5DVCO
	NyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTB23gCqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFB3xxcD4AEnxAO01Ogmyt7ggMRcoCtF6ilFRSpx3Ichc
	AZBERmke3FhY8njFKA70pTDvepAqHmDiget+BTSYCWiwYxzY4JJEhJRUA2PkHQNPjZDwxp9r
	jx82VWw9oLy45tiyOXe4Oyu8Hn5WOfV3+uuw+Dc2F/o2yQtxsz8Q6gz6+/YRh3bClGzRhsVF
	iRklroKzu44E7/yyKz/AKrSlli9H2EVfyOfjjDjROU4zdnAEH/7oa6635tOniTbG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268794>

Now that we don't need a ref_entry to pass to
report_refname_conflict(), it is sufficient to store the refname of
the conflicting reference.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 7422594..effd91a 100644
--- a/refs.c
+++ b/refs.c
@@ -843,7 +843,7 @@ static void prime_ref_dir(struct ref_dir *dir)
 
 struct nonmatching_ref_data {
 	const struct string_list *skip;
-	struct ref_entry *found;
+	const char *conflicting_refname;
 };
 
 static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
@@ -853,7 +853,7 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 	if (data->skip && string_list_has_string(data->skip, entry->name))
 		return 0;
 
-	data->found = entry;
+	data->conflicting_refname = entry->name;
 	return 1;
 }
 
@@ -963,7 +963,8 @@ static int is_refname_available(const char *refname,
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
 			return 1;
 
-		error("'%s' exists; cannot create '%s'", data.found->name, refname);
+		error("'%s' exists; cannot create '%s'",
+		      data.conflicting_refname, refname);
 		return 0;
 	}
 
-- 
2.1.4
