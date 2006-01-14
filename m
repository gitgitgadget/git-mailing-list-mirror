From: John Ellson <ellson@research.att.com>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 14 Jan 2006 10:39:17 -0500
Message-ID: <43C91B25.9030707@research.att.com>
References: <dp3qpb$7uk$1@sea.gmane.org> <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 16:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExnVG-0000NT-JW
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 16:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWANPjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWANPjj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 10:39:39 -0500
Received: from main.gmane.org ([80.91.229.2]:33486 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751045AbWANPjj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 10:39:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ExnV6-0000L1-GG
	for git@vger.kernel.org; Sat, 14 Jan 2006 16:39:32 +0100
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 16:39:32 +0100
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 16:39:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Thunderbird 1.5 (X11/20060112)
In-Reply-To: <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14665>

Junio C Hamano wrote:
> John Ellson <ellson@research.att.com> writes:
> 
>> Suggested fix:  Use '_' instead of '-'
> 
> I wonder if the right fix is to change the git-describe output
> before the current output becomes too widespread.  After all,
> somebody might be tempted to use 1.0.6-g58e3 as a tagname ;-).
> For example, if we say "1.0.6:58e3" there is no ambiguity, but
> probably binary packagers would not like colon either X-<.
> 
> More seriously, I do not think git-describe based versioning
> scheme meshes well with binary packagers.  There is no guaranee
> 1.0.6-g58e3 comes before 1.0.6-g4e7a2 (it does not).  To really
> fix this problem, I think the rpm target of the main Makefile
> needs to be modified to include something monotonicly increasing
> (e.g. number of seconds since the base commit encoded in base26,
> or something silly like that) between the base version and the
> abbreviated object name, but the development being distributed,
> my today's version on top of 1.0.6 may be way behind your
> yesterday's version, so some centralized coordination (read:
> manual version assignment by the maintainer, or automated
> assignment but only reserved for the maintainer and unavailable
> to mere mortals) might be needed to truly solve this.  In that
> sense, maybe leaving the interim version unbuildable for binary
> packaging might be considered a feature.


What happened to this?   I don't particularly like my fix either, but
some kind of fix is needed for the "make rpm" target to work.  Its still broken 
because of the '-' in the version string.


The need in rpm versioning is to be able to distinguish and monotonically
order, locally built rpms.   There is no particular need to disambiguate against
somebody else's rpms since if you are merging someone else's changes you
would be doing it in git and not by intermixing rpms.

I think that distinguishing between local branches is not likely to be a prolem. 
  Most developers are likely to use only one for rpm construction, or if there 
is a second experimental branch, then it is likely to contain more-recent 
changes anyway.

So a count of minutes since last tag is probably sufficient.

This could have a hash appended if it is essential to make the rpm version 
unique without losing the ordering of the timestamp.

Something like:

	1.1.2_123456_g9e9b


John
