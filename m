From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config
 variable "diff.primer"
Date: Mon, 26 Jan 2009 12:28:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261220300.14855@racer>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901261154330.14855@racer> <20090126111605.GB19993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:29:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPf6-0007sZ-QH
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbZAZL21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbZAZL21
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:28:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:58899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750923AbZAZL20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:28:26 -0500
Received: (qmail invoked by alias); 26 Jan 2009 11:28:24 -0000
Received: from pD9EB294D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.77]
  by mail.gmx.net (mp031) with SMTP; 26 Jan 2009 12:28:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VSrUMF7wVLgxSueCCfWmwBeQVXg1dtRfAjn1XXh
	lUvz7BASukaYkj
X-X-Sender: gene099@racer
In-Reply-To: <20090126111605.GB19993@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107192>

Hi,

On Mon, 26 Jan 2009, Jeff King wrote:

> On Mon, Jan 26, 2009 at 11:59:46AM +0100, Johannes Schindelin wrote:
> 
> > Just a reminder: we are very conservative when it comes to breaking 
> > backwards compatibility.  For example, people running (but not upgrading) 
> > gitweb who want to upgrade Git may rightfully expect their setups not to 
> > be broken for a long time, if ever.
> 
> Are you aware that gitweb no longer calls "git diff", exactly because
> of problems caused by calling a porcelain from a script?

As I said: do you really expect people not to forget to upgrade gitweb 
manually when they do "sudo make install" with a new Git version?

> I don't want to break existing setups, either. But at some point you 
> have to say "this is porcelain, so don't rely on there not being any 
> user-triggered effects in its behavior". If porcelain is cast in stone, 
> then what is the point in differentiating plumbing from porcelain?

Two points there:

- with gitweb, we were the offenders ourselves.  So we should give the 
  users of gitweb at least _some_ slack.

- Concretely for the "porcelain" git diff: This workflow

	git diff > my-patch
	<attach and send to somebody>

  is probably pretty wide spread.  And it is okay, a user is not a script, 
  they are very much allowed to use porcelain.  And we _would_ break 
  expectations there.

Now, I have another two, fundamental problems with the diff options 
defaults: you are restricting the thing to _one_ set of options, and when 
somebody wants to run without those options, she has to actively _undo_ 
them.

Remember, sometimes you need another set of options. Like, when I send 
mail to a Git user, I want "-M -C -C", when I send mail to a non-Git user, 
I do not want any additional options (and try to undo "-M -C -C" on the 
command line, good luck), and sometimes it is much easier to see what 
happened with a word diff.

So what I need are three different sets of diff options.

Guess how well that works with aliases -- we are talking command line 
here after all, right?

Ciao,
Dscho
