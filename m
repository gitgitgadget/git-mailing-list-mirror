From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 10:44:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806241036560.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <20080623195314.GA29569@sigill.intra.peff.net> <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org> <20080624053504.GB19224@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org> <20080624173428.GA9500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCcY-0007K8-SA
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbYFXRq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbYFXRq4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:46:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37044 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752748AbYFXRqz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 13:46:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OHiP56021018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 10:44:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OHiOA5030825;
	Tue, 24 Jun 2008 10:44:25 -0700
In-Reply-To: <20080624173428.GA9500@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.851 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86098>



On Tue, 24 Jun 2008, Jeff King wrote:
> 
> Perhaps I was confused about the definition of "single", because
> throughout this thread you seem to be making multiple complaints about
> parse_options, including its lack of a "stop on unknown" flag, a
> "continue on unknown flag", and the movement of arguments within the
> argv array.

You think that is multiple problems, but it's not.

It was a single issue - the issue of being able to do incremental parsing, 
and mixing *different* parsers together (not just two different calls to 
"parse_options()", but also having hand-parsing still in the picture for 
things where it was hard to convert).

And to solve that _single_ problem, I wanted parse_options() to be able 
to:

 - stop at unknown options (so that I could hand-parse them)

 - ignore unknown options (so that I could parse all the ones I knew 
   about, and then either hand-parse the rest, or just pass them on to 
   _another_ function that used some arbitrary model to parse the parts it 
   knew about)

See? Single issue.

And I even sent out a single patch for it. That single patch, btw, was 
even rather small. 

Did you ever look at that patch? Did you ever look at the code I was 
trying to have use parse_options()? No.

> So I will say one last time, as clearly as I possibly can, what I was
> trying to bring to the discussion:

You constantly try to change the discussion to be about SOMETHIGN ELSE.

For example, you keep on bringing up this TOTAL RED HERRING:

>   - It is impossible for that mechanism to be correct in all cases, due
>     to the syntactic rules for command lines. IOW, you cannot parse an
>     element until you know the function of the element to the left.

NOBODY F*CKIGN CARES!

Because what builtin-blame.c *already* does is exactly that.

This is what I'm complaining about with your totally IDIOTIC mails. You're 
ignoring reality, and talking about how things "ought to work", and never 
ever apparently looked at how things *do* work.

The fact is, the one program I wanted to convert already does exactly what 
you claim is "impossible to be correct in all cases".  

So either shut up, or send a patch to fix what you consider a bug. I'm 
waiting.

So screw it. I'm simply not interested in discussing this with you. You 
aren't apparently interested in looking at the problems we have today, 
because you're only interested in fixing some theoretical case.

		Linus
