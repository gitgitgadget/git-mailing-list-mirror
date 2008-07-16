From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 13:53:44 -0400
Message-ID: <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:54:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBDB-0001zr-FK
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 19:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYGPRxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 13:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYGPRxq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 13:53:46 -0400
Received: from hs-out-0708.google.com ([64.233.178.248]:6168 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbYGPRxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 13:53:45 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1501862hsl.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8rZvxqW4/s/MjYHHxlTe4TkB79DVNqb4lfOoj5t8Q+8=;
        b=cvujuTPdKSIsZONnQnvp9g7HM3wLz6JS1xc6KNteDY3CU6lsYnV8bsgEkUQKDzqpbd
         oDkgkktoyKCGb0pAGYQKmEDIvLUs52JsL3DZpn+3pbAbYRe2mQ5AMdmcB10VPaIFURyf
         m919y0F4knfhs38YmFlWOQEfSSvi/PDv6DH9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SEh4TN99n94kh13Gf2rBBFNAdE6C6XYjIzqWUX0Xnc8+hJjjpuwJH8S/2FNo17CAvv
         CPIYWA6i0g879m27tVB6KJZuv1MS9bZP7cynxOjdu1UlOfWLW4ylJmIGJ9IzVrCxcDXf
         fCH4ZTIXnbNZjWcwhE0PPcR41+ccCgaaDwtLE=
Received: by 10.100.57.6 with SMTP id f6mr2518665ana.58.1216230824139;
        Wed, 16 Jul 2008 10:53:44 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 10:53:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88700>

On 7/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  Am I the only one who deems teaching plumbing to users ("I like it raw!
>  So I teach it the same way!") harmful?

I believe the only way you can get away with such a simple learning
sequence is if your workflow is as simple as that you seem to
describe: everyone has push access to the central 'master'.

That works (and mostly just as well as any other "supposedly easy"
VCS, like svn), but because git's power is so tempting, almost
nobody's real-life repository actually works like that.

At the very least, there will be branches.  And where there are
branches, there's merging.  And with merging comes merge conflicts.
And with merge conflicts comes the crazy (yes, very useful, but still
crazy) conflicted index features.  And so you suddenly need to find
out about things like

       git diff :{1,3}:path/to/filename

Which is a great command, but svn definitely makes it easier to do the
same thing.

Even if you have a repo with widespread push access, git's log looks
annoying compared to svn because of all the merge commits.  That's a
primary reason why rebase was invented, of course.   But teaching
people about rebase vs. merge is highly nontrivial.  "git pull
--rebase" helps a little, but it's still nontrivial, particularly when
local patch #3 of 5 has a conflict.

Also, inevitably, someone will ask "what happened to those simple svn
revision numbers?" or "when I do a merge, why are the patches from
branch #1 interspersed with the ones from branch #2 in git log?"  The
answers are "look at gitk to see the real merge history, that's way
more powerful than svn, and check out git-bisect!" and "use git log
--topo-order" respectively, but those are pretty nontrivial answers
too.

Submodules, which are critical to large-scale software development,
are also very complicated.  You can't explain how to use them without
knowing about .git/config, the difference between that and
.gitmodules, the concept of gitlinks (and therefore the concepts of
trees and blobs), the idea of a "disconnected HEAD" (which all
submodules check out by default), the idea that pushing submodules in
the wrong order can create references to non-existing commitids, and
so on.  In contrast, the lame svn:externals mechanism is far easier to
explain.

The "problem" with learning git is that it's so powerful.  A person
can feel like they've "learned all the svn there is to learn" in a
couple of days, because it really doesn't do all that much.  But with
git, if you want to make it *appear* simple, you have to artificially
restrict what you tell people, and because the git *developers* don't
work using that restricted subset of commands, the abstraction always
leaks.

Example: "git remote" didn't originally even have an "rm" subcommand.
Why?  Because real git developers knew they could delete a remote by
editing .git/config, and it never even occurred to anyone to do it any
other way.  I still do it by editing the file, because the file is in
a nice format and it's still easier than typing "git remote".

The svn developers have the same annoyingly small subset of commands
that their users do.  It means svn is much less powerful, but it also
means that subset is actually enough to somehow handle *all* the tasks
a user will run into.  After all, there's no other way.

That said, it's debatable if all this is actually a problem.  If I
wanted simple-minded, I'd use svn.  Ironically, the plumbing is the
only part of git that isn't supposed to ever change, so it's the most
valuable knowledge to have. Why *not* teach it?

Have fun,

Avery
