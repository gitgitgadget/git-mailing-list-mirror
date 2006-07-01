From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Sat, 1 Jul 2006 12:38:38 -0700 (PDT)
Message-ID: <20060701193838.71618.qmail@web31802.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0606301954140.12404@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 21:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwlIg-0007S9-Nv
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 21:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWGATij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 15:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWGATij
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 15:38:39 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:45709 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751918AbWGATij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 15:38:39 -0400
Received: (qmail 71620 invoked by uid 60001); 1 Jul 2006 19:38:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=r5kGdzUasVzVNwfHTCzfBcEbTqT3AMtYPSIf3wv0Poo+F2QK+seEFTg9++dGwhtfivM6F+Cx1RvpQfk9rm2g44vtAVOck/jm8NqocHEZ3r+XeQqe/aRMKdlsH+KAjDRFHaB8D/dzgilU1YGKjJbLehshKoCKw4oI/vzmEc2L6UI=  ;
Received: from [68.186.62.135] by web31802.mail.mud.yahoo.com via HTTP; Sat, 01 Jul 2006 12:38:38 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606301954140.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23060>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> Well, with history simplification, we still show merges that are required 
> to make the history _complete_, ie say that you had
> 
> 	  a
> 	  |
> 	  b
> 	 / \
> 	c   d
> 	|   |
> 
> and neither "a" nor "b" actually changed the file, but both "c" and "d" 
> did: in this case we have to leave "b" around just because otherwise there 
> would be no way to show the _relationship_, even if "b" itself doesn't 
> actually change the tree in any way what-so-ever.

I agree.  If "c" and/or "d" changed the file but neither "a" nor "b" did,
then by (merge/diff/etc) "inheritance" we do need to leave "b" around.

(This is similar to git-blame/git-annotate which should show "b", so that
we can track down the change to "c" and/or "d".)

> > Can you consider the default case to be simplify_history=1,
> > which is currently the default behaviour of git-rev-list.
> 
> Actually, for your case, you don't want _any_ merges, unless those merges 
> literally changed the tree from all of the parents.

Yes, that's true.  s/all/one or more:
Don't want to show a merge, unless one or more of the parents,
changed the file.  If no parent changed the tree, then do not
show the commit.

> I think it would make sense to make that further simplification if the 
> "--parents" flag wasn't present. 
> 
> Hmm. Maybe something like this..
> 
> BTW! Junio, I think this patch actually fixes a real bug.
> 
> Without this patch, the "--parents --full-history" combination (which 
> you'd get if you do something like
> 
> 	gitk --full-history Makefile
> 
> or similar) will actually _drop_ merges where all children are identical. 
> That's wrong in the --full-history case, because it measn that the graph 
> ends up missing lots of entries.
> 
> In the process, this also should make
> 
> 	git-rev-list --full-history Makefile
> 
> give just the _true_ list of all commits that changed Makefile (and 
> properly ignore merges that were identical in one parent), because now 
> we're not asking for "--parent", so we don't need the unnecessary merge 
> commits to keep the history together.
> 
> Luben, does this fix the problem for you?

Given Junio's analysis, and briefly looking at the logic, it does seem
correct.  Let me apply it and see what I get, but I think it is a good thing.

Thanks for the patch!

      Luben
