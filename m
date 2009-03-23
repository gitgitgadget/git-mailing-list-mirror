From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-fast-export.c: add default case to avoid crash
	on corrupt repo
Date: Sun, 22 Mar 2009 17:26:36 -0700
Message-ID: <20090323002636.GI23521@spearce.org>
References: <1237675051-6688-1-git-send-email-kusmabite@gmail.com> <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlY1Q-0005mw-Up
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZCWA0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 20:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbZCWA0j
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:26:39 -0400
Received: from george.spearce.org ([209.20.77.23]:41958 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbZCWA0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:26:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D6EB138211; Mon, 23 Mar 2009 00:26:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114211>

Junio C Hamano <gitster@pobox.com> wrote:
> It
> appears that there is no way to feed a tree object to fast-import, but I
> think the fast-import language can represent a tag that points at another
> tag just fine.

Correct.

This area of the langauge was built around the basic CVS->Git sort
of conversion, where we just wanted to attach the CVS "tag" symbol
onto a Git snapshot that seemed to match it.  Annotated tags were
used only because tools like git fetch and git describe prefer to
work with them, and these were (at some point in time) meaningful
labels for these revisions so the project post-conversion should
retain those same labels.

In hindsight, parts of the fast-import langauge are problematic as
they don't fully represent the Git object graph, and this is one
of those areas.  It wasn't designed to represent the same range
of structures as Git can represent.

> So the best you can do is perhaps to issue a warning
> "skipping a tag that points at a tree object" and impoement a proper
> handling of a tag that points at a tag.

Or, patch fast-import to expand its language.  You could relax
the "from <committish>" rule to be "from <objectish>" and then
create tag a tree using a temporary branch and a from line of
"from temp-branch^{tree}".

-- 
Shawn.
