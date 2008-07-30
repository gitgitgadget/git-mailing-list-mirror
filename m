From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 04:48:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net>
 <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain>
 <20080729125247.GC12069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 04:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO1m4-0002TM-DQ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 04:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbYG3Ctl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 22:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760367AbYG3Ctl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 22:49:41 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:1657 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbYG3Ctj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 22:49:39 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6U2ms0s053514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 04:48:55 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <20080729125247.GC12069@sigill.intra.peff.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90728>

Hi,

On Tue, 29 Jul 2008, Jeff King wrote:

> > > Perhaps I am just slow, but I haven't been able to figure out what that
> > > history is, or what the "correct" output should be. Can you try to state
> > > more clearly what it is you are looking for?
> > 
> > Most frequently this involves changes where the same change is merged 
> > twice. Another interesting example is kernel/printk.c where a change is 
> > added and later removed again before it's merged.
> 
> I glanced briefly over "gitk kernel/printk.c" and it looks pretty sane.
> I was really hoping for you to make your case as something like:
> 
>   1. here is an ascii diagram of an actual history graph (or a recipe of
>      git commands for making one)
>   2. here is what git-log (or gitk) produces for this history by
>      default; and here is why it is not optimal (presumably some
>      information it fails to convey)
>   3. here is what git-log (or gitk) with --full-history produces; and
>      here is why it is not optimal (presumably because it is too messy)
>   4. here is what output I would like to see. Bonus points for "and here
>      is an algorithm that accomplishes it."

For printk.c look for commit 02630a12c7f72fa294981c8d86e38038781c25b7 and 
try to find it in the graphical outputs.
Here is a bit better example than Linus gave:

mkdir test
cd test
git init

echo 1 > file1
echo a > file2

git add file1 file2
git commit -m "initial commit"
git tag base

git branch test1 base
git checkout test1
echo 2 > file1
git commit -a -m "duplicate change 1"

git branch test2 base
git checkout test2
echo 2 > file1
git commit -a -m "duplicate change 2"

git branch test3 base
git checkout test3
echo b > file2
git commit -a -m "some other change"

git checkout base

git merge test1
git merge test2
git merge test3

Now compare the output of "git-log file1", "git-log --full-history file1" 
and "git-log --full-history --parents file1". You get either both merge 
commits or none, but only one of it is relevant to file1.

The problem is that in practice "git-log --full-history --parents" 
produces way too much information to be useful right away.

bye, Roman
