From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Re: Make 'git show' more useful
Date: Mon, 13 Jul 2009 17:00:42 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907131652120.13838@localhost.localdomain>
References: <7vtz1gi67v.fsf@alter.siamese.dyndns.org> <1247528614-24590-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 02:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQVS6-00083s-Sn
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 02:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757706AbZGNAAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 20:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757689AbZGNAAv
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 20:00:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53610 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757659AbZGNAAv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 20:00:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6E00h4r000885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Jul 2009 17:00:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6E00gao012530;
	Mon, 13 Jul 2009 17:00:42 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1247528614-24590-1-git-send-email-bonzini@gnu.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.466 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123215>



On Tue, 14 Jul 2009, Paolo Bonzini wrote:
> 
> So, what about squashing this with Linus's patch?  (This is meant to be
> squashed, which is why this text is not in a cover letter).

I wouldn't squash it.

That said, in the original commit that introduced "no_walk" (ba1d4505), I 
said

    I was going to add "--no-walk" as a real argument flag to git-rev-list
    too, but I'm not sure anybody actually needs it. Although it might be
    useful for porcelain, so I left the door open.

and I never actually did it. That was Apr 15, 2006.

The actual "--no-walk" flag was then added over a year later by Dsco, in 
commit 8e64006eee ("Teach revision machinery about --no-walk").

Doing a "git log -p -S--no-walk", I have to admit that I don't find a 
single actual _use_ of --no-walk. And it obviously wasn't even exported 
until a year after it was internally implemented.

So I have to agree with the fact that "--no-walk" and "--do-walk" seem to 
be pretty worthless as command line switches.  Removing them might be a 
good thing.

However, doing some googling, I do actually find examples of it on the 
web. And some of them even appear valid:

	second_parent=$(git rev-list --no-walk --parents $newrev | sed 's/ /\n/g' | grep -v $newrev | tail --lines=1)

because you can't use "git rev-parse" with --parents (of course, I'm not 
at all clear on why it doesn't do

	second_parent=$(git rev-parse "$newrev"^2)

but that's really immaterial - the point is that "git rev-parse" is _not_ 
a replacement for "git rev-list --no-walk").

So I dunno. I think we might as well leave --no-walk and --do-walk around, 
even though they are of dubious value. They do mirror the internal 
revision walking logic very directly. 

			Linus
