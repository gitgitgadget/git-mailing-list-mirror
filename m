From: Andreas Ericsson <ae@op5.se>
Subject: Re: Test that every revision builds before pushing changes?
Date: Thu, 26 Mar 2009 09:16:37 +0100
Message-ID: <49CB39E5.5060000@op5.se>
References: <87myb8aja1.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 09:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmkn4-00066V-5o
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 09:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbZCZIQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 04:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbZCZIQp
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 04:16:45 -0400
Received: from mail.op5.se ([193.201.96.20]:57540 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755336AbZCZIQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 04:16:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6F35224B0D22;
	Thu, 26 Mar 2009 09:16:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxADmqt87lLU; Thu, 26 Mar 2009 09:16:46 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 93C0724B0D2E;
	Thu, 26 Mar 2009 09:16:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <87myb8aja1.fsf@rimspace.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114749>

Daniel Pittman wrote:
> G'day.
>=20
> I would like to ensure that my commits are fully bisectable before I
> commit them to an upstream repository, at least to the limits of an
> automatic tool for testing them.
>=20
> 'git bisect run' is similar: it can automatically locate the breaking=
 in
> a test suite, for example, but that doesn't help me in the case of th=
ree
> commits, A (good), B (bad) and C (good, fixing B).
>=20
> I would much rather, in this case, use rebase to fix B so that it, to=
o,
> builds before I push the changes and pollute a public repository with=
 a
> broken changeset =E2=80=94 and make bisect that much harder to use in=
 future.
>=20

You can do that, but it requires manual work too. The trick is to make
the release branch immutable on the public repository and use topic
branches with per-developer namespaces. The per-developer namespace
thing is actually important, as it leaves the freedom to rewind and
recreate topics to the developers (which shared branches do not).

The manual step comes at merge-time; Someone has to be responsible for
merging all the topics that are to be included in the release branch
and make sure it builds and passes all tests after each merge.

This workflow is a bit cumbersome. NASA uses something like this but
with an extra step for multiple peer reviews on every feature/fix for
software they send to satellites. Or so I've heard anyways.

If you're thinking of a staging area that should queue all commits
and lock the repo while testing is in progress, you need to think
again, I'm afraid, as that locks up developer time in such huge
amounts that it isn't really worth it. Without the locking, you
get the problem of trying to automate merges (which may conflict
and need a manual resolution). Although I guess a merge conflict
could result in a delayed push error, so perhaps that could work
too. If you manage to cook up a solution for this, please make a
small writeup on this list how you went about achieving it.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
