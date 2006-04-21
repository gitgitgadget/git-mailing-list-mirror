From: Bob Portmann <bportmann@yahoo.com>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 11:48:15 -0700 (PDT)
Message-ID: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
References: <Pine.LNX.4.64.0604211102000.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 20:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX0g0-0004QP-50
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 20:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWDUSsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 14:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDUSsR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 14:48:17 -0400
Received: from web60319.mail.yahoo.com ([209.73.178.127]:31353 "HELO
	web60319.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750701AbWDUSsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 14:48:16 -0400
Received: (qmail 22941 invoked by uid 60001); 21 Apr 2006 18:48:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=efoLkPJ/SlCZ6Y1LbC6nDeJsIWFJ0X2Jlu/GEGENfqB2oxQ38PeCnylJ1byHbWKxI6tJ2ZbiiNuy3e8fpJ6I0wdFr4RocD4f4BEer3RQqWhkg5j1LUtPYtXK2Dx2Im1863pid/uEJkDe2+bdv/muRReTNDswvs77lQQsNOIrC3U=  ;
Received: from [140.172.241.92] by web60319.mail.yahoo.com via HTTP; Fri, 21 Apr 2006 11:48:15 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604211102000.3701@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19024>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> On Fri, 21 Apr 2006, Bob Portmann wrote:
> >
> >  I cannot get any output out of it and am wondering if I am using
> it
> > correctly or it is broken.
> 
> You're using it correctly, but it isn't broken for me. 
> 
> > As I understand it, git-log should just print out the log messages
> but 
> > not the changes, whereas git-whatchanged will print out both.
> 
> Well, in 1.3.0, "git log" can actually do both, and you can get the 
> whatchanged output by just saying "git log -p".
> 
> But yes, without the "-p", you should get just the log.
> 
> And that's exactly what I get, both with current HEAD git, and with a
> 
> v1.3.0 checkout.
> 
> > test-log> git log
> > test-log> 
> > 
> > As you can see git log produces no output.  I've tried it with
> other
> > options with the same result.
> 
> Very strange indeed. Can you do
> 
> 	git log > file
> 
> to see if that changes (and see if the file contains anything)? The
> reason 
> I mention that is that by default "git log" will start a pager for
> you, 
> and if you somehow have a broken PAGER setup, I could imagine exactly
> the 
> behaviour you see (although I don't see why "git whatchanged" would
> work 
> either, in that case).

Yes, this is the problem.  It works when I send it to a file.  It seems
to be that having any extra options my PAGER command that messes it up
(see below).  If get-log was a shell script I would imagine that some
quotes are missing:-)

Bob

test-log> export PAGER='more'
test-log> git log
commit 9a4d7602fff052b6796c2862edddd11ae2e45d08
Author: Bob Portmann <portmann@removed>
Date:   Fri Apr 21 10:56:11 2006 -0600

    Two line hello

commit a38306518c5e5e8eb630c02a47bec2a9fc292025
Author: Bob Portmann <portmann@removed>
Date:   Fri Apr 21 10:55:44 2006 -0600

    One line hello

test-log> export PAGER='more -i'
test-log> git log
test-log> 

Adding the option -i (which should do nothing) has eliminated the
output.


> Finally, if that doesn't output anything either, please do (for just
> that 
> small repository, so that the trace is also small)
> 
> 	strace -o git-trace git log > /dev/null
> 
> and send out the result. Again, for PAGER reasons, that "> /dev/null"
> is 
> actually important, because we don't want to trigger the pager code.
> 
> 		Linus
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
