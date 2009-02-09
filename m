From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git 
 repository
Date: Sun, 08 Feb 2009 20:58:48 -0800
Message-ID: <7vmycww6if.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
 <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
 <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
 <200902081918.35665.bss@iguanasuicide.net>
 <e38bce640902081859o47462a58s59c120209fabb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 06:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWOFr-0003fZ-4N
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 06:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZBIE65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 23:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbZBIE64
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 23:58:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbZBIE6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 23:58:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D9BD2ABC6;
	Sun,  8 Feb 2009 23:58:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 693DF2ABBD; Sun, 
 8 Feb 2009 23:58:50 -0500 (EST)
In-Reply-To: <e38bce640902081859o47462a58s59c120209fabb0@mail.gmail.com>
 (Brent Goodrick's message of "Sun, 8 Feb 2009 18:59:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59B380D6-F666-11DD-90E8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109044>

Brent Goodrick <bgoodr@gmail.com> writes:

> What I really want to do is simply replace the last two commits on the
> branch with one commit, so that when I make my patch it will be just
> the full set of changes and not a lot of noise. Is there a way to do
> that? (note: I did try the git merge --squash command but it just
> showed me the usage, as I was on my bg/no-progress branch).  Note that
> I know that I would not be able to do this once some of my changes had
> merged upstream.

Suppose you have this topology.  You forked and built 2 commits, while the
upstream advanced its tip (or not).

                 1--2 your commits (master)
                /
	---o---o---o upstream (origin)

1. Using "rebase -i"

    ... on your "master"
    $ git rebase -i origin
    ... will give you an insn sheet for interactive rebase to edit.
    ... you will see something like:

	pick xxxxxx title of commit 1
       	pick yyyyyy title of commit 2

    ... edit the second "pick" to "squash", save and exit the editor.
    ... You are telling it to "first cherry-pick my 1, and then squash my
    ... 2 on top of it.

    ... it will do as it is told, and will give you another editor, with
    ... messages from both commits in it.  Edit to formulate a log message
    ... suitable for the combined commit, save and exit the editor.

   You will end up with:

	---o---o---o---X

   where rightmost 'o' is still origin, X is your two commits squashed
   into one.

2. Using "mrege -s squash"

    ... on your "master"
    $ git merge --squash origin
    ... this will stop without creating a commit.  Then you would
    $ git commit
    ... and the editor will give you the log message from all the
    ... commits on the branch you just merged.  Come up with a single
    ... log message to describe all, save and exit the editor.

   You will end up with:

	---o---o---o---X

   where rightmost 'o' is still origin, X is your two commits squashed
   into one.
