From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Tue, 6 Nov 2007 12:25:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061216330.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
 <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site>
 <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <7vk5oviqbe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpNW1-0006R9-Hp
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbXKFM0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755727AbXKFM0a
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:26:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:36965 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752464AbXKFM03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:26:29 -0500
Received: (qmail invoked by alias); 06 Nov 2007 12:26:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 06 Nov 2007 13:26:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9vT5gLq79obP/zGBpf3Hv6aguoqMBoqlcYXmpYp
	FlAKKhBba0deI+
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5oviqbe.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63668>

Hi,

On Tue, 6 Nov 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> In the same way, I would expect "git revert <commit> -- file" to undo the 
> >> changes in that commit to _that_ file (something like "git merge-file 
> >> file <commit>:file <commit>^:file"), but this time commit it, since it 
> >> was committed at one stage.
> >
> > Allowing people to revert or cherry pick partially by using
> > paths limiter is a very good idea; ...
> 
> As Pierre said earlier, a partial revert via "revert <commit> --
> <paths>" and a partial cherry-pick would make quite a lot of
> sense, and in addition, it should not be too hard to add.

Yes, but Pierre also said earlier that people want to revert their local 
changes.  And the logical thing to try that really is

	git revert <path>

Now, if you read that out in English, it does not make too much sense: 
"revert the path" (not "revert the _changes_ to that file").  But it is 
what people try to do.

However, IIUC another thing Pierre mentioned is that

	$scm revert <commit> <path>

commonly means "revert the file _to the version_ stored in <commit>".  
This is just different enough from "revert the _changes_ to that file 
stored in <commit>" to bite people, no?

> Reusing the 'merge-recursive' part should be almost trivial. The only 
> tricky part is coming up with a fake tree using base and next commit in 
> revert_or_cherry_pick() for this purpose.

FWIW I really wanted to use the merge-file machinery, not the 
merge-recursive one.  But since "<path>" can be a directory, too, I was 
mistaken, and you are correct, as always.

> As to "reverting to the index" case, if somebody is interested in doing 
> a builtin-checkout.c, please keep in mind that major parts of that work 
> should be made available to the implementation of "git revert [--] 
> <paths>", as it appears that it will be exactly the same as "git 
> checkout" with the same set of options.

I was planning to put cmd_checkout() into builtin-reset.c for that reason.

But first things first, that "git remote prune" with --mirror'ed 
repositories misbehaviour annoys me just enough that I started converting 
this script first.  It has been stable enough for quite a long time, and 
the script now shows its limitations.

Besides, remote.[ch] makes it easy, even if not _really_ easy.

Ciao,
Dscho
