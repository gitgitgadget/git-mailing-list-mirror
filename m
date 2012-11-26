From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [RFC/PATCH] Option to revert order of parents in merge commit
Date: Mon, 26 Nov 2012 13:42:01 +0100
Message-ID: <20121126124200.GA29859@camk.edu.pl>
References: <20121123083550.GA702@camk.edu.pl>
 <7vfw3zzoye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 13:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcy1B-0004iI-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 13:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab2KZMmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 07:42:19 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:39402 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab2KZMmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 07:42:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 7AD195F0053;
	Mon, 26 Nov 2012 13:40:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id j51Ytla8m2qj; Mon, 26 Nov 2012 13:40:36 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id B2E0C5F0050;
	Mon, 26 Nov 2012 13:40:36 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id AB94043CFD; Mon, 26 Nov 2012 13:42:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfw3zzoye.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210436>

On Fri, Nov 23, 2012 at 06:58:49PM -0800, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > The following patch is an attempt to implement this idea.

> I think "revert" is a wrong word (implying you have already done
> something and you are trying to defeat the effect of that old
> something), and you meant to say "reverse" (i.e. the opposite of
> normal) or something.

You are right. Probably transpose is the best description what the patch
really does.

> I am unsure about the usefulness of this, though.

> After completing a topic on branch A, you would merge it to your own
> copy of the integration branch (e.g. 'master') and try to push,
> which may be rejected due to non-fast-forwardness:

>     $ git checkout master
>     $ git merge A
>     $ git push

> At that point, if you _care_ about the merge parent order, you could
> do this (still on 'master'):

>     $ git fetch origin
>     $ git reset --hard origin/master
>     $ git merge A
>     $ test test test
>     $ git push

> With --reverse-parents, it would become:

>     $ git pull --reverse-parents
>     $ test test test
>     $ git push

> which certainly is shorter and looks simpler.  The workflow however
> would encourage people to work directly on the master branch, which
> is a bit of downside.

Our developers work mainly on master branches. The project consists of
many thousands independent git repositories, and at the given time a
developer usually wants to make only one commit in the given repository
and push his changes upstream. So he usually doesn't care to make a
branch.  Then after failed pushed, one needs to add creation and removal
of temporary branch (see the commit message of the suggested patch).
The possibility to do git pull --reverse-parent would make the life
easier in this case.

> Is there any interaction between this "pull --reverse-parents"
> change and possible conflict resolution when the command stops and
> asks the user for help?  For example, whom should "--ours" and "-X
> ours" refer to?  Us, or the upstream?

The change of order of parents happens at the very last moment, so
"ours" in merge options is local version and "theirs" upstream.

-- 
  Kacper Kornet
