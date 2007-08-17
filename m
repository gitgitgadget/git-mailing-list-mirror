From: David Kastrup <dak@gnu.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 20:26:28 +0200
Message-ID: <86d4xmxbjf.fsf@lola.quinscape.zz>
References: <86y7gaxef5.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 20:26:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM6X8-0006HB-VK
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 20:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685AbXHQS0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbXHQS0q
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 14:26:46 -0400
Received: from main.gmane.org ([80.91.229.2]:42333 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757685AbXHQS0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 14:26:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IM6Wv-0004l7-Rr
	for git@vger.kernel.org; Fri, 17 Aug 2007 20:26:41 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 20:26:41 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 20:26:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:lSjYwYgiL9JU9RrQXbILylWkdyw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56079>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 17 Aug 2007, David Kastrup wrote:
>> 
>> Now is there any chance to set up a git structure that will me
>> allow to let _git_ perform merges between the standalone dsp
>> project and the part that has started off as a copy of it in a
>> subdirectory from projects/great, so that I have a merge history in
>> my git mirror?
>
> Yes. That's what git "submodule" support is all about.  You could
> create that "dsp" project as its own git project, and then include
> it within the bigger project as a submodule. Then, that "dsp" thing
> is really a totally independent git project in its own right, with
> git support for just "tying" it into the superproject.

But it isn't an independent git project: the superproject has its
_own_ copy of dsp, with its _own_ specific commits and fixes that are
not supposed to ever end up in the dsp "mothership".  There are
sometimes cross merges, but the stuff in the "dsp" subdirectory of
"great" is maintained completely together with the branches of
"great": tags, branches and all.

But I would like to be able to merge this _subdirectory_ with branches
from the "mothership" dsp from which it was originally copied.

With Subversion, I can actually merge files in different projects of
the repository even when they are in different directory levels.  Of
course, since Subversion does not track any merge info, that is not an
accomplishment.

I don't see quite how this would work with submodules, and in
particular not when git-svn gets involved as well.

> A few words of caution:
>
>  - while the low-level core submodule support has been around for a
>  while now, the actual "porcelain" level helper stuff is new to
>  1.5.3 (which is unreleased, so you'd have to use the current git
>  "master" branch, of course)

Have to for a variety of reasons, anyway.

>  - submodules are (very much by design) meant to be git projects in
>  their own right, and kept separate. That very explicit separation
>  means that you will *see* it as a separate project, and you may
>  decide that it's not worth the extra setup/complexity if the "dsp"
>  thing just isn't big enough or the merge complexity just isn't
>  worth the effort.

And that is the problem here: in this case it does not make sense to
see it as a separate project, and in particular, it needs to be in
synch with the tags/branches of the superproject, and particularly
while I am using git-svn.

> Another alternative is to do what git has long done with "gitk": you
> can maintain a separate project and just merge it directly into
> another git project, and it works fine that way, but it gets
> impossible to merge back and forth between the two projects (you can
> only merge one way: make all the major changes in the "dsp" project,
> and then you can just merge it into the project that uses it (but if
> you fix things in the bigger project, you can't merge the fixes
> back, you'll have to export the fixes as patches and do them in the
> "dsp" tree).

Well, that would be at least quite handy for propagating upstream dsp
fixes into project/great.  How do I merge one project into a
_subdirectory_ of another one?

-- 
David Kastrup
