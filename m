From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 16:41:59 -0000
Message-ID: <22283.5020781078$1214329638@news.gmane.org>
References: <U-ySqQANiPRpld4kgzdXbovGgsj6LfOEdRmtTDU2yyvITSG3LnZAsQ@cipher.nrlssc.navy.mil>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5uqS9FEDjCcuF>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCbh-00070M-S3
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbYFXRqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbYFXRqH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:46:07 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60205 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752998AbYFXRqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:46:06 -0400
Received: (qmail 15963 invoked by uid 90); 24 Jun 2008 17:46:02 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 16:41:59 -0000
In-Reply-To: <U-ySqQANiPRpld4kgzdXbovGgsj6LfOEdRmtTDU2yyvITSG3LnZAsQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86097>


My takeaways from this thread:

- THANKS! to all of you for the detailed discussion, and for making git. Even
though it's still unfamiliar to me, I really enjoy (g)it!

- I don't think anyone here thinks git is beyond improvement. This discussion
did change my mind on a few things since my original post. I started this
discussion to share my "unacclimated usability suggestions", because after I
acclimate to git, I'll be telling new users that these idiosyncrasies are all
no big deal too.  :) I still think there is value in this list of suggestions.
I'll work on submitting patches...

- improve the man page description of "reset --hard" (see below)
- standardize all the potentially destructive operations (after gc) on "-f /
--force" to override
- add "checkout" to the git-gui history right-click menu, and make the danger
of
"reset --hard" more obvious and require a confirmation dialog (the gui
equivilant of -f)


----------

a couple more specific responses below..


-- Rogan Dawes wrote:
> -- David wrote:
> > Let me guess, you're always running euid==0. :)
> Do you also ask the gnu coreutils folks to remove the -f option from their
utilities?

-- Johannes Gilger wrote:
> I think the name of the command "reset" itself is a name which should
> prompt everyone to read a manpage before using it. [snip ]
> Nobody complains about rm --force or anything.

Isn't it nice that they standardized on "-f" and "--force" across ALL commands?

I would be inclined to talk to coreutils if it was "rm -f", "cp -R" (vs cp -r),
and "mv --aggressive" to do the respective non-safe versions.

It would simplify git's command-line-ui and cognitive load if it did the same
thing. Pick one standard for "overriding dangerous commands", instead of
"danger caps" and "danger --reset" and "danger -f". Consider branch which has
both "branch -[MD]" and "branch -f" in the same subcommand. What's wrong with
"branch -[md] -f"?

Of course --hard encourages one to read the manpage. However, git is using a
bunch of new terms for things, and uses at least those three different methods
to indicate command danger. Lets look at the working on the manpage:

"Matches the working tree and index to that of the tree being
switched
to. Any changes to tracked files in the working tree since <commit>
are lost."

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I interpreted this as "any [non committed changes] to tracked files in the
working tree since <commit> are lost."  I don't this this was a naive
interpretation. I still think that's the way it reads after this whole
conversation.

I'll work on my first patch for git:

-> "References to any working tree changes, and pulled changes, AND COMMITTED
CHANGES to tracked files in the branch after <commit> will be dropped, causing
them to be removed at the next garbage collect.".

-- Brandon Casey wrote:
> After saying all of that, here is how I think you _should_ have done things.
> Notice I _did_not_ use 'reset --hard'.

I was told that I can safely do "git checkout origin/master" instead of "reset
--hard" to get back to the pull point, in case I didn't branch ahead of time.
The wrinkle being that my "master" branch-pointer still points to my local
changes, so I need to move onto a different branchname before I push if I want
to avoid those changes going to the server, which is fine..

> git clone <master_repo>
> cd master_repo
> git checkout -b feature1 # we create our feature branch immediately since
> # creating branches is so effortless in git. A
> # private feature branch should _always_ be created
> # and used for development.

I'm beginning to see why I would always work this way, though if "private
feature branches should always be created and used for development", then I'm
unclear about why this isn't the default. git could implicitly create them when
I checkin a change on the head of a pulled branch. (i.e. user/branchname/id, or
something else). I'm reaching here, I'll need to use git more with other
developers to understand this better.

-------------------
Thanks again for all the detailed responses and explanations!

- David
