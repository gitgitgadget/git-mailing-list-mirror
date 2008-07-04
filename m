From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cherry picking instead of merges.
Date: Fri, 4 Jul 2008 09:47:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807040939150.2815@woody.linux-foundation.org>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org> <20080703223949.GA23092@old.davidb.org> <20080704001003.GA19053@atjola.homenet> <20080704044032.GA4445@old.davidb.org>
 <alpine.LFD.1.10.0807032221190.2815@woody.linux-foundation.org> <486DC4F2.70608@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brown <git@davidb.org>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 18:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEoT0-0004Cd-3z
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 18:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbYGDQsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 12:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757239AbYGDQsD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 12:48:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51413 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756416AbYGDQsB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jul 2008 12:48:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m64Glong021546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Jul 2008 09:47:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m64Glndh008513;
	Fri, 4 Jul 2008 09:47:50 -0700
In-Reply-To: <486DC4F2.70608@viscovery.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.365 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87403>



On Fri, 4 Jul 2008, Johannes Sixt wrote:
> 
> FWIW, the same thing in different words is written in section
> 
> "Why bisecting merge commits can be harder than bisecting linear history"
> 
> of Documentation/user-manual.txt.

I don't think that's the same thign at all.

That section basically says "just keep things linear". Which I very much 
disagree with. Trying to keep things linear just doesn't work if you work 
together with other people - since you have to rewrite history.

So my argument was the exact _reverse_. Don't try to keep things linear, 
because it doesn't _work_ right. Do the merges. They will very seldom 
cause subtle merge problems (non-subtle ones are much more common, but 
trivial to handle), and they will mean that you can work effectively 
togethr with other people.

And then, _if_ you have a merge that you really cannot figure out why it 
breaks, at that point you can _temporarily_ linearize the git history 
after-the-fact just as easily as you would ever have done before-the-fact.

In other words: linearization throws away real and useful information. You 
can always linearize afterwards for bisection purposes or whatever, but 
you can never _un_linearize because you've thrown away the information.

So it's much better to just do merges and keep the history, and then there 
are ways to rewrite the history later if you really need it.

That said - I think it's good practice and perfectly sane to do things 
like git-rebase to rewrite the history in a _private_ tree that contains 
only your own modifications and has never been public (where "applied 
emailed patches from others" still counts as your own work).

The "don't linearize" mantra really only is about commits that have ever 
been in anybody elses repository (and whether they _came_ from there, or 
whether they came from you but were public to others is immaterial).

			Linus
