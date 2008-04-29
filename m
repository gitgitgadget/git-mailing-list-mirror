From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tracability in git commits
Date: Tue, 29 Apr 2008 14:34:01 -0700
Message-ID: <7vd4o873cm.fsf@gitster.siamese.dyndns.org>
References: <1209473739.5642.31.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:35:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxTi-0000v9-8W
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbYD2VeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbYD2VeZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:34:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbYD2VeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:34:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A3BA1A19;
	Tue, 29 Apr 2008 17:34:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 495E61A16; Tue, 29 Apr 2008 17:34:18 -0400 (EDT)
In-Reply-To: <1209473739.5642.31.camel@dax.rpnet.com> (Richard Purdie's
 message of "Tue, 29 Apr 2008 13:55:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08A7AE8C-1634-11DD-90A5-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80742>

Richard Purdie <rpurdie@rpsys.net> writes:

> Assuming a shared server using something like gitosis each set of
> commits is made under a certain ssh ID and what I'd like is to be able
> to validate that against the commits so we could tell that commits A-D
> were made by ID Z.

First of all, you need to learn the differences between making commits and
updating remote repositories.  Push does not create commits, it only
propagates a new part of commit DAG created elsewhere.

When you grant rights to a person to update the tip of a branch of a
repository, you are saying that you trust the person to advance the
history recorded on that branch in a way that is compatible with the goal
of the branch of your repository.

Whether you like it or not, git is a distributed system and git does not
care how that other person came up with the new part of the history.  The
person may find somebody else's work that is useful and apply patches to
his history (introducing commits whose authors are not himself), or merge
it (introducing commits whose committer are not himself), but you trust
that the person who does so uses good judgement, the same good judgement
he uses when making changes on his own.

And then the branch you granted the right to update its tip to that person
is updated, using that added part of the history.  The updates to the tip
will be recorded in reflog to record who updated the tip and when, which
would allow you to go back and point your finger at the person who
introduced problematic new history and at that point you really do not
care if the problem you have with the new history was due to faulty
commits the pusher made himself, was introduced by a merge the pusher did,
or was applied by the pusher from his mailbox.
