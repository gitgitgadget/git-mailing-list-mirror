From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Suggestion: superceded tags
Date: Fri, 27 May 2005 12:26:20 +0100
Message-ID: <1117193179.1957.28.camel@sisko.sctweedie.blueyonder.co.uk>
References: <4296B051.10603@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Stephen Tweedie <sct@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 13:25:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbcx4-0001h3-9U
	for gcvg-git@gmane.org; Fri, 27 May 2005 13:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVE0L01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVE0L01
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 07:26:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262438AbVE0L0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 07:26:24 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4RBQNk3012106;
	Fri, 27 May 2005 07:26:23 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4RBQNO18264;
	Fri, 27 May 2005 07:26:23 -0400
Received: from chunnel (sct.cipe.redhat.com [10.0.1.44])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j4RBQK6l032196;
	Fri, 27 May 2005 07:26:22 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4296B051.10603@zytor.com>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 2005-05-27 at 06:29, H. Peter Anvin wrote:

> When a tag is moved, a new tag object is created.  This tag object will 
> have a "supercedes" header which references the old tag object.

Strictly speaking, don't you need to allow multiple "supercedes" lines
to cover all the cases?  The pathological case is when you've got
multiple trees all with different variants of the same tag name, and you
try to merge them all at once with a multi-parent commit.  

Sure, tags refer to trees, not commits, so you don't necessarily have to
do this tag resolution at commit time (indeed, since commits don't refer
to tags, you *can't* do that resolution atomically on commit.)

But if you do pull tags into the local .git/refs/tags on merge, then you
will want to either resolve the conflict or supercede those tags, and at
that point you've got multiple equally valid tags in the histories that
are being superceded.  Doing so is a porcelain issue, but the core will
still need to understand tags with multiple supercedes: lines.

--Stephen


