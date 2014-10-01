From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 25/38] try_merge_strategy(): remove redundant lock_file allocation
Date: Wed,  1 Oct 2014 12:28:29 +0200
Message-ID: <1412159322-2622-26-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHB7-00038s-0G
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbaJAKa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:30:26 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53417 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751705AbaJAK3c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:32 -0400
X-AuditID: 12074411-f79d86d000006a97-21-542bd78c708c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 72.AE.27287.C87DB245; Wed,  1 Oct 2014 06:29:32 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6O026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:31 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1O25rh1isGeevEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bkr3l5gLDjHXtFw6D5rA+MMti5G
	Tg4JAROJnm2vmCBsMYkL99YDxbk4hAQuM0r07O9jh3COM0l8n/maHaSKTUBXYlFPM1iHiICa
	xMS2QywgRcwCi5kkJhzaBDZWWCBU4viFDlYQm0VAVeLUrr2MIDavgIvE1KVXmSHWyUls2P0f
	LM4JFF9+uZkFxBYScJbYcecr0wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL
	9FJTSjcxQsJRcAfjjJNyhxgFOBiVeHgVErRDhFgTy4orcw8xSnIwKYnyLroEFOJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTCm30AKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV
	4eBQkuBluAbUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjvhiYHyApHiA9jqD
	tPMWFyTmAkUhWk8xGnO0NL3tZeJY1/mtn0mIJS8/L1VKnDcTpFQApDSjNA9uESwRvWIUB/pb
	mDccpIoHmMTg5r0CWsUEtCp5DdiqkkSElFQDY/vCnDUVhydZ3tlbEynOH3Xuxu4kg37J6OeJ
	ZolnzuUfeSe540GNWszcb9ayzUFqi69KK720v64bonFSzv9XMpOZQMrjXgNg2Ey1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257726>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block shadowed the "lock"
variable at function scope, so the only change needed is to remove the
inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dff043d..1ec3939 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -668,7 +668,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
 		struct commit_list *j;
-- 
2.1.0
