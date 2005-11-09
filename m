From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Wed, 09 Nov 2005 15:36:44 -0800
Message-ID: <7virv18kc3.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108210332.GB23265@c165.ib.student.liu.se>
	<20051109112452.GD30496@pasky.or.cz>
	<46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzUn-0003yf-Ap
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbVKIXgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbVKIXgq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:36:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51363 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751590AbVKIXgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:36:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109233543.KTHT2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 18:35:43 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 10 Nov 2005 12:04:11 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11441>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
>> The world would be so much better if there would be just a _single_
>> per-file automerger instead of three right now...
>
> I don't quite agree with this. The multi-merger mechanism is something
> (relatively) unique and powerful in GIT.

If I am reading you two correctly, you are not disagreeing, but
are talking about different issues.

Pasky is talking about what to do after merge strategy finds
that a path (from three stages) needs to be merged.  git-core
uses git-merge-one-file or git-merge-recursive::mergeFile (which
are the implementations of the same logic), and Pasky has his
own in Cogito.

Fredrik's using his own mergeFile is defensible from both
performance and implementation point of view.  After the rename
processing stage, he already extracted enough information from
trees involved, and there is no reason for him to be preparing
three stages in the index file with that information (which is
cumbersome because there is no interface to populate the higher
stage directly using git-update-index --- you have to first
create temporary tree objects and ask git-read-tree -m to do so)
and asking git-merge-index to call git-merge-one-file.  If you
read git-merge-one-file, it is not a rocket science.  While we
_may_ want to keep the logic that decides what to do in various
cases across these three implementations, at least for me, it
does not particularly feel disturbing, especially when there are
good reasons.
