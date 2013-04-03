From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: git https transport and wrong password
Date: Wed, 3 Apr 2013 12:43:02 +0300
Message-ID: <20130403094302.GY30514@lakka.kapsi.fi>
References: <20130402155440.GT30514@lakka.kapsi.fi>
 <20130402192845.GC17784@sigill.intra.peff.net>
 <20130402194751.GV30514@lakka.kapsi.fi>
 <20130402200551.GA535@sigill.intra.peff.net>
 <20130402202054.GX30514@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 11:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNKEF-0003TQ-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 11:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763315Ab3DCJnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 05:43:08 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:40562 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752Ab3DCJnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 05:43:05 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UNKDe-0005Si-8g; Wed, 03 Apr 2013 12:43:02 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UNKDe-0005os-6M; Wed, 03 Apr 2013 12:43:02 +0300
Content-Disposition: inline
In-Reply-To: <20130402202054.GX30514@lakka.kapsi.fi>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219931>

Maybe my git installation was incomplete before when running from ~/bin since
I was not able to set break points to http_request() and some debug code
was not there until I ran git through bin-wrappers in the source tree.

I added some debug prints to http.c functions http_request() and
handle_curl_result(), and now I see this chain of events:

 http_request_reauth()
 http_request()
 GET ...info/refs?service=git-upload-pack
 HTTP/1.1 401 Authorization Required
* Ignoring the response-body
* Issue another request to this URL: '...'
 GET ...info/refs?service=git-upload-pack
 HTTP/1.1 401 Authorization Required
 handle_curl_result: res = 22, http_code = 401, user = ..., pass = (null)
Password for '...': (enter valid password)
 GET ...info/refs?service=git-upload-pack
 HTTP/1.1 200 OK

So, for some reason the first GET request is issued twice and first 401
is ignored. I'll try to debug run_active_slot() next...

-Mikko
