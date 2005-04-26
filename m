From: Mike Taht <mike.taht@timesys.com>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Mon, 25 Apr 2005 21:12:04 -0700
Message-ID: <426DBF94.3010502@timesys.com>
References: <20050426032422.GQ13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 06:09:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQHOD-0002QB-IE
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDZEOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDZEOn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:14:43 -0400
Received: from mail.timesys.com ([65.117.135.102]:36378 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261290AbVDZEOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 00:14:25 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 26 Apr 2005 00:08:55 -0400
X-Accept-Language: en-us, en
To: pasky@ucw.cz, git@vger.kernel.org
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
X-OriginalArrivalTime: 26 Apr 2005 04:08:55.0609 (UTC) FILETIME=[A9F4D290:01C54A15]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>   Yes, this is a huge change. No, I don't expect any further changes of
> similar scale. I think the new interface is significantly simpler _and_
> cleaner than the old one.

Heh. Another huge change would be moving the top level directories 
around a bit.


bindings  COPYING  git.spec  Makefile  programs  README.reference  tests
contrib   doc      include   po        README    src  VERSION

Leaving fixing the makefiles aside as an exercise for the interested 
reader... that's:

#!/bin/sh

# completely rearrange the file structure of cogito/git
# just to make pasky and other scm users insane once again
# FIXME - fix the makefiles, git.spec

CFILES=`ls *.c`
DFILES=`ls ppc/* mozilla-sha1/*`
HFILES=`ls *.h`
SRCDIR=src # or libgit?
INCDIR=include/git-guts # or keep in SRCDIR or include/git or whatever
COGDIR=programs/cogito # or just cogito. is git-web likely to be inc?

mkdir -p $SRCDIR $INCDIR $COGDIR \
bindings/perl bindings/python bindings/ruby po tests doc # just ideas,
# no files (yet)

mv $CFILES ppc mozilla-sha1 $SRCDIR
mv $HFILES $INCDIR
COGFILES=`file * | grep "script text executable" | cut -f1 -d:`
mv $COGFILES $COGDIR

cg-rm $CFILES $HFILES $COGFILES
for i in $CFILES $DFILES
do
         cg-add $SRCDIR/$i
done
for i in $HFILES
do
         cg-add $INCDIR/$i
done

cg-commit




-- 

Mike Taht


   "A straw vote only shows which way the hot air blows.
	-- O'Henry"
