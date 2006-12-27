From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Segfault in xdl_merge is back
Date: Wed, 27 Dec 2006 12:22:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061227041644.GA22449@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 12:22:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzWrJ-0004E4-PA
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 12:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWL0LWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 06:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWL0LWF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 06:22:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:53243 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932235AbWL0LWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 06:22:04 -0500
Received: (qmail invoked by alias); 27 Dec 2006 11:22:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 27 Dec 2006 12:22:02 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061227041644.GA22449@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35462>

Hi,

On Tue, 26 Dec 2006, Shawn Pearce wrote:

> So I've been able to reproduce the segfault that was earlier reported in 
> xdl_merge.  Unfortunately its in the repo that I can't publish.

So here I am again, wanting to help, being unable to. *Sigh*. At least 
this time it is due to legal reasons, not unknown ones.

As you said in another mail, Junio suggested using git-merge-file on the 
blobs themselves. This is a little tricky, since git-merge-file does not 
read blobs; only files. I'd do this:

	- in merge-recursive.c just before line 658 I'd add an
	  fprintf(stderr, "xdl_merge: %s %s %s\n", sha1_to_hex(a->sha1),
		sha1_to_hex(o->sha1), sha1_to_hex(b->sha1));
	- run the merge until it segfaults
	- get the blobs by using the last three SHA1's in the output by
	  $ git-show <sha1>  > a   # or "o" or "b"
	- $ git merge-file -p a o b >/dev/null

This command line ensures that "a" is not edited, and you can repeat the 
merge as often as needed.

If this still segfaults, I'd like to have the files privately (I will not 
look at the contents, as they are irrelevant to this particular bug).

Ciao,
Dscho
