From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 5/7] git mv: Support moving submodules
Date: Thu, 17 Jul 2008 15:06:51 +0200
Message-ID: <20080717130651.GU32184@machine.or.cz>
References: <20080716190753.19772.93357.stgit@localhost> <20080716191129.19772.41903.stgit@localhost> <7vhcapme0q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 15:07:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJTD6-0006Q3-7L
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 15:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbYGQNGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 09:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbYGQNGy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 09:06:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42537 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbYGQNGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 09:06:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AAD992C4C027; Thu, 17 Jul 2008 15:06:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhcapme0q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88848>

  Hi!

On Wed, Jul 16, 2008 at 07:37:57PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > ... The horrid
> > index_path_src_sha1 hack is unfortunately much worse,
> 
> This one certainly is ugly beyond words.

  ;-)

> By the way, why is it even necessary to rehash the contents when you run
> "mv"?
> 
> IOW,
> 
> 	$ >foo
>         $ git add foo
>         $ echo 1 >foo
>         $ git mv foo bar
> 
> makes "foo" disappear from the index and adds "bar", but it makes the
> local change added to the index at the same time.
> 
> 	Side note. It actually is a lot worse than that.  When you move
> 	something to another existing entry, the code does not even add
> 	the object name of moved entry recorded in the index, nor rehashes
> 	the moved file.  This is totally inconsistent!
> 
> I personally think these buggy behaviours you are trying to inherit are
> making this patch more complex than necessary.  Perhaps this needs to be
> fixed up even further (you did some fix with the first patch) before
> adding new features?  For example, I think it is a bug that the
> "overwrite" codepath does not work with symlinks.

  I agree that it would be much cleaner to fix this; I got puzzled about
this behaviour a bit, but I was afraid to break the traditional
behaviour. However, if you are feeling this brave, patch to follow up
shortly. :-)

>  * Then, only for case (1), you do not call add_file_to_cache() -- because
>    you know you do not have anything you can rehash; instead, factor out
>    the codepath "git-update-index --cacheinfo" uses and call that.

  This is excellent hint, sort of what I hoped for, thanks! I forgot
about --cacheinfo completely, which is truly a shame especially when I
look at the history of this switch. ;-) (BTW, curiously, the commit
lists Linus as an author even though the patch is yours. Maybe this was
merely some imperfection of the early scripts around Git, though.)
I really did not touch git internals for way too long.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
