From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH/RFC] Allow empty commits during rebase -i
Date: Sun, 17 Jan 2010 18:11:33 -0800
Message-ID: <4B53C355.1010109@pcharlan.com>
References: <4B53B561.0@pcharlan.com> <7vljfww686.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 03:11:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWh5r-0007Zt-0V
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 03:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0ARCLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 21:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961Ab0ARCLl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 21:11:41 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:53623 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753207Ab0ARCLe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 21:11:34 -0500
X-Greylist: delayed 3571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2010 21:11:34 EST
Received: from [192.168.0.119] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id B8F518F22E;
	Sun, 17 Jan 2010 18:11:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vljfww686.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137358>

On 01/17/2010 05:29 PM, Junio C Hamano wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> I imagine an ideal version of this fix would make it so the use case I
>> presented here would work, but rebase -i would still prevent
>> introducing a new empty commit, or at least warn when it was
>> introducing one.  In the absence of that ideal fix, I think this
>> behavior is better than failing to handle this case.
> 
> Sorry, I actually tend to think that in the absense of that fix, your
> version introduces risky behaviour that only a corner-case use case
> benefits, and pros-and-cons doesn't look attractive enough.
> 
> Why not do something like:
> 
>     pick X a crap tree with a good message
>     pick Y revert X
>     pick Z a good tree with a crap message
> 
> -->
> 
>     # drop X
>     # drop Y
>     edit Z
> 
> and then run "git commit --amend -C X" when it is Z's turn to be
> processed?

That is another way to accomplish the same thing, but doesn't prevent
the current behavior from being confusing.

Part of the problem is that with the current behavior the user is sent
to the command line with:

  # Not currently on any branch.
  nothing to commit (working directory clean)

  Could not apply a0b17c5... Revert "Crap tree good message"

with HEAD pointed to X^.  Unsure of how to proceed from here, I
--aborted the rebase and copy/pasted the commit message I wanted and
resolved to track this down and fix it when I got a chance.

As it happens, "git rebase --continue" does exactly what I would have
wanted to happen, including putting me in an editor with all three
commit messages and succeeding when I exit the editor.  But without a
better message from git I don't expect a user to discover that.  And,
when rebase can continue just by being told so it would be nice if it
didn't require that user intervention.

If the introduction of empty commits that the user has asked for
(perhaps inadvertently) is considered too undesirable, then perhaps my
fix is too simple.  I'll think about how to do something more
sophisticated.

Thanks for your feedback,

--Pete
