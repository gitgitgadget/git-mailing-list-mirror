From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: RFC: Subprojects
Date: Mon, 20 Feb 2006 14:16:59 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060220131659.GA8613@informatik.uni-freiburg.de>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de> <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org> <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 20 14:17:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBAua-0000gJ-20
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 14:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWBTNRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 08:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWBTNRE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 08:17:04 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:20706 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1030182AbWBTNRC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 08:17:02 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FBAuT-0002yU-Fr
	for git@vger.kernel.org; Mon, 20 Feb 2006 14:17:01 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k1KDGxf9009206
	for <git@vger.kernel.org>; Mon, 20 Feb 2006 14:16:59 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k1KDGxTe009205
	for git@vger.kernel.org; Mon, 20 Feb 2006 14:16:59 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16482>

Hello,

Junio C Hamano wrote:
> The "containing" project would have a handful "gitlink" objects
> among other things.  The toplevel tree object from a commit in
> such a project might look like this (mode bits 0160000 is
> S_IFDIR|S_IFLNK, which is what this thing is):
> 
>       $ git ls-tree HEAD
>         0100644 blob 012345... Makefile
>         0100644 blob 123456... README
>         0160000 link 234567... gcc-4.0
>         0160000 link 345678... linux-2.6
>         0040000 tree 456789... src
>       $ git cat-file -t 345678
>         link
>       $ git cat-file link 345678
>         commit 87530db5ec7d519c7ba334e414307c5130ae2da8
>         url git://...torvalds/linux-2.6.git/
> 
>         The upstream Linux 2.6 repository.
>       $ cd linux-2.6 && git-rev-parse --verify HEAD
>         87530db5ec7d519c7ba334e414307c5130ae2da8
> 
> URL will be used as a suggestion for people who cloned this tree
> to set up their repository.
I'd prefer to have the objects needed to get the linux-2.6 tree in the
object db of the containing project.  Then "url" is not needed, and you
could directly use the commit as value for the link.  i.e.

       $ git ls-tree HEAD
         0100644 blob 012345... Makefile
         0100644 blob 123456... README
         0160000 link 435363... gcc-4.0
         0160000 link 87530d... linux-2.6
         0040000 tree 456789... src

(You could now rename "link" to "commit", but it would break the
layout.)

Moreover I prefer the the link approach over the bind method.  The
reason is, that binds use information from the commit object to build
the wc other than the tree.  Moreover the condition that the
"containing" tree must not have an entry named linux-2.6 is handled
implicitly with links.

Please correct me if I'm wrong somewhere.  It's some time ago I read the
patches and this thread.  This mail is the result of some thoughts in my
vacation.

Best regards
Uwe


-- 
Uwe Zeisberger

http://www.google.com/search?q=1+year+divided+by+3+in+seconds
