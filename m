From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Cannot clone the git repository shared over http with authorization.
Date: Tue, 10 Apr 2012 11:53:38 +0200
Message-ID: <1334051620-18044-1-git-send-email-drizzd@aon.at>
References: <20120402083115.GA2235@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 12:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHXta-0004kv-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 12:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab2DJKBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 06:01:49 -0400
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:10936 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753807Ab2DJKBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 06:01:47 -0400
Received: (qmail 14739 invoked from network); 10 Apr 2012 09:55:06 -0000
Received: from smarthub79.res.a1.net (HELO email.aon.at) ([172.18.1.199])
          (envelope-sender <drizzd@aon.at>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 09:55:06 -0000
Received: (qmail 27704 invoked from network); 10 Apr 2012 09:55:01 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL605.highway.telekom.at
X-Spam-Level: *******
Received: from unknown (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[80.123.242.182])
          (envelope-sender <drizzd@aon.at>)
          by smarthub79.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 09:55:01 -0000
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <20120402083115.GA2235@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195078>

On Mon, Apr 02, 2012 at 04:31:15AM -0400, Jeff King wrote:
> On Sun, Apr 01, 2012 at 09:45:36PM +0200, Clemens Buchacher wrote:
> 
> > So far I figured out that setting 'git config http.maxRequests 1' fixes
> > the problem as well. Looking at the output with GIT_CURL_VERBOSE=1 set,
> > it seems that some GET requests use the credentials, while others do
> > not. My guess is that the CURLOPT_USERPWD option does not apply to all
> > threads.
> 
> Yes, that is exactly it. Furthermore, the multi-fetch code paths used by
> the http walker do not have the magic "notice a 401 and retry". I think
> something like this should fix it (it passes your tests),
> which is basically just double-checking that we set CURLOPT_USERPWD
> whenever we get a slot (I wish there was some way of asking "does this
> curl handle have USERPWD already set?", but I couldn't fine one).

I think this is the way to go. I am sending the updated patch for the test
(much of my changes were unnecessary), and your fix on top.

[PATCH 1/2] http auth fails with multiple curl handles
[PATCH 2/2] fix http auth with multiple curl handles

Clemens
