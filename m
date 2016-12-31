Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675652070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbcLaDNi (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:38 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56965 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754660AbcLaDNh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:37 -0500
X-AuditID: 12074414-773ff70000004a85-43-5867225fa1d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 43.67.19077.F5227685; Fri, 30 Dec 2016 22:13:35 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uE010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:34 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 20/23] try_remove_empty_parents(): don't trash argument contents
Date:   Sat, 31 Dec 2016 04:13:00 +0100
Message-Id: <6164af2d1f9eeb5bd339b3913e8046c1ea0b02be.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqBuvlB5h8G29pUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4MlZfMSm4y12x9NsM5gbGiZxdjJwcEgImEutnb2AFsYUELjNKLLsQ38XIBWQfZ5LYPn0G
        C0iCTUBXYlFPMxOILSKgJjGx7RALSBGzwERGiWlbLoElhAWCJSZ0f2IHsVkEVCX6Fh1hBLF5
        BaIkfnd8ZIPYJidxadsXZhCbU8BCYvGnPiaIzeYS63ZeYp7AyLOAkWEVo1xiTmmubm5iZk5x
        arJucXJiXl5qka6FXm5miV5qSukmRkjgiOxgPHJS7hCjAAejEg9vx7W0CCHWxLLiytxDjJIc
        TEqivJaWqRFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgXyqVHCPGmJFZWpRblw6SkOViUxHm/
        LVb3ExJITyxJzU5NLUgtgsnKcHAoSfAqKAI1ChalpqdWpGXmlCCkmTg4QYbzAA3vBanhLS5I
        zC3OTIfIn2JUlBLnXasAlBAASWSU5sH1wiL7FaM40CvCvKwg7TzApADX/QpoMBPQYLWcZJDB
        JYkIKakGxika8zamHfB+MPm+X+vEc//2CMfMFVI74DSPaU9I8Pry/9ErWOO53Hpz57vvWs1+
        f7P4zST/mRNig4/e7Cvznx8/aaZAQOJC9+yJ9+u38b7YJ3zsg7Hoi99Wy7/8OhS71OdbPtNC
        z+uVWYv4uo5G2Jr/cDl2NCH32LQ39wK2JfMZT/vFz5BsJqfEUpyRaKjFXFScCACKin88xwIA
        AA==
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
index 0275c8d..af5a0e2 100644
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

