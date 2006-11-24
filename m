X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 5/5] fetch-pack: Do not fetch tags for shallow clones.
Date: Fri, 24 Nov 2006 16:00:13 +0100
Message-ID: <87k61kubya.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 15:00:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32224>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncXO-0000AO-NY for gcvg-git@gmane.org; Fri, 24 Nov
 2006 16:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934639AbWKXPAT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 10:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934640AbWKXPAT
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 10:00:19 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:19173 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S934639AbWKXPAR
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 10:00:17 -0500
Received: from adsl-84-226-49-216.adslplus.ch ([84.226.49.216]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GncXG-0005NU-V8 for
 git@vger.kernel.org; Fri, 24 Nov 2006 09:00:16 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 11EF610A155; Fri,
 24 Nov 2006 16:00:13 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

A better fix may be to only fetch tags that point to commits that we
are downloading, but git-clone doesn't have support for following
tags. This will happen automatically on the next git-fetch though.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 fetch-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index bb310b6..80979b8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -342,7 +342,8 @@ static void filter_refs(struct ref **ref
 		if (!memcmp(ref->name, "refs/", 5) &&
 		    check_ref_format(ref->name + 5))
 			; /* trash */
-		else if (fetch_all) {
+		else if (fetch_all &&
+			 (!depth || strncmp(ref->name, "refs/tags/", 10) )) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
-- 
1.4.4.1.ga335e

-- 
Alexandre Julliard
