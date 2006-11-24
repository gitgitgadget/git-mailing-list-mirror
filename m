X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 4/5] git-fetch: Reset shallow_depth before auto-following tags.
Date: Fri, 24 Nov 2006 15:59:12 +0100
Message-ID: <87odqwubzz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 14:59:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32221>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncWM-0008MT-B1 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 15:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934636AbWKXO7P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 09:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934637AbWKXO7P
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 09:59:15 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:65508 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S934636AbWKXO7P
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 09:59:15 -0500
Received: from adsl-84-226-49-216.adslplus.ch ([84.226.49.216]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GncWI-0005KP-4p for
 git@vger.kernel.org; Fri, 24 Nov 2006 08:59:14 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 3656910A155; Fri,
 24 Nov 2006 15:59:12 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Otherwise fetching the tags could also fetch commits up to the
specified depth, which isn't the expected behavior.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 git-fetch.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 0b1e6d1..f0645d9 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -461,6 +461,8 @@ case "$no_tags$tags" in
 	case "$taglist" in
 	'') ;;
 	?*)
+		# do not deepen a shallow tree when following tags
+		shallow_depth=
 		fetch_main "$taglist" ;;
 	esac
 esac
-- 
1.4.4.1.ga335e

-- 
Alexandre Julliard
