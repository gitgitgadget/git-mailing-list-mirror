From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the first rebase illustration with command example
Date: Sat, 01 Sep 2007 13:04:34 -0700
Message-ID: <7vy7fqqhil.fsf@gitster.siamese.dyndns.org>
References: <bqcmsld7.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 22:05:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRZDS-0004kk-A0
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 22:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbXIAUEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 16:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbXIAUEj
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 16:04:39 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbXIAUEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 16:04:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C36C612AB18;
	Sat,  1 Sep 2007 16:04:57 -0400 (EDT)
In-Reply-To: <bqcmsld7.fsf@cante.net> (Jari Aalto's message of "Sat, 01 Sep
	2007 13:58:28 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57280>

Jari Aalto <jari.aalto@cante.net> writes:

> The case where rebasing need arises was not previously explained. The
> first illustration was broadened to contain complete set of commands
> and explanatory commentary how to synchronize current branch development
> with new upstream changes.
>
> The patch does not do justice, because the overall structure of the
> manual was changes as well. Changes:
>
> - Take out the examples from DESCRIPTION and move them after the
>   OPTIONS, under new heading EXAMPLES.
> - Number the examples 1, 2, 3 and make each one separate topic
> - Broaden the example 1 illustration with commands.
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>

Thanks for a patch.  I tried to rebase it on top of 'master',
but then noticed a few things.

> +In case of conflict, git-rebase will stop at the first problematic commit
> +and leave conflict markers in the tree.  You can use git diff to locate
> +the markers (<<<<<<) and make edits to resolve the conflict.  For each
> +file you edit, you need to tell git that the conflict has been resolved,
> +typically this would be done with
> +
> +
> +    git add <filename>
> +
> +

Do not need nor want two blank lines around these examples; one
each should be enough.

> +After resolving the conflict manually and updating the index with the
> +desired resolution, you can continue the rebasing process with
> ...
> +Alternatively, you can undo the git-rebase with
> +
> +    git rebase --abort

That's already there in the previous paragraph that begins with
"It is possible that a merge failure will prevent this process
from being completely automatic", but I think it makes sense to
present the way you did to make each of them to stand out more.
Perhaps we would want to remove the second and later sentences
from that paragraph.

> +include::merge-strategies.txt[]
> +
> +EXAMPLES
> +--------
> +
> +EXAMPLE 1
> +~~~~~~~~~
> +
> +Suppose you're tracking upstream development and developing a serarate
> +feature that is not yet ready. You branched when upsream's HEAD was at
> +E. You have progressed by 2 commits to (A,B) and working towards
> +finishing commit C*. As the work is taken some time, you decide to
> +update the upstream code in order to make sure you don't diverge too
> +far.
> +
> +However, your work is unfinished and you cannot commit C* yet. We'll
> +use gitlink:git-stash[1] here to assist the workflow:
> +
>  ------------
> +1. git stash               # Save state of branch: the incomplete C*
> +2. git checkout master     # switch to master, where upstream code is
> +3. git pull                # update master to: D-E + F-G (new changes)
> +4. git checkout topic      # return to previous branch
> +5. git rebase master       # change branch from D-E-A-B to D-E-F-G-A-B
> +6. git stash apply         # Bring back previously saved state C*
> +
> +                 A---B---C* [1]          [4,5] A---B [6] ---C*
> +                /                       /
> +    master D---E ........... [2,3] F---G
>  ------------
>  
> +The command at phase 5 `git-rebase master topic` is just a short-hand
> +of `git checkout topic` followed by `git rebase master`. In the end of
> +phase 6, te next commit would make working branch into
> +A--B--C--X--Y--D--E--F:

You don't.  You would make D-E-F-G-A-B-C.

It would be much easier for new users to read if our examples
start from simpler and progress to more complex. It appears that
the use of stash in this example (only because the example
assumes you are in the middle of something that is unfinished)
complicates description without merit.

After the user understands the workflow that starts from having
A-B and with clean working tree, IOW, your steps 2 through 5,
managing the situation where you have that dirty state C* comes
as a very natural extension of what he already knows, and at
that point, it does not matter to your use of stash/unstash what
you do between steps 2-5.  You stash because you are going to do
anything complicated, and the details of that complicated stuff
does not matter why surrounding that sequence with stash/unstash
pair is useful.  In yet another words, the pair of steps 1 and 6
and the rest are orthogonal issues.

So what I would want to see in this example, if you wanted to
talk about the way git-stash can be used in conjunction with
git-rebase, would be something like this:

-- clipcrop -- >8 -- clipcrop --

EXAMPLE 1
~~~~~~~~~

Suppose you're tracking upstream development and developing a serarate
feature that is not yet ready. You started when upsream's HEAD was at
E. You have progressed by 2 commits to (A,B).

Because your work A and B have some interactions to what has
been done at the upstream in the meantime, you decide to update
the upstream code in order to make sure you don't diverge too
far.

------------
1. git checkout master     # switch to master, where upstream code is
2. git pull                # update master to: D-E + F-G (new changes)
3. git checkout topic      # return to previous branch
4. git rebase master       # change branch from D-E-A-B to D-E-F-G-A'-B'

                 A---B [3]            A'--B' [4]
                /                    /
    master D---E [1] ---------- F---G [2]
------------

The command at step 4 `git-rebase master topic` is just a short-hand
of `git checkout topic` followed by `git rebase master`. When
you are done, your topic branch has two commits on top of the
updated master.

Note, that If D and E does not have any interaction with what
your topic are attempting to achieve, there is no reason to
rebase, but some people prefer it because rebasing tends to keep
the history clearer.

If you are in the middle of building some more stuff on top of
B but not committed yet, rebase will refuse to run.  You can use
gitlink:git-stash[1] to help you in such a case.

------------
0. git stash
1...4 (the same as before)
5. git stash apply

                 A---B---C* [0]       A'--B'--C*
                /                    /
    master D---E [1] ---------- F---G [2]
------------

What happens to A, B, D, E, F and G is exactly the same as
before.  The only difference is that your work-in-progress
(depicted as `C*` in the above, the work you did since `B`) is
saved away first, and then reapplied on top of updated `B`.

In short, the above procedure would transform this history
structure:

------------
          A---B---C* topic
         /
    D---E---F---G* master
------------

into this:

------------
                  A'--B'--C' topic
                 /
    D---E---F---G master
------------
