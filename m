From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 17:54:27 +0200
Message-ID: <20080912155427.GB2915@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAzj-0001F0-3V
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbYILPya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbYILPya
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:54:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60695 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYILPy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:54:29 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 779BB5465; Fri, 12 Sep 2008 17:54:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080912145802.GV5082@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95741>

Theodore Tso wrote:
>On Fri, Sep 12, 2008 at 07:47:39AM +0200, Stephen R. van den Berg wrote:
>> It would probably become computationally prohibitive to use it between
>> long lived permanent branches.  In that case it would need to be
>> augmented by the sha1 of the originating commit.

>Nope, as Sam suggested in his original message (but which got clipped
>by Linus when he was replying) all you have to do is to have a
>separate local database which ties commits and patch-id's together as
>a cache/index.

True.  But repopulating this cache after cloning means that you have to
calculate the patch-id of *every* commit in the repository.  It sounds
like something to avoid, but maybe I'm overly concerned, I have only a
vague idea on how computationally intensive this is.

>I know you seem to be resistent to caches, but caches are **good**
>because they are local information, which by definition can be
>implementation-dependent; you can always generate the cache from the
>git repository if for some reason you need to extend it.  It also
>means that if it turns out you need to index reationships a different
>way, you can do that without having to make fundamental (incompatible)
>changes in the git object.  

I fully agree that caches are good.
And yes I seem to resist the idea to create a cache at every whim, but
that mostly is because I want to avoid that everyone invents their own
mini-database for each and every data access they want to accellerate.

I mean, ideally, any database/index/accellerator structure you'd need
can reuse the SHA1 object database index, or maybe one or two other
semi-standard index types, and git would provide suitable library
functions for all three solutions.  And if that would be the case, I'll
gladly throw in an extra cache or index at anytime to speed up the
particular access pattern I'm trying to make useable.  But as far as I
can see, those library functions have not materialised yet, so I'm
hesitant to create yet another private database structure just for my
access patterns; and simply pulling in libdb or sqlite without agreement
that those libs are (re)used in a lot of places in git seems a bit
bloat-prone.

>local caches are database indexes.  Just because you need an index in
>a particular direction to optimize a query or loopup operation does
>***not*** imply that you need to make a fundamental, globally visible,
>database schema change or git object layout which breaks compatibility
>for everybody.

It's not a certainty that changing the git object layout has to break
compatibility (it should be reasonably possible to add columns to the
schema without breaking anything, to stay with the database paradigm),
but I agree that creating another index can be considered better than
extending the schema.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."
