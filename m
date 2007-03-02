From: Junio C Hamano <junkio@cox.net>
Subject: identifying blobs (was Re: Memory overrun in http-push.c)
Date: Fri, 02 Mar 2007 14:52:34 -0800
Message-ID: <7vr6s7dzrh.fsf@assigned-by-dhcp.cox.net>
References: <20070228151516.GC57456@codelabs.ru>
	<200703011040.35971.andyparkins@gmail.com>
	<200702281541.41164.andyparkins@gmail.com>
	<20070301051323.GG57456@codelabs.ru>
	<81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
	<7vslcpux62.fsf@assigned-by-dhcp.cox.net>
	<20070301120042.GD63606@codelabs.ru> <es9cnt$egh$1@sea.gmane.org>
	<Pine.LNX.4.63.0703021617040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 23:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNGcC-0007fd-Nj
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 23:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992703AbXCBWwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 17:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992705AbXCBWwh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 17:52:37 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53554 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992703AbXCBWwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 17:52:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302225236.YVPV3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Mar 2007 17:52:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vysb1W0041kojtg0000000; Fri, 02 Mar 2007 17:52:35 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41256>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 2 Mar 2007, Jakub Narebski wrote:
>
>> Second, there were some work on git mailing list to create git command 
>> which given a blob (or sha1 of a blob object) would list all commits (in 
>> date order) which have this exact version of a file (of a blob).
>
> It was shot down, and rightly so.

I think this "rightly" needs a clarification (otherwise Jakub
wouldn't have said the above).

It wasn't that identifying the commit that contained the version
of the file was not needed.  It is just there already is a way
to do so, and "to create git command" turns out to be
unnecessary.  Something like:

	$ hash=`git hash-object --stdin <$file_in_question`
	$ git log -z --raw -r --abbrev=40 |
          grep -z '^:[0-7][0-7]* [0-7][0-7]* [0-9a-f][0-9a-f]* '"$hash"'
