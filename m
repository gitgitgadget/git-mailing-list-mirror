From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history
 simplification with paths
Date: Sun, 10 Aug 2008 15:16:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808101507510.3462@nehalem.linux-foundation.org>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch> <7vabfk3cge.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808101226130.3462@nehalem.linux-foundation.org> <7v63q8353m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:18:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJEl-0006UH-MZ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYHJWRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbYHJWRE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:17:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42702 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258AbYHJWRD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2008 18:17:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7AMGinn032538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Aug 2008 15:16:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7AMGhhN002285;
	Sun, 10 Aug 2008 15:16:44 -0700
In-Reply-To: <7v63q8353m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.909 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91891>



On Sun, 10 Aug 2008, Junio C Hamano wrote:
> 
> Oh, I was not talking about revs.print_parents part, but about
> revs.rewrite_parents part.  What got Thomas puzzled about was exactly how
> the set of commits _shown_ are different with and without --parents, which
> sets both of these internal flags.  Your "pointless" argument applies to
> "print_parents" part, but "rewrite_parents" affects the resulting set.

Umm. Since --parents sets both, I don't see the point of that statement.

The fact is, --parents makes us show parenthood. That means that we need 
the merges to show up, otherwise the parenthood is meaningless.

So without "--parents", there is absolutely no point in showing the merges 
that don't have any other reason to be shown. And _with_ --parents, we 
need to show them because they matter for parenthood.

What's so confusing or hard to understand?

And yes, we now have split that "parents" flag into two separate flags 
internally, but that has absolutely _zero_ meaning for "--parents" itself, 
and it is totally irrelevant and meaningless to bring up that internal 
implementation issue and mentioning "print_parents" and "rewrite_parents". 

They are immaterial to the actual argument, and the split-up happened 
because of the "--graph" flag, where we actually *do* show parents too, 
but we show them through the graph, not by printing the SHA1 of the 
parent. So the reason "rewrite_parents" is the one that affects the set of 
commits that get output is a small _internal_ implementation detail, and I 
really don't see what it has to do with anything at all.

So the fact is:

 - "rewrite_parents" is the flag that says that we are interested in 
   parenthood and keeping the graph consistent and dense.

   This very much implies showing merges that would otherwise not be 
   relevant.

 - "print_parents" is just a flag whether we should print the parent SHA1 
   or not. Nothing less, nothing more.

   This one has absolutely no relevance to whether a merge should be shown 
   or not, since it only affects the output _format_. It's related to 
   pretty-printing, not to anything else!

I really don't see what the confusion is all about. It's very 
straightforward and obvious.

			Linus
