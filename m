From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Sun, 06 Jul 2008 21:43:58 -0700
Message-ID: <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 06:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFib3-0005i6-8u
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 06:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbYGGEoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 00:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbYGGEoG
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 00:44:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbYGGEoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 00:44:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34CDD25B66;
	Mon,  7 Jul 2008 00:44:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 95CBE25B65; Mon,  7 Jul 2008 00:44:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52ECFF48-4BDF-11DD-A0C3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87575>

Brian Gernhardt <benji@silverinsanity.com> writes:

> This makes rebase act a little more like merge when working on the
> current branch.  This is particularly useful for `git pull --rebase`
>
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---
>
>  ARG!  This is what v3 was supposed to be.  I should make sure I am sending in
>  the correct patch.

Yeah, I was scratching my head about the discrepancy between the revision
comment and the patch in the previous one.

Having said that, thanks to updates to git-rebase, rebased_branch@{1} has
useful information these days, so I do not see much practical upside, even
though I _will_ apply this patch, just for the sake of consistency.

We would make it _appear_ rebase and merge are interchangeable even more.
But the thing is, I am not convinced if promoting that appearance is
necessarily a good thing.

You now do not have to say something like:

	After a 'git pull' you can view 'git diff ORIG_HEAD..' to check
	what are new, but 'git pull --rebase' is different and you would
	say 'git diff branch@{1}.." instead.

and you can tell the users that ORIG_HEAD can be used in both cases.

But you cannot say the same thing with "gitk ORIG_HEAD..", for example.
The meaning of the topology and commits you would see would be quite
different.  For rebase you will see your own commits that are carried
forward, and for merge you won't.  Besides this example, there probably
are many fundamental differences between rebase and merge, and trying to
give a false impression that they are interchangeable may not add much
value to the end user experience, and it could even be harmful from
educational point of view.
