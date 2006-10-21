From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 08:01:11 -0500
Message-ID: <20061021130111.GL75501@over-yonder.net>
References: <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 15:01:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbGTV-0003cl-JH
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 15:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993000AbWJUNBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 09:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993007AbWJUNBO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 09:01:14 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:6095 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S2993000AbWJUNBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 09:01:13 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 3C3A22842F;
	Sat, 21 Oct 2006 08:01:12 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id AED6A61C52; Sat, 21 Oct 2006 08:01:11 -0500 (CDT)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87irie1wvv.wl%cworth@cworth.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29607>

On Fri, Oct 20, 2006 at 02:48:52PM -0700 I heard the voice of
Carl Worth, and lo! it spake thus:
> 
> The entire discussion is about how to name things in a distributed
> system.

I think we're getting into scratched-record-mode on this.


Git: Revnos aren't globally unique or persistent.

Bzr: Yes, we know.

G: Therefore they're useless.

B: No, they're very useful in [situation] and [situation], and we deal
   with [situation] all the time, and they work great for that.

G: But they fall apart totally in [situation].

B: Yes, so use revids there.

G: So use revids everywhere.

B: Revnos are handier tools for [situation] and [situation] for
   [reason] and [reason].

*brrrrrrrrrrrrrrrrip!!!*    *skip back to start*


I'm not sure there's any unturned stone left along this line, so I'm
not sure how productive it really is to keep walking down it.  So, to
make something productive of it, I'm going to put it onto my todo list
to spend some time with bzr trying to use revids for stuff.  I'm
fairly certain that, due to the bzr cultural tendancy to use revnos
where possible, there are some rough edges in the UI when using revids
that should be filed down (though I think it much less likely to turn
up underlying model failures that interfere with using revids).


> It may be that the centralization bias

I think it's more accurately describable as a branch-identity bias.
The git claim seems to be that the two statements are identical, but I
have some trouble swallowing that.


> I'm still not sure exactly what a bzr branch is, but it's clearly
> something different from a git branch,

The term is somewhat overloaded, which is why it's causing you trouble
(and did me).  It refers both to the conceptual entity ("a line of
development" roughly, much like what 'branch' means in git and VCS in
general), and to the physical location (directory, URL) where that
branch is stored, and where it'll often have a working tree.  Branches
are always referred to by location, never by name.


> (and I'd be interested to see a "corrected" version of the commands
> above to fix the storage inefficiencies).

The 'corrected' step would be:

> 	mkdir bzrtest; cd bzrtest
    bzr init-repo .
> 	mkdir master; cd master; bzr init

Then all branches stored under that 'bzrtest' dir will use the
bzrtest/.bzr/ dir for storing the revisions, and shared revisions will
only exist once saving the space/time for multiple copies.

Probably, you'd actually want 'init-repo --trees' in this case,
because repos default to being [working]tree-less.  In a tree-less
setup, you'd create a [lightweight] checkout of the branch(es) you
wanted to work on elsewhere, giving you a layout much like CVS or SVN
where "my VCS files are THERE, my working tree is HERE".


> (since pull seems the only way to synch up without infinite new
> merge commits being added back and forth).

The infinite-merge-commits case doesn't happen in bzr-land because we
generally don't merge other branches except when the branch owner says
"Hey, I've got something for you to merge".  If you were to setup a
script to merge two branches back and forth until they were 'equal',
yes, it'd churn away until you filled up your disk with the N bytes of
metadata every new revision uses up.



-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
