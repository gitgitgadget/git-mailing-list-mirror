From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple
 times
Date: Tue, 18 Jun 2013 08:36:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306180825460.24456@tvnag.unkk.fr>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com> <20130618051902.GA5916@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brandon Casey <bcasey@nvidia.com>, git@vger.kernel.org,
	gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 08:37:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UopXq-0004Z1-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 08:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab3FRGhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 02:37:17 -0400
Received: from giant.haxx.se ([80.67.6.50]:51583 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab3FRGhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 02:37:16 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r5I6b0Kq031690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Jun 2013 08:37:00 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r5I6axEO031685;
	Tue, 18 Jun 2013 08:36:59 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20130618051902.GA5916@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228160>

On Tue, 18 Jun 2013, Jeff King wrote:

TL;DR: I'm just confirming what's said here! =)

> My understanding of curl's pointer requirements are:
>
>  1. Older versions of curl (and I do not recall which version off-hand,
>     but it is not important) stored just the pointer. Calling code was
>     required to manage the string lifetime itself.
>
>  2. Newer versions of curl will strdup the string in curl_easy_setopt.

That's correct. This "new" behavior in (2) was introduced in libcurl 7.17.0 - 
released in September 2007 and should thus be fairly rare by now.

I mention this primarily because I think it should be noted that there will 
probably be very little testing by users with such old libcurl versions. It 
may increase the time between a committed change and people notice brekages 
caused by it. Even Debian old-stable has a much newer version.

> For older versions, if we were to grow the strbuf, we might free() the 
> pointer provided to an earlier call to curl_easy_setopt. But since we are 
> about to call curl_easy_setopt with the new value, I would assume that curl 
> will never actually look at the old one (i.e., when replacing an old 
> pointer, it would not dereference it, but simply overwrite it with the new 
> value).

Another accurate description.

-- 

  / daniel.haxx.se
