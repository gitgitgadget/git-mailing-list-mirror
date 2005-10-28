From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change git-cvsimport to handle slashes in CVS tags
Date: Fri, 28 Oct 2005 13:29:27 -0700
Message-ID: <7vmzkt4c7s.fsf@assigned-by-dhcp.cox.net>
References: <59a6e5830510281146s7b25da76l8bf97287522b89f2@mail.gmail.com>
	<Pine.LNX.4.64.0510281151450.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 22:33:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVarX-0004uG-7D
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 22:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbVJ1U3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 16:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJ1U3a
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 16:29:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35015 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750736AbVJ1U33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 16:29:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028202912.VFYY16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Oct 2005 16:29:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510281151450.4664@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 28 Oct 2005 12:10:30 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10774>

Linus Torvalds <torvalds@osdl.org> writes:

> I dunno. But maybe we do want the option of just keeping it as a slash, 
> and teach git-cvsimport to create the proper subdirectory prefixes.

How about doing both?

I think patch by Johannes to allow replacing slash to arbitrary
string is a reasonable thing to have, but somebody who uses
cvsimport needs to sign that off for me -- I do not regularly
use git-ANYimport myself.

> I have no idea how to do that in perl, though. Right now it just does
>
> 	open(C,">$git_dir/refs/tags/$xtag")
>
> how would you do "create file with all path components"?

Something like this? 

use File::Path;
my $file = "$git_dir/refs/tags/$xtag";
my ($dir) =  $file =~ m/(.*)\//;
mkpath($dir) && open C, ">$file";
