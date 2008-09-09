From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 16:04:53 +0200
Message-ID: <20080909140453.GC25476@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <48C67C47.6000107@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 16:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3r0-0001lY-0q
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYIIOEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbYIIOEy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:04:54 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:41633 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbYIIOEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:04:54 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4BA545465; Tue,  9 Sep 2008 16:04:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C67C47.6000107@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95386>

Paolo Bonzini wrote:
>> - At the time of creation, the origin field contains a hash B which refers
>>   to a reachable commit pair (B, B~1).  If B has multiple parents and the pair
>>   being referred to needs to be e.g. (B, B~2), then the hash is followed by
>>   a space and followed by an integer (base10, two in this case),
>>   which designates the proper parentnr of B (see: mainline in git
>>   cherry-pick/revert).

>What about just storing *two* hashes?  This way cherry-pick can store
>B~1..B and revert can store B..B~1.  The two cases can be distinguished
>by checking which commit is an ancestor of which.

Valid point, but consider:
The new commit to receive hash A.  The diff between A~1..A and B~1..B
actually defines the relation.  Revert and cherry-pick are symmetrical
operations as far as git is concerned since git tracks content.
So I'm not quite sure if we actually need this extra information, git
already knows it all.

>> - git cherry-pick/revert allow for the creation of origin links only if
>>   the object they are referring to is presently reachable.

>Will cherry-pick -x create origin links?

I'd propose a cherry-pick -o and revert -o for that.
I wouldn't want to force the text which -x generates into the commit
when origin links are used.

>  Also, does the origin link
>propagate through multiple cherry picks?

The origin link is created point-to-point from the object referenced by
cherry-pick/revert to the new commit.  The link creation specifically
does not follow any existing origin links.  If you want the origin link
to point to a deeper origin behind the current, then cherry-pick from
there, no need to fake it.

>  If not, how can the origin
>object not be reachable?

That can only happen during a fetch/pull, which doesn't use origin links
to determine transmittability by default.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
