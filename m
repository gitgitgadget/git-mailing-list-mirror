From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/18] is_refname_available(): avoid shadowing "dir" variable
Date: Mon, 11 May 2015 17:25:05 +0200
Message-ID: <1431357920-25090-4-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpai-0002aa-7G
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbbEKPZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:48 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60027 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963AbbEKPZo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:44 -0400
X-AuditID: 1207440c-f79376d00000680a-6e-5550c9ed17f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.EE.26634.DE9C0555; Mon, 11 May 2015 11:25:33 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnF002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:31 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqPv2ZECowefZOhZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7oy/n+cxFuxgr/j38g5jA+NP1i5GTg4JAROJi5cOMEPYYhIX7q1n62Lk
	4hASuMwo8e7qNUYI5ziTxNz7e1hAqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQvsYpS4t3QqWJGw
	QIBE8+/F7CA2i4CqxI2jD8HivAIuEg9uzGKEWCcncf74T7DVnAKuEkuvXgarEQKqaXp8j2UC
	I+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCFhxrOD8ds6mUOMAhyM
	Sjy8HZf8Q4VYE8uKK3MPMUpyMCmJ8v7aGxAqxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXeQ1Q
	jjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUIJivDwaEkwdt4AqhRsCg1PbUiLTOn
	BCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQd8cXA+ABJ8QDtrQJp5y0uSMwFikK0nmLU5bgz5f8i
	JiGWvPy8VClx3nsgRQIgRRmleXArYEnlFaM40MfCvOtBqniACQlu0iugJUxASxzjwJaUJCKk
	pBoYmwK4PRfYPatJNPcztFnO+uHV/xTrXTfite+J/7qZfrRwmbZj+xPduWukf3+z6ZomElgY
	7f/a58HUT/t6So3ntfQrPfpy0NvEPls1OtA522SP027m1MuH1u9ONWa8/U30iPqh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268782>

The function had a "dir" parameter that was shadowed by a local "dir"
variable within a code block. Use the former in place of the latter.
(This is consistent with "dir"'s use elsewhere in the function.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 776bbce..9d87e84 100644
--- a/refs.c
+++ b/refs.c
@@ -967,10 +967,10 @@ static int is_refname_available(const char *refname,
 		 * "refs/foo/bar/"). It is a problem iff it contains
 		 * any ref that is not in "skip".
 		 */
-		struct ref_entry *entry = dir->entries[pos];
-		struct ref_dir *dir = get_ref_dir(entry);
 		struct nonmatching_ref_data data;
+		struct ref_entry *entry = dir->entries[pos];
 
+		dir = get_ref_dir(entry);
 		data.skip = skip;
 		sort_ref_dir(dir);
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
-- 
2.1.4
