From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Tue, 02 Feb 2016 20:34:31 -0600
Message-ID: <87egcu5xoo.fsf@waller.obbligato.org>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
	<xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
	<87twmbaizo.fsf@waller.obbligato.org> <569EE046.9040506@semantics.de>
	<871t9cvqsp.fsf@waller.obbligato.org> <56A4CC85.90705@semantics.de>
	<87fuxil8cw.fsf@waller.obbligato.org> <56A993D7.3000107@semantics.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: Marcus Brinkmann <m.brinkmann@semantics.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 03:34:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQnHJ-0000Jh-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 03:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbcBCCem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 21:34:42 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:42477 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754965AbcBCCek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 21:34:40 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aQnJE-0005G2-2J; Tue, 02 Feb 2016 20:36:44 -0600
In-Reply-To: <56A993D7.3000107@semantics.de> (Marcus Brinkmann's message of
	"Thu, 28 Jan 2016 05:06:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Marcus Brinkmann <m.brinkmann@semantics.de> writes: >> Are
    you still able to do a re-roll on this? > > I have to admit that my interest
    has declined steeply since > discovering that subtree-split and filter-branch
    --subtree-filter give > different results from "git svn" on the subdirectory.
    The reason is > that git-svn includes all commits for revisions that regular
    "svn log" > gives on that directory, which includes commits that serve as
    branch > points only or that are empty except for unhandled properties. [...]
 Content analysis details:  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285325>

Marcus Brinkmann <m.brinkmann@semantics.de> writes:

>> Are you still able to do a re-roll on this?
>
> I have to admit that my interest has declined steeply since
> discovering that subtree-split and filter-branch --subtree-filter give
> different results from "git svn" on the subdirectory.  The reason is
> that git-svn includes all commits for revisions that regular "svn log"
> gives on that directory, which includes commits that serve as branch
> points only or that are empty except for unhandled properties.

What do you mean by "branch points only?"

It's ok if you can't do a reroll.  I can't work on it right now but
perhaps when I get back to cleaning up the split code I can take what
you have and incoporate it.  I do very much appreciate your work on
this!

> While empty commits for unhandled properties wouldn't be fatal,
> missing branch points make "git svn" really unhappy when asked to
> rebuild .git/svn.

[ I may have misunderstood your intent, see below. ]

I just want to make sure I understand your situation.  You used git-svn
to mirror a project to git and then used git-subtree to incorporate that
mirror into a larger project?

Why is the split being done?  If there's an active Subversion repository
being mirrors it's much better to commit changes back to the Subversion
repository than to the git mirror.

> As migration from SVN is my main motivation at this point to use a
> subtree filter at this point (git-svn is just very slow - about one
> week on our repository), I am somewhat stuck and back to using
> git-svn. Although hacking up something with filter-branch seems like a
> remote option, it's probably nothing that generalizes.

Ok, maybe I misunderstood your situation.  Are you converting one big
repository via git-svn and then trying to break out individual
directories into smaller projects?

git-svn + git-subtree/git-filter-branch is not the best way to do that.
svn-all-fast-export is far superior for a one-off conversion and makes
splitting repositories a breeze.  It happens during conversion rather
than as a post-processing step.

https://techbase.kde.org/Projects/MoveToGit/UsingSvn2Git

> It didn't help that "make test" in contrib/subtree gives me 27 out of
> 29 failed tests (with no indication how to figure out what exactly
> failed).

Huh.  I don't know why that would happen.  Did you build the git tools
first?  A testing run using --debug and --verbose (see the Makefile in
contrib/subtree/t) would be informative.  I understand if you don't have
time to do that.  I haven't seen such failures before so I'm curious as
to what happened.

                      -David
