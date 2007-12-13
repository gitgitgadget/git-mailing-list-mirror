From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git describe candidate filtering
Date: Thu, 13 Dec 2007 00:57:46 -0500
Message-ID: <20071213055746.GV14735@spearce.org>
References: <4760C250.5080103@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 06:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2h5I-0002LZ-W5
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 06:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbXLMF5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 00:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbXLMF5v
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 00:57:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41113 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbXLMF5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 00:57:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J2h4u-0000ez-K9; Thu, 13 Dec 2007 00:57:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0EB9120FBAE; Thu, 13 Dec 2007 00:57:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4760C250.5080103@byu.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68122>

Eric Blake <ebb9@byu.net> wrote:
> Would it be possible to add an option to git-describe that limits the
> candidate tags to those matching a glob pattern or regular expression?
> I've got a repository imported from CVS which has a number of less
> interesting tags for events such as branch creation, but I'm only
> interested in describing the current commit relative to tags matching
> v[0-9]\.[0-9]*, rather than the closest tag of any spelling.

Sure, it shouldn't be too difficult, just need to alter the get_name()
function to add the item with add_to_known_names() only if it matches
the pattern.  Take a look at builtin-describe.c around line 74...

We only match things that were "added".  So if you don't add a tag
via add_to_known_names() then git-describe won't return it.

However that's only true for the standard case; for --contains its
a different story as we are actually passing everything to name-rev.

-- 
Shawn.
