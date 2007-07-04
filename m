From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Wed, 04 Jul 2007 12:51:44 -0700
Message-ID: <7vir90gd67.fsf@assigned-by-dhcp.cox.net>
References: <20070610150839.GG4084@efreet.light.src>
	<e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	<20070611044258.GJ4084@efreet.light.src>
	<e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	<20070701122625.GC26243@efreet.light.src>
	<e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
	<20070702180309.GA4400@efreet.light.src>
	<7vy7hwlpo4.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707040544l6272bdeao3a891c1793d29eae@mail.gmail.com>
	<20070704182806.GA3268@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jul 04 21:51:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6AtB-0004ce-AD
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 21:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbXGDTvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 15:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756610AbXGDTvq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 15:51:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51353 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552AbXGDTvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 15:51:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704195144.PWQT17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 15:51:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KXrk1X0061kojtg0000000; Wed, 04 Jul 2007 15:51:44 -0400
In-Reply-To: <20070704182806.GA3268@efreet.light.src> (Jan Hudec's message of
	"Wed, 4 Jul 2007 20:28:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51635>

Jan Hudec <bulb@ucw.cz> writes:

> On Wed, Jul 04, 2007 at 14:44:16 +0200, Marco Costalba wrote:
>> On 7/4/07, Junio C Hamano <gitster@pobox.com> wrote:
>>> But if a Porcelain like StGIT or Qgit would want to do that kind
>>> of operation for different use case than "amending", it can and
>>> should use plumbing commands, just like the implementation of
>>> "commit --amend" does, with different constraints and error
>>> checks.
>
> I would prefer if there was something between git-commit-tree and git-commit.
> There are several steps one has to do for commit, that are the same for most
> ways of commit:
>  - call pre-commit hook (unless --no-verify)
>  - write-tree
>  - commit-tree
>  - update-ref
>  - mv next-index index
>  - call post-commit hook (unless --no-verify or unconditionally?)
>
> Would factoring out such script from the end of git-commit.sh be accepted?
>
> Or would it be possible to get just that from git-commit with right options?
> Basically I need to replicate the logic with 
>
> I would suggest a name git-commit-index. It would take the index to commit,
> index to move in after commit, head to update, list of parents and commit
> message on standard input (as commit-tree does).

Judging from the existing users (am, commit, filter-branch, and
merge), I would say "write-tree then commit-tree then
update-ref" sequence could be made to a new built-in plumbing if
you really wanted to.  "mv next-index index" and calling of
hooks definitely do _not_ belong there, though, since the hook
that needs to be called are different, and the caller of such a
plumbing command is very well equipped to do them by themselves
anyway.
