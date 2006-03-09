From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 9 Mar 2006 13:26:36 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne10b8c.fr9.mdw@metalzone.distorted.org.uk>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de> <4410140E.2000609@op5.se> <Pine.LNX.4.63.0603091243001.20908@wbgn013.biozentrum.uni-wuerzburg.de>
X-From: git-owner@vger.kernel.org Thu Mar 09 14:27:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHLAC-0005By-QQ
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 14:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWCIN0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 08:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCIN0l
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 08:26:41 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:54963 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751863AbWCIN0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 08:26:41 -0500
Received: (qmail 4353 invoked by uid 110); 9 Mar 2006 13:26:36 -0000
To: git@vger.kernel.org
Received: (qmail 4340 invoked by uid 9); 9 Mar 2006 13:26:36 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1141910796 3374 172.29.199.2 (9 Mar 2006 13:26:36 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 9 Mar 2006 13:26:36 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17415>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Sorry, I was unclear. Of course, memcmp() does not stop on NUL. But it 
> stops when that NUL is different from what the other pointer has. Which is 
> the case here.

Does it really?  My copy of the spec doesn't say that.  It says only
this:

: 7.21.4.1  The memcmp function
:
: Synopsis
:
: #include <string.h>
: int memcmp(const void *s1, const void *s2, size_t n);
:
: Description
:
: The memcmp() function compares the first n characters of the object
: pointed to by s1 to the first n characters of the object pointed to by
: s2.262)
:
: Returns
:
: The memcmp function returns an integer greater than, equal to, or less
: than zero, accordingly as the object pointed to by s1 is greater than,
: equal to, or less than the object pointed to by s2.
:
: 262) The contents of ``holes'' used as padding for purposes of
: alignment within structure objects are indeterminate.  Strings shorter
: than their allocated space and unions may also cause problems in
: comparison.

There are reasons for which it'd be desirable that memcmp really compare
all the bytes, even if it can in theory stop early: in particular, there
are cases where early exit can leak timing information which makes it
possible to attack cryptographic protocols.

I'd have to recommend strncmp for this job.

-- [mdw]
