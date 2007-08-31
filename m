From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 08:21:53 -0700
Message-ID: <20070831152153.GA30745@muzzle>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com> <7vveav21uv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:22:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8Jt-0007WQ-DY
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 17:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbXHaPVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 11:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbXHaPVz
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 11:21:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37144 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283AbXHaPVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 11:21:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EA64B2DC08D;
	Fri, 31 Aug 2007 08:21:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vveav21uv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57173>

Junio C Hamano <gitster@pobox.com> wrote:
> "Robert Newson" <robert.newson@gmail.com> writes:
> 
> > The latest head of git gives me this when doing most operations, this
> > also happens with the rc7 experimental Debian package. It's annoying
> > because it prints this line hundreds of times for each call to 'log',
> > for example
> >
> > "Use of uninitialized value in string eq at blah/git/git-svn line 826."
> >
> > and this fixes it;
> 
> Curious.  I wonder how can it trigger.
> 
> Presimably, that while (<$fh>) loop is reading from git-log, and
> the first line would look like "commit [0-9a-f]{40}" and will
> set $hash, do "next".  Which means the variable should have been
> initialized by the time the part that complains about string eq
> (which I think is "if ($c && $c eq $hash)" comparison) is
> reached.

This could be a sign of a bigger problem.

Does git-log read .git/config and that could potentially change
its default output format?  A quick scan of the docs say "no".

I remember using git-rev-list in the original code because git-log was
(is still?) considered porcelain and less suitable for automated
parsing...

-- 
Eric Wong
