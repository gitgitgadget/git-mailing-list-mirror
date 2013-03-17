From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] remote.<name>.pushurl does not consider aliases when
 pushing
Date: Sun, 17 Mar 2013 23:47:05 +0100
Message-ID: <20130317234705.654fc987@hoelz.ro>
References: <20130317224002.366f54f7@hoelz.ro>
	<7vppyxptbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, josh@joshtriplett.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 23:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHMMb-0007JG-N0
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 23:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673Ab3CQWrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 18:47:11 -0400
Received: from hoelz.ro ([66.228.44.67]:53563 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576Ab3CQWrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 18:47:10 -0400
Received: from localhost.localdomain (g95115.upc-g.chello.nl [80.57.95.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id BFBE8280F2;
	Sun, 17 Mar 2013 18:47:08 -0400 (EDT)
In-Reply-To: <7vppyxptbr.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218382>

On Sun, 17 Mar 2013 15:14:32 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Rob Hoelz <rob@hoelz.ro> writes:
> 
> > Hi everyone!  I found a bug in Git today and wrote up a fix; I did
> > my best to conform to the rules layed out in
> > Documentation/SubmittingPatches, but please let me know if I need
> > to change anything to get my work merged. =)  I have CC'ed Josh
> > Triplet, as he was the last one to touch the line I modified.  I
> > hope my commit messages explain the problem I encountered well
> > enough; if not, I can always go back and amend them.
> >
> > Patches follow.
> >
> > -Rob
> 
> 
> Please read Documentation/SubmittingPatches and follow it.  The
> above is most likely to be the cover letter of a two-patch series
> (meaning you will be sending three pieces of e-mail messages), or
> perhaps out of band comment below the three-dash line of a single
> patch (you will send only one piece of e-mail message).
> 
> See recent patches on the list from list regulars for good examples,
> e.g.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/218350
>     http://thread.gmane.org/gmane.comp.version-control.git/218177/focus=218361
> 
> > From 5007b11e86c0835807632cb41e6cfa75ce9a1aa1 Mon Sep 17 00:00:00
> > 2001 From: Rob Hoelz <rob@hoelz.ro>
> > Date: Sun, 17 Mar 2013 21:49:20 +0100
> > Subject: [PATCH 1/2] Add test for pushInsteadOf + pushurl
> >
> > git push currently doesn't consider pushInsteadOf when
> > using pushurl; this test tests that.
> >
> > Signed-off-by: Rob Hoelz <rob@hoelz.ro>
> > ---
> >  t/t5500-push-pushurl.sh | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 t/t5500-push-pushurl.sh
> 
> The number 5500 is already taken.  Please do not add a duplicate.
> 
> I also wonder if we need to waste a new test number for this;
> perhaps adding new tests to 5516 that already tests insteadOf might
> be a better fit, but I didn't carefully read it.
> 
> > diff --git a/t/t5500-push-pushurl.sh b/t/t5500-push-pushurl.sh
> > new file mode 100644
> 
> Test scripts are supposed to be executable.
> 
> > +test_expect_success 'test commit and push' '
> > +	test_commit one &&
> > +	git push origin master:master
> > +'
> > +
> > +test_expect_success 'check for commits in rw repo' '
> > +	cd ../rw/repo &&
> > +	git log --pretty=oneline | grep -q .
> > +'
> 
> Are both expected to succeed in patch 1/2 without any code change?
> 
> If you were doing a large code change, it is a good series structure
> to have tests first that are marked as "expect_failure" in an early
> patch, and then in a later patch that changes the code to fix it,
> update the tests that start to pass to "expect_success".
> 
> I personally do not think you need such a two-step approach for
> something small like this; instead you can just have a single patch
> that adds a set of tests that expect success and code change.
> 
> Thanks.
> 

Thanks for the feeback; another reply with the new patch follows.
