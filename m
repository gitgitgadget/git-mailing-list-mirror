From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 20:54:45 +0200
Message-ID: <20060505185445.GD27689@pasky.or.cz>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz> <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 20:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5Qm-00075D-Oi
	for gcvg-git@gmane.org; Fri, 05 May 2006 20:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWEESxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 14:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWEESxe
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 14:53:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24005 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751214AbWEESxd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 14:53:33 -0400
Received: (qmail 19497 invoked by uid 2001); 5 May 2006 20:54:45 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19627>

Dear diary, on Fri, May 05, 2006 at 08:31:06PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> Moving data around happens with a whole lot more than "mv".

Let's keep this on the per-file level - if you want to go below the file
granularity, I already _DID_ say that I agree that explicit tracking is
not a way. (If sub-file tracking would end up having any usable
reliability in real-world cases, which is something I do not take for
granted.)

Another thing is, the sub-file content tracking would end up being a lot
more "magic" than the simple per-file content tracking, and you stated
several times that you prefer simple merge over better but magic merge -
so why do you prefer sub-file content tracking anyway?

> It happens with patches (somebody _else_ may have done an "mv", without 
> using git at all),

_Here_ is the place for automated renames detection. Between applying
and committing the patch, the user can verify that it got the renames
right. That's impossible when guessing the renames later.

> and it happens with editors (moving data around until 
> most of it exists in another file).

I doubt this in fact happens that often (to a degree the automatic
rename detection would catch). And if it happens, then the user has to
tell Git - I have never heard that _this_ would be any problem in other
version control systems. You could make it more foolproof by running the
automatic rename detection on the diff being committed and suggesting
the user that other yet unrecorded renames did happen.

The point is, the user stays in control and can override any stupid guess.

> So doing "*mv" is just a special case.
> 
> And supporting special cases is _wrong_. If you start depending on data 
> that isn't actually dependable, that's WRONG.

I prefer making this data dependable to having to resort to guessing on
dependable less amount of data.

> There's another reason why encoding movement information in the commit is 
> totally broken, namely the fact that a lot of the actions DO NOT WALK THE 
> COMMIT CHAIN!
> 
> Try doing
> 
> 	git diff v1.3.0..
> 
> and think about what that actually _means_. Think about the fact that it 
> doesn't actually walk the commit chain at all: it diffs the trees between 
> v1.3.0 and the current one. What if the rename happened in a commit in the 
> middle?

Then the automated renames detection will miss it given that the other
accumulated differences are large enough, and the suggested workarounds
_are_ precisely walking the commit chain.

If you use persistent file ids, you never miss it _AND_ you DO NOT WALK
THE COMMIT CHAIN! You still just match file ids in the two trees.

> The "track contents, not intentions" approach avoids both these things. 
> The end result is _reliable_, not a "random guess".

No, the end result is whichever some heuristic randomly guessed, and
it's not reliable either since the heuristic can change.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
