From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Announcing 3 git docs: Best Practices, fixing mistakes, post-production editing
Date: Sun, 04 Mar 2012 14:20:46 -0500
Message-ID: <201203041920.q24JKk3h024813@no.baka.org>
References: <201202281304.q1SD4U8W018223@no.baka.org>
        <7v399uxxkq.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 20:20:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4GzF-0002J8-Au
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 20:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab2CDTUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 14:20:49 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:53468 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab2CDTUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 14:20:48 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q24JKkdl022052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Mar 2012 14:20:46 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q24JKk3h024813;
	Sun, 4 Mar 2012 14:20:46 -0500
In-reply-to: <7v399uxxkq.fsf@alter.siamese.dyndns.org>
Comments: In reply to a message from "Junio C Hamano <gitster@pobox.com>" dated "Tue, 28 Feb 2012 17:00:53 -0800."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192171>


In message <7v399uxxkq.fsf@alter.siamese.dyndns.org>, Junio C Hamano writes:

    Just a few I noticed that are dubious to be in a document that is meant to
    describe "best practices".

Thanks for the comments.  I will incorporate most of them and
certainly thought hard about all of them.

    "Don't panic"
    -------------

    * As we never "auto-stash", anything that is on stash is by definition
      what the user deliberately placed, just like a commit on a branch that
      the user may have forgotten.  So it is strange to count it as one of the
      three places that "lost" commit may be hiding.  If you make it four and
      add "a branch you might have forgotten" to the mix, it would make a bit
      more sense, though.

I do.  That was the next bullet "misplaced".  I also expand on this a
bit during the second document about finding and fixing mistakes.

    * The example command line for gitk passes --all and also everything from
      "log -g" output, which should be OK for toy history, but wouldn't be
      such a good idea when you can expect tons of data from "log -g".

My reasoning is that the live/referenced history provides context.
Seeing a series of commits going back in time is nice and all, but
knowing that at some point it branched from some particular
still-referenced branch allows you to concentrate only on the commits
that were "lost" (abandoned/replaced/etc), lets you have a better idea
on whether those commits are relevant, and perhaps you will even see
similar commits nearby on a still referenced branch.

Yes, for projects with dozens of simultaneously active branches it may
cause information overload.  Ideally there would be an easy way to
only have gitk show relevant branches without a lot of work.  Right
now, the only way I can think of is to find the --contains of the
first referenced parent of the unreferenced commits and then pick the
closest named branch to display using some algorithm.  I'll also
suggest using `git log -Sfoo -g` in addition to my current alternate
suggestion of looking at the reflog directly.

Anyway, someone managing dozens of branches should know what --all
does and that they can remove it.

      Doesn't "gitk" itself accept -g these days?

My gitk (1.7.9.2) accepts -g but doesn't show the reflog.

    * Lost and found

      Why "git ls-tree -r"?  Doesn't "git show" work eqully well?

I find the added information of ls-tree more useful since you can more
easily examine the contents/blobs of the tree.

git show    |  git ls-tree -r
------------|--------------------------------------------------------------
tree 51e4   |
            |
A           | 100644 blob e900b1c81c65dc52463027be827c1418fc7ff505    A
asdf/       | 100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc    asdf/a
x           | 100644 blob e900b1c81c65dc52463027be827c1418fc7ff505    x



    "On Sausage Making"
    -------------------

    * The desription of "downside" shows a bias against efforts to strive for
      useful history, and also shows ignorance of the true motivation behind
      such discipline. It is _not_ blame or ego. It is all about leaving a
      history others can later use to understand _why_ the code became the way
      it is now, to make it less likely for others to break it.

I have included that last sentence in the argument for creating a
perfected history.  I personally believe that there are many contexts
in which a perfected history is critical, but I also feel there are
many cases where it is entirely overkill, which is why I talk about
both sides of the issue.  But I think it important enough that I made
it one of the three things I mention in the title of the document
(perfect later) *and* I wrote the third document describing how
someone might actually go about the process.


    "Do keep up to date"
    --------------------

    * You explained in "Do choose a workflow" section that different workflows
      suite different projects.  ... it
      would be more useful to say in what workflow and the workflow elements
      such as "pull --rebase" you advocate in this section are suited (you do
      not have to say in what other workflow they are inappropriate).

In the pull --rebase section, I spend one short paragraph talking
about why I think it is a good idea and four providing arguments
against it.  In my opinion, it rebase should always be used when it is
possible, and I did specifically mark it as my opinion and that people
disagree with me.  I think I did about as good as I can presenting the
negative side, but if you have more specific arguments against rebase,
I'll be happy to include them.  Perhaps it will even change my stance
about using rebase.

					-Seth Robertson
