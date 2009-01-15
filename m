From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 14:38:08 +0100
Message-ID: <20090115133808.GA10045@leksak.fem-net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSRf-0002mv-82
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764893AbZAONiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764838AbZAONiO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:38:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:56126 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762367AbZAONiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:38:12 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:38:10 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp026) with SMTP; 15 Jan 2009 14:38:10 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18k/0lciTokr6S+HjF+35hDrigZM3R54yPmxucdek
	BjTNoHRormWdC7
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNSQC-0004q4-Ik; Thu, 15 Jan 2009 14:38:08 +0100
Content-Disposition: inline
In-Reply-To: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105800>

Hi Sitaram,

Sitaram Chamarty wrote:
> The outputs I got really confused me.  Before the "rebase
> -p", the tree looked like
>     
>     * 78ffda9... (refs/heads/work) b4
>     * be1e3a4... b3
>     *   cd8d893... Merge branch 'master' into work
>     |\
>     | * 0153c27... (refs/heads/master) a4
>     | * 74f4387... a3
>     * | f1b0c1c... b2
>     * | 2e202d0... b1
>     |/
>     * b37ae36... a2
>     * ed1e1bc... a1
> 
> But afterward, this is what it looks like -- all the "b"
> commits are gone!
> 
>     * 0153c27... (refs/heads/work, refs/heads/master) a4
>     * 74f4387... a3
>     * b37ae36... a2
>     * ed1e1bc... a1
> 
> What did I do wrong/misunderstand?

Hmm, you are rebasing onto master which is merged into the branch you
want to rebase. So, I think the correct output should be the same like
git rebase without -p, ie

* 1337bee... (refs/heads/work) b4
* deadbee... b3
* badbeef... b2
* fa1afe1... b1
* 0153c27... (refs/heads/master) a4
* 74f4387... a3
* b37ae36... a2
* ed1e1bc... a1

This is because master is already merged into work and a preserved
merge will see that everything is already merged in.

Well, so I think you've discovered a bug.

> (2) git config alias.lg log --graph --pretty=oneline --abbrev-commit --decorate

Funny, I have exactly the same alias, but named "logk".

>     git init
>     testci a1 a2
>     git checkout -b work
>     testci b1 b2
>     git checkout master
>     testci a3 a4
>     git checkout work
>     git merge master
>     testci b3 b4
>     git --no-pager lg   # graph before rebase -p
>     git rebase -p master
>     git --no-pager lg   # graph after rebase -p

Thanks and regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
