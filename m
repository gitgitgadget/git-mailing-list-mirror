From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach fmt-patch to write individual files.
Date: Thu, 04 May 2006 17:09:00 -0700
Message-ID: <7vhd452uzn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605050115440.12795@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 02:09:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbnsf-0004JQ-21
	for gcvg-git@gmane.org; Fri, 05 May 2006 02:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWEEAJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 20:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWEEAJE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 20:09:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8833 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932398AbWEEAJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 20:09:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505000902.BDOH9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 20:09:02 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605050115440.12795@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 5 May 2006 01:16:40 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19587>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When called with "--stdout", it still writes to standard output.
>
> Notable differences to git-format-patch:
>
> 	- since fmt-patch uses the standardized logging machinery, it is
> 	  no longer "From nobody", but "From <commit_sha1>",

Yes, and the date on that UNIX-From line has been updated ;-).

> 	- the empty lines before and after the "---" just before the
> 	  diffstat are no longer there,

Personally, I find this the most annoying myself.  I am not
complaining to you because as you know you inherited this
behaviour from my code.

> 	- git-format-patch outputs the commit_sha1 just before the first
> 	  diff, which fmt-patch does not,

Which should be fine.

> 	- the file names are no longer output to stdout, but to stderr
> 	  (since stdout is freopen()ed all the time), and

Which might be a bigger deal; I suspect people capture that while
dumping patches into individual files, and do their
postprocessing using the list of filenames.

> 	- "git fmt-patch HEAD^" does not work as expected: it outputs
> 	  *all* commits reachable from HEAD^!

If we really wanted to handle this, you could do something like
what builtin-diff does before letting the revision machinery
start walking the revision tree.  Look at pending objects, and
if you find only one UNINTERESTING commit, add_object the
current HEAD there as well.  Personally I do not think it is
worth it; rather we would probably want to standardize on rev-list
syntax.

Two major differences you forgot to mention.

One is that it does not do the "git cherry" filtering.  It is
not a big deal for me personally, but some people may be
depending on it.  I dunno.

Another is -o outdir, which should be trivial to add once you
have implemented output switching with freopen().

Anyhow, thanks for starting this.
