From: bshOriginal <mindplayintricks@gmx.de>
Subject: Re: Git range merge (cherry-pick a range)
Date: Fri, 17 Jul 2009 01:41:37 -0700 (PDT)
Message-ID: <24530703.post@talk.nabble.com>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil> <24512201.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 10:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRj0k-0006wv-U6
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934238AbZGQIlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 04:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934228AbZGQIlk
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:41:40 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40395 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934226AbZGQIli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:41:38 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MRj0b-0003T5-FB
	for git@vger.kernel.org; Fri, 17 Jul 2009 01:41:37 -0700
In-Reply-To: <24512201.post@talk.nabble.com>
X-Nabble-From: mindplayintricks@gmx.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123451>


On Thu, Jul 16, 2009 at 2:44 PM, Michael J Gruber <git@drmicha.warpmail.net>
wrote:

    Babak S. H. venit, vidit, dixit 16.07.2009 14:16:
    >>> Hello Micheal,
    >>> thank you for the response... I will try to answer inline as I
read...
    
    >>>>     Did you use a monospaced font when composing this e-mail? All
graphs
    >>>>     come out disconnect/distorted when reading your e-mail with a
monospaced
    >>>>     font.
    
    
    >>> What a pity. I pasted the text out of the editor (vi | Font: lucida
    >>> console 8) in the web form.
    >>> Anyway I attach my original posting in a file to this email. I hope
you
    >>> can open that undistorted.
    

    >>Yep, it's fine.

    
    >>>>    I assume that above, a is the first additional commit of B1
which
    >>>>    branches off o.


    >>> Correct.
    
   
    >>>>> Commit B:
    >>>>> ---------
    >>>>> FluidSolver::FluidSolver(int argc, char* argv[]) {
    >>>>>     init(argc, argv);
    >>>>>     // test edit 1: a + b
    >>>>> }
    >>>>>
    >>>>> Commit C:
    >>>>> --------
    >>>>> FluidSolver::FluidSolver(int argc, char* argv[]) {
    >>>>>     init(argc, argv);
    >>>>>     // test edit 1: a + b
    >>>>>     // test edit 2: a - b
    >>>>> }
    >>>>>
    >>>>> Commit D:
    >>>>> --------
    >>>>> FluidSolver::FluidSolver(int argc, char* argv[]) {
    >>>>>     init(argc, argv);
    >>>>>     // test edit 1: a + b
    >>>>>     // test edit 2: a - b
    >>>>>     // test edit 3: a * b
    >>>>> }
    >>>>>
    >>>>> Commit E:
    >>>>> --------
    >>>>> FluidSolver::FluidSolver(int argc, char* argv[]) {
    >>>>>     init(argc, argv);
    >>>>>     // test edit 1: a + b
    >>>>>     // test edit 2: a - b
    >>>>>     // test edit 3: a * b
    >>>>>     // test edit 4: a / b
    >>>>> }
    >>>>>
    >>>>>
    >>>>> Range merge (the GIT way):
    >>>>> =========================
    >>>>>
    >>>>> 1) Switch to Branch B1
    >>>>>
    >>>>> 2) Create a temporary branch which does not contain anything
    >>>>>     beyond commit D
    >>>>>
    >>>>>    $ git checkout -b volatileBranch D
    >>>>>
    >>>>>     Master:                o-
    >>>>>                                 \
    >>>>>     Branch B1:              A-B-C-D-E
    >>>>>                                               \
    >>>>>     Branch volatileBranch:              (A)-(B)-(C)-(D)
    >>>>>
    >>>>> 3) Rebase volatile branch to master from commit (B) to master's
HEAD
    >>>>>    git rebase --onto master (A)
    >>>>>
    >>>>>
    >>>>>     Branch volatileBranch:   (B)-(C)-(D)
    >>>>>                                      /
    >>>>>     Master:                      o-
    >>>>>                                      \
    >>>>>     Branch B1:                    A-B-C-D-E
    >>>>>
    >>>>>
    >>>>> Rebasing output:
    >>>>> ----------------
    >>>>>
    >>>>> First, rewinding head to replay your work on top of it...
    >>>>> Applying: test edit 2: a - b
    >>>>> error: patch failed: fluidsolver.cpp:28
    >>>>> error: fluidsolver.cpp: patch does not apply
    >>>>> Using index info to reconstruct a base tree...
    >>>>> Falling back to patching base and 3-way merge...
    >>>>> Auto-merging fluidsolver.cpp
    >>>>> CONFLICT (content): Merge conflict in fluidsolver.cpp
    >>>>> Failed to merge in the changes.
    >>>>> Patch failed at 0001 test edit 2: a - b
    >>>>>
    >>>>>
    >>>>> When you have resolved this problem run "git rebase --continue".
    >>>>> If you would prefer to skip this patch, instead run "git rebase
--skip".
    >>>>> To restore the original branch and stop rebasing run "git rebase
--abort".

    >>>>> Conflicts:
    >>>>> ----------
    >>>>> FluidSolver::FluidSolver(int argc, char* argv[]) {
    >>>>>     init(argc, argv);
    >>>>> <<<<<<< HEAD:fluidsolver.cpp
    >>>>> =======
    >>>>>     // test edit 1: a + b
    >>>>>     // test edit 2: a - b
    >>>>>     >>>>>>>> test edit 2: a - b:fluidsolver.cpp
    >>>>> }
    
    >>>>> After manually resolving the conflict and continuing the rebasing
    >>>>> with git rebase --continue, we are finally finished.
    
    >>>>> Since we only had updates in branch 1, it is astonishing that we
get a
    >>>>> conflict at all.
    >>>>> Same situation works like a charme in subversion.
    
    >>>>     Ahem, how could /anything/ work like a charm in subversion?
(I've been
    >>>>     using it myself.)
   
    >>> Please let's try not to start a belief war. Every version control
    >>> systems has its quirks and we just
    >>> try to figure out what the problem in the above described scenario
is.

    >>Agreed. (Which is why I started the next paragraph with "Seriously,".)

   
    >>>>     Seriously, if, in subversion, you merge -rA:D onto master then
    >>>>     subversion only computes the diff between A and D and applies
it to
    >>>>     master. You an do this in git as well, of course, but that's
not a merge
    >>>>     and does not preserve individual commit messages.
    >>>>

    
    >>> Subversion does preserve individual commit messages.
    >>> Try to pass the --use-merge-history parameter to svn log.
    

    >> I have to admit that I've ever used svn 1.4x. I do belief though that
    >> even 1.5 makes a single commit in that situation and reconstructs the
    >> merge history from the metadata.


> Maybe. But it works and you can additionally inspect diffs between
> revisions.


 
  
    >>>>> We would be happy to get an explanation for this merge bahaviour,
    >>>>> since
    >>>>> many edits in large projects could as a matter of principle result
    >>>>> a lot of merge conflicts which all have to be treated manually.

    >>>>> We believe that GIT's interface for range merges needs to get more
    >>>>> user friendly.
    >>>>> Since steps 1) - 3) use already developed components of GIT, there
    >>>>> should be a layer above 'em
    >>>>> which performs a range merge by internally calling 1) - 3).
    >>>>>
    >>>>> Example: git cherry-pick $from_branch@startCommitHash
    >>>>> $to_branch@endCommitHash

    >>     If I read you graphs correctly you could just as well
fast-forward
    >>     master to D (using reset or merge) and then "rebase -i" in order
to
    >>     remove A.
    >>
    >>     Alternatively, you can use "git format-patch --stdout revrange |
git
    >>     am".
   
    
    > Yes applying a patch is an alternative.
    > But don't you think git needs to provide a more user friendly
interface
    > for range merges?

    >> Sometimes it's only a matter of workflow. Have you tried the
suggestion
    >> above?


Yes, many ways lead to Rome..
Personally, I think most companies and open source coders are currently
bound to subversion
and are keen to start off with a more sophisticated version control system
as e.g. git, mercurial or darcs. As they are already pretty familiar with
subversion,
I think it is clever to follow established and accepted workflows in case
those workflows are really
equivalent. This enhances the acceptability and is a pro for git in a direct
comparison to the
mentioned alternative distributed version control systems.

I tried out the patch alternative and apart from the fact that
one of the patches could not be directly applied and as a result we again
faced the
same merge conflict, everything worked out the way it ought to.


 
    >> In general, in git it's preferable to have merges of feature branches
    >> rather than cherry picks. So you would rebase the feature branch
first
    >> (rebase -i to remove A) and then merge the result to master. Have you
    >> tried whether you get conflicts that way? It's really one rebase -i
and
    >> one merge.




No I must admit that I did not try that one out, but I believe it is pretty
much the same
thing I did. I branched from revision D dropping out revision E.
Then I rebased in a way that everything above revision A was merge relevant
cropping A.
==>    A CROP B - C - D CROP E

 


    > If you want to use a patch approach then "git format-patch|git am" and
    > "git cherry" are your options. Currently, git cherry-pick accepts only
a
    > single commit, but if you want to pick the range B through D that
would
    > be B^..D in git lingo, so

    > git rev-list --reverse --topo-order B^..D | while read rev
    > do
    >   git cherry-pick $rev || break
    > done



The above lines look correct to me.
But again, if git really wants to be the next king version control system,
it has
to be more user friendly. You and me are comfortable with the command line.
There are a lot of GUI users though, that are overstrained with all that.
I hope git implements a few more top level functions to simplify specific
operations
as it seems to be a really nice VCS.

Have a nicce day.

Babak Sayyid Hosseini


 


    > should do the job (untested!).

    > Cheers,
    > Michael




-- 
Regards.

Babak Sayyid Hosseini
-- 
View this message in context: http://www.nabble.com/cherry-pick---since---tp10105685p24530703.html
Sent from the git mailing list archive at Nabble.com.
