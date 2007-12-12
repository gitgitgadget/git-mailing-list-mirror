From: Andreas Ericsson <ae@op5.se>
Subject: Re: Invalid dates in git log
Date: Wed, 12 Dec 2007 16:51:46 +0100
Message-ID: <47600392.5050809@op5.se>
References: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>	 <20071212092304.GA20799@coredump.intra.peff.net> <34660cca0712120619r708ee7a8ta20a5458ca11a5ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Eirik_Bj=F8rsn=F8s?= <eirbjo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Tsc-0004eV-P6
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXLLPvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 10:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXLLPvv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:51:51 -0500
Received: from mail.op5.se ([193.201.96.20]:33284 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbXLLPvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:51:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 135731F08016;
	Wed, 12 Dec 2007 16:51:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtYcktO5IBfn; Wed, 12 Dec 2007 16:51:48 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D205E1F08008;
	Wed, 12 Dec 2007 16:51:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <34660cca0712120619r708ee7a8ta20a5458ca11a5ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68057>

Eirik Bj=F8rsn=F8s wrote:
>> Your best guess is probably the committer information. Try this:
>=20
> Thanks Jeff, Junio,
>=20
> I'll just use the committer date instead.
>=20
> Being a Git newbie (only started looking at it yesterday) I'm not sur=
e
> my understanding of "author" and "committer" and how they releate to
> dates is correct:
>=20

They're often the same. They will end up being different if
* you cherry-pick a commit made by someone else.
   ("someone else" is author, you are the committer)
* you rebase a series of commit containing changes from others
   ("others" are the authors, you are the committer)
* you apply a patch using "git am" from someone
   ("someone" is the author, you are the committer)
* you "git commit --amend" a commit from someone else
   ("someone else" is author, you are the committer)

There are probably other cases, but those were the ones I could
think of right now.

In short, whenever a commit is modified in some way, it gets a
new committer. It might help if you think of author as "contributor"
and "committer" as "integrator", where various integrators merge
between each other. A merge obviously doesn't fiddle with commits,
so once a commit has entered an integrators repository, both author
and committer stays intact (that's not strictly true, but for the
sake of this argument, which concerns the linux kernel, it will
suffice and be mostly correct insofar as I understand the kernel
workflow).

> * author: Original source of the change. This person may typically
> have sent a committer an email with a patch. It's the commiter's
> responsibility to supply this information.

No, it's the author's responsibility to supply this information.
Author is hardly ever changed.

> * author date: The commiter is free to specify a date for the contrib=
ution.
>=20

No, the author does that too :)

> * committer: First committer to actually add this change to a reposit=
ory

No, committer is the person who added the commit to the repository by
some other means than merging from another repository.

> * committer date: Date of the actual commit, added by the git client
> during the commit. Typically the system clock at the time of the
> commit.
>=20

Sort of, yes, although commits can be created by other means than
just running "git commit". The operations listed in bullets at the
top of this mail all create new commits, in the sense that they
can't have the same SHA1 as their original ones. Hence, committer
and commitdate must be updated.

> * A transfer of a commit across repositories (pull, push) will not
> change the author, commit or date information
>=20

True. Since neither ancestry nor content is allowed to change, the
commit will be exactly the same in the new repository as it was in
the old one.

> If I got some of this wrong, I'd be happy if someone would correct me=
=2E
>=20

I think I just did. Perhaps I missed something, but I'm sure someone
will correct me if that's the case.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
