From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 18:21:40 +0200
Message-ID: <86sl7k4b57.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site> <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com> <Pine.LNX.4.64.0707191642270.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 18:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBYle-00062u-6d
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939736AbXGSQV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 12:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939716AbXGSQVz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 12:21:55 -0400
Received: from main.gmane.org ([80.91.229.2]:44233 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S939654AbXGSQVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 12:21:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBYlE-0005on-Ox
	for git@vger.kernel.org; Thu, 19 Jul 2007 18:21:52 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 18:21:52 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 18:21:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:kSVQFxsluHxQFAk8LPiJn5vsOQU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53003>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 19 Jul 2007, Brian Gernhardt wrote:
>
>> 
>> On Jul 19, 2007, at 8:24 AM, David Kastrup wrote:
>> 
>> > I think that the placeholder name should rather be ".".
>> 
>> For what it's worth, the more this gets discussed, the more I think your 
>> idea is a good one.
>
> I do not like it at all. "." already has a very special meaning.  It is a 
> _directory_, no place holder.

And this is what it will be under my scheme: a directory.  It is just
that "directory" is differentiated from a "tree".  Both are tracked in
the repository (directory tracking is optional), and there is no such
thing as an empty tree, a tree being defined by its contents and
nothing else, as previously.  A "directory" has no contents, but only
existence in index and repository.  A "tree" only exists in the
repository, not in index or work directory.  It is mapped to physical
directories in the work directory.  If no corresponding "directory"
exists in index and/or repository, the work directories are created
and deleted on the fly as before in order to represent the state of
the "tree" in the repository.  So here are the concepts:

entity     working directory        index           repository
--------------------------------------------------------------
file       mapped to files          file            [blob]
dir        mapped to dir existence  dir             [dir]
tree       mapped to dir tree       unrepresented   [tree] (non-empty container)

> More and more I get the impression that this thread is just not
> worth it.  The problem was solved long ago, and all that is talked
> about here is how to complicate things.

I disagree on both accounts: that the problem has been solved (the
existence of a workaround involving constant manual intervention is
not a solution for me), and that my proposal will constitute a
complication to the user.

For projects setting a "." into the top level .gitignore, nothing at
all will change, even when "core.adddirs: true" will become the
default at some point of time.  Once this is the default, new users
with new projects will not notice anything surprising, at least until
the time that they pull from somebody with a repository with different
non-explicit conventions.

This is something which may still require thought in order to result
in the least complicated handling of cooperation.  But with regard to
the internals itself, I don't see that there is too much non-obvious
complexity involved here, and the framework appears very consistent,
logical, and compatible with git's ideas to me.

-- 
David Kastrup
