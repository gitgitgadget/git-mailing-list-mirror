From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Fri, 27 Feb 2009 13:00:21 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902271255530.3111@localhost.localdomain>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>  <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>  <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>  <49A66057.1050501@drmicha.warpmail.net>  <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
  <49A7C3A7.6060202@drmicha.warpmail.net> <76718490902271248p2de44082ka66645203c9683d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9r8-0002e0-QB
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 22:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbZB0VBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756332AbZB0VBB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 16:01:01 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50244 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755521AbZB0VBA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 16:01:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1RL0Lm1007630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Feb 2009 13:00:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1RL0LUP001717;
	Fri, 27 Feb 2009 13:00:21 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <76718490902271248p2de44082ka66645203c9683d4@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111715>



On Fri, 27 Feb 2009, Jay Soffian wrote:
> 
> So I still don't get why Linus introduced the option. I'm looking at
> bcc785f:builtin-push.c and AFAICT, the following are exactly
> equivalent:
> 
> $ git push [options]... <repo>
> $ git push [options]... --repo=<repo>

Yes. 

But now do

	[alias]
		push-all=push all

and then try to add those options AFTERWARDS!

> --repo can be placed anywhere on the command line, but other than
> that, it's identical in effect to specifying the repo as the first
> non-dashed argument.
> 
> Or am I completely blind?

It's the "placed anywhere on the command line" that is the important part.

Try 

	git push-all --tags

and it didn't use to work without "--repo=all".

Of course, I think it works now, because I think "git push" uses 
"parse_options" these days, so now "--tags" actually works even after the 
repository definition. So _these_ days, you can just do

	git push all --tags

but that was not true historically. Back then, if you wanted to use an 
alias (which mean that the repo was named _before_ the arguments), you 
needed to do

	git push --repo=all --tags

because putting "--tags" after the repository name wouldn't work.

So _today_, we could remove the use of "--repo". But today, we have 
another reason to do "--repo" - compatibility.

		Linus
