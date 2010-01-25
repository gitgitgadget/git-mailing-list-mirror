From: tom fogal <tfogal@sci.utah.edu>
Subject: Re: [Mesa3d-dev] mesa_7_7_branch -> master merges
Date: Mon, 25 Jan 2010 12:14:33 -0700
Message-ID: <auto-000021766326@sci.utah.edu>
Reply-To: tfogal@alumni.unh.edu
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jfonseca@vmware.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 20:44:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUov-0001G2-3j
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 20:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab0AYTlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 14:41:52 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537Ab0AYTlw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 14:41:52 -0500
Received: from mail.sci.utah.edu ([155.98.58.79]:60399 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750718Ab0AYTlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 14:41:51 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2010 14:41:51 EST
Received: from dummy.name; Mon, 25 Jan 2010 12:11:49 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137983>

This bounced, it seems because Jose's [1] name is not representable in
8bit ASCII (some header wasn't, at least).

I'm not cc'ing Mesa to avoid spamming everyone.  I'm not sure
non-subscribers can post there anyway.  Jose or myself will forward
along any relevant discussion...

[1] sorry for misspelling it there..

------- Forwarded Message

=46rom: tom fogal <tfogal@alumni.unh.edu>
To: Jos=E9 Fonseca <jfonseca@vmware.com>
cc: mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, git@vger.kernel.org
Subject: Re: [Mesa3d-dev] mesa_7_7_branch -> master merges=20
In-Reply-To: Your message of "Mon, 25 Jan 2010 18:14:24 GMT."
             <1264443264.3029.255.camel@jfonseca-laptop>=20
References: <1264424650.3029.155.camel@jfonseca-laptop> <auto-000021765=
525@sci.utah.edu>  <1264443264.3029.255.camel@jfonseca-laptop>=20
Date: Mon, 25 Jan 2010 12:04:00 -0700

I think we've touched on a core git workflow issue here, and its likely
others have hit this && have a solution, so I've added the git ML to
the CC list.

Git: the situation in this repo is a fast-moving master that is
including many changes to internal interfaces.  Stable branches just
get bugfixes, and are periodically merged to master.  However, the more
the heads diverge, the more difficult it is for a bugfix to merge into
the head.  The major issue is that more experienced developers should
really weigh in on these merges, because they tend to automagically
undo some of the interface changes.  Yet during such a delay, master
inevitably moves, and the bugfixer has to do even more work to "redo"
the merge (and potentially get more review!).

Of course, if there are two bugfixers trying to make separate changes
in the same time period, this gets worse.

Is there a workflow that can solve this issue?

 writes:
> On Mon, 2010-01-25 at 09:52 -0800, tom fogal wrote:
> > writes:
> > [snip]
> > > The ideal would be to peer-review the merges before committing,
> > > but it seems difficult to do that with git, while preserving merg=
e
> > > history and not redoing merges.
> >=20
> > Google has developed an infrastructure to do peer review using git.
> > `Gerrit':
[snip]
> Review infrastructures are nice. I'd have some bias towards
> http://www.reviewboard.org/  by the similar reasons ;)

Heh, yeah I can understand the bias ;)

Personally, I'm not keen on a review tool I can't use from the command
line, or at least not-the-web.  Then again, my reviews wouldn't really
be important in Mesa, so my opinion is irrelevant here ;)

> But automated infrastructures aside, my worry with reviewing merges i=
s
> the actual constraints that git has. For example, let's suppose the
> following scenario:
>=20
> 1) Developer A merges a stable branch into master.
> 2) After spending a bunch of time fixing conflicts the best he can, h=
e
> emails the patch to mesa3d-dev for peer review.
> 3) Developer B checks in a change into master.
> 4) Developer A takes feedback from list, updates the code, and commit=
s.
> 5) Developer A cannot push because remote head has moved.
>=20
> So what can Developer A do now?
>
> a) Redo the merge, using the new master head.
> b) Rebase the merge on top of the new head (I'm not sure it works, or
> that it preserves branch history)
> c) Double merge, i.e., merge its local head with the new master head.

Hrm, I was thinking of some sort of staging branch, but I can't think
of a good way to make it work.  The crux of the issue seems to be that
a developer needs to somehow give a version control promise that they
will do the merge, even if the merge isn't done yet, because otherwise
anyone else coming afterwards will duplicate the work (potentially
incorrectly).  That would mean some kind of lock though, which sounds
like a terrible idea...

- -tom

------- End of Forwarded Message
