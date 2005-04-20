From: Nick Craig-Wood <nick@craig-wood.com>
Subject: Re: enforcing DB immutability
Date: Wed, 20 Apr 2005 15:57:25 +0100
Message-ID: <20050420145725.GA23072@craig-wood.com>
References: <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org> <20050420074053.GA22436@elte.hu> <20050420074948.GA22620@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 16:53:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOGZs-0002WI-4o
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 16:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDTO5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 10:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVDTO5c
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 10:57:32 -0400
Received: from boxa.alphawave.net ([207.218.5.130]:55188 "EHLO
	box.alphawave.net") by vger.kernel.org with ESMTP id S261657AbVDTO52
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 10:57:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by box.alphawave.net (Postfix) with ESMTP
	id 6518BE8437; Wed, 20 Apr 2005 15:45:10 +0100 (BST)
Received: from irishsea.home.craig-wood.com (userbb201.dsl.pipex.com [62.190.241.201])
	by box.alphawave.net (Postfix) with ESMTP
	id 2975EE8423; Wed, 20 Apr 2005 15:45:10 +0100 (BST)
Received: by irishsea.home.craig-wood.com (Postfix, from userid 502)
	id 2D7083FF7C; Wed, 20 Apr 2005 15:57:25 +0100 (BST)
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050420074948.GA22620@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at alphawave.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 09:49:48AM +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > perhaps having a new 'immutable hardlink' feature in the Linux VFS 
> > would help? I.e. a hardlink that can only be readonly followed, and 
> > can be removed, but cannot be chmod-ed to a writeable hardlink. That i 
> > think would be a large enough barrier for editors/build-tools not to 
> > play the tricks they already do that makes 'readonly' files virtually 
> > meaningless.
> 
> immutable hardlinks have the following advantage: a hardlink by design 
> hides the information where the link comes from. So even if an editor 
> wanted to play stupid games and override the immutability - it doesnt 
> know where the DB object is. (sure, it could find it if it wants to, but 
> that needs real messing around - editors wont do _that_)

This has already been implemented for the linux vserver project.  Take
a look in the patch here :-

  http://vserver.13thfloor.at/Experimental/patch-2.6.11.7-vs1.9.5.x5.diff.bz2

(Its not split out, but search for IMMUTABLE and you'll see what I mean)

It implements immutable linkage invert, which basically allows people
to delete hardlinks to immutable files, but not do anything else to
them.  It uses another bit out of the attributes to "invert" the
immutability of the linkage of immutable files.

Its used in the vserver project so that individual vservers (which are
basically just fancy chroots) can share libraries, binaries and hence
memory, can't muck each other up, but can upgrade their libs/binaries.

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
