From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-add has gone lstat() mad
Date: Fri, 30 Mar 2007 18:38:56 -0700
Message-ID: <7vslbmxkcv.fsf@assigned-by-dhcp.cox.net>
References: <200703302055.13619.andyparkins@gmail.com>
	<200703302120.23713.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 03:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXSYg-0002X0-Q3
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 03:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290AbXCaBi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 21:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933294AbXCaBi6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 21:38:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50846 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933290AbXCaBi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 21:38:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331013856.BFVL25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 30 Mar 2007 21:38:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hDew1W00P1kojtg0000000; Fri, 30 Mar 2007 21:38:57 -0400
In-Reply-To: <200703302120.23713.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 30 Mar 2007 21:20:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43523>

Andy Parkins <andyparkins@gmail.com> writes:

> I can't see why git feels that it has to recurse the entire subtree.  It 
> seems to be something to do with the gitignore stuff.  Surely there is 
> no need to use a recursive search when no directories are being added?

I do not think this is anything new.

> If git-add were given
>
>  file1
>  dir1/file2
>  dir2/dir3/file3

The thing is, you are not giving the above three pathnames,
although you might think you are.

You are giving three path *patterns* and asking git-add: "please
run 'git ls-files --others' and add the ones that match these
patterns".

You can teach it to detect cases where you do not have wildcard
(that is both shell glob wildcard and directory names; the
latter means "grab everything in that named directory") to limit
the set of directories to descend into.

Patches are welcome, but applying them to 'master' needs to wait
post 1.5.1.
