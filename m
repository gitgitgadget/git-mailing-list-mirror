From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Show of hands, how many set USE_NSEC
Date: Fri, 8 Aug 2008 09:34:55 -0700
Message-ID: <20080808163455.GE9152@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRUwa-0007pg-Iq
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYHHQe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYHHQe4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:34:56 -0400
Received: from george.spearce.org ([209.20.77.23]:43807 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYHHQe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:34:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7E2AF38420; Fri,  8 Aug 2008 16:34:55 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91690>

How many users really build their Git with USE_NSEC=1?

I'm suspecting a status issue in jgit caused by jgit honoring a
millisecond resolution on file modification timestamps, and the
underlying filesystem supporting at least a 1/2 second (or finer)
granularity, but C Git was built without USE_NSEC so it only honors
1 second granularity.

This can cause jgit to think a file is locally modified as the
mtime has data in the tv_nsec field, but C Git set that to 0 in
the index as USE_NSEC wasn't enabled at build time.

I'm trying to come up with a sane way for jgit to realize it should
truncate the milliseconds out of a timestamp before it comes to
the index record.

-- 
Shawn.
