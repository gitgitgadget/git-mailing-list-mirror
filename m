From: "Art Haas" <ahaas@airmail.net>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Tue, 19 Sep 2006 07:20:19 -0500
Message-ID: <20060919122019.GA14835@artsapartment.org>
References: <20060918225445.GF1261@artsapartment.org> <7v4pv4pyey.fsf@assigned-by-dhcp.cox.net> <20060918235753.GG1261@artsapartment.org> <Pine.LNX.4.63.0609191027020.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 19 14:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPeae-0000Pa-RD
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 14:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWISMUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 08:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWISMUZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 08:20:25 -0400
Received: from wmail-2.airmail.net ([209.196.70.85]:47558 "EHLO
	wmail-2.airmail.net") by vger.kernel.org with ESMTP
	id S1751952AbWISMUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 08:20:24 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by wmail-2.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1GPeaN-00068P-VE
	for git@vger.kernel.org; Tue, 19 Sep 2006 07:20:24 -0500
Received: (qmail 17446 invoked by uid 1000); 19 Sep 2006 12:20:19 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609191027020.19042@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27272>

On Tue, Sep 19, 2006 at 10:31:12AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 18 Sep 2006, Art Haas wrote:
> 
> > +#if LIBCURL_VERSION_NUM < 0x070f05
> > +#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
> > +#endif
> 
> If you go to 
> 
> http://cool.haxx.se/cvs.cgi/curl/include/curl/curl.h?annotate=1.308
> 
> and search for HTTP_RETURNED_ERROR, it shows that revision "badger_1.180" 
> introduced it, which you can verify by clicking on the link to the diff. 
> This diff also says that the LIBCURL_VERSION_NUM (which is changed just 
> after a release in the curl project) is 0x70a03. Thus, you should check 
> for 0x70a03 instead of 0x70f05.

Hi.

Here's a patch that checks for that version of libcurl.

Signed-off-by: Art Haas <ahaas@airmail.net>

diff --git a/http.h b/http.h
index 9ca16ac..6e12e41 100644
--- a/http.h
+++ b/http.h
@@ -22,6 +22,10 @@ #if LIBCURL_VERSION_NUM < 0x070c04
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
+#if LIBCURL_VERSION_NUM < 0x070a03
+#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
+#endif
+
 struct slot_results
 {
 	CURLcode curl_result;

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
