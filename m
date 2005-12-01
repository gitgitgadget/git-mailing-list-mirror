From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: What's new in git.git master branch
Date: Thu, 1 Dec 2005 09:54:33 +0100
Message-ID: <20051201085433.GA7866@c165.ib.student.liu.se>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 09:57:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhkDd-00064D-2I
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 09:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbVLAIyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 03:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbVLAIyl
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 03:54:41 -0500
Received: from [85.8.31.11] ([85.8.31.11]:38329 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751648AbVLAIyk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 03:54:40 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 19BFE4102; Thu,  1 Dec 2005 10:04:17 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EhkD3-0005ar-00; Thu, 01 Dec 2005 09:54:33 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13042>

On Wed, Nov 30, 2005 at 02:57:06PM -0800, Junio C Hamano wrote:

[...]

>  - ls-tree rewrite (Linus).

[...]

> One interesting change is ls-tree rewrite by Linus.  The command
> does _not_ show tree nodes when running with -r flag anymore.
> Running "git diff v0.99.9i t/t3100-ls-tree-restrict.sh"
> after updating to the master tells you the summary of changes in
> the behaviour.

It turns out that this change breaks the directory/file conflict
handling in git-merge-recursive. Right now merge-recursive uses

   git-ls-tree -r -z <tree SHA1>

to get a listing of every blob object (which corresponds to files) and
every tree object (which corresponds to directories) in the tree
designated by the SHA1. With the new ls-tree behaviour we don't get
any tree objects and hence merge-recursive can't do the d/f conflict
detection as it doesn't know about the directories. As we don't track
empty directories it could be fixed within git-merge-recursive, a list
of the directory names can be obtained from the list of file names by
stripping everything after the last slash in the file names.

Should we do it that way or should ls-tree be changed?

- Fredrik
