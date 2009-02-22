From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 12:34:08 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902221225080.3111@localhost.localdomain>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>  <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>  <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>  <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 21:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbL3g-0006NM-Ge
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 21:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbZBVUeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 15:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbZBVUeq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 15:34:46 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42527 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441AbZBVUep (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 15:34:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1MKYAau005122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Feb 2009 12:34:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1MKY8gr024360;
	Sun, 22 Feb 2009 12:34:09 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.955 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111058>



On Sun, 22 Feb 2009, Felipe Contreras wrote:
>
> 'git log --pretty=foo' is very unintuitive, no one would ever find
> that option by intuition. Are there different kinds of pretties? Is
> the default behavior --ugly?

Historically, the default behaviour _was_ indeed --ugly.

There was no native "git log" command per se, it was literally a script 
that did something like

	git-rev-list <rev-opts> |
		git-diff-tree --stdin --pretty |
		$(PAGER)

and the "--pretty" option was to tell git to give human-readable output 
from git-diff-tree rather than the harsh raw stuff.

So yes, the default for git used to be "low-level plumbing commands for 
scripting", with some options to turn them pretty for the fleshies.

Then we started having more options, so "--pretty" became "--pretty=xyz".

But I do realize that without the historical background, none of this 
makes sense. And quite frankly, I do hate "--pretty=xyz" myself. I find 
myself wishing I could just write

	git log --oneline

instead of "--pretty=oneline", and I wish "shortlog" was a pretty format 
instead of a command of its own.

So at least personally, I would not object AT ALL to

 - leave the "--pretty=xyz" parsing for historical reasons

 - support "--format=xyz" too, because it does make sense (and it's 
   unambiguous: a format without a '%' sign in it makes no sense, so there 
   is no reason to have "--format=format:%s"

 - if we see an unrecognized "--<option>", and the <option> is a format 
   name, just assume the user was lazy and couldn't be bothered to write 
   out "format="

and then for extra bonus points, make "shortlog" work as a format too.

			Linus
