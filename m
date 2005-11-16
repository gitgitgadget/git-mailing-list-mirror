From: Junio C Hamano <junkio@cox.net>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 11:15:59 -0800
Message-ID: <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net>
References: <437B6997.8010903@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 20:18:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcSlL-0003WK-Hu
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVKPTQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 14:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbVKPTQE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:16:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45698 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751501AbVKPTQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 14:16:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116191450.JILC17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 14:14:50 -0500
To: Andrew Wozniak <awozniak@mc.com>
In-Reply-To: <437B6997.8010903@mc.com> (Andrew Wozniak's message of "Wed, 16
	Nov 2005 12:17:11 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12043>

Andrew Wozniak <awozniak@mc.com> writes:

> Have just started using git for u-boot related development. After 
> downloading git-snapshot-20051116 tarball and attempting a build under 
> RH7.2, I get the following failure:

Would this help?

-- >8 --

diff --git a/http-fetch.c b/http-fetch.c
index 21cc1b9..45e97f9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -902,16 +902,18 @@ static void fetch_alternates(char *base)
 	char *data;
 	struct active_request_slot *slot;
 	static struct alt_request alt_req;
-	int num_transfers;
 
+#ifdef USE_CURL_MULTI
 	/* If another request has already started fetching alternates,
 	   wait for them to arrive and return to processing this request's
 	   curl message */
 	while (got_alternates == 0) {
+		int num_transfers;
 		curl_multi_perform(curlm, &num_transfers);
 		process_curl_messages();
 		process_request_queue();
 	}
+#endif
 
 	/* Nothing to do if they've already been fetched */
 	if (got_alternates == 1)
