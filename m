From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Fri, 8 Feb 2008 21:28:00 -0500
Message-ID: <20080209022759.GD2572@coredump.intra.peff.net>
References: <20080208073456.GA17791@glandium.org> <1202501335-28205-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNfSe-0005vP-63
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 03:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696AbYBIC2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 21:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756694AbYBIC2H
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 21:28:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3636 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756687AbYBIC2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 21:28:06 -0500
Received: (qmail 6768 invoked by uid 111); 9 Feb 2008 02:28:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 08 Feb 2008 21:28:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2008 21:28:00 -0500
Content-Disposition: inline
In-Reply-To: <1202501335-28205-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73183>

On Fri, Feb 08, 2008 at 09:08:55PM +0100, Mike Hommey wrote:

> 	#include <curl/curl.h>
> 	#include <curl/easy.h>
> 
> 	int main(void) {
> 	        CURL *easy = curl_easy_init();
> 	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
> 	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
> 	        curl_easy_perform(easy);
> 	        curl_global_cleanup();
> 	        easy = curl_easy_init();
> 	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
> 	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
> 	        curl_easy_perform(easy);
> 	}

Hrmph. I had tried to produce a similar minimum test case, but for some
reason I didn't try doing a global_cleanup() between the requests, which
obviously is the culprit.

Thank you for spending the time to track this down. I have confirmed
that your fix works on my test case.

-Peff
