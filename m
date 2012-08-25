From: mhagger@alum.mit.edu
Subject: [PATCH v2 07/17] Pass nr_heads to do_pack_ref() by reference
Date: Sat, 25 Aug 2012 08:44:17 +0200
Message-ID: <1345877067-11841-8-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7Y-0002XY-TD
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab2HYGpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:17 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:57026 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab2HYGpO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:14 -0400
X-AuditID: 12074413-b7f786d0000008bb-6e-5038747affee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 50.7A.02235.A7478305; Sat, 25 Aug 2012 02:45:14 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSi011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:12 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqFtVYhFg0LyR3aLrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGW/vzmMvuMBd8ePBefYGxgOcXYycHBICJhJbDx1mg7DFJC7cWw9mCwlcZpTofqrexcgF
	ZJ9lkpjydgoLSIJNQEriZWMPO4gtIqAmMbHtEAtIEbNAF6PE8nW/wLqFBVwlfk58DdbAIqAq
	sf38YVYQm1fARWLr634WiG2KEj++r2EGsTmB6if8usgOsdlFounYFZYJjLwLGBlWMcol5pTm
	6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoSElPAOxl0n5Q4xCnAwKvHw3jhjHiDEmlhW
	XJl7iFGSg0lJlFes0CJAiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvdwagHG9KYmVValE+TEqa
	g0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgre2GKhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4
	NS8ltSixtCQjHhQb8cXA6ABJ8QDtTQZp5y0uSMwFikK0nmLU5fh/8uRdRiGWvPy8VClxXgOQ
	IgGQoozSPLgVsATyilEc6GNh3plFQFU8wOQDN+kV0BImoCXlruYgS0oSEVJSDYw8NTUHr6su
	nHH4ifkHiz+e1oJ7uh03ce+XV/3x+3VW5wTGdezvn1ndcLgQd4BV91vRgglrqmW13EvOCG1u
	vHwn8PCFkunbT/jtmLp5r/39q08TNM5e89q97feEf4VFWXfu+Lh0Or3+vvQn38kt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204253>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is the first of a few baby steps towards changing filter_refs()
to compress matched refs out of the list rather than overwriting the
first character of such references with '\0'.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cf65998..fae4f7c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -777,7 +777,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 
 static struct ref *do_fetch_pack(int fd[2],
 		const struct ref *orig_ref,
-		int nr_heads, char **heads,
+		int *nr_heads, char **heads,
 		char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -818,7 +818,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (everything_local(&ref, nr_heads, heads)) {
+	if (everything_local(&ref, *nr_heads, heads)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1086,7 +1086,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy = do_fetch_pack(fd, ref, *nr_heads, heads, pack_lockfile);
+	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
 
 	if (args.depth > 0) {
 		struct cache_time mtime;
-- 
1.7.11.3
