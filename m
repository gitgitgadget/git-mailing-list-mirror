From: Greg Price <price@ksplice.com>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Thu, 12 Nov 2009 12:57:09 -0500
Message-ID: <1ac2d430911120957gecb6a27k4166016ef8498eab@mail.gmail.com>
References: <20091104214611.GL9139@dr-wily.mit.edu>
	 <alpine.DEB.1.00.0911111804520.19111@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8dv2-0000S7-UU
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbZKLR5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 12:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbZKLR5F
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:57:05 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:53207 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbZKLR5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 12:57:04 -0500
Received: by ywh40 with SMTP id 40so517697ywh.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 09:57:10 -0800 (PST)
Received: by 10.213.24.24 with SMTP id t24mr2594622ebb.90.1258048629513; Thu, 
	12 Nov 2009 09:57:09 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911111804520.19111@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132790>

On Wed, Nov 11, 2009 at 12:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> That is very interesting!
>
> However, for rebase-i-p to have a chance to be accepted, I think a fe=
w
> things are necessary still (this is all from memory, so please take
> everything with a grain of salt):

Great, this is helpful, and it overlaps with my existing to-do list.
I have a couple of questions.


> - reorder the series to have the -i fixes first, the new commands nex=
t,
> =C2=A0and then the changes to the actual -p mode

This one will be easy when everything else is ready, I think.


> - rework the mark stuff so that 'todo' works properly, and then chang=
e the
> =C2=A0system to use ':<name>' style bookmarks.

This is the biggest change I was going to suggest!  Glad we're on the
same page.  To be clear, what I want to do here is
 - add a 'mark' command
 - emit 'mark' commands in the TODO generation for the target of each
'goto', and use them.
Is that also what you had in mind?


> - fix that nasty bug which makes one revision not pass the tests (I f=
orgot
> =C2=A0which one, but it should be in the TODOs)

Hmm.  I see one TODO comment in your patches, and it doesn't sound
like this.  Is there a TODO somewhere else that I'm missing?
Alternatively, I can always end up just running the tests on all the
revisions and find out.


> - add proper handling for the case when a patch has been applied in
> =C2=A0upstream already, but was not correctly identified as that by
> =C2=A0--cherry-pick (well, this TODO is actually not really related t=
o rebase
> =C2=A0-i -p, but something I deeply care about)

Hmm.  I'll have to think about what the behavior could be here.
Unless you've already worked out a behavior you would like to see?
=46or context, I think the issue you're referring to is that sometimes
the patch-id changed, so that --cherry-pick doesn't identify the
patch; and then some later upstream patch has touched the same code
again, so that there's a conflict when we try to apply the older
patch.  I would also like to see this fixed, but I don't see offhand
what the right behavior would be.

The "read my mind" behavior might be something like, somewhere between
the merge-base and the upstream there is a commit after which this one
would apply as no changes, so let's say that commit already applied
this patch.  But that could be the wrong thing if e.g. a patch was
applied and later reverted.  And I don't know offhand how to implement
it efficiently.

Anyway, I think you're right that this improvement is orthogonal to
rebase -i -p.


> Unfortunately, I am getting more and more deprived of Git time budget
> these days, so that I cannot seem to find a few hours to at least res=
tart
> my efforts.

Understood.  I may have some time to work on this soon, we'll see.  I
think the priorities will be to
 - add "mark" as you say
 - add the "pause" command, to make it possible to amend a merge
 - write tests
 - fix a couple of bugs, track down the one you mentioned
 - write documentation

At that point, and with the reordering you suggested, I think it will
be ready to submit for inclusion.

=46urther comments, and bug reports from anyone else using the
development version, are welcome.

Thanks,
Greg
