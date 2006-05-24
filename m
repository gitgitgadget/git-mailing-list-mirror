From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: file name case-sensitivity issues
Date: Wed, 24 May 2006 09:55:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0605240949470.29399@dildano.hawaga.org.uk>
References: <20060523210615.GB5869@steel.home>
 <Pine.LNX.4.64.0605232239070.15915@dildano.hawaga.org.uk>
 <7vd5e4xkrh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 11:55:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiq5O-0006LC-Vt
	for gcvg-git@gmane.org; Wed, 24 May 2006 11:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWEXJzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 05:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWEXJzY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 05:55:24 -0400
Received: from dildano.hawaga.org.uk ([81.187.211.37]:32489 "EHLO
	dildano.hawaga.org.uk") by vger.kernel.org with ESMTP
	id S932630AbWEXJzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 05:55:23 -0400
Received: from dildano.hawaga.org.uk (localhost.localdomain [127.0.0.1])
	by dildano.hawaga.org.uk (8.13.6/8.13.6/Debian-1) with ESMTP id k4O9tFm7004765;
	Wed, 24 May 2006 09:55:15 GMT
Received: from localhost (benc@localhost)
	by dildano.hawaga.org.uk (8.13.6/8.13.6/Submit) with ESMTP id k4O9tEnL004761;
	Wed, 24 May 2006 09:55:15 GMT
X-Authentication-Warning: dildano.hawaga.org.uk: benc owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5e4xkrh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20676>



On Tue, 23 May 2006, Junio C Hamano wrote:

> That's interesting.  I wonder how...  Does this sequence remove FOO
> on that filesystem?
> 
> 	$ date >FOO
>         $ rm -f foo
>         $ ls

yes.

$ ls
$ date >FOO
$ ls
FOO
$ rm -f foo
$ ls



> Also if you do the final "git pull" using resolve strategy, does
> it change the result (say "git pull -s resolve . side" instead)?

Different result:

$ mkdir case-sensitivity-test
$ cd case-sensitivity-test
$ git init-db
defaulting to local storage area
$ echo foo > foo
$ echo bar > bar
$ git add foo bar
$ git commit -m initial\ commit
Committing initial tree 89ff1a2aefcbff0f09197f0fd8beeb19a7b6e51c
$ git checkout -b side
$ echo bar-side >> bar
$ git commit -m side\ commit -o bar
$ git checkout master
$ rm foo
$ git update-index --remove foo
$ echo FOO > FOO
$ git add FOO
$ git commit -m case\ change
$ ls
FOO bar
$ git pull -s resolve . side
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Trying simple merge.
Merge 06c11eeb08edefba8178b091287ec6d951d1ef1d, made by resolve.
 bar |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
$ ls
FOO bar
$ 


-- 
