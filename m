From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Can I remove stg sync --undo ?
Date: Sat, 5 Jul 2008 10:33:48 +0200
Message-ID: <20080705083348.GA21097@diana.vm.bytemark.co.uk>
References: <20080702072524.GA26805@diana.vm.bytemark.co.uk> <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com> <20080704020918.GA30669@diana.vm.bytemark.co.uk> <b0943d9e0807041505oc15660bpcd62a62100e517b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 10:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF3EV-0002RF-Oj
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 10:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbYGEIeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jul 2008 04:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYGEIeG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 04:34:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1632 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYGEIeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 04:34:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KF3DI-0005WA-00; Sat, 05 Jul 2008 09:33:48 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807041505oc15660bpcd62a62100e517b9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87438>

On 2008-07-04 23:05:11 +0100, Catalin Marinas wrote:

> 2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-07-03 23:02:28 +0100, Catalin Marinas wrote:
> >
> > > The sync performs three operations - push, merge and refresh (if
> > > the refresh is automatic after merge, it doesn't update the
> > > backup information since it was done by merge).
> > >
> > > If merge fails, the refresh is manual after solving the
> > > conflicts. I suspect this will be recorded as a separate step
> > > for undo
> >
> > Yeah, the new undo stuff will currently handle sync just like e.g.
> > push and pop: write one log entry when the command's all done,
> > plus one extra just before the conflicting push if there is one.
> > So you can always undo the entire command; and in case of
> > conflicts, you also have the option of undoing just the
> > conflicting push. Is this enough for sync?
>
> There are two operations that can conflict for sync - pushing a
> patch and the actual sync'ing, i.e. a three-way merge with the patch
> to be synchronised with (kind of fold).

My guess is that conflicts of the first type would work out of the box
(i.e. they'd get an extra log entry) while conflicts of the second
type would not.

We need a sync undo test.

> > > (BTW, is resolved take into account for undo?).
> >
> > Hmmm, what do you mean by "resolved"?
>
> The current resolved command - the clearing of the conflicting
> entries in the index.

With just "stg undo" (or reset or redo), you get the usual
new-infrastructure check about dirty index and working tree (the whole
index must be clean, and the parts of the worktree we need to touch
must be clean). Which prevents you from undoing a conflicting push,
for example.

With the --hard flag, any uncleanliness in index or worktree simply
gets zapped (just like with git reset --hard). I'm not 100% happy with
this -- what I'd really like is to zap only the files that we need to
touch. But I haven't figured out a good way to do that.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
