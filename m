From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Make 'git fsck' complain about non-commit branches
Date: Wed, 16 Jan 2008 12:28:23 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161217050.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801151618300.2806@woody.linux-foundation.org> <7v8x2qd2hu.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151654050.2806@woody.linux-foundation.org> <7vk5m9pmmq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEsm-00089I-63
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbYAPU2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYAPU2i
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:28:38 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57641 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704AbYAPU2h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 15:28:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GKSOpk022226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 12:28:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GKSNhQ022646;
	Wed, 16 Jan 2008 12:28:24 -0800
In-Reply-To: <7vk5m9pmmq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70739>



On Wed, 16 Jan 2008, Junio C Hamano wrote:
> 
> If we take that "plumbing knows much more about Porcelain
> convention" shift-of-paradigm all the way, refs/remotes/ would
> contain what are copied from refs/heads/ elsewhere, so checking
> would have been correct.

Yes. I'm taking a slightly weaker approach, which is to say that git 
should check not "conventions", but "requirements".

So the reason I made it check HEAD and refs/heads/* is that yes, it's a 
convention that they be branches (and thus must point to commit objects), 
but it's also something deeper than that: git cit commands actually break 
when it's not true.

So I think there is a difference between "convention" and "requirement". 
One is how we do things, the other is how things must be done to work.

And yes, conventions have a tendency to become requirements, as people 
start depending on them, so it's not a black-and-white or even a static 
thing, and it changes over time.

I just suspect that at least right now, if refs/remotes/xyzzy isn't a 
commit, nothing actually technically *breaks*, even if it is against the 
convention.

For example, would it be wrong to have "remote tags" listed under 
refs/remotes/<remotename>/tags? I don't think it necessarily is wrong. 
It's not something we support right now, of course, and maybe we never 
will, but I don't think it's something that is necessarily conceptually 
broken - and maybe some external porcelain would want to do it that way?

So if core git doesn't really care, it shouldn't set the rules. But yes, 
the rules clearly have expanded over time, and probably will continue to 
do so..

		Linus
