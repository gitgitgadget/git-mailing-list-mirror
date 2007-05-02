From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] http-fetch: Disable use of curl multi support for libcurl < 7.16.
Date: Wed, 02 May 2007 14:53:23 +0200
Message-ID: <87slafs7y4.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 14:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjELC-0002qO-2D
	for gcvg-git@gmane.org; Wed, 02 May 2007 14:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993114AbXEBMxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 08:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993124AbXEBMxo
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 08:53:44 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:55913 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993114AbXEBMxd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 08:53:33 -0400
Received: from adsl-84-227-166-186.adslplus.ch ([84.227.166.186] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HjEKq-0000pn-4A
	for git@vger.kernel.org; Wed, 02 May 2007 07:53:32 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 43F574F68D; Wed,  2 May 2007 14:53:23 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46018>

curl_multi_remove_handle() is broken in libcurl < 7.16, in that it
doesn't correctly update the active handles count when a request is
aborted. This causes the transfer to hang forever waiting for the
handle count to become less than the number of active requests.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 http.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http.h b/http.h
index 324fcf4..69b6b66 100644
--- a/http.h
+++ b/http.h
@@ -6,7 +6,7 @@
 #include <curl/curl.h>
 #include <curl/easy.h>
 
-#if LIBCURL_VERSION_NUM >= 0x070908
+#if LIBCURL_VERSION_NUM >= 0x071000
 #define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
 #endif
-- 
1.5.2.rc1.4.g8c87-dirty

-- 
Alexandre Julliard
julliard@winehq.org
