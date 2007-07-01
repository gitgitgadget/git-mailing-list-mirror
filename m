From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (3rd try)] Add git-stash script
Date: Sun, 1 Jul 2007 01:16:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707010111340.4438@racer.site>
References: <200706302327.l5UNRMtc027974@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1939489957-1183248971=:4438"
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 02:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4n75-00069w-Ms
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 02:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbXGAAQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 20:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbXGAAQR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 20:16:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:35596 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753597AbXGAAQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 20:16:16 -0400
Received: (qmail invoked by alias); 01 Jul 2007 00:16:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 01 Jul 2007 02:16:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/y2jtWun3ybiffbuTj9wf+Q9xWQuRxzj28+rvbTG
	/neU7OzROhKj/y
X-X-Sender: gene099@racer.site
In-Reply-To: <200706302327.l5UNRMtc027974@mi0.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51263>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1939489957-1183248971=:4438
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 1 Jul 2007, しらいしななこ wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > On Sat, 30 Jun 2007, しらいしななこ wrote:
> >
> >> diff --git a/git-stash.sh b/git-stash.sh
> >> [...]
> >> +	printf >&2 'Saved WIP on %s\n' "$msg"
> >
> > You have an awful lot of printfs in the code. Why not just use echos?
> 
> I just imitated other scripts.  I can change it to
> 
> echo >&2 "Saved WIP on $msg"
> 
> but after reading Junio's comments, I think I probably should not.

You can leave them as-are, but I am actually more used to reading 
something like

	echo "Saved WIP on $msg" >&2

> >> +list_stash () {
> >> +	git-log --pretty=oneline -g "$@" $ref_stash |
> >
> > Wouldn't you want "--default $ref_stash" here?
> 
> I do not know, and I'm sorry I do not understand Junio's comments.
> 
> What does --default do in this case?

I had the impression that

	git stash list stash@{3}

would make sense. Probably I was mistaken.

> >> +apply_stash () {
> >> +	git-diff-files --quiet ||
> >> +		die 'Cannot restore on top of a dirty state'
> >
> > You meant "no_changes", right? I think you miss changes in the index 
> > otherwise.
> 
> After I read exchanges between you and Junio I do not know which way is 
> preferred.

Well, there are two differing, and contradicting, preferences: Junio's and 
mine.

Now you can have a third preference, but in the end what weighs most is 
the opinion of the person implementing it.

> Using no_changes does not forbid me from doing that, but I think Junio's 
> example will be forbidden.  The original scenario was that I apply a 
> stashed change to an unmodified state, and there is no problem either 
> way.

Oh, but there is. Imagine this:

File "f" contains "1" in HEAD, "2" in the index and "3" in the working 
directory. Now you say "git stash". Okay, file "f" now contains "1" in all 
three, and the working directory is clean. Suppose you decide the stash 
was a mistake. "git stash apply". File "f" contains "1" in _both_ the HEAD 
and the index, and "3" in the working directory.

Now, you might say that it does not matter. But then we should not even 
save the index.

Can I make one further request? Add "git stash save" to do the same as 
"git stash"?

Ciao,
Dscho

--8323584-1939489957-1183248971=:4438--
