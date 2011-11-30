From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 17:58:13 -0500
Message-ID: <20111130225813.GA11544@arf.padd.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org>
 <4ED6809A.9020703@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Nov 30 23:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVt6c-0000wu-OM
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 23:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1K3W6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 17:58:18 -0500
Received: from honk.padd.com ([74.3.171.149]:38583 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab1K3W6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 17:58:17 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id D1B7F31BF;
	Wed, 30 Nov 2011 14:58:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B19A03196F; Wed, 30 Nov 2011 17:58:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4ED6809A.9020703@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186143>

luke@diamand.org wrote on Wed, 30 Nov 2011 19:14 +0000:
> On 30/11/11 14:55, Vitor Antunes wrote:
> >Luke Diamand<luke<at>  diamand.org>  writes:
> >
> >>In adding the test case for labels I also found and fixed a few other
> >>small bugs in the label handling:
> >>
> >>  - labels missing a description or "EOT" in their text cause problems;
> >>  - labels without an owner cause problems.
> >>
> >>I also noticed, but did not fix, that you can't have more than one label
> >>per commit (the others are silently dropped) and the documentation for
> >>branch import could be improved. I've added a (failing) test case for
> >>the multiple label problem.

I was hanging onto your v1, and made a comment on the v1's 3/4
that perhaps you missed.  Also acked the entire thing.  I can
resend if my mailer ate it.

Don't expect Junio to pick it up until after 1.7.8 goes out.

> >Hi Luke,
> >
> >Seeing that you have some experience using labels, could I kindly ask you to
> >include some description of it in git-p4.txt?
> 
> OK, if you can help me understand what's going on...
> 
> The label-detection bug that I've described, on further
> investigation, looks to be a fundamental limitation.
> 
> With perforce, I can check out the head revision, and then tag just
> a single file. If I then check out on that tag, I get just that one
> file.
> 
> I think I can't do that with git; certainly fast-import can't do it.

This is another fundamental disconnect between p4 and git.
Reading

http://www.perforce.com/perforce/doc.current/manuals/p4guide/07_labels.html

it is clear that labels are supposed to be used exactly where
tags cannot:  to specify a collection of files as they existed
at _different_ points in the commit history.

Thus I think supporting labels is kind of pointless.  But in the
restricted use case that perforce docs tell us not to do, namely
using labels to identify change numbers, git can reflect that
with tags.

> So the code in git-p4 that is checking the file vs label counts
> (git-p4 around line 1496) is actually trying to say "this label
> can't be imported into git".
> 
> If my understanding is correct, I can then fix my test and update
> the docs and the code to explain this.

Yeah.  It's just a big restriction on how labels get imported.
A better error message and some docs would be useful.

> As an aside, git-p4.txt currently has quite good information on the
> config variables, but nothing on the command line variables.
> Possibly that should be fixed.

Recently, I wrote an asciidoc-style document for git-p4, and
tried to find all the options on all the commands.  There's a lot
more than I ever knew about.  :)  I'll take another pass
through it then send it out for review.  Maybe we can get rid
of the old git-p4.txt then and work on improving a more
structured document.

		-- Pete
