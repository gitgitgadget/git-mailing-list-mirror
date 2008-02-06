From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 5 Feb 2008 16:52:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802051648410.2967@woody.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
 <7vprvb6k9u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYYK-0006IY-5g
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbYBFAxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYBFAxo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:53:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38830 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064AbYBFAxn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 19:53:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m160qiDg003351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Feb 2008 16:52:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m160qhwZ018220;
	Tue, 5 Feb 2008 16:52:44 -0800
In-Reply-To: <7vprvb6k9u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72735>



On Tue, 5 Feb 2008, Junio C Hamano wrote:
> >
> >  - make commit warn if any parent commit date is in the future from the 
> >    current commit date (allow a *small* fudge factor here, say 5 minutes).
> 
> Hmmm.  In other words, you are punished for trying to build on
> top of somebody else who screwed up.  That sucks.

Well, I was actually thinking that the most reasonable thing to do is that 
if you pull from somebody, and you get this warning, you send an email 
saying "you suck, I will not pull your broken crap".

But the real problem is that you might be importing it from some external 
legacy SCM entity, and then you can't say "you suck, I won't pull", 
because the whole point is that external entity obviously *does* suck, and 
you want to simply stop using it. And then the "I won't pull" isn't an 
option ;)

So yeah, I don't think the warnings really work, if only because of that 
"import from crappy CVS repo" issue.

But the revision.c change might be worth it, if only as a slight band-aid 
for the current issue. It won't fix the original problem, though (because 
that broken repo had a five *year* clock skew, not an hour :)

I'll continue to think about whether I can come up with some sane 
heuristic that allows non-broken cases to not go all the way up to the 
root.

		Linus
