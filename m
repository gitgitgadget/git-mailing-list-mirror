From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [TopGit PATCH/RFC] Do not use mktemp
Date: Tue, 12 Aug 2008 16:07:34 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808121557290.24244@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
 <20080812204433.GM10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:09:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT16e-0004hV-UP
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 23:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYHLVHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbYHLVHi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 17:07:38 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:52563 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbYHLVHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 17:07:37 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7CL7YxB030157;
	Tue, 12 Aug 2008 16:07:34 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7CL7YdD024506;
	Tue, 12 Aug 2008 16:07:34 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <20080812204433.GM10151@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92139>

Hi,

Petr Baudis wrote:

> On Tue, Aug 12, 2008 at 01:14:27PM -0500, Jonathan Nieder wrote:
> > Old operating systems may not even have mktemp; less old
> > operating systems may have a mktemp which is not compatible with
> > the usual post-1.5 version.  Let's try to do without.
> 
>   can you give some concrete examples?

SunOS 5.8 has no mktemp (which is not so bad, because as you say, we
could provide our own stub).

Mac OS X mktemp does not allow omitting the template argument but
otherwise shouldn't be much of a problem.  On Mac OS X (and old BSDs,
too, presumably), "mktemp -t arg" treats arg as a prefix for a filename
rather than a template for a filename, but that is just a cosmetic
problem.

So thinking it through, perhaps we should do the following:
 - provide a simple mini-mktemp for users install to install themselves
   on old systems
 - always provide the template argument to mktemp

The arcane umask use would then go in that mini-mktemp which most people
would not be using.  I still would appreciate suggestions from any shell
hackers on how to implement it properly (in particular, how to get
random numbers that change more than once/second).

I'll work on a patch in a few hours when I get home.  Thanks for the
comments.

Jonathan
