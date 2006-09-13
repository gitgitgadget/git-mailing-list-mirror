From: Junio C Hamano <junkio@cox.net>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 11:58:41 -0700
Message-ID: <7vfyeva90e.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	<20060913152451.GH23891@pasky.or.cz>
	<9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
	<ee9akc$d62$1@sea.gmane.org> <45083490.9020203@gmail.com>
	<20060913164937.GC29933@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 13 20:59:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNZwe-0006J8-O4
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 20:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWIMS6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 14:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWIMS6n
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 14:58:43 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:22672 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750847AbWIMS6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 14:58:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913185842.KQQN6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 14:58:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MuyX1V00G1kojtg0000000
	Wed, 13 Sep 2006 14:58:31 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060913164937.GC29933@spearce.org> (Shawn Pearce's message of
	"Wed, 13 Sep 2006 12:49:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26931>

Shawn Pearce <spearce@spearce.org> writes:

> How about using a regex or a shell wildcard in config such as:
>
> 	[core]
> 		hideRefs = refs/abandoned/
> 		hideRefs = refs/some-garbage-i-have/

A suggestion to say "[core] anything" is out; this does _not_
belong to the core at all.

Depending on how much abandoned you want to make the abondond
refs, you can do one of the following:

 - If you just do not want visualizers to clutter what you are
   usually interested in viewing by default, teach visualizers
   to ignore that refs/ hierarchy.  Right now visualizers either
   use "ls-remote ." (e.g. gitk) or walking refs directory
   itself (e.g. gitweb) to find what refs are available.  Filter
   that and you are done.  If we were to do show-refs helper and
   if all the visualizers use it (we would need something like
   that when the refs/ work Linus is doing hits the mainline --
   walking refs directory to find available refs becomes
   officially unsupported when that happens), I am not opposed
   to give it --ignore=refs/abandoned option.  Similarly for
   ls-remote but _NOT_ peek-remote (the former is Porcelain-ish,
   the latter is core).

 - If you do not want to have even clone look at them, you need
   to have two repositories: with-clutter and main.  You call
   the current Mozilla full-import repository the former, make a
   copy of it and remove unwanted refs from it and repack.  Call
   that main and have people work on it.

   People who want to look at old, failed experiments can pull
   from with-clutter repository in two ways.  Either they can
   pull into their clone of 'main', or they make a separate
   clone using --reference option to cut the download time and
   to keep the cluttered part separate.
