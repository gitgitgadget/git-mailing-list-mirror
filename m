From: mhagger@alum.mit.edu
Subject: [PATCH v2 08/17] Pass nr_heads to everything_local() by reference
Date: Sat, 25 Aug 2012 08:44:18 +0200
Message-ID: <1345877067-11841-9-git-send-email-mhagger@alum.mit.edu>
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
	id 1T5A7Z-0002XY-C3
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab2HYGpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:19 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55065 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752666Ab2HYGpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:16 -0400
X-AuditID: 12074414-b7f846d0000008b8-e3-5038747cece7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id EC.16.02232.C7478305; Sat, 25 Aug 2012 02:45:16 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSj011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:15 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqFtTYhFgMKtJwKLrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGS+mfmQtmMVV0bP7AlsD4yqOLkZODgkBE4mHpw4zQdhiEhfurWcDsYUELjNKHJ7u28XI
	BWSfZZJ4ubKLESTBJiAl8bKxhx3EFhFQk5jYdogFpIhZoItRYvm6X0DdHBzCAl4SK9aZgZgs
	AqoSpw6YgpTzCrhIfL+wiRlil6LEj+9rwGxOAVeJCb8uskPsdZFoOnaFZQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIeEksoPxyEm5Q4wCHIxKPLw3zpgHCLEm
	lhVX5h5ilORgUhLlFSu0CBDiS8pPqcxILM6ILyrNSS0+xCjBwawkwvudASjHm5JYWZValA+T
	kuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBW1sM1ChYlJqeWpGWmVOCkGbi4AQRXCAb
	eIA2JIMU8hYXJOYWZ6ZDFJ1iVJQS5zUASQiAJDJK8+AGwCL/FaM40D/CvDOLgKp4gEkDrvsV
	0GAmoMHlruYgg0sSEVJSDYxd996X+Z9R8SidGOMgH9eqM+8j81Wu8t/69aHrDryozny3K+zC
	iZ+Bpol2rWs2es09onhhn9nbtEvu4m/bVCOUde88vXN8RoxcyUezSbl882RerS/bXm//Tibz
	8Rvma9vFVOukPIufir653tYoOeWl4DU3ucNq683bGXhShUTnrm319cuIvaXEUpyR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204252>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fae4f7c..a4bb0ff 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -595,7 +595,7 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 	mark_complete(NULL, ref->old_sha1, 0, NULL);
 }
 
-static int everything_local(struct ref **refs, int nr_heads, char **heads)
+static int everything_local(struct ref **refs, int *nr_heads, char **heads)
 {
 	struct ref *ref;
 	int retval;
@@ -646,7 +646,7 @@ static int everything_local(struct ref **refs, int nr_heads, char **heads)
 		}
 	}
 
-	filter_refs(refs, nr_heads, heads);
+	filter_refs(refs, *nr_heads, heads);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -818,7 +818,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (everything_local(&ref, *nr_heads, heads)) {
+	if (everything_local(&ref, nr_heads, heads)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-- 
1.7.11.3
