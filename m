From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: Handling large files with GIT
Date: Mon, 13 Feb 2006 14:26:06 +1300 (NZDT)
Message-ID: <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 02:43:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8SkR-0007kF-Ax
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 02:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWBMBnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 20:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBMBnX
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 20:43:23 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:50694 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1750976AbWBMBnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 20:43:23 -0500
Received: from piva.hawaga.org.uk (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k1D1gkN1022826;
	Mon, 13 Feb 2006 01:42:47 GMT
Received: by piva.hawaga.org.uk (Postfix, from userid 501)
	id 9C347D4EAA6; Mon, 13 Feb 2006 14:26:06 +1300 (NZDT)
Received: from localhost (localhost [127.0.0.1])
	by piva.hawaga.org.uk (Postfix) with ESMTP id 818A4D4EAA2;
	Mon, 13 Feb 2006 14:26:06 +1300 (NZDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16033>


On Thu, 9 Feb 2006, Martin Langhoff wrote:

> I did suggest maildir,  where GIT is bound to do well as the content
> of the emails doesn't change but they just move around a lot. Though
> yes, trees are going to be nasty.

I've been keeping maildir in git for a few months, with mail being 
delivered into a git repo on one (permanently connected) host and me 
merging that branch into a repo on my laptop for reading (the intention 
being that I should be able to sync it back to the permanently connected 
host as I sometimes read mail there.

Alas, the merge part of this absolutely sucks -- as time goes by, its 
getting slower and slower (its taking an hour or so to do the merge, which 
has got to the point of being barely usable -- if it wasn't for the neat 
hack-value, I'd have given up on this by now).

I haven't really probed whats happening when I'm doing the merges in any 
depth, but I see a lot of index manipulation happening (git update-index, 
I think) to add and remove files where each invocation of that seems to be 
taking almost a whole second.

I wonder if the present merge algorithms perform especially badly in the 
case of a large number of files with lots of renames (and so lots of 
adds/removes) but no content changes? The merge should be able to happen 
entirely in the index, I think.

Perhaps one way to proceed would be for me to write a move-optimised merge 
strategy where I flip the index round and instead of saying "how has the 
content inside this filename changed?" I instead say "how has the filename 
associated with this content <hash> changed?"

A special-case on top of a move-optimised merge might be some 
maildir-aware filename handling that knows how to resolve conflicts when a 
particular content-hash has been renamed to two different names (eg. when 
one flag is added to a message in one repo and a different flag is added 
to a message in another repo).

Any advice/thoughts/suggestions-that-this-is-a-stupid-thing-to-do would be 
greatly appreciated.

-- 
