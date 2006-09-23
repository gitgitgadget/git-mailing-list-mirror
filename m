From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Sat, 23 Sep 2006 06:45:36 +0200
Message-ID: <200609230645.37773.chriscool@tuxfamily.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org> <Pine.LNX.4.64.0609180926590.4388@g5.osdl.org> <7v3baj365g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 06:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQzId-000680-L5
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 06:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWIWEjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWIWEjd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 00:39:33 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:23528 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750846AbWIWEjc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 00:39:32 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 1AC0F18478;
	Sat, 23 Sep 2006 06:39:31 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7v3baj365g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27563>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > It's entirely possible that the proper way to do branch deletion with
> > packed branches is to simply re-pack without the old branch, rather
> > than the negative branch model. I couldn't really decide.
>
> After playing with branch deletion issues for some time, I
> started to think it would be a lot simpler if we do not mark
> a deleted branch with 0{40}.

I also came to the same conclusion and I wonder if we could delete a branch 
by moving the file ".git/refs/heads/frotz" 
to ".git/deleted-refs/heads/frotz".
If the branch is packed we could perhaps just create 
".git/deleted-refs/heads/frotz". 

It means everytime we are looking up a ref we have to check 
in ".git/deleted-refs/" first to see if it exists.

> But the latter falls apart if we use 0{40} convention to mark a
> deleted branch. Removing .git/refs/heads/frotz/nitfol file which
> has 0{40} and creating .git/refs/heads/frotz file resurrects
> frotz/nitfol branch that is still packed.

If we move ".git/refs/heads/frotz/nitfol" 
to ".git/deleted-refs/heads/frotz/nitfol" when we remove this ref, we only 
need to try to rmdir all subdirectories under ".git/refs/heads/frotz/" and 
then ".git/refs/heads/frotz/" to see if we can 
create ".git/refs/heads/frotz", and if we can, we won't 
resurect "frotz/nitfol" because ".git/deleted-refs/heads/frotz/nitfol" 
still exists.

> Not allowing frotz 
> branch to be created only because we had deleted frotz/nitfol
> previously is not what we want either, so at that point we need
> to repack without frotz/nitfol anyway.
>
> Which makes me think that we would better repack when removing
> any existing ref.

Yes but it may not be fast and may be corruption prone.

Christian.
