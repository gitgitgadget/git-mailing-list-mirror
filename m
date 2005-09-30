From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] HTTP partial transfer support for object, pack, and index transfers
Date: Fri, 30 Sep 2005 16:27:47 -0700
Message-ID: <20050930232747.GB15593@reactrix.com>
References: <20050928171404.GA15593@reactrix.com> <7vk6gz6lpp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 01:29:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELUIP-0006eC-3S
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 01:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbVI3X2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 19:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbVI3X2A
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 19:28:00 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:10012 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030500AbVI3X17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 19:27:59 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8UNRmKU015541;
	Fri, 30 Sep 2005 16:27:48 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8UNRlZe015539;
	Fri, 30 Sep 2005 16:27:47 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6gz6lpp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9578>

On Fri, Sep 30, 2005 at 12:47:30AM -0700, Junio C Hamano wrote:

> I took a look at this patch.  It did not cleanly apply anymore,
> but I merged it anyway, and then took the liberty of updating it
> further, according to your response to my earlier comments.

Sorry about that - we're actually using git as a back end to a content
distribution system, so I'm still learning the finer points of using it
for source control...

> They will appear near the tip of the proposed updates branch.
> I'd appreciate it if you could check it out and see I did not
> break things by mistake.

I've included a patch that fixes one small problem; I've tested partial
transfers of packs and objects with this applied and it looks good.




Don't unlink the temp file when an object transfer fails, so next attempt
will pick up where the failed transfer left off

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

22226e509b916958a8b7aae76945c08d15ec686a
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -550,7 +550,6 @@ static int fetch_object(struct alt_base 
 	curl_result = curl_easy_perform(curl);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_range_header);
 	if (curl_result != 0) {
-		unlink(tmpfile);
 		return error("%s", curl_errorstr);
 	}
 
