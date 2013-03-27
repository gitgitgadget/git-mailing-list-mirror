From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 17:48:45 -0500
Message-ID: <20130327174845.5e3081d1@hoelz.ro>
References: <20130327122216.5de0c336@hoelz.ro>
	<20130327182345.GD28148@google.com>
	<20130327211554.GH28148@google.com>
	<7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKz9g-0004F9-68
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab3C0Wss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:48:48 -0400
Received: from hoelz.ro ([66.228.44.67]:40320 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297Ab3C0Wss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:48:48 -0400
Received: from localhost.localdomain (108-234-129-20.lightspeed.milwwi.sbcglobal.net [108.234.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id 231F7280F3;
	Wed, 27 Mar 2013 18:48:47 -0400 (EDT)
In-Reply-To: <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219347>

On Wed, 27 Mar 2013 15:07:18 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Sorry, typo.  The configuration in the example above should have
> > been
> >
> > 	[url "git://anongit.myserver.example.com/"]
> > 		insteadOf = myserver.example.com:
> > 	[url "myserver.example.com:"]
> > 		pushInsteadOf = myserver.example.com:
> >
> > In other words, suppose I set url.*.insteadof to point to a faster
> > address for fetching alongside url.*.pushinsteadof requesting that
> > the original address should still be used for pushing.
> 
> I didn't know we were even shooting for supporting the identity
> mapping:
> 
> 	url.X.pushinsteadof=X
> 
> but that would certainly be nice.
> 
> By the way, it seems that the original commit 1c2eafb89bca (Add
> url.<base>.pushInsteadOf: URL rewriting for push only, 2009-09-07)
> wanted to explicitly avoid use of pushInsteadOf aliasing for a
> pushURL and it is also documented in config.txt from day one.
> 
> I think the intent is "You have a normal URL, and a way to override
> it explicitly with pushURL, or a way to rewrite it via the aliasing
> the normal URL with pushInsteadOf. Either one or the other, but not
> both, as having many levels of indirection would be confusing."
> 
> Which I can understand and sympathise.
> 
> In anay case, the change proposed in this thread seems to change
> that, so the documentation would need to be updated.  Also the tests
> the original commit adds explicitly checks that pushInsteadOf is
> ignored, which may have to be updated (unless that test is already
> broken).
> 

My use case is that I use Github for my personal development.  I have a
prefix for my personal repos (hoelzro: -> git://github.com/hoelzro for
fetch, git@github.com:hoelzro/ for push) and one for all other Git repos
(github: -> git://github.com/)  I have a few projects where I work in a
fork, but I want to fetch updates from the original project.  So my url
for the origin remote is github:org/project, but my pushurl is
hoelzro:project.  This behavior in Git currently doesn't allow me to
work that way.  I used to work with two remotes; origin for my repo and
base for the official one, but I've found that I prefer this other way.

The test that checked that pushInsteadOf + pushurl shouldn't work as I
expect was actually broken; I have removed it, updated the
documentation, and sent a new patch to the list.

-Rob
