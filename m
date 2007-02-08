From: Bill Lear <rael@zopyra.com>
Subject: Git rescue mission
Date: Wed, 7 Feb 2007 18:18:35 -0600
Message-ID: <17866.27739.701406.722074@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 01:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwzw-00076Z-0a
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbXBHASp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbXBHASp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:18:45 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60080 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422823AbXBHASo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:18:44 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l180Iik14392;
	Wed, 7 Feb 2007 18:18:44 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39015>

A perfect example of the sort of trouble I'm having with git just
happened again.

I have a public bare repo on my machine that I have cloned to make a
private repo.  I just want to sync my branches on my public and
private repos.  I do not want to merge across branches, I just want to
"sync".

So, here's what I did.

In my private repo:

%  cat .git/remotes/origin
URL: /repos/git/project
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/topic:refs/heads/topic

And this is the sequence of unfortunate events:

Starting on topic branch:

% git commit -a -m "Fix spacing rules"
% git checkout master
% git pull
[Won't pull non-fast-forward on my topic, so I try to get that synced.]
% git checkout topic
% git push
[ok, fine, seems good.]
[Now, instead of remembering to move back to master, I do this:]
% git pull
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
[AAAAGH!]
Merging HEAD with 37e229835103a11365b1e081f9b9987a88437e62
Merging:
e298e7f Skip rails in user nets
37e2298 Typofixen.
[NO NO NO!  This is not what I want!]
found 1 common ancestor(s):
a2ba736 Try #2: Fixed (mostly harmless) bugs in handling of time variable.
Auto-merging src/ast/tstD.cc
Auto-merging src/meth/XMLImporter.cc
Auto-merging src/meth/XMLImporter.hh
Auto-merging src/meth/tstXMLI.cc
merge: warning: conflicts during merge
CONFLICT (content): Merge conflict in src/meth/tstXMLF.cc
Auto-merging src/nat/MacroFanLoader.cc
Auto-merging src/nat/VPE.cc
Auto-merging src/nat/PnDef.cc
Auto-merging src/nat/VLExporter.hh
Auto-merging src/nat/tstMod.cc
Automatic merge failed; fix conflicts and then commit the result.

Ok, now I'm hosed.  Putting aside WHY git would do this to me (yes, I
know the answer is that I asked for it), on my topic branch I now have
tons of files listed when I do git status.  git diff shows tons of
stuff I don't want in my branch.

So, I edit the file and "fix" the merge conflict, then realize that
this is probably not what I want to do at all.

So, 1) how do I get back to the status quo ante?  I have about 30 files
listed as "Updated but not checked in", then this:

# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       unmerged:   src/methodic/tstXMLI.cc
#       modified:   src/methodic/tstXMLI.cc

which I don't want, as I just want them to go away...

2) Why does git pull do the right thing when on master, but seemingly
changes behavior when on topic?  I mean, the origin file seems to say
update topic from topic.  It says nothing about updating topic from
master, which is what seems to have happened.  When on master I get my
desired "sync" behavior, but when on topic, it merges cross-branch...


Bill
