From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 17:53:00 -0700
Message-ID: <7vd4b6ddzn.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
 <20090420113216.GC25059@dpotapov.dyndns.org>
 <49EC6596.8060208@drmicha.warpmail.net>
 <20090420132414.GD25059@dpotapov.dyndns.org>
 <49EC7E3B.9050909@drmicha.warpmail.net>
 <20090420184048.GF25059@dpotapov.dyndns.org>
 <7viqkzdoua.fsf@gitster.siamese.dyndns.org> <87r5znashf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Marius Vollmer <marius.vollmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4G6-0004wJ-PG
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZDUAxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbZDUAxL
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:53:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbZDUAxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 20:53:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8DC7100DF;
	Mon, 20 Apr 2009 20:53:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9575C100DE; Mon,
 20 Apr 2009 20:53:01 -0400 (EDT)
In-Reply-To: <87r5znashf.fsf@gmail.com> (Marius Vollmer's message of "Tue, 21
 Apr 2009 01:08:12 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C76BA5E2-2E0E-11DE-91D3-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117058>

Marius Vollmer <marius.vollmer@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If we made it easy for Dscho to create the merge M to record my tree as
>> the first parent, [...]
>
> But it _is_ easy for Dscho to do that, isn't it?  He just needs to
> remember to do the merge the other way around, checking out your branch
> and merging his into it.
>
> This doesn't change much, of course, since we still can't follow a
> branch backwards in time reliably.  Would it make sense to record
> additional information in a merge commit, such as the branch name for
> each parent?  Then tools could automatically draw the history of the
> current branch as a straight line, say.

We already have record of that, but I do not think using it is necessarily
healthy.

There are certainly cases where the relationship between the maintainer
and a contributor makes one branch "the primary" in the sense that it is
the integration ground for everything under the sun, as opposed to the
other one that is "the side branch that was merged" in the sense that it
brought in a more narrowly focused set of patches.  If you examine the
merge commit M Dscho makes in the example in my previous message, it shows
that one of the parents was committed by me and the other was committed by
Dscho.  By following my commits over Dscho's, you will identify which one
of the parents of a merge is the mainline.  You would perhaps instead of
"git log --first-parent" use "git log --mainline=gitster" or something
like that.

The point is that a convention to follow my commits over Dscho's commits
is just as valid as a convention to follow the first parent.  It is purely
a social convention.

A more problematic is that in a distributed environment, there doesn't
necessarily such a "mainline vs side branch" relationship exist, and it is
not healthy to try to introduce such a concept like "mainline" when there
is no such thing.

Perhaps Alice and Bob forked at the same point, agreeing between
themselves that Alice works on the code updates while Bob updates the
documentation as a team of two to produce a new feature.  Before they
collectively conclude their work and send a pull request to the project
management, they will merge their branches to produce the end result that
is pullable.  From the overall project's point of view, the merge to get
their work into the mainline will be "the mainline merges one side branch
for the feature", but what about the merges between Alice and Bob while
they work together?  There is no "this is the mainline and this is a side
branch" relationship between what they do.
