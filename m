From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during
 check-out
Date: Mon, 06 Aug 2007 21:03:44 +0200
Message-ID: <20070806190344.GF999MdfPADPa@greensroom.kotnet.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org>
 <20070805144632.GB999MdfPADPa@greensroom.kotnet.org>
 <46B76B8C.9050905@tromer.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eran Tromer <git2eran@tromer.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II7rw-000874-Ax
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 21:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759314AbXHFTDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759262AbXHFTDr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 15:03:47 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:38764 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759301AbXHFTDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 15:03:46 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMD00IBV8Y8TL@psmtp09.wxs.nl> for git@vger.kernel.org; Mon,
 06 Aug 2007 21:03:44 +0200 (MEST)
Received: (qmail 14754 invoked by uid 500); Mon, 06 Aug 2007 19:03:44 +0000
In-reply-to: <46B76B8C.9050905@tromer.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55167>

On Mon, Aug 06, 2007 at 02:42:20PM -0400, Eran Tromer wrote:
> On 2007-08-05 10:46, Sven Verdoolaege wrote:
> > You always have to be careful when doing "git commit -a".
> 
> Exactly. You now have to be very careful, whereas previously
> $ git checkout master && vi foo && git commit -a -m "fixed typos"
> was perfectly safe.

I don't see the difference.  If you forgot you changed something
(be it a submodule or a file) you will commit something you
didn't plan to commit.

    bash-3.00$ git init; touch a b c; git add .; git commit  -m 1
    Initialized empty Git repository in .git/
    Created initial commit 4e6da45: 1
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 a
     create mode 100644 b
     create mode 100644 c
    bash-3.00$ git checkout -b branch
    Switched to a new branch "branch"
    bash-3.00$ echo "foo" > a; git add a; git commit -m 2
    Created commit fe87123: 2
     1 files changed, 1 insertions(+), 0 deletions(-)
    bash-3.00$ echo "bar" > c
    bash-3.00$ git checkout master && echo "test" > b && git commit -a -m 'change b'
    M       c
    Switched to branch "master"
    Created commit 657c5b1: change b
     2 files changed, 2 insertions(+), 0 deletions(-)

> >> Another approach is for pull, checkout etc. to automatically update the
> >> submodule' head ref, but no more.
> > 
> > Then everything, including "git submodule update", would assume
> > that the submodule is up-to-date.
> 
> With that approach, "git submodule update" would fetch the submodule's
> head commit (which could be missing), and then check it against the
> submodule's index (and maybe its work tree).

And how is anyone supposed to figure out what HEAD the submodule's
index and working tree correspond to?
I can only hope that "git submodule update" would never blindly assume
that the submodule is clean and so the user would have to manually
sync the HEAD and the working tree.

skimo
