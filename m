From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow disabling expensive broken symlink
	checks
Date: Wed, 4 Feb 2009 23:42:15 -0800
Message-ID: <20090205074215.GA24887@dcvr.yhbt.net>
References: <200901311414.58205.markus.heidelberg@web.de> <20090201021844.GB18855@dcvr.yhbt.net> <7vbptlo7zg.fsf@gitster.siamese.dyndns.org> <20090203044549.GA2483@dcvr.yhbt.net> <7v4ozcdnbt.fsf@gitster.siamese.dyndns.org> <20090203191021.GB2077@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:43:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUytj-00048O-6B
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbZBEHmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbZBEHmR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:42:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52720 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbZBEHmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:42:16 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38321F449;
	Thu,  5 Feb 2009 07:42:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090203191021.GB2077@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108514>

Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > 
> > >> How common is this breakage in people's subversion repositories that
> > >> dbc6c74d (git-svn: handle empty files marked as symlinks in SVN,
> > >> 2009-01-11) works around?
> > >
> > > It's not common at all.  Some broken Windows clients were able to
> > > create it.
> > >
> > >> What's the way to recover from a broken import, when the subversion
> > >> repository does have such a breakage, and the user used git-svn that
> > >> predates dbc6c74?  Is it very involved, and it is much better to have the
> > >> safety by default than to force everybody else who interacts with
> > >> non-broken subversion repository suffer from this performance penalty?
> > >
> > > Previously, git-svn would just stop importing and refuse to continue.
> > > So allowing the user to enable it would be a problem; too.  I don't
> > > recall the error being easy to distinguish from other errors.

Actually I was wrong on git-svn refusing to continue.  git-svn will
create a regular 100644 file with "link path/to/dest" as its contents.
git-svn only croaks on checksum differences with the blob itself; it
does not have an easy way to verify the mode change => 120000 if it
happened previously.

> > >> Because the fix (that is broken from the performance angle) is relatively
> > >> recent, I am wondering if it makes more sense to turn it off by default,
> > >> and allow people with such a broken history to optionally turn it on.
> > >
> > > I'm considering disabling it by default, too.

I'm considering keeping it on by default given the above
(re)discovery...

-- 
Eric Wong
