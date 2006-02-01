From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 3/9] http-fetch: Abort requests for objects which arrived in packs
Date: Wed, 1 Feb 2006 17:23:21 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu1rk9.2i8.mdw@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk> <20060201114430.5042.5144.stgit@metalzone.distorted.org.uk> <20060201171225.GI3873@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 18:24:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Lhb-00057X-Q1
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 18:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWBARX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWBARX1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 12:23:27 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:2804 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1030385AbWBARX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 12:23:26 -0500
Received: (qmail 28815 invoked by uid 110); 1 Feb 2006 17:23:21 -0000
To: git@vger.kernel.org
Received: (qmail 28801 invoked by uid 9); 1 Feb 2006 17:23:21 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1138814601 28628 172.29.199.2 (1 Feb 2006 17:23:21 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Wed, 1 Feb 2006 17:23:21 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15431>

Nick Hengeveld <nickh@reactrix.com> wrote:
> Does it make sense to call curl_easy_cleanup here?  This will close
> persistent server connections and cause another connection startup if
> the slot is reused.

I'm by no means a Curl expert.  But I scoured the docs for another way
of interrupting the current fetch and I couldn't find anything.  It
really didn't seem like a good idea to leave the handle as it was,
having (possibly) half-fetched a thing we weren't actually interested in
-- that way lies confusion.

Besides, in practice, what's happened is that the object we asked for is
in a pack which we've just collected.  Unless the upstream repository
hasn't been git-prune-packed, our fetch is going to fail with a 404
anyway, at which point Curl /will/ close the connection and make another
one next time.  So, in real life, it makes no difference.

-- [mdw]
