From: David Kastrup <dak@gnu.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 23:32:58 +0200
Message-ID: <85mywpx2wl.fsf@lola.goethe.zz>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
	<86d4xmxbjf.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org>
	<7vvebdg8r5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 23:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM9RO-0007i2-5d
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863AbXHQVdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757954AbXHQVdE
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:33:04 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:36809 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755187AbXHQVdD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 17:33:03 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id D0B7031EB92;
	Fri, 17 Aug 2007 23:33:00 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id C02AD2C6A0D;
	Fri, 17 Aug 2007 23:33:00 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-047-037.pools.arcor-ip.net [84.61.47.37])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id A5D2235E729;
	Fri, 17 Aug 2007 23:33:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9A59A1C36605; Fri, 17 Aug 2007 23:32:59 +0200 (CEST)
In-Reply-To: <7vvebdg8r5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 17 Aug 2007 14\:18\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3974/Fri Aug 17 20:13:57 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56087>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Fri, 17 Aug 2007, David Kastrup wrote:
>>> 
>>> But it isn't an independent git project: the superproject has its
>>> _own_ copy of dsp, with its _own_ specific commits and fixes that are
>>> not supposed to ever end up in the dsp "mothership". 
>>
>> Sure. And that's different from any git "branch" exactly how?
>>
>> So you'd have different branches in the superproject - the way you always 
>> have when you have two copies of a git project. And then you merge between 
>> the two at will.
>
> My reading of the project David is talking about is that its dsp
> project which is a "subproject" part gets non generic commits within
> the context of the superproject --- which means (1) you would have
> branches in the subproject not superproject, and (2) once you did
> that, the subproject is not really a subproject anymore, as you
> cannot merge that back to the standalone dsp project without
> dragging the non-generic bits along with it.

Ok, I should perhaps should not make things harder than they are: the
superprojects, being particular to one customer each, don't really
branch (except that git-svn makes a git branch from every Subversion
tag).  The subproject is the one that has considerable branching and
merges.  What usually gets pulled into the superproject is a copy of a
stable subproject branch.  Once this copy is in, only fixes (from the
stable branch) or features (from the development branch) that the
customer definitely needs are merged into the superproject.  While
there might happen some subproject work in the customer branch, this
mostly happens during bugfixing for the customer, and the changes are
typically pulled back into the subproject proper at some point of
time.  Inside of the subproject tree, there is really no superproject
_development_ going on.

>> There's a special "subtree" merge that does exactly that: it
>> basically is the normal recursive merge, except it merges into a
>> subtree. I think that's how Junio does the "git-gui" merges. Junio?
>
> Yes.  It has exactly the same semantics and limitations with the
> gitk merge, but just merges into a sub directory.  Shawn cannot
> easily pull the changes done inside git.git repository back to
> git-gui.git proper.

Well, the other direction would be the most important one: merging or
cherrypicking selected changes in the subproject branches into the
superproject copy of the subproject.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
