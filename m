From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: check-ref-format question
Date: Wed, 13 May 2009 11:03:52 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905131051240.2147@iabervon.org>
References: <93c3eada0905121709k73a47bddu60def6b5fbc1b15e@mail.gmail.com> <4A0AD5A2.2090103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 13 17:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4G0C-0003Tc-RS
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 17:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344AbZEMPDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 11:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbZEMPDw
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 11:03:52 -0400
Received: from iabervon.org ([66.92.72.58]:42304 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbZEMPDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 11:03:51 -0400
Received: (qmail 3015 invoked by uid 1000); 13 May 2009 15:03:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2009 15:03:52 -0000
In-Reply-To: <4A0AD5A2.2090103@drmicha.warpmail.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119056>

On Wed, 13 May 2009, Michael J Gruber wrote:

> Geoff Russell venit, vidit, dixit 13.05.2009 02:09:
> > 1 $ git --version
> > git version 1.6.2.3
> > 2 $ git check-ref-format xxxx && echo OK
> > 3 $ git-check-ref-format --branch xxxx && echo OK
> > xxxx
> > OK
> > 4 $ git check-ref-format --branch xxxx && echo OK
> > usage: git check-ref-format refname
> > 
> > 
> > 2 seems wrong,
> > I tried 3 after looking at  builtin-check-ref-format.c
> > I couldn't find any test cases in the git/t directory
> > 
> > From the documenation, I expect "git check-ref-format xxx" to return 0 if xxx is
> > a valid branch or ref name.  git version 1.6.3 gives the same results.
> 
> There are several things going on:
> 
> A) In 3 you use a different git than in 1,2,4. You told us the latter is
> 1.6.2.3, and I'm telling you the former contains v1.6.2.1-310-ga31dca0
> (which has the new --branch option).
> This simply checks whether refs/heads/xxxx is sane. (It also resolves
> @{-1} and such, which is what makes it useful at all.)
> 
> B) "master" certainly looks like a valid refname, the doc seems to imply
> that it should pass the check.
> 
> C) Looking at the code, check-ref-format checks explicitly for the
> presence of at least 2 levels: foo/bar is good, foo is bad. So, master
> always had been bad, as well (or bad) as full sha1s!
> 
> The code has always behaved like C since its inception but I don't know
> the rationale behind the 2 level requirement. Daniel, Junio?

In general, it's because you use it right before trying to use git 
update-ref $name, and you probably don't really want to change 
refs/master. Unless you know exactly what you're going (in which case, 
you're unlikely to check whether it's okay), you want to have a first 
level that specifies the type of ref and one or more additional levels 
that specify which ref of that type it is.

I believe that, if you've got "master", and you want to do the sensible 
thing with it (i.e., the file you care about is .git/refs/heads/master), 
you want to use rev-parse with some option or other, not check-ref-format, 
but I don't know the plumbing-level shell API very well.

	-Daniel
*This .sig left intentionally blank*
