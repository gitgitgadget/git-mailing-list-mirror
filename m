From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: why does git perpetually complain about
	include/asm-blackfin/macros.h?
Date: Mon, 2 Jul 2007 16:24:30 +0200
Message-ID: <20070702142430.GA10400@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain> <4688EF9B.8020405@garzik.org> <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jeff Garzik <jeff@garzik.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:24:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Mpb-0005V1-Pg
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573AbXGBOYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759396AbXGBOYi
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:24:38 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:35755 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758168AbXGBOYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:24:37 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1I5MpK-0002kz-PG; Mon, 02 Jul 2007 16:24:30 +0200
Content-Disposition: inline
In-Reply-To: <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51368>

On Monday July 2nd 2007 at 15:58 Jesper Juhl wrote:

> [obnoxious zero sized file include/asm-blackfin/macros.h that gets
>  zapped by toolchains and resurrected again by git]
>
> I've seen that as well, but in my case doing a
> $ git reset --hard master
> fixed it.

Dangerous, as it may overwrite local changes you have! A simple "git
checkout include/asm-blackfin/macros.h" is much safer in this case.

In git commit df30b11 this file got redundant. Perhaps because a normal
patch was applied, instead of with git, the file didn't get deleted from
the repository but truncated to size zero. Not strictly wrong perse, but
for the Linux repository highly unusual (and the only one at that).

Your toolchain perhaps deletes files with zero size after cleaning up or
something. Git then notices that you deleted this file.

Perhaps someone can apply something like the following to finally fix
this up:

commit 7d98740800f3d9ad2428afa8c677be9573a51b7b
Author: Marco Roeland <marco.roeland@xs4all.nl>
Date:   Mon Jul 2 16:19:49 2007 +0200

    Blackfin arch: remove zero-sized include/asm-blackfin/macros.h
    
    This file accidentally got truncated instead of deleted in commit df30b11.
    
    Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>

diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
deleted file mode 100644
index e69de29..0000000
