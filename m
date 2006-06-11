From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: git-applymbox broken?
Date: Sun, 11 Jun 2006 17:33:59 -0600
Message-ID: <m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
X-From: git-owner@vger.kernel.org Mon Jun 12 01:34:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpZRy-0007Eh-LU
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 01:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWFKXec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 19:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWFKXec
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 19:34:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57230 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751140AbWFKXeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 19:34:31 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5BNY3Md015404;
	Sun, 11 Jun 2006 17:34:03 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5BNXx1N015403;
	Sun, 11 Jun 2006 17:33:59 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Jun 2006 15:40:24 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21674>

Linus Torvalds <torvalds@osdl.org> writes:

> It looks like something has broken git-applymbox lately.
>
> The "From: authorname" lines are no longer removed from the message, and 
> are duplicated in the commit log. This has resulted in several recent 
> kernel commits looking like this:

Agreed.  That isn't terribly desirable.
Do you have the original email message some place?

There is an odd case where if someone put the From: header
in the middle of the text that we now notice and process and I
didn't feel right about removing a line from the middle of the
text.

I was fixing a nasty corner case that happens if there aren't any
mail headers at all passed to git-mailinfo.  Where we could drop
lines without processing them at all.

This doesn't look like the From: header was in the middle of the
message until it was imported into git so it is probably a small
logic error that is easily corrected.  But I need to see what
we are parsing so I can understand what is happening.


> 	commit c0bbbc73d58f1b774cd987b5687a478a027f137c
> 	Author: Christoph Lameter <clameter@sgi.com>
> 	Date:   Sun Jun 11 15:22:26 2006 -0700
> 	
> 	    [PATCH] typo in vmscan.c
> 	    
> 	    From: Christoph Lameter <clameter@sgi.com>
> 	    
> 	    Looks like a comma was left from the conversion from a struct to an
> 	    assignment.
> 	    
> 	    Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 	    Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> where that "From:" in the body is totally wrong. I just didn't notice, 
> until now. Arrr!
>
> I _suspect_ that this is the work by Eric Biederman, ie part of the 
> patches that do "Allow in body headers beyond the in body header 
> prefix." and "Refactor commit messge handling."
>
> Eric? Can you please fix this up? Lines from the body of the email that 
> have been used to set authorship should _not_ also show up in the commit 
> message.

Even if the header lines are in the middle of the body?

Eric
