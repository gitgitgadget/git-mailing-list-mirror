From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..."
 page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 14:56:53 +0100
Message-ID: <20100125135653.GN4159@machine.or.cz>
References: <cover.1264198194.git.jnareb@gmail.com>
 <201001251246.40237.jnareb@gmail.com>
 <20100125130230.GE9553@machine.or.cz>
 <201001251448.27513.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 14:57:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZPRR-0000N1-9C
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab0AYN45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897Ab0AYN45
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:56:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37490 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908Ab0AYN44 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:56:56 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id AA18586208B; Mon, 25 Jan 2010 14:56:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201001251448.27513.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137964>

On Mon, Jan 25, 2010 at 02:48:26PM +0100, Jakub Narebski wrote:
> Now those patches (mine and J.H. both) make gitweb use locking
> (it is IIRC configurable in J.H. patch) to make only one process
> generate the page if it is missing from cache, or is stale.  Now
> if it is missing, we have to wait until it is generated in full
> before being able to show it to client.  While it is possible to
> "tee" output (using PerlIO::tee, or Capture::Tiny, or tie like
> CGI::Cache) writing it simultaneously to browser and to cache for 
> the process that is generating data, it is as far as I understand
> it impossible for processes which are waiting for data.  Therefore
> the need for "Generating..." page, so the user does not think that
> web server hung or something, and is not generating output.

Ah, ok, so the message is there to cover up for a technical problem. ;-)
I didn't quite realize. Then, it would be great to tweak the mechanisms
so that the user does not really have to wait.

So, I wonder about two things:

(i) How often does it happen that two requests for the same page are
received? Has anyone measured it? Or is at least able to make
a minimally educated guess? IOW, isn't this premature optimization?

(ii) Can't the locked gitwebs do the equivalent of tail -f?


P.S.: Again the disclaimer - if this is "too hard", it's better to
accept patches like they are, then improve this later. But perhaps
a better solution would be not to clutter the code by optimizing this
case at all if it's not clear it really matters in the real world.

				Petr "Pasky" Baudis
