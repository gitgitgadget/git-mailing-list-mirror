From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: potential improvement to 'git log' with a range
Date: Fri, 9 Apr 2010 18:20:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>  <i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com> <n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 03:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0PQo-0002LR-Jp
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 03:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab0DJBYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 21:24:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56849 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab0DJBYL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 21:24:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o3A1Nfu4004993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Apr 2010 18:23:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o3A1Nf7j022382;
	Fri, 9 Apr 2010 18:23:41 -0700
In-Reply-To: <n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144494>



On Fri, 9 Apr 2010, Aghiles wrote:
> 
> Oh, I should have read the documentation. I was certain that ".." stands
> for a range but it is a ... complement.

Well, technically ".." means two different things

 - for "set operations" (ie "git log" and friends) it's the "relative 
   complement" of two sets (or "'reachable from A' \ 'reachable from B'").

 - for "edge operations" (ie "git diff" and friends) it's just two 
   end-points (aka "range"). A diff doesn't work on sets, it only works on 
   the two endpoints.

It's arguably a bit confusing, but quite frankly, the room for confusion 
is very small, and the biggest source of confusion is probably not so much 
that ".." means two different things in two (clearly different) contexts, 
as much as just the fact that people aren't used to thinking in terms of 
set operations at all. 

Most SCM's really talk about "ranges". Once you think in those terms, 
complex history doesn't work. Git very fundamentally is much about set 
theory, and "ranges" is a bad word to use.

To make things even more exciting triple-dot, "A...B" has two different 
meanings too, again one that is about sets ("symmetric difference") for 
the log-based ones, and one that is a somewhat badly defined range for the 
diff based ones (where the end-points are "one common nearest ancestor of 
A and B" and "B" respectively).

It's all actually very natural when you get used to it, although that 
"A...B" as a range really isn't well-defined, since there can be more than 
one common nearest ancestors. It's still often enough useful in practice 
that I wouldn't get rid of it, but it's not the greatest feature.

		Linus
