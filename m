From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Heads up: major rebase -i -p rework coming up
Date: Sat, 24 Jan 2009 21:25:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901242056070.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQp7G-0002QS-GX
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbZAXUZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbZAXUZH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:25:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:40561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755028AbZAXUZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:25:06 -0500
Received: (qmail invoked by alias); 24 Jan 2009 20:25:03 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp013) with SMTP; 24 Jan 2009 21:25:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19m7EdXyo5m7GhI4OW/UUUu7b3OVLlK+IHlplb8p7
	UmT01kUtWjEwIq
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107004>

Hi all,

as probably everybody agrees, the code to preserve merges is a big mess 
right now.

Worse, the whole concept of "pick <merge-sha1>" just does not fly well.

So I started a _major_ cleanup, which happens to reduce the code very 
nicely so far.

It will take a few days to flesh out, I guess, but these are the major 
ideas of my work:

- pick $sha1

	will only work on non-merges in the future

- merge $sha1 [$sha1...] was $sha1 "Merge ..."

	will merge the given list of commits into the current HEAD, for 
	the user's reference and to keep up-to-date what was rewritten, 
	the original merge is shown after the keyword "was" (which is not 
	a valid SHA-1, luckily)

- goto $sha1

	will reset the HEAD to the given commit

- $sha1'

	for merge and goto, if a $sha1 ends in a single quote, the 
	rewritten commit is substituted (if there is one)

Example:

A - B - - - E 
  \       /
    C - D

could yield this TODO script:

	pick A
	pick C
	pick D
	goto A'
	pick B
	merge D' was E

This should lead to a much more intuitive user experience.

I am very sorry if somebody actually scripted rebase -i -p (by setting 
GIT_EDITOR with a script), but I am very certain that this cleanup is 
absolutely necessary to make rebase -i -p useful.

As always, I am thankful for suggestions to make this even more useful, or 
even easier to operate.

Ciao,
Dscho
