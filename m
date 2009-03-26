From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: Test that every revision builds before pushing changes?
Date: Thu, 26 Mar 2009 20:10:52 +1100
Organization: I know I put it down here, somewhere.
Message-ID: <87ljqs7ioz.fsf@rimspace.net>
References: <87myb8aja1.fsf@rimspace.net> <49CB39E5.5060000@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 10:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmlkY-0007tu-Sq
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbZCZJSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 05:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbZCZJSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:18:16 -0400
Received: from main.gmane.org ([80.91.229.2]:52275 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbZCZJSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:18:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lmlj0-0002um-PU
	for git@vger.kernel.org; Thu, 26 Mar 2009 09:18:10 +0000
Received: from ppp59-167-189-244.static.internode.on.net ([59.167.189.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 09:18:10 +0000
Received: from daniel by ppp59-167-189-244.static.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 09:18:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ppp59-167-189-244.static.internode.on.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:FvQrUd7Xu+gcpQxfLfiehxPkKxM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114754>

Andreas Ericsson <ae@op5.se> writes:
> Daniel Pittman wrote:
>>
>> I would like to ensure that my commits are fully bisectable before I
>> commit them to an upstream repository, at least to the limits of an
>> automatic tool for testing them.
>>
>> 'git bisect run' is similar: it can automatically locate the breakin=
g in
>> a test suite, for example, but that doesn't help me in the case of t=
hree
>> commits, A (good), B (bad) and C (good, fixing B).
>>
>> I would much rather, in this case, use rebase to fix B so that it, t=
oo,
>> builds before I push the changes and pollute a public repository wit=
h a
>> broken changeset =E2=80=94 and make bisect that much harder to use i=
n future.
>
> You can do that, but it requires manual work too. The trick is to mak=
e
> the release branch immutable on the public repository and use topic
> branches with per-developer namespaces. The per-developer namespace
> thing is actually important, as it leaves the freedom to rewind and
> recreate topics to the developers (which shared branches do not).
>
> The manual step comes at merge-time; Someone has to be responsible fo=
r
> merging all the topics that are to be included in the release branch
> and make sure it builds and passes all tests after each merge.

Ah.  You have not quite grasped what I was looking for: I was after a
tool to help automate that step, rather than a workflow around it.

=46or example, the responsible person for that testing could use the
hypothetical (until someone tells me where to find it):

    git test public..test make test

Which would then effectively wrap:

    for each revision between public and private:
         git checkout revision
         make test
         # report if that fails, allow fixing the commit or whatever
         # then 'git test continue' to carry on...

That turn the process from a manual one to an automated one: it runs
that command for every revision until it fails, or until they all pass.

Regards,
        Daniel
