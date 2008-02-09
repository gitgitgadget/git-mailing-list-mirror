From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 16:27:25 +0100
Message-ID: <200802091627.25913.kendy@suse.cz>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 16:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNrch-0004mv-7I
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 16:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYBIP12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 10:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYBIP12
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 10:27:28 -0500
Received: from styx.suse.cz ([82.119.242.94]:38303 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751941AbYBIP11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 10:27:27 -0500
Received: from ben.suse.cz (ben.suse.cz [10.20.1.143])
	by mail.suse.cz (Postfix) with ESMTP id 507CD6280B1;
	Sat,  9 Feb 2008 16:27:26 +0100 (CET)
User-Agent: KMail/1.9.1
In-Reply-To: <m3ejbngtnn.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73236>

Hi Jakub,

On Friday 08 February 2008 20:00, Jakub Narebski wrote:

> It was not implemented because it was thought to be hard; git assumes
> in many places that if it has an object, it has all objects referenced
> by it.
>
> But it is very nice of you to [try to] implement 'lazy clone'/'remote
> alternates'.
>
> Could you provide some benchmarks (time, network throughtput, latency)
> for your implementation?

Unfortunately not yet :-(  The only data I have that clone done on 
git://localhost/ooo.git took 10 minutes without the lazy clone, and 7.5 
minutes with it - and then I sent the patch for review here ;-)  The deadline 
for our SVN vs. git comparison for OOo is the next Friday, so I'll definitely 
have some better data by then.

> Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> you would need machine with large amount of memory to repack it
> tightly in sensible time!

As I answered elsewhere, unfortunately it goes out of memory even on 8G 
machine (x86-64), so...  But still trying.

> > Shallow clone is not a possibility - we don't get patches through
> > mailing lists, so we need the pull/push, and also thanks to the OOo
> > development cycle, we have too many living heads which causes the
> > shallow clone to download about 1.5G even with --depth 1.
>
> Wouldn't be easier to try to fix shallow clone implementation to allow
> for pushing from shallow to full clone (fetching from full to shallow
> is implemented), and perhaps also push/pull between two shallow
> clones?

I tried to look into it a bit, but unfortunately did not see a clear way how 
to do it transparently for the user - say you pull a branch that is based off 
a commit you do not have.  But of course, I could have missed something ;-)

> As to many living heads: first, you don't need to fetch all
> heads. Currently git-clone has no option to select subset of heads to
> clone, but you can always use git-init + hand configuration +
> git-remote and git-fetch for actual fetching.

Right, might be interesting as well.  But still the missing push/pull is 
problematic for us [or at least I see it as a problem ;-)].

> By the way, did you try to split OpenOffice.org repository at the
> components boundary into submodules (subprojects)? This would also
> limit amount of needed download, as you don't neeed to download and
> checkout all subprojects.

Yes, and got to much nicer repositories by that ;-) - by only moving some 
binary stuff out of the CVS to a separate tree.  The problem is that the deal 
is to compare the same stuff in SVN and git - so no choice for me in fact.

> The problem of course is _how_ to split repository into
> submodules. Submodules should be enough self contained so the
> whole-tree commit is alsays (or almost always) only about submodule.

I hope it will be doable _if_ the git wins & will be chosen for OOo.

> > Lazy clone sounded like the right idea to me.  With this
> > proof-of-concept implementation, just about 550M from the 2.5G is
> > downloaded, which is still about twice as much in comparison with
> > downloading a tarball, but bearable.
>
> Do you have any numbers for OOo repository like number of revisions,
> depth of DAG of commits (maximum number of revisions in one line of
> commits), number of files, size of checkout, average size of file,
> etc.?

I'll try to provide the data ASAP.

Regards,
Jan
