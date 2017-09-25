Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E3720281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933832AbdIYIAd (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:33 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58069 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933809AbdIYIAc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:32 -0400
X-AuditID: 12074411-f95ff70000007f0a-d0-59c8b79fa7c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.12.32522.F97B8C95; Mon, 25 Sep 2017 04:00:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6M027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:29 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/21] prefix_ref_iterator: break when we leave the prefix
Date:   Mon, 25 Sep 2017 09:59:59 +0200
Message-Id: <ff88edea0574e10597d86e3fd2e6390994dad277.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqDt/+4lIg4OnxS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZSx64V/QL1Rx6f5e5gbGlXxdjJwc
        EgImEsvurmDpYuTiEBLYwSSx72QLO0hCSOAUk8S6C1wgNpuArsSinmYmEFtEQE1iYtshsAZm
        gZXMEpO2XmEFSQgL+EqcXrqRGcRmEVCVONT0E6yBVyBK4uLmQ+wQ2+Qlzj24DVbDKWAh8ebM
        ETaIZeYS52/cYp3AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkjA
        Ce5gnHFS7hCjAAejEg9vxL/jkUKsiWXFlbmHGCU5mJREee/ynYgU4kvKT6nMSCzOiC8qzUkt
        PsQowcGsJMJ7bDVQjjclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwdu5
        DahRsCg1PbUiLTOnBCHNxMEJMpwHaPhykBre4oLE3OLMdIj8KUZdjo6bd/8wCbHk5eelSonz
        bgApEgApyijNg5sDSxSvGMWB3hLmTQOp4gEmGbhJr4CWMAEt6Z0KtqQkESEl1cBYKf1O7PSu
        3uCTjcX9s34XlrwK2zuF4ePUHXdjUu+cuj7PVJa95Mu1G0XnFsxR2MD4V0fr+mtV6Yc6KdpP
        Fluzp6n4Bl1YulK/7mBU+tsXVQVtrldvnfS+vCJuBkd76Zpp+xR2HfsREdl066njnP+Wpnys
        b5/rf3w7++6RFQszJz+aKmXhe3afoBJLcUaioRZzUXEiANjOQJnvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

If the underlying iterator is ordered, then `prefix_ref_iterator` can
stop as soon as it sees a refname that comes after the prefix. This
will rarely make a big difference now, because `ref_cache_iterator`
only iterates over the directory containing the prefix (and usually
the prefix will span a whole directory anyway). But if *hint, hint* a
future reference backend doesn't itself know where to stop the
iteration, then this optimization will be a big win.

Note that there is no guarantee that the underlying iterator doesn't
include output preceding the prefix, so we have to skip over any
unwanted references before we get to the ones that we want.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/iterator.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index c475360f0a..bd35da4e62 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -287,6 +287,20 @@ struct prefix_ref_iterator {
 	int trim;
 };
 
+/* Return -1, 0, 1 if refname is before, inside, or after the prefix. */
+static int compare_prefix(const char *refname, const char *prefix)
+{
+	while (*prefix) {
+		if (*refname != *prefix)
+			return ((unsigned char)*refname < (unsigned char)*prefix) ? -1 : +1;
+
+		refname++;
+		prefix++;
+	}
+
+	return 0;
+}
+
 static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	struct prefix_ref_iterator *iter =
@@ -294,9 +308,25 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
-		if (!starts_with(iter->iter0->refname, iter->prefix))
+		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
+
+		if (cmp < 0)
 			continue;
 
+		if (cmp > 0) {
+			/*
+			 * If the source iterator is ordered, then we
+			 * can stop the iteration as soon as we see a
+			 * refname that comes after the prefix:
+			 */
+			if (iter->iter0->ordered) {
+				ok = ref_iterator_abort(iter->iter0);
+				break;
+			} else {
+				continue;
+			}
+		}
+
 		if (iter->trim) {
 			/*
 			 * It is nonsense to trim off characters that
-- 
2.14.1

