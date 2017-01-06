Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7351FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967505AbdAFQXx (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:53 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48260 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967432AbdAFQXb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:31 -0500
X-AuditID: 12074414-78bff70000004a85-ee-586fc4807bbb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 37.EF.19077.084CF685; Fri,  6 Jan 2017 11:23:28 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmXB023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:27 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 21/23] try_remove_empty_parents(): don't trash argument contents
Date:   Fri,  6 Jan 2017 17:22:41 +0100
Message-Id: <0bbc4f8f99c5915037e0f743c2f442988b91c7bd.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqNtwJD/CYMJWA4uuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKaD3wla3gLnfF9jez2RsYJ3J2MXJySAiYSPw+coi1
        i5GLQ0jgMqPEg8vroJwTTBLtk7Yxg1SxCehKLOppZgKxRQTUJCa2HWIBKWIW+MAo8atzFjtI
        QlggWOLqkZtgRSwCqhJ/rl4Fs3kFoiQW9e5mhFgnJ3Fp2xewoZwCFhKNu76BxYUEzCU+TTzM
        PIGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkBAT2cF45KTcIUYB
        DkYlHt4Ir7wIIdbEsuLK3EOMkhxMSqK8YY75EUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeO0O
        AeV4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4Gw8DNQoWpaanVqRl
        5pQgpJk4OEGG8wAN7wCp4S0uSMwtzkyHyJ9iVJQS590CslUAJJFRmgfXC0sBrxjFgV4R5u0B
        aecBpg+47ldAg5mABgt6gg0uSURISTUwtllXsEoZs+6SLC6OOb3rwDx7yY8MWYJbD4opiHx+
        uHLnUb5tbttXzhPwNDXleMPA+3+37rMcRR2XVJNuLtkduy5nmN7YPkH1osqpj7+efT316pi9
        R+XbrheyHya9dHhUqel1rbLmgVrdvR2XpDsPSW1f6sh2qf9IbvvrX+9rllnafO5IfjmhWoml
        OCPRUIu5qDgRAGeh4QPcAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's bad manners and surprising and therefore error-prone.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 92a9d99..88f8c7a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2282,13 +2282,15 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *refname)
+static void try_remove_empty_parents(const char *refname)
 {
+	struct strbuf buf = STRBUF_INIT;
 	char *p, *q;
 	int i;
-	p = refname;
+
+	strbuf_addstr(&buf, refname);
+	p = buf.buf;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2296,8 +2298,7 @@ static void try_remove_empty_parents(char *refname)
 		while (*p == '/')
 			p++;
 	}
-	for (q = p; *q; q++)
-		;
+	q = buf.buf + buf.len;
 	while (1) {
 		while (q > p && *q != '/')
 			q--;
@@ -2305,10 +2306,11 @@ static void try_remove_empty_parents(char *refname)
 			q--;
 		if (q == p)
 			break;
-		*q = '\0';
-		if (rmdir(git_path("%s", refname)))
+		strbuf_setlen(&buf, q - buf.buf);
+		if (rmdir(git_path("%s", buf.buf)))
 			break;
 	}
+	strbuf_release(&buf);
 }
 
 /* make sure nobody touched the ref, and unlink */
-- 
2.9.3

