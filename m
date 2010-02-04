From: Sitaram Chamarty <sitaram@atc.tcs.com>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 08:52:39 +0530
Message-ID: <20100204032239.GA5429@atcmail.atc.tcs.com>
References: <20100204013556.GA2590@atcmail.atc.tcs.com> <20100204012840.GC497@atcmail.atc.tcs.com> <20100204014657.GA10114@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 04:23:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcsJJ-0003hg-1S
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 04:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab0BDDXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 22:23:12 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:36995 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab0BDDXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 22:23:09 -0500
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id o143MdBM005973;
	Thu, 4 Feb 2010 08:52:39 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id o143MdC4005972;
	Thu, 4 Feb 2010 08:52:39 +0530
Content-Disposition: inline
In-Reply-To: <20100204014657.GA10114@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/10354/Wed Feb  3 16:33:21 2010 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138941>

On Thu, Feb 04, 2010 at 02:46:57PM +1300, martin f krafft wrote:
> also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1428 +1300]:
> > I'm ok with symlinking stuff; a couple of "cp" commands
> > would change to "ln" :)  Let me try it out (and make sure it
> > works for upgrades also...)
> 
> ln -sf even.

yup...

> also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1435 +1300]:
> > I forgot... part of the reason this "copy all hooks over each time
> > you run install" is also to give people an easy way to update the
> > hooks when the repo was *copied* from elsewhere, and not *created*
> > by gitolite in the first place.
> > 
> > Basically I'm paranoid about that "update" hook, without which the
> > branch level access control doesn't work at all.
> 
> Wouldn't it thus make sense to check during authentication that the
> symlink exists and points to the right file, and to deny access
> completely if that isn't the case?

Yeah I guess that's easy enough really... just need to
include a way to tell the code what is the right file to
point to.  (Currently it's all inside $GL_ADMINDIR but in
the APT case that may not be true...?)

> Having a mass-update command for this might be nice, but I suppose
> it's also a trivial shell one-liner...
> 
>   for i (**/*.git/hooks/update) \
>     ln -sf ~git/.gitolite/src/hooks/update $i
> 
> (this is zsh, not sure bash can do this yet)

This has to work on systems that don't even have bash (like
plain old sh personality of ksh), leave alone zsh :)

Not saying it's hard; just a "find" in backticks.  I'd still
rather put it inside the perl code somewhere that already
gets run anyway, as it is now...
