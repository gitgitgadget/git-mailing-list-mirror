From: Ximin Luo <xl269@cam.ac.uk>
Subject: [git-svn] [FEATURE-REQ] track merges from git
Date: Wed, 26 Aug 2009 17:42:21 +0100
Message-ID: <4A9565ED.4010608@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 19:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgLu0-0003V1-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 19:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbZHZRDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 13:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbZHZRDF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 13:03:05 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:43147 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbZHZRDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 13:03:04 -0400
X-Greylist: delayed 1322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2009 13:03:03 EDT
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from 94-192-233-202.zone6.bethere.co.uk ([94.192.233.202]:58543 helo=[192.168.1.64])
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:587)
	with esmtpsa (PLAIN:xl269) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1MgLYU-0002ZI-0V (Exim 4.70) for git@vger.kernel.org
	(return-path <xl269@cam.ac.uk>); Wed, 26 Aug 2009 17:41:02 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127107>

Hi,

I'm have 2 separate svn projects from googlecode imported into a single git
repo. One is a semi-fork of the other, so I thought I'd be able to use git's
merge feature to repeatedly merge from the mother project (and possibly vice
versa too).

However, this doesn't happen. I "git pull" and this works fine, but when I "git
svn dcommit" back into svn, this rewrites my git history and it loses track of
the merge (and next time I try to pull, the same conflicts appear).

For now I just have a .git/info/grafts, but this doesn't get exported anywhere,
so if other people "git svn clone" from svn, or "git clone" from my git repo,
they don't get the merge information.

It would be nice if git-svn saved the merge info somewhere instead of getting
rid of it. #git tells me this is impossible at the moment, hence the mail.
Relevant parts of the convo are pasted below.

I understand if this is a low priority, but I don't think it would be a major
PITA to implement (some suggestions are listed in the convo log). And it'd be
useful for people converting from svn to git.

Thanks for your time.

X

P.S. please don't troll me.

(17:13:10) The topic for #git is: 1.6.4.1 | Homepage: http://git-scm.com |
Everyone asleep or clueless? Try git@vger.kernel.org | Git User's Survey 2009!
http://tinyurl.com/GitSurvey2009 | Channel log http://tinyurl.com/gitlog |
Mailing list archives: http://tinyurl.com/gitml | Gits on git:
http://tinyurl.com/gittalks | Pastebin: http://gist.github.com/ | GSoC '09:
http://socghop.appspot.com/org/home/google/gsoc2009/git
(17:13:14) infinity0: hi
(17:13:21) infinity0: i've used git-svn to import two svn repo
(17:13:23) infinity0: repos*
(17:13:28) infinity0: and used git to merge the two
(17:13:45) infinity0: the problem is, when i git-svn dcommit back to svn,
git-svn rewrites my git history
(17:13:50) infinity0: and loses the merge i just did
(17:14:01) offby1: infinity0: of course
(17:14:04) infinity0: how do i get it to retain knowledge of the merge?
(17:14:11) offby1: infinity0: you don't.  Next questions.
(17:14:16) infinity0: why not?
(17:14:29) offby1: svn is incapable of storing a merge, at least in the sense
that we git people use the term "merge"
(17:14:46) Grum: you should be able to store the result of a merge as a commit
(17:14:51) offby1: sure
(17:14:57) infinity0: sure, but why does git-svn have to rewrite my *git*
history to remove knowledge of the merge?
(17:15:02) offby1: but not as a "merge commit", whatever that might mean in svn
(17:15:35) Grum: because it has to be representative of the svn repo after you
dcommit there obviously
(17:15:42) offby1: infinity0: it's trying to mirror the svn repository in your
git repository.  I assume the original, un-rewritten commits are still in your
git repository; they're just not pointed at by any branch.  Poke around in the
reflog; I imagine you'll find 'em in there
(17:16:09) infinity0: ok, but that's not useful if they're dangling
(17:16:26) infinity0: it's trying to mirror the svn repo yes... but as you
said, svn doesn't know about merges
(17:16:26) ***offby1 idly wonders if it'd be possible for git svn to indeed
store merge commits, by applying the appropriate svn:mergeinfo properties
(17:16:40) infinity0: i read a thread where it says those are different things
(17:16:41) offby1: infinity0: I suspect you're using git svn for something for
which it wasn't designed.
(17:17:17) infinity0: would it be possible, in theory, to have git-svn store
the git merge information in eg. the same way it stores the git-svn tag in the
svn commit message
(17:17:33) Grum: then just use svn?
(17:17:37) Grum: and a postit?
(17:18:01) infinity0: i'm trying to link two separate svn repos together via git
(17:18:17) Grum: and that is just what offby1 said
(17:18:30) infinity0: "what" is
(17:18:40) Grum: I suspect you're using git svn for something for which it
wasn't designed.
(17:18:42) infinity0: as you all are saying, git merges and svn "merges" are
different things
(17:18:58) infinity0: ok, but it would be possible to make git-svn have this
functionality? or not
(17:18:59) offby1: certainly
(17:19:16) offby1: I fear not, since Eric Wong seems like a smart fella; if it
were doable, I suspect he'd have done it already.
(17:19:21) offby1: But then ... who knows, maybe he's busy.
(17:20:07) infinity0: well afaic it would just involve adding some extra
git-svn info to the svn commit messages, but meh
(17:20:10) infinity0: i'll go file a bug
(17:21:14) offby1: infinity0: if it were me, I'd shy away from cramming more
junk into the svn commit messages; that strikes me as an unreliable storage medium
(17:21:22) offby1: I'd use properties instead
(17:21:24) Grum: ok lets do this properly
(17:21:31) Grum: why do you want to 'merge' 2 svn 'repos' this way?
(17:21:34) Grum: as you are not actually merging them
(17:21:45) offby1: Grum: go, man, go!
(17:21:58) infinity0: what do you mean "not actually merging them"
(17:22:17) infinity0: they are "actually merged" in git
(17:22:24) infinity0: then i git-svn dcommit and they become unmerged again
(17:22:34) Grum: why do you want to merge them?
(17:22:42) infinity0: so i can grab changes from one into the other
(17:22:42) Grum: and what is your goal with dcommitting this?
(17:22:57) infinity0: long story short, the two projects use svn on google code
(17:23:06) infinity0: one is a semi-fork of the other
(17:23:10) offby1: aaahhh
(17:23:13) infinity0: i need to pull changes quite often
(17:23:17) offby1: and you want to keep them in sync, kinda
(17:23:19) infinity0: yeah
(17:23:28) offby1: yeesh, dunno how I'd do that
(17:24:09) infinity0: ok well i guess the only thing i can do atm is file a bug
for git-svn and tell people to manually add the .git/info/grafts
(17:24:12) infinity0: but thanks for your info
(17:27:24) infinity0: uh, where is the git bug tracker
(17:27:40) Grum: its the mailinglist =)
(17:27:41) sitaram: no bugs, so no tracker
(17:27:44) sitaram: :
(17:27:45) sitaram: :D
(17:27:51) infinity0: lol
(17:27:59) Grum: and erm you want a feature, its nt a bug you are reporting
(17:27:59) Grum: s
(17:28:00) infinity0: ok i'll post on the mailing list then.. *grumble*
(17:28:08) infinity0: ok, *feature request :p
(17:28:08) Grum: you are not using the tool for what it is meant to
(17:28:13) Grum: and you can still do waht you want in either case
(17:28:17) Grum: just not by merging
(17:28:22) infinity0: well, how then?
(17:29:48) infinity0: aww fuck 120 messages a day? oh come on... are
non-members allowed to post to it?
(17:30:00) Grum: infinity0: just 120 yeah, and yeah they are
(17:30:06) infinity0: ah ok
